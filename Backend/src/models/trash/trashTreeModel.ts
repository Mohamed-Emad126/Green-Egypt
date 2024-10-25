import mongoose, { Schema, Model } from "mongoose";
import { ITree } from "../../interfaces/iTree";

const trashTreeSchema: Schema = new Schema({
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
    problem: {
        type: String,
    },
    image: {
        imageName: {
            type: String,
            
        },
        imageUrl: {
            type: String,
        } 
        
    },
    deletionReason: {
        type: String,
        enum: ['Died', 'Cut down', 'False Record'],
        required: true
    }
});

const trashTreeModel: Model<ITree> = mongoose.model<ITree>('TrashTree', trashTreeSchema);
export default trashTreeModel;

