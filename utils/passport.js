const passport = require('passport');
const { Strategy, ExtractJWT } = require('passport-jwt');

const User = require('../resources/user/user.model');
const { secrets } = require('../config');

const opts = {
  jwtFromRequest: ExtractJWT.fromAuthHeaderWithScheme('JWT'),
  secretOrKey: secrets.jwt
};

passport.use(User.createStrategy());
passport.serializeUser(User.serializeUser());
passport.deserializeUser(User.deserializeUser());
passport.use(
  new Strategy(opts, (req, done) => {
    User.findOne({ id: req.sub }, (err, user) => {
      if (err) {
        return done(err, false);
      }
      if (user) {
        return done(null, user);
      }
      return done(null, false);
    });
  })
);
