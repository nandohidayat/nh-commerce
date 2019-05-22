const { merge } = require('lodash');

require('dotenv').config({ path: '.env' });

const env = process.env.NODE_ENV || 'development';

const baseConfig = {
  env,
  isDev: env === 'development',
  isTest: env === 'testing',
  port: 3000,
  secrets: {
    jwt: process.env.JWT_SECRET,
    jwtExp: '100d'
  }
};

let envConfig = {};

switch (env) {
  case 'dev':
  case 'development':
    // eslint-disable-next-line global-require
    envConfig = require('./dev').config;
    break;
  case 'test':
  default:
    // eslint-disable-next-line global-require
    envConfig = require('./dev').config;
}

module.exports = merge(baseConfig, envConfig);
