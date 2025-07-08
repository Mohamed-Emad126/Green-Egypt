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
        //claimPendingCouponsValidator,
        promoteUserValidator, 
        getUserTreesValidator, 
        getUserPointsHistoryValidator,
        getUserSavedReportsValidator
        } from "../utils/validators/userValidator";

import { createTaskValidator, getUserTreesWithTasksValidator } from "../utils/validators/taskValidator";
import { locateTreeValidator } from "../utils/validators/treeValidator";
import { getUserInterestedEventsValidator } from "../utils/validators/eventValidator";
import { verifyUserMiddleware , verifyToken, verifyAdminMiddleware} from "../middlewares/authMiddleware";
import { uploadImage } from "../middlewares/uploadImageMiddleware";
import TaskController from "../controllers/taskController";
import TaskService from "../services/taskService";
import TreeController from "../controllers/treeController";
import TreeService from "../services/treeService";
import EventService from "../services/eventService";
import EventController from "../controllers/eventController";


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
        //claimPendingCoupons,
        promoteUserToAdmin,
        getUserTrees,
        getUserPointsHistory,
        getUserSavedReports,
        saveDeviceToken} = new UserController(userService);

const taskService = new TaskService();
const { createTask, getUserTreesWithTasks } = new TaskController(taskService);

const treeService = new TreeService();
const { LocateTree } = new TreeController(treeService);

const eventService = new EventService();
const { getUserInterestedEvents } = new EventController(eventService);

userRouter.route('/')
        .get(verifyAdminMiddleware, getUsers);

userRouter.route('/:id')
        .get(verifyToken, getUserValidator, getUserById)
        .patch(verifyUserMiddleware, updateUserValidator, updateUser)
        .delete(verifyUserMiddleware, deleteUserValidator, deleteUser)

userRouter.route('/:id/activity')
        .put(verifyUserMiddleware, updateUserPointsValidator, updateUserPoints);

userRouter.route('/:id/points-history')
        .get(verifyUserMiddleware, getUserPointsHistoryValidator, getUserPointsHistory);

// userRouter.route('/:id/claim-coupon')
//         .post(verifyUserMiddleware, claimPendingCouponsValidator, claimPendingCoupons);

userRouter.route('/:id/image')
        .patch(verifyUserMiddleware, uploadImage, uploadUserImageValidator, uploadUserPicture)
        .delete(verifyUserMiddleware, deleteUserImageValidator, deleteUserPicture);

userRouter.route('/:id/change-password')
        .put(verifyUserMiddleware, changeUserPasswordValidator, changeUserPassword);

userRouter.route('/:id/promote-admin')
        .put(verifyAdminMiddleware, promoteUserValidator, promoteUserToAdmin);

userRouter.route('/:id/tree')
        .get(verifyToken, getUserTreesValidator, getUserTrees)
        .post(verifyUserMiddleware, uploadImage, locateTreeValidator, LocateTree);

userRouter.route('/:id/task')
        .post(verifyUserMiddleware, createTaskValidator, createTask)
        .get(verifyUserMiddleware, getUserTreesWithTasksValidator,  getUserTreesWithTasks);


userRouter.route('/:id/device-token')
        .patch(verifyUserMiddleware, updateUserValidator, saveDeviceToken);


userRouter.route('/:id/saved-reports')
        .get(verifyUserMiddleware, getUserSavedReportsValidator, getUserSavedReports);

userRouter.route('/:id/events')
        .get(verifyUserMiddleware, getUserInterestedEventsValidator, getUserInterestedEvents);

export default userRouter;