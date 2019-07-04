import express from 'express';

import { authController } from '../../controllers/api';
import { isAuthenticatedApi } from '../../middlewares';

const router = express.Router();

router.post('/', authController.login);
router.post('/signup', authController.signup);
router.post('/checkstatus', isAuthenticatedApi, authController.checkUserStatus);
router.post('/cart', authController.protect, authController.addToCart);
router.get('/carts', authController.protect, authController.getCart);

export default router;
