import admin from '../utils/firebase';
import NotificationModel from '../models/notificationModel';
import { INotificationInput } from '../interfaces/iNotification';
import UserModel from '../models/userModel';
import ReportModel from '../models/reportModel';
import trashNotification from '../models/trash/trashNotificationModel';
import mongoose from "mongoose";


export default class NotificationService {
    async createNotification(notificationData: INotificationInput) {
        const { userId, type, title, message, reportId } = notificationData;

        if (type === 'community') {
            if (!reportId) {
                throw new Error("reportId is required for community notifications");
            }

            const reportExists = await ReportModel.findById(reportId);
            if (!reportExists) {
                throw new Error("Report not found");
            }
        }

        const notification = {
        userId: new mongoose.Types.ObjectId(userId),
        type,
        title,
        message,
        reportId: reportId ? new mongoose.Types.ObjectId(reportId) : undefined,
    };

        const newNotification = new NotificationModel(notification);
        return await newNotification.save();
    }

    async sendPushNotification(userId: string, title: string, message: string){
        const user = await UserModel.findById(userId);

        if (!user) {
            console.error('User not found with ID:', userId);
            return { success: false, error: 'User not found' };
        }

        if (!user.deviceToken) {
            console.error('User deviceToken missing for user:', userId);
            return { success: false, error: 'Device token missing' };
        }

        const payload: admin.messaging.Message = {
            notification: { title, body: message },  // structure used in the Firebase Admin SDK notification: {title: string;body: string;}
            token: user.deviceToken,
        };
        try {
            const response = await admin.messaging().send(payload);
            return { success: true, response };
        }catch (error: any) {
        console.error('FCM Error:', error);
        return { success: false, error: error.message || error.toString() };
        }
    }

    async sendNotificationWithSave(notificationData: INotificationInput){
        const { userId, type, title, message, reportId } = notificationData;

        try{
        const user = await UserModel.findById(userId);

        if (!user) {
            console.error('User not found with ID:', userId);
            return { success: false, error: 'User not found' };
        }

        if (!user.deviceToken) {
            console.error('User deviceToken missing for user:', userId);
            return { success: false, error: 'Device token missing' };
        }

        const savedNotification = await this.createNotification({ userId, type, title, message, reportId});
        const fcmResult = await this.sendPushNotification(userId, title, message);

        if (!fcmResult.success) {
            console.error(`[NotificationService] FCM send failed: ${fcmResult.error}`);
        }

        return {
            success: true,
            savedNotification,
            fcmResult
        };
    } catch (error: any) {
        console.error('[NotificationService] Unexpected error in sendNotificationWithSave:', error);
        return { success: false, error: error.message || 'Unexpected error occurred' };
    }
    }

    async getUserNotifications(userId: string,type?: string){
        const filter: any = { userId };
        if (type) {
            filter.type = type;
        }
        return await NotificationModel.find(filter).sort({ createdAt: -1 });
    }

    async markAsRead(notificationId: string){
        return await NotificationModel.findByIdAndUpdate(notificationId, { read: true }, { new: true });
    }

    async deleteNotification(notificationId: string) {
        const notification = await NotificationModel.findById(notificationId);
        if (!notification) {
            throw new Error("Notification not found");
        }
        const toTrash = new trashNotification({...notification.toObject(),deletedAt: new Date()});
        await toTrash.save();

        await notification.deleteOne();
        return true
    }

    async deleteAllNotifications(userId: string) {
        const allNotifications = await NotificationModel.find({ userId });
        if (!allNotifications.length) {
            return { deleted: 0 };
        }

        const trashData = allNotifications.map(notification => ({...notification.toObject(),deletedAt: new Date()}));
        await trashNotification.insertMany(trashData);

        const result = await NotificationModel.deleteMany({ userId });
        return { deleted: result.deletedCount || 0 };
    }
}
