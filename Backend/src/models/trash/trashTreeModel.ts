import mongoose, { Schema, Model } from "mongoose";
import { ITree } from "../../interfaces/iTree";

const trashTreeSchema: Schema = new Schema({
    treeName: {
        type: String,
        trim: true,
    },
    treeLocation: {
        type: {
            type: String,
            enum: ['Point'],
            required: true,
        },
        coordinates: {
            type: [Number],
            required: true,
        }
    },
    healthStatus: {
        type: String,
        enum: ['Healthy', 'Needs Care'],
        required: true
    },
    problem: {
        type: mongoose.Types.ObjectId,
        ref: 'Report',
    },
    image: String,
    plantedRecently: {
        type: Boolean,
        required: true,
    },
    byUser: {
        type: mongoose.Schema.Types.ObjectId,
        ref: "User", 
        required: true
    },
    reportsAboutIt: {
        type: {
            resolved: [{
                type: mongoose.Schema.Types.ObjectId,
                ref: "Report",
                default: []
            }],
            unresolved: [{
                type: mongoose.Schema.Types.ObjectId,
                ref: "Report",
                default: []
            }]
        }
    },
    deletionReason: {
        type: String,
        enum: ['Died', 'Cut down', 'False Record'],
        required: true
    },
    deletedAt: {
        type: Date,
        default: Date.now
    },
    deletedBy: {
        role: {
            type: String,
            enum: ['user', 'admin'],
        },
        hisID:{
            type: mongoose.Types.ObjectId,
            ref: 'User'
        }
    }
}, { timestamps: true });

const trashTreeModel: Model<ITree> = mongoose.model<ITree>('TrashTree', trashTreeSchema);
export default trashTreeModel;

