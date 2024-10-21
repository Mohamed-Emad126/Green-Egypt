import { Date, Document } from "mongoose";

export interface IUser extends Document {
    username: string;
    email: string;
    password: string;
    passwordChangedAt: Date;
    points: number;
    profilePic: {
        imageName: string;
        imageUrl: string
    };
    isActive: boolean;
    generateToken(): Promise<string> ;
}


export interface IAuthInput {
    username?: string;
    email: string;
    password: string;
    profilePic?: {
        imageName: string;
        imageUrl: string
    };
}

export interface IUpdateInput {
    username?: string;
    email?: string;
}

export type TUserActivity = 'locate' | 'report' | 'plant' | 'care';
