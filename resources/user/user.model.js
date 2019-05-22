import mongoose from 'mongoose'
import passportLocalMongoose from 'passport-local-mongoose'
import beautifyUnique from 'mongoose-beautiful-unique-validation'

mongoose.Promise = global.Promise

const userSchema = new mongoose.Schema(
  {
    email: {
      type: String,
      require: true,
      unique: 'email {VALUE} already exist',
      trim: true,
      lowercase: true
    },
    username: {
      type: String,
      require: true,
      unique: 'username {VALUE} already exist',
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
)

userSchema.plugin(passportLocalMongoose)
userSchema.plugin(beautifyUnique)

const User = mongoose.model('User', userSchema)

export default User
