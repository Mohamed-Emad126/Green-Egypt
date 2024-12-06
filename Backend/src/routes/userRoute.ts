import { Router } from "express";
import UserService from "../services/userService";
import UserController from "../controllers/userController";
import { getUserValidator, updateUserValidator, changeUserPasswordValidator, deleteUserValidator, uploadUserImageValidator, deleteUserImageValidator, updateUserPointsValidator, claimPendingCouponsValidator,promoteUserValidator} from "../utils/validators/userValidator";
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
        claimPendingCoupons,
        promoteUserToAdmin,} = new UserController(userService);

userRouter.route('/')
        .get(verifyAdminMiddleware, getUsers);

userRouter.route('/:id')
        .get(verifyToken, getUserValidator, getUserById)
        .patch(verifyUserMiddleware, updateUserValidator, updateUser)
        .delete(verifyUserMiddleware, deleteUserValidator, deleteUser)
        .post(verifyUserMiddleware, claimPendingCouponsValidator, claimPendingCoupons);

userRouter.route('/:id/activity')
        .put(verifyUserMiddleware, updateUserPointsValidator, updateUserPoints);

userRouter.route('/:id/claim-coupon')
        .post(verifyUserMiddleware, claimPendingCouponsValidator, claimPendingCoupons);

userRouter.route('/:id/image')
        .post(verifyUserMiddleware, uploadImage, uploadUserImageValidator, uploadUserPicture)
        .delete(verifyUserMiddleware, deleteUserImageValidator, deleteUserPicture);

userRouter.route('/:id/change-password')
        .put(verifyUserMiddleware, changeUserPasswordValidator, changeUserPassword);

userRouter.route('/promote-admin/:id')
        .put(verifyAdminMiddleware,promoteUserValidator, promoteUserToAdmin);
        
export default userRouter;

