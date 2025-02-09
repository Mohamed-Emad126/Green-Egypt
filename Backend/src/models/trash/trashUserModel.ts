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
            enum: ['Point'],
            default: 'Point',
            required: true,
        },
        coordinates: {
            type: [Number],
            required: true,
            length: 2
        }
    }
    
}, { timestamps: true });

const trashUserModel: Model<IUser> = mongoose.model<IUser>('TrashUser', trashUserSchema);
export default trashUserModel;

