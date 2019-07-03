import bcrypt from 'bcryptjs';
import validator from 'validator';
import UserModel from '../../models/user';

const PROFILE_ROUTE_MAIM = '/profile';
const PASSWORD_MIN_VALUE = 4;

export default class Profile {
    static profile(req, res) {
        res.render('profile/index', {
            title: 'Edit profile',
            currentUser: req.session.user,
            currentPath: req.baseUrl,
        });
    }

    static async updateProfile(req, res) {
        const { email, name, phone, password } = req.body;
        const lengthRange = { min: 4, max: 30 };

        // validate fields
        if (
            validator.isEmpty(name) ||
            !validator.isAlpha(name) ||
            !validator.isLength(name, lengthRange)
        ) {
            req.flash('error', 'Invalid last name');
            res.redirect(PROFILE_ROUTE_MAIM);
        }

        if (!validator.isEmail(email) || validator.isEmpty(email)) {
            req.flash('error', 'Invalid email');
            res.redirect(PROFILE_ROUTE_MAIM);
        }

        try {
            const userObj = await UserModel.findOne({
                _id: req.session.user._id,
            });

            // update password only if provided
            if (password.length > PASSWORD_MIN_VALUE) {
                try {
                    const genSalt = await bcrypt.genSalt(10);
                    const hash = await bcrypt.hash(password, genSalt);
                    userObj.password = hash;
                } catch (err) {
                    req.flash('error', err.message);
                    res.redirect(PROFILE_ROUTE_MAIM);
                }
            }

            userObj.name = name;
            userObj.phone = phone;
            userObj.email = email;

            const updatedUser = await userObj.save();

            if (updatedUser) {
                delete updatedUser.password;
                req.session.user = updatedUser;

                return req.session.save(err => {
                    if (err) {
                        throw new Error(err);
                    }

                    req.flash(
                        'success',
                        'Your profile has been successfully updated!'
                    );
                    res.redirect(PROFILE_ROUTE_MAIM);
                });
            }

            req.flash('error', 'No user was found!');
            res.redirect(PROFILE_ROUTE_MAIM);
        } catch (err) {
            req.flash('error', err.message);
            res.redirect(PROFILE_ROUTE_MAIM);
        }
    }
}
