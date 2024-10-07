import { Router } from "express";
import AuthService from "../services/authService";
import AuthController from "../controllers/authController";
import { verifyToken } from "../middlewares/authMiddleware";
import { createUserValidator, loginValidator } from "../utils/validators/authValidator";

const rootRouter = Router();

const authService = new AuthService();
const { createNewUser, login, logout } = new AuthController(authService);

rootRouter.route('/register').post(createUserValidator, createNewUser);
rootRouter.route('/login').post(loginValidator, login);
rootRouter.route('/logout').post(verifyToken, logout);

export default rootRouter;