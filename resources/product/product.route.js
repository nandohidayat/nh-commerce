import { Router } from 'express'
import controllers from './product.controllers'

const router = Router()

router
  .route('/')
  .get(controllers.getMany)
  .post(controllers.upload, controllers.resize, controllers.createOne)

router
  .route('/:id')
  .get(controllers.getOne)
  .put(
    controllers.remove,
    controllers.upload,
    controllers.resize,
    controllers.updateOne
  )
  .delete(controllers.remove, controllers.removeOne)

module.exports = router
