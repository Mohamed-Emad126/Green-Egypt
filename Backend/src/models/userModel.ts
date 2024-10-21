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
        imageName: {
            type: String,
            default: 'default-user-avatar.png'
        },
        imageUrl: {
            type: String,
            default: '../uploads/default-user-avatar.png'
        }
    }
    ,
    password: {
        type: String,
        required: [true, 'Password is required'],
        minlength: [6, 'Password must be at least 6 characters long']
    },
    passwordChangedAt: Date,
    points: {
        type: Number,
        default: 0,
        min: [0, 'Points cannot be negative']
    },
    isActive: {
        type: Boolean,
        default: true
    }
}, { timestamps: true });

UserSchema.methods.generateToken = async function () : Promise<string> {

    const token = jwt.sign({ id: this.id }, process.env.JWT_SECRET as string , { expiresIn: process.env.JWT_EXPIRE_TIME as string });

    const expireDays = parseInt(process.env.JwT_EXPIRE_TIME as string);
    const expiresAt = new Date(Date.now() +  expireDays * 24 * 60 * 60 * 1000);

    await Token.create({
        token: token,
        expiresAt: expiresAt,
        blacklisted: false 
    });

    return token;
}


const UserModel: Model<IUser> = mongoose.model<IUser>('User', UserSchema);
export default UserModel;


