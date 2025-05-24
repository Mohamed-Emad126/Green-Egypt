import { Router } from "express";
import NotificationService from "../services/notificationService";
import NotificationController from "../controllers/notificationController"; 
import {createNotificationValidator,
        sendNotificationValidator,
        sendNotificationwithSaveValidator,
        getUserNotificationsValidator,
        markAsReadValidator,
        deleteNotificationValidator,
        deleteAllNotificationsValidator} from "../utils/validators/notificationValidator";

const notificationRouter  = Router();

const notificationService = new NotificationService();
const {
    createNotification,
    sendPushNotification,
    sendNotificationWithSave,
    getUserNotifications,
    markAsRead,
    deleteNotification,
    deleteAllNotifications} = new NotificationController(notificationService);

notificationRouter.route("/create")
        .post(createNotificationValidator, createNotification);

notificationRouter.route("/send")
        .post(sendNotificationValidator ,sendPushNotification);

notificationRouter.route("/send-with-save")
        .post(sendNotificationwithSaveValidator, sendNotificationWithSave);

notificationRouter.route("/get-user-notifications")
        .get(getUserNotificationsValidator,getUserNotifications);

notificationRouter.route("/markAsRead/:id")
        .patch(markAsReadValidator, markAsRead);

notificationRouter.route("/delete/:id")
        .delete(deleteNotificationValidator ,deleteNotification);

notificationRouter.route("/deleteAll")
        .delete(deleteAllNotificationsValidator,deleteAllNotifications);

export default notificationRouter;

