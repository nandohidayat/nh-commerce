import mongoose from 'mongoose';
import options from '../config';

exports.connect = (url = options.dbUrl, opts = {}) => {
  return mongoose.connect(url, { ...opts, useNewUrlParser: true });
};
