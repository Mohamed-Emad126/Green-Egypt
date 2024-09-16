import { Router } from "express";
import AuthService from "../services/authService";
import AuthController from "../controllers/authController";

const rootRouter = Router();

const authService = new AuthService();
const { createNewUser, login } = new AuthController(authService);


rootRouter.route('/register').post(createNewUser);
rootRouter.route('/login').post(login);

export default rootRouter;