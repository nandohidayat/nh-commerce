const express = require('express');
const passport = require('passport');
const { json, urlencoded } = require('body-parser');
const morgan = require('morgan');
const cors = require('cors');
const config = require('./config');
const { signup, signin } = require('./utils/auth');
const { connect } = require('./utils/db');
// const userRouter = require('./resources/user/user.router');
// const itemRouter = require('./resources/item/item.router');
// const listRouter = require('./resources/list/list.router');

require('./utils/passport');

const app = express();

app.disable('x-powered-by');

app.use(cors());
app.use(json());
app.use(urlencoded({ extended: true }));
app.use(morgan('dev'));

app.post('/signup', signup);
app.post('/signin', signin);

app.use('/api', passport.authenticate('jwt', { session: false }));
// app.use('/api/user', userRouter);
// app.use('/api/item', itemRouter);
// app.use('/api/list', listRouter);

exports.start = async () => {
  try {
    await connect();
    app.listen(config.port, () => {
      console.log(`REST API on http://localhost:${config.port}/api`);
    });
  } catch (e) {
    console.error(e);
  }
};