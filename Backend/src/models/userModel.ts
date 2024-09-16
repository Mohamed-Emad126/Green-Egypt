import mongoose, { Schema, Model } from "mongoose";
import { IUser } from "../interfaces/iUser";

const UserSchema: Schema = new Schema({
    username: {
        type: String,
        required: true
    },
    email: {
        type: String,
        required: true,
        unique: true
    },
    password: {
        type: String,
        required: true
    },
    points: {
        type: Number,
        default: 0
    }
});

const UserModel: Model<IUser> = mongoose.model<IUser>('User', UserSchema);
export default UserModel;

