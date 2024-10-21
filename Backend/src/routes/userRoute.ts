import { Router } from "express";
import UserService from "../services/userService";
import UserController from "../controllers/userController";
import { getUserValidator, updateUserValidator, changeUserPasswordValidator, deleteUserValidator, uploadUserImageValidator, deleteUserImageValidator, updateUserPointsValidator} from "../utils/validators/userValidator";
import { verifyTokenAndAuthorizationMiddleware } from "../middlewares/authMiddleware";
import { uploadImage } from "../middlewares/uploadImageMiddleware";


const userRouter = Router();

const userService = new UserService();
const { getUsers,
        getUserById, 
        updateUser,
        changeUserPassword,
        deleteUser,
        uploadUserPicture,
        deleteUserPicture, 
        updateUserPoints} = new UserController(userService);

userRouter.route('/')
        .get(getUsers);

userRouter.route('/:id')
        .get(getUserValidator, getUserById)
        .patch(verifyTokenAndAuthorizationMiddleware, updateUserValidator, updateUser)
        .delete(verifyTokenAndAuthorizationMiddleware, deleteUserValidator, deleteUser);

userRouter.route('/activity/:id')
        .put(verifyTokenAndAuthorizationMiddleware, updateUserPointsValidator, updateUserPoints);

userRouter.route('/image/:id')
        .post(verifyTokenAndAuthorizationMiddleware, uploadImage, uploadUserImageValidator, uploadUserPicture)
        .delete(verifyTokenAndAuthorizationMiddleware, deleteUserImageValidator, deleteUserPicture);

userRouter.route('/change-password/:id')
        .put(verifyTokenAndAuthorizationMiddleware, changeUserPasswordValidator, changeUserPassword);

export default userRouter;

