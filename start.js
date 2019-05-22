const mongoose = require('mongoose');

require('dotenv').config();

mongoose.connect(process.env.DATABASE, {
  useNewUrlParser: true,
  useCreateIndex: true,
  useFindAndModify: false
});
mongoose.Promise = global.Promise;
mongoose.connection.on('error', err => {
  // eslint-disable-next-line no-console
  console.error(`❌ 💥 ❌ 💥 ❌ 💥 ➡ ${err}`);
});

const app = require('./app');

app.set('port', process.env.PORT || 7777);
const server = app.listen(app.get('port'), () => {
  // eslint-disable-next-line no-console
  console.log(`Express running on port ➡ ${server.address().port}`);
});
