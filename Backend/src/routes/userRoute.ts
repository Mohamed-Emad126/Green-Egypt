import { Router } from "express";
import UserService from "../services/userService";
import UserController from "../controllers/userController";
import { getUserValidator, updateUserValidator, changeUserPasswordValidator, deleteUserValidator, uploadUserImageValidator, deleteUserImageValidator, updateUserPointsValidator, claimPendingCouponsValidator} from "../utils/validators/userValidator";
import { verifyUserMiddleware , verifyToken, verifyAdminMiddleware} from "../middlewares/authMiddleware";
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
        updateUserPoints,
        claimPendingCoupons} = new UserController(userService);

userRouter.route('/')
        .get(verifyAdminMiddleware, getUsers);

userRouter.route('/:id')
        .get(verifyToken, getUserValidator, getUserById)
        .patch(verifyUserMiddleware, updateUserValidator, updateUser)
        .delete(verifyUserMiddleware, deleteUserValidator, deleteUser)
        .put(verifyUserMiddleware, updateUserPointsValidator, updateUserPoints)
        .post(verifyUserMiddleware, claimPendingCouponsValidator, claimPendingCoupons);

userRouter.route('/activity/:id')
        .put(verifyUserMiddleware, updateUserPointsValidator, updateUserPoints);

userRouter.route('/image/:id')
        .post(verifyUserMiddleware, uploadImage, uploadUserImageValidator, uploadUserPicture)
        .delete(verifyUserMiddleware, deleteUserImageValidator, deleteUserPicture);

userRouter.route('/change-password/:id')
        .put(verifyUserMiddleware, changeUserPasswordValidator, changeUserPassword);

export default userRouter;

