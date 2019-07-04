import mongoose from 'mongoose';
import mongooseTimestamp from 'mongoose-timestamp';
mongoose.Promise = global.Promise;

const Schema = mongoose.Schema;
const userSchema = new Schema({
    email: { type: String, required: true },
    name: { type: String, required: true },
    phone: { type: String, required: true },
    password: { type: String, required: true },
    cart: [
        {
            product: { type: mongoose.Types.ObjectId, ref: 'Product' },
            quantity: { type: Number },
        },
    ],
});

// Add some method as necessary

// add plugin (add/update date)
userSchema.plugin(mongooseTimestamp);

export default mongoose.model('User', userSchema);
