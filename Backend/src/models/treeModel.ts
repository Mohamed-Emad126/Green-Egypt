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
            index: '2dsphere',
        }
    },
    healthStatus: {
        type: String,
        enum: ['Healthy', 'Needs Care'],
        default: 'Healthy',
        required: true,
    },
    problem: {
        type: mongoose.Types.ObjectId,
        ref: 'Report',
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
    reportsAboutIt: {
        type: {
            resolved: [{
                type: mongoose.Types.ObjectId,
                ref: "Report",
                default: []
            }],
            unresolved: [{
                type: mongoose.Types.ObjectId,
                ref: "Report",
                default: []
            }],
            _id : false
        },
        default: {
            resolved: [],
            unresolved: []
        }
    }
    
}, { timestamps: true });

TreeSchema.index({ treeLocation: '2dsphere' });

const TreeModel: Model<ITree> = mongoose.model<ITree>('Tree', TreeSchema);
export default TreeModel;

