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
            length: 2
        }
    },
    healthStatus: {
        type: String,
        enum: ['Healthy', 'Diseased', 'Dying'],
        required: true
    },
    problem: {
        type: String,
    },
    image: String,
    deletionReason: {
        type: String,
        enum: ['Died', 'Cut down', 'False Record'],
        required: true
    },
    plantedRecently: {
        type: Boolean,
        required: true,
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

});

const trashTreeModel: Model<ITree> = mongoose.model<ITree>('TrashTree', trashTreeSchema);
export default trashTreeModel;

