import { Date, Document } from "mongoose";

export interface IUser extends Document {
    username: string;
    email: string;
    password: string;
    passwordChangedAt: Date;
    points: number;
    pendingCoupons: number;
    profilePic: string;
    isActive: boolean;
    role: string;
    location?:{
        latitude?: number;
        longitude?: number;
    };
    generateToken(expiration?: string): Promise<string>;
}

export interface IAuthInput {
    username?: string;
    email: string;
    password: string;
    profilePic?: string;
    location?:{
        latitude?: number;
        longitude?: number;
    }
}

export interface IUpdateInput {
    username?: string;
    email?: string;
    location?:{
        latitude?: number;
        longitude?: number;
    }
}

export type TUserActivity = 'locate' | 'report' | 'plant' | 'care';
