import mongoose,{ Schema, Model } from "mongoose";
import { INotification } from "../../interfaces/iNotification";

const TrashNotificationSchema: Schema = new Schema({
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
    },
    reportId: {
        type: mongoose.Schema.Types.ObjectId,
        ref: 'Report',
        required: false
    },
    deletedAt: { 
        type: Date, 
        default: Date.now 
    }

})

const trashNotificationModel: Model<INotification> = mongoose.model<INotification>('TrashNotification', TrashNotificationSchema);
export default trashNotificationModel;