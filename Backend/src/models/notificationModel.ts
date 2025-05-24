import mongoose, { Schema, Model} from "mongoose";
import { INotification } from "../interfaces/iNotification";
import { title } from "process";

const NotificationSchema: Schema = new mongoose.Schema({
    userId: {
        type: Schema.Types.ObjectId,
        required: true,
        ref : 'User'
    },
    type: {
        type: String, 
        enum: ['info', 'warning','daily-task','community','coupon'],
        default: 'info'
    },
    title:{
        type: String,
        required:true
    },
    message: {
        type: String,
        required: true
    },
    createdAt: {
        type: Date,
        default: Date.now
    },
    read: {
        type: Boolean,
        default: false
    }
    
});

const NotificationModel: Model<INotification> = mongoose.model<INotification>('Notification', NotificationSchema);

export default NotificationModel;
