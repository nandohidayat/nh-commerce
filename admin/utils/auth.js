const jwt = require('jsonwebtoken');

const User = require('../resources/user/user.model');
const config = require('../config');

exports.signup = async (req, res) => {
  if (!req.body.email || !req.body.password) {
    return res.status(400).send({ message: 'need email and password' });
  }

  try {
    const user = new User(req.body);
    await user.setPassword(req.body.password);
    await user.save();
    const token = jwt.sign({ id: user.email }, config.secrets.jwt);
    return res.status(201).send({ token });
  } catch (e) {
    return res.status(500).send(`An error occured: ${e}`);
  }
};

exports.signin = async (req, res) => {
  if (!req.body.email || !req.body.password) {
    return res.status(400).send({ message: 'need email and password' });
  }

  const invalid = { message: 'Invalid email and passoword combination' };

  try {
    const { user } = await User.authenticate()(
      req.body.email,
      req.body.password
    );

    if (!user) {
      return res.status(401).send(invalid);
    }

    const token = jwt.sign({ id: user.username }, config.secrets.jwt);
    return res.status(201).send({ token });
  } catch (e) {
    console.error(e);
    return res.status(500).end();
  }
};
