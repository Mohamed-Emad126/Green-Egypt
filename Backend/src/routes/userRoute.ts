import { Router } from "express";
import UserService from "../services/userService";
import UserController from "../controllers/userController";
import {getUserValidator,
        updateUserValidator, 
        changeUserPasswordValidator, 
        deleteUserValidator, 
        uploadUserImageValidator, 
        deleteUserImageValidator, 
        updateUserPointsValidator, 
        claimPendingCouponsValidator,
        promoteUserValidator, 
        getUserTreesValidator} from "../utils/validators/userValidator";
import { createTaskValidator, getUserTreesWithTasksValidator } from "../utils/validators/taskValidator";
import { locateTreeValidator } from "../utils/validators/treeValidator";
import { verifyUserMiddleware , verifyToken, verifyAdminMiddleware} from "../middlewares/authMiddleware";
import { uploadImage } from "../middlewares/uploadImageMiddleware";
import TaskController from "../controllers/taskController";
import TaskService from "../services/taskService";
import TreeController from "../controllers/treeController";
import TreeService from "../services/treeService";


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
        promoteUserToAdmin,
        getUserTrees} = new UserController(userService);

const taskService = new TaskService();
const { createTask, getUserTreesWithTasks } = new TaskController(taskService);

const treeService = new TreeService();
const { LocateTree } = new TreeController(treeService);

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

userRouter.route('/:id/promote-admin')
        .put(verifyAdminMiddleware,promoteUserValidator, promoteUserToAdmin);

userRouter.route('/:id/tree')
        .get(verifyToken, getUserTreesValidator, getUserTrees)
        .post(verifyToken, locateTreeValidator, LocateTree);

userRouter.route('/:id/task')
        .post(verifyUserMiddleware, createTaskValidator, createTask)
        .get(verifyUserMiddleware, getUserTreesWithTasksValidator,  getUserTreesWithTasks);



export default userRouter;

