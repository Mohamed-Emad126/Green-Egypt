import { Document } from "mongoose";

export interface INotification extends Document {
    userId: string;
    type: 'info' | 'warning' | 'daily-task' | 'community' | 'coupon';
    title: string;
    message: string;
    createdAt: Date;
    read: boolean;
    reportId?: string;
}

export interface INotificationInput {
    userId: string;
    type: 'info' | 'warning' | 'daily-task' | 'community' | 'coupon';
    title: string;
    message: string;
    reportId?: string;

}