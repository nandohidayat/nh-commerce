const { merge } = require('lodash');

require('dotenv').config();

const env = process.env.NODE_ENV || 'development';

const baseConfig = {
  env,
  isDev: env === 'development',
  port: 3000,
  secrets: {
    jwt: process.env.JWT_SECRET,
    jwtExp: '100d'
  }
};

const envConfig = require('./dev').config;

module.exports = merge(baseConfig, envConfig);
