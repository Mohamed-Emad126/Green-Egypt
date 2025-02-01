import mongoose, { Schema, Model } from "mongoose";
import { ITree } from "../interfaces/iTree";

const TreeSchema: Schema = new Schema({
    treeName: {
        type: String,
        required: [true, 'Tree name is required'],
        trim: true,
        maxLength: [10, 'Tree name cannot be more than 10 characters'],
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
    },
    plantedRecently: {
        type: Boolean,
        required: true,
        default: false
    },
    byUser: {
        type: mongoose.Schema.Types.ObjectId,
        ref: "User", 
        required: true
    },
    reportsAboutIt: [{
        type: mongoose.Schema.Types.ObjectId,
        ref: "Report"
    }],
    
}, { timestamps: true });

const TreeModel: Model<ITree> = mongoose.model<ITree>('Tree', TreeSchema);
export default TreeModel;

