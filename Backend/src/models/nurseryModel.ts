import mongoose, { Schema, Model } from "mongoose";
import { INursery } from "../interfaces/iNursery";

const NurserySchema: Schema = new Schema({
    nurseryName: {
        type: String,
        required: [true, 'Nursery name is required'],
        minlength: [3, 'Nursery name must be at least 3 characters long'],
        maxlength: [100, 'Nursery name must not exceed 100 characters'],
    },
    nurseryPic: {
        type: String,
    },
    address: {
        type: String,
        required: [true, 'location is required'],
        minlength: [3, 'location must be at least 3 characters long'],
        maxlength: [100, 'location must not exceed 100 characters'],
    },
    location: {
        type: {
            type: String,
            enum: ['Point'],
            required: true
        },
        coordinates: {
            type: [Number],
            required: true
        }
    },
    rate: {
        type: Number,
        required: [true, 'rate is required'],
        min: [1, 'rate must be at least 1'],
        max: [5, 'rate must not exceed 5']
    }
});
const NurseryModel: Model<INursery> = mongoose.model<INursery>('Nursery', NurserySchema);
export default NurseryModel;



