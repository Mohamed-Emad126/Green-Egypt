import { Router } from "express";
import AuthService from "../services/authService";
import AuthController from "../controllers/authController";
import { verifyToken } from "../middlewares/authMiddleware";

import { createUserValidator, loginValidator, resetPasswordValidator, updatePasswordValidator } from "../utils/validators/authValidator";

const rootRouter = Router();

const authService = new AuthService();

const { createNewUser, login, logout, forgotPassword, resetPassword, verifyGoogleIdToken } = new AuthController(authService);

rootRouter.route('/register').post(createUserValidator, createNewUser);
rootRouter.route('/login').post(loginValidator, login);
rootRouter.route('/logout').post(verifyToken, logout);
rootRouter.route('/forgot-password').post(resetPasswordValidator, forgotPassword);
rootRouter.route('/reset-password/:token').patch(updatePasswordValidator, resetPassword);
rootRouter.route('/google/callback').get(verifyGoogleIdToken);

export default rootRouter;
