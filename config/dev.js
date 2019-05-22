const config = {
  secrets: {
    jwt: process.env.JWT_SECRET
  },
  dbUrl: process.env.DATABASE
};

export default config;
