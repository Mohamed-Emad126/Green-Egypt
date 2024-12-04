import mongoose, { Schema, Model } from "mongoose";
import { ITree } from "../interfaces/iTree";

const TreeSchema: Schema = new Schema({
    species: {
        type: String,
        trim: true,
        required: [true, 'Species is required']
    },
    treeLocation: {
        latitude: {
            type: Number,
            required: [true, 'Latitude is required'],
        },
        longitude: {
            type: Number,
            required: [true, 'Longitude is required'],
        }
    },
    healthStatus: {
        type: String,
        enum: ['Healthy', 'Diseased', 'Dying'],
        required: true,
    },
    problem: {
        type: String,
        required: function () {
            return this.healthStatus === 'Diseased' || this.healthStatus === 'Dying';
        },
        trim: true,
        default: 'No problem'
    },
    image: {
        type: String,
        default: '../uploads/not-found-image.png'
    }
}, { timestamps: true });

const TreeModel: Model<ITree> = mongoose.model<ITree>('Tree', TreeSchema);
export default TreeModel;

