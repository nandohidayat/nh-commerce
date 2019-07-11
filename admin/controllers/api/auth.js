import bcrypt from 'bcryptjs';
import jwt from 'jsonwebtoken';
import validator from 'validator';
import UserModel from '../../models/user';

export default class Auth {
    static async login(req, res) {
        const { email, password } = req.body;

        try {
            const user = await UserModel.findOne({ email });

            if (!user) {
                return res
                    .status(401)
                    .json({ error: 'Something went wrong.', user });
            }

            const isEqual = await bcrypt.compare(password, user.password);

            if (!isEqual) {
                return res.status(401).json({ error: 'Something went wrong.' });
            }

            const token = jwt.sign(
                {
                    id: user._id.toString(),
                },
                process.env.JWT_SECRET,
                { expiresIn: '1d' }
            );

            res.status(200).json({ token, userId: user._id.toString() });
        } catch (err) {
            res.status(500).json({ error: err.message });
        }
    }

    static checkUserStatus(req, res) {
        res.status(200).json({ success: true });
    }

    static async signup(req, res) {
        const { name, email, phone, password } = req.body;
        const lengthRange = { min: 4, max: 30 };

        // validate fields
        if (
            validator.isEmpty(name) ||
            !validator.isAlpha(name) ||
            !validator.isLength(name, lengthRange)
        ) {
            return res.status(401).json({ error: 'Something went wrong.' });
        }

        if (!validator.isEmail(email) || validator.isEmpty(email)) {
            req.flash('error', 'Invalid email');
            return res.status(401).json({ error: 'Something went wrong.' });
        }

        if (
            validator.isEmpty(password) ||
            !password.match(/^[a-zA-Z0-9]{4,30}$/)
        ) {
            req.flash('error', 'Invalid password');
            return res.status(401).json({ error: 'Something went wrong.' });
        }

        try {
            const user = await UserModel.findOne({ email });

            if (user) {
                return res.status(401).json({ error: 'Something went wrong.' });
            }

            try {
                const genSalt = await bcrypt.genSalt(10);
                const hash = await bcrypt.hash(password, genSalt);
                const userObj = new UserModel({
                    name,
                    email,
                    phone,
                    password: hash,
                });

                const savedUser = await userObj.save();

                if (savedUser) {
                    return res.status(200).json({ status: 'success' });
                }

                return res.status(401).json({ error: 'Something went wrong.' });
            } catch (err) {
                res.status(500).json({ error: err.message });
            }
        } catch (err) {
            res.status(500).json({ error: err.message });
        }
    }

    static async protect(req, res, next) {
        const bearer = req.headers.authorization;

        if (!bearer || !bearer.startsWith('Bearer ')) {
            return res.status(401).end();
        }

        const token = bearer.split('Bearer ')[1].trim();
        let payload;
        try {
            payload = await jwt.verify(token, process.env.JWT_SECRET);
        } catch (e) {
            return res.status(401).end();
        }

        const user = await UserModel.findById(payload.id)
            .select('-password')
            .lean()
            .exec();

        if (!user) {
            return res.status(401).end();
        }

        req.user = user;
        next();
    }

    static async addToCart(req, res) {
        const { product, quantity } = req.body;

        try {
            const user = await UserModel.findById(req.user._id);

            if (!user) {
                return res.status(401).json({ error: 'Something went wrong.' });
            }

            let found = false;
            for (let i = 0; i < user.cart.length; i++) {
                if (user.cart[i].product == product) {
                    found = true;
                    break;
                }
            }

            if (found) {
                return res.status(401).json({ error: 'Something went wrong.' });
            }

            user.cart.push({ product, quantity });
            const saved = user.save();

            if (saved) {
                return res.status(200).json({ status: 'success' });
            } else {
                return res.status(500).json({ error: 'something went wrong' });
            }
        } catch (err) {
            return res.status(500).json({ error: err.message });
        }
    }

    static async getCart(req, res) {
        try {
            const user = await UserModel.findById(req.user._id).populate(
                'cart.product'
            );

            if (user) {
                return res.status(200).json({ data: user.cart });
            }

            return res.status(500).json({ error: 'something went wrong' });
        } catch (err) {
            return res.status(500).json({ error: err.message });
        }
    }

    static async deleteCart(req, res) {
        try {
            const user = await UserModel.update(
                { _id: req.user._id },
                { $pull: { cart: { _id: req.params.id } } }
            );
            if (user) {
                return res.status(200).json({ status: 'success' });
            }

            return res.status(500).json({ error: 'something went wrong' });
        } catch (err) {
            return res.status(500).json({ error: err.message });
        }
    }
}
