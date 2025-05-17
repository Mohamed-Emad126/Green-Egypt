import mongoose, { Document } from "mongoose";

export interface IUser extends Document {
    username: string;
    email: string;
    password: string;
    passwordChangedAt: Date;
    points: number;
    pointsHistory: {
        points: number;
        activity: TUserActivity;
        date: Date;
        img: string;
    }[];
    // pendingCoupons: number;
    profilePic: string;
    isActive: boolean;
    role: string;
    location?:{
        type?: string;
        coordinates?: [number, number]
    };
    createdAt?: Date;
    updatedAt?: Date;
    deletedAt?: Date;
    deletedBy?: {
        role: string;
        hisID: mongoose.Types.ObjectId;
    };
    isVerified: boolean;
    savedReports: mongoose.Types.ObjectId[];
    generateToken(expiration?: string): Promise<string>;
}

export interface IAuthInput {
    username?: string;
    email: string;
    password: string;
    profilePic?: string;
    location?:{
        type?: string;
        coordinates?: [number, number]
    }
}

export interface IUpdateInput {
    username?: string;
    email?: string;
    location?:{
        type?: string;
        coordinates?: [number, number]
    }
}

export type TUserActivity = 'locate' | 'report' | 'plant' | 'care';
