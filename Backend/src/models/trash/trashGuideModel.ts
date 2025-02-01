import mongoose, { Schema, Model } from "mongoose";
import { IGuide } from "../../interfaces/iGuide";

const TrashGuideSchema: Schema = new Schema({
    articletitle: {
        type: String,
    },
    content: {
        type: String,
    },
    articlePic:  {
        imageName: {
            type: String,
        },
        imageUrl: {
            type: String,
        } 
    },
    createdAt:{
        type: Date,
    } 
})

const TrashGuideModel: Model<IGuide> = 
    mongoose.models.Trash || mongoose.model<IGuide>('Trash', TrashGuideSchema);
export default TrashGuideModel;