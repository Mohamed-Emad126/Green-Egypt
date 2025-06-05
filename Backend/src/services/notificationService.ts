import admin from '../utils/firebase';
import NotificationModel from '../models/notificationModel';
import { INotificationInput ,ISendNotificationInput } from '../interfaces/iNotification';
import UserModel from '../models/userModel';

export default class NotificationService {
    async createNotification(notificationData: INotificationInput){
        const notification = new NotificationModel({
            userId: notificationData.userId,
            type: notificationData.type,
            title: notificationData.title,
            message: notificationData.message
        });
        return await notification.save();
    }

    async sendPushNotification(userId: string, title: string, message: string){
        const user = await UserModel.findById(userId);

        if (!user || !user.deviceToken) {
            return { success: false, error: 'User not found or device token missing' };
        }
        const payload: admin.messaging.Message = {
            notification: { title, body: message },  // structure used in the Firebase Admin SDK notification: {title: string;body: string;}
            token: user.deviceToken,
        };
        try {
            const response = await admin.messaging().send(payload);
            return { success: true, response };
        } catch (error) {
            console.error('FCM Error:', error);
            return { success: false, error };
        }
    }

    async sendNotificationWithSave(notificationData: INotificationInput){
        const { userId, type, title, message } = notificationData;

        const user = await UserModel.findById(userId);
        if (!user || !user.deviceToken) {
            return { success: false, error: 'User not found or device token missing' };
        }

        const savedNotification = await this.createNotification({ userId, type, title, message });
        const fcmResult = await this.sendPushNotification(user.deviceToken, title, message);
        return { savedNotification, fcmResult };
    }

    async getUserNotifications(userId: string){
        return await NotificationModel.find({ userId }).sort({ createdAt: -1 }); // sort by descending order
    }

    async markAsRead(notificationId: string){
        return await NotificationModel.findByIdAndUpdate(notificationId, { read: true }, { new: true });
    }

    async deleteNotification(notificationId: string) {
        return await NotificationModel.findByIdAndDelete(notificationId);
    }

    async deleteAllNotifications(userId: string) {
        return await NotificationModel.deleteMany({ userId });
    }
}
