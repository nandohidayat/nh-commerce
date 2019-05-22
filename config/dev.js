const config = {
  secrets: {
    jwt: process.env.JWT_SECRET
  },
  dbUrl: process.env.DATABASE
};

module.exports = config;
