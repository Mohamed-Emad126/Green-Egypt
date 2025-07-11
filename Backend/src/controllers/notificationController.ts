import NotificationService from '../services/notificationService';
import { INotificationInput } from '../interfaces/iNotification';
import { Request, Response, NextFunction } from 'express';
import asyncHandler from 'express-async-handler';
import ApiError from '../utils/apiError';

export default class NotificationController {

    constructor(private notificationService: NotificationService) {}

    /**
     * @desc      Create a new notification
     * @route     POST /api/notifications/create
     * @access    Private
    */

    createNotification = asyncHandler(async (req: Request, res: Response, next: NextFunction) => {
        const { userId, title, type, message, reportId }: INotificationInput = req.body;
        
        try{
            const notification = await this.notificationService.createNotification({ userId, title, type, message,reportId});
            res.status(201).json({ message: "Notification created successfully"});
            return;
        } catch (err: any) {
            if (err.message === "reportId is required for community notifications") {
                return next(new ApiError(err.message, 400));
        }
            if (err.message === "Report not found") {
                return next(new ApiError(err.message, 404));
        }
        return next(new ApiError("Error creating notification", 500));
        }
    });

    /**
     * @desc      Send a push notification to a user
     * @route     POST /api/notifications/send
     * @access    Private
    */

    sendPushNotification = asyncHandler(async (req: Request, res: Response, next: NextFunction) => {
        const { userId, title, message } = req.body;
        const fcm = await this.notificationService.sendPushNotification(userId, title, message);
        if (fcm.success) {
            res.json({ message: "Push notification sent successfully" });
            return;
        }else{
            return next(new ApiError(fcm.error || "Error sending push notification", 500));
        }
    });

    /**
     * @desc      Send a notification with save
     * @route     POST /api/notifications/send-with-save
     * @access    Private
    */

    sendNotificationWithSave = asyncHandler(async (req: Request, res: Response, next: NextFunction) => {
        const {userId , type, title, message, reportId } = req.body;
        const notification = await this.notificationService.sendNotificationWithSave({userId, type, title, message, reportId});
        if (notification.savedNotification && notification.fcmResult?.success) {
            res.json({ message: "Notification saved and push notification sent successfully" });
            return;
        }else{
            return next(new ApiError(notification.error || "Error sending push notification", 500));
        }
    });

    /**
     * @desc      Get user notifications, optionally filtered by type
     * @route     GET /api/notifications/get-user-notifications?type=TYPE
     * @access    Private
    */

    getUserNotifications = asyncHandler(async (req: Request, res: Response, next: NextFunction) => {
        const { userId } = req.body;
        const { type } = req.query;
        const userNotifications = await this.notificationService.getUserNotifications(userId, type as string);
        if (userNotifications) {
            res.json(userNotifications);
            return;
        }else{
            return next(new ApiError("Error getting user notifications", 404));
        }
    });

    /**
     * @desc      Mark a notification as read
     * @route     PUT /api/notifications/mark-as-read/:id
     * @access    Private
    */

    markAsRead = asyncHandler(async (req: Request, res: Response, next: NextFunction) => {
        const {id} = req.params;
        const notification = await this.notificationService.markAsRead(id);
        if (notification) {
            res.json({ message: "Notification marked as read successfully" });
            return;
        }else{
            return next(new ApiError("Error marking notification as read", 404));
        }
    });

    /**
     * @desc      Delete a notification
     * @route     DELETE /api/notifications/delete/:id
     * @access    Private
    */

    deleteNotification = asyncHandler(async (req: Request, res: Response, next: NextFunction) => {
        const {id} = req.params;
        const notification = await this.notificationService.deleteNotification(id);
        if (notification) {
            res.json({ message: "Notification deleted successfully" });
            return;
        }else{
            return next(new ApiError("Notification not found",404));
        }
    });

    /**
     * @desc      Delete all notifications
     * @route     DELETE /api/notifications/deleteAll
     * @access    Private
     */

    deleteAllNotifications = asyncHandler(async (req: Request, res: Response, next: NextFunction) => {
        const {userId} = req.body;
        const result = await this.notificationService.deleteAllNotifications(userId);
        if (result.deleted > 0) {
            res.json({ message: "All notifications deleted successfully", deleted: result.deleted});
            return;
        }else{
            return next(new ApiError("Error deleting notifications", 404));
        }
    });

}