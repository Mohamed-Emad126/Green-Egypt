import mongoose, { Schema, Model } from "mongoose";
import { ITree } from "../interfaces/iTree";

const TreeSchema: Schema = new Schema({
    treeName: {
        type: String,
        required: [true, 'Tree name is required'],
        trim: true,
        maxLength: [15, 'Tree name cannot be more than 15 characters'],
    },
    treeLocation: {
        type: {
            type: String,
            enum: ['Point'],
            default: 'Point',
            required: true,
        },
        coordinates: {
            type: [Number],
            required: true,
            validate: {
                validator: function (value: number[]) {
                    return value.length === 2;
                },
                message: 'Coordinates must have exactly two elements',
            },
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

TreeSchema.index({ treeLocation: '2dsphere' });

const TreeModel: Model<ITree> = mongoose.model<ITree>('Tree', TreeSchema);
export default TreeModel;

