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
    },
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
            date: Date,
            img: String
        }
    ],
    // pendingCoupons: {
    //     type: Number,
    // },
    isActive: {
        type: Boolean,
        default: false
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
    },
    address: {
        type: String,
    },
    isVerified: {
        type: Boolean,
    },
    savedReports: [{
        type: mongoose.Types.ObjectId,
        ref: 'Report'
    }],
    deletedAt: {
        type: Date,
        default: Date.now
    },
    deletedBy: {
        role: {
            type: String,
            enum: ['user', 'admin'],
        },
        hisID:{
            type: mongoose.Types.ObjectId,
            ref: 'User'
        }
    }
}, { timestamps: true });

const trashUserModel: Model<IUser> = mongoose.model<IUser>('TrashUser', trashUserSchema);
export default trashUserModel;

