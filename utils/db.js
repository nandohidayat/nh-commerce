const mongoose = require('mongoose');
const options = require('../config');

exports.connect = (url = options.dbUrl, opts = {}) => {
  return mongoose.connect(url, {
    ...opts,
    useNewUrlParser: true,
    useCreateIndex: true
  });
};
