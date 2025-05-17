import mongoose, { Schema, Model } from "mongoose";
import { IGuide } from "../../interfaces/iGuide";

const TrashGuideSchema: Schema = new Schema({
    articleTitle: {
        type: String,
    },
    content: {
        type: String,
    },
    articlePic:  {
        type: String, 
    },
    deletedAt: {
        type: Date,
        default: Date.now
    },
    deletedBy: {
        type: mongoose.Types.ObjectId,
        ref: 'User'
    }
}, { timestamps: true });

const TrashGuideModel: Model<IGuide> = 
    mongoose.models.trashGuideModel || mongoose.model<IGuide>('TrashGuide', TrashGuideSchema);
export default TrashGuideModel;