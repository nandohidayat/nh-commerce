import { crudControllers } from '../../utils/crud'
import { imageControllers } from '../../utils/image'
import Product from './product.model'

export default {
  ...crudControllers(Product),
  ...imageControllers(Product, 'products')
}
