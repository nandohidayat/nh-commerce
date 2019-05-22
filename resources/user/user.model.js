import mongoose from 'mongoose';
import passportLocalMongoose from 'passport-local-mongoose';

mongoose.Promise = global.Promise;

const userSchema = new mongoose.Schema(
  {
    email: {
      type: String,
      require: true,
      unique: true,
      trim: true,
      lowercase: true
    },
    username: {
      type: String,
      require: true,
      unique: true,
      trim: true
    },
    name: {
      type: String,
      trim: true
    },
    phone: {
      type: String,
      trim: true
    },
    address: {
      type: String,
      trim: true
    }
  },
  { timestamps: true }
);

userSchema.plugin(passportLocalMongoose);

const User = mongoose.model('User', userSchema);

export default User;
