import mongoose, { Schema, Model } from "mongoose";
import { IUser } from "../interfaces/iUser";
import jwt from "jsonwebtoken";
import Token from "./tokenModel";

const UserSchema: Schema = new Schema({
    username: {
        type: String,
        trim: true,
        required: [true, 'username is required'],
        minlength: [3, 'username must be at least 3 characters long'],
        maxlength: [15, 'username must not exceed 15 characters'],
    },
    email: {
        type: String,
        required: [true, 'Email is required'],
        unique: true,
        lowercase: true
    },
    profilePic: {
        type: String,
        default: '../uploads/default-user-avatar.png'
    },
    password: {
        type: String,
        required: [true, 'Password is required'],
        minlength: [8, 'Password must be at least 8 characters long']
    },
    passwordChangedAt: Date,
    points: {
        type: Number,
        default: 0,
        min: [0, 'Points cannot be negative']
    },
    pointsHistory: [
        {
            points: Number,
            activity: {
                type: String,
                enum: ['locate', 'report', 'plant', 'care'],
            },
            date: Date,
            img: String
        }
    ],
    pendingCoupons: {
        type: Number,
        default: 0,
        min: [0, 'Points cannot be negative']
    },
    isActive: {
        type: Boolean,
        default: true
    },
    role: {
        type: String,
        enum: ['admin', 'user'],
        default: 'user'
    },
    location: {
        type: {
            type: String,
        },
        coordinates: {
            type: [Number],
        }
    }    
}, { timestamps: true });

UserSchema.index({ location: '2dsphere' });

UserSchema.methods.generateToken = async function (customExpireTime?: string): Promise<string> {
    const expiresIn = customExpireTime || process.env.JWT_EXPIRE_TIME as string;

    const token = jwt.sign({ id: this.id, role: this.role }, process.env.JWT_SECRET as string, { expiresIn });

    const expireValue = parseInt(expiresIn.slice(0, -1));
    const expireUnit = expiresIn.slice(-1);
    let expiresAt;

    switch (expireUnit) {
        case 'm':
            expiresAt = new Date(Date.now() + expireValue * 60 * 1000);
            break;
        case 'h':
            expiresAt = new Date(Date.now() + expireValue * 60 * 60 * 1000);
            break;
        case 'd':
            expiresAt = new Date(Date.now() + expireValue * 24 * 60 * 60 * 1000);
            break;
        default:
            throw new Error("Invalid JWT expiration format");
    }
    await Token.create({
        token: token,
        expiresAt: expiresAt,
        blacklisted: false,
        user: this.id
    });
    
    return token;
};

const UserModel: Model<IUser> = mongoose.model<IUser>('User', UserSchema);
export default UserModel;


