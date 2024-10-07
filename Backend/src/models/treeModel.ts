import mongoose, { Schema, Model } from "mongoose";
import { ITree } from "../interfaces/iTree";

const TreeSchema: Schema = new Schema({
    species: {
        type: String,
        trim: true,
        required: [true, 'Species is required']
    },
    location: {
        type: String,
        required: [true, 'Location is required']
    },
    healthStatus: {
        type: String,
        enum: ['Healthy', 'Diseased', 'Dying'],
        required: true
    },
    image: {
        imageName: {
            type: String,
            
        },
        imageUrl: {
            type: String,
        } 
        
    }
});

const TreeModel: Model<ITree> = mongoose.model<ITree>('Tree', TreeSchema);
export default TreeModel;

