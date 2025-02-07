import mongoose, { Schema, Model } from "mongoose";
import { INursery } from "../interfaces/iNursery";

const NurserySchema: Schema = new Schema({
    nurseryname: {
        type: String,
        required: [true, 'nurseryname is required'],
        minlength: [3, 'nurseryname must be at least 3 characters long'],
        maxlength: [100, 'nurseryname must not exceed 100 characters'],
    },
    nurseryPic: {
        type: String,
    },
    location: {
        type: String,
        required: [true, 'location is required'],
        minlength: [3, 'location must be at least 3 characters long'],
        maxlength: [100, 'location must not exceed 100 characters'],
    },
});
const NurseryModel: Model<INursery> = mongoose.model<INursery>('Nursery', NurserySchema);
export default NurseryModel;



