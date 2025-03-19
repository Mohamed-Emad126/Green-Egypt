import mongoose, { Schema, Model } from "mongoose";
import { IUser } from "../../interfaces/iUser";

const trashUserSchema: Schema = new Schema({
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
        lowercase: true
    },
    profilePic: {
        type: String,
    }
    ,
    password: {
        type: String,
        required: [true, 'Password is required'],
    },
    passwordChangedAt: Date,
    points: {
        type: Number,
        min: [0, 'Points cannot be negative']
    },
    pointsHistory: [
        {
            points: Number,
            activity: String,
            createdAt: Date,
            img: String
        }
    ],
    pendingCoupons: {
        type: Number,
    },
    isActive: {
        type: Boolean,
        default: [false, 'User must be inactive']
    },
    role: {
        type: String,
        enum: ['user', 'admin'],
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

const trashUserModel: Model<IUser> = mongoose.model<IUser>('TrashUser', trashUserSchema);
export default trashUserModel;

