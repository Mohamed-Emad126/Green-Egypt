import { Router } from "express";
import UsersService from "../services/usersService";
import UsersController from "../controllers/usersController";

const usersRouter = Router();

const usersService = new UsersService();
const { getUsers } = new UsersController(usersService);

usersRouter.route('/').get(getUsers);

export default usersRouter;

