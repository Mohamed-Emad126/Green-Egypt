import mongoose, { Document } from "mongoose";

export interface INotification extends Document {
    userId: string;
    type: 'info' | 'warning' | 'daily-task' | 'community' | 'coupon';
    title: string;
    message: string;
    createdAt: Date;
    read: boolean;
}

export interface INotificationInput {
    userId: string;
    type: 'info' | 'warning' | 'daily-task' | 'community' | 'coupon';
    title: string;
    message: string;
}


export interface ISendNotificationInput {
    userId: string;
    type: 'info' | 'warning' | 'daily-task' | 'community' | 'coupon';
    title: string;
    message: string;
    token: string;
}
