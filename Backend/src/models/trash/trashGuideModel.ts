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
            type: String, 
    },
    createdAt:{
        type: Date,
    } 
})

const TrashGuideModel: Model<IGuide> = 
    mongoose.models.trashGuideModel || mongoose.model<IGuide>('TrashGuideModel', TrashGuideSchema);
export default TrashGuideModel;