import mongoose, { Schema, Model } from "mongoose";
import { IGuide } from "../interfaces/iGuide";

const GuideSchema: Schema = new Schema({
    articleTitle: {
        type: String,
        required: [true, 'article Title is required'],
        minlength: [3, 'article Title must be at least 3 characters long'],
        maxlength: [60, 'article Title must not exceed 60 characters'],
    },
    content: {
        type: String,
        required: true,
    },
    articlePic:  {
        type: String,
        default: '../uploads/not-found-image.png'
    }
}, { timestamps: true });


const GuideModel: Model<IGuide> = mongoose.model<IGuide>('Guide', GuideSchema);
export default GuideModel;


