import mongoose, { Schema, Model } from "mongoose";
import { ITree } from "../interfaces/iTree";

const TreeSchema: Schema = new mongoose.Schema({
    species: {
        type: String,
        required: true
    },
    location: {
        type: String,
        required: true
    },
    healthStatus: {
        type: String,
        enum: ['Healthy', 'Diseased', 'Dying'],
        required: true
    },
    image: {
        type: String
    }
});

const TreeModel: Model<ITree> = mongoose.model<ITree>('Tree', TreeSchema);
export default TreeModel;

