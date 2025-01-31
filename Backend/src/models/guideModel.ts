import mongoose, { Schema, Model } from "mongoose";
import { IGuide } from "../interfaces/iGuide";

const GuideSchema: Schema = new Schema({
    articletitle: {
        type: String,
        required: [true, 'articletitle is required'],
        minlength: [3, 'articletitle must be at least 3 characters long'],
        maxlength: [30, 'articletitle must not exceed 30 characters'],
    },
    content: {
        type: String,
        required: [true, 'content is required'],
    },
    articlePic:  {
        imageName: {
            type: String,
            default: 'not-found-image.png'
        },
        imageUrl: {
            type: String,
            default: '../uploads/not-found-image.png'
        } 
    },
    createdAt: Date,
});


const GuideModel: Model<IGuide> = mongoose.model<IGuide>('Guide', GuideSchema);
export default GuideModel;


