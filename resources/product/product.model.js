import mongoose from 'mongoose'
import slug from 'mongoose-slug-updater'
import Store from '../store/store.model'

mongoose.plugin(slug)
mongoose.Promise = global.Promise

const productSchema = new mongoose.Schema(
  {
    photos: [String],
    name: {
      type: String,
      minlength: 6,
      maxlength: 70,
      required: true,
      trim: true
    },
    slug: {
      type: String,
      slug: 'name',
      unique: true,
      slugPaddingSize: 1
    },
    brand: {
      type: String,
      enum: ['Nike', 'Adidas', 'Lain-lain'],
      required: true
    },
    category: {
      type: String,
      required: true,
      enum: ['Shoes']
    },
    gender: {
      type: String,
      required: true,
      enum: ['Man', 'Woman']
    },
    price: {
      type: Number,
      max: 1000000000,
      min: 100,
      required: true
    },
    stock: {
      type: Number,
      min: 1,
      max: 10000,
      required: true
    },
    condition: {
      type: String,
      enum: ['New', 'Second']
    },
    description: {
      type: String,
      required: true,
      trim: true
    },
    weight: {
      type: Number,
      required: true
    },
    insurance: {
      type: Boolean
    },
    userId: {
      type: mongoose.SchemaTypes.ObjectId,
      ref: 'User',
      required: true
    },
    storeId: {
      type: mongoose.SchemaTypes.ObjectId,
      ref: 'Store'
    }
  },
  {
    timestamps: true
  }
)

productSchema.index({
  name: 'text',
  description: 'text'
})

productSchema.pre('save', async function(next) {
  try {
    const storeId = await Store.findOne({ userId: this.userId })
      .select('_id')
      .lean()
      .exec()

    if (!storeId) {
      next(new Error(`You don't have store bruh`))
    }

    this.storeId = storeId
    next()
  } catch (e) {
    next(new Error(`Unexpected error happen: ${e}`))
  }
})

module.exports = mongoose.model('Product', productSchema)
