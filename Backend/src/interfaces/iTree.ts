import mongoose, { Document } from "mongoose";

export interface ITree extends Document {
    treeName: string;
    treeLocation: {
        type: string;
        coordinates: [number, number]
    };
    healthStatus: 'Healthy' | 'Needs Care';
    problem?: mongoose.Types.ObjectId;
    image: string;
    deletionReason?: 'Died'| 'Cut Down'| 'False Record';
    deletedAt?: Date;
    deletedBy?: {
        role: string;
        hisID: mongoose.Types.ObjectId;
    };
    plantedRecently: boolean,
    byUser: mongoose.Schema.Types.ObjectId,
    createdAt?: Date,
    updatedAt?: Date,
    reportsAboutIt: {
        resolved: mongoose.Types.ObjectId[];
        unresolved: mongoose.Types.ObjectId[];
    };
}

export interface ITreeInput {
    treeName?: string;
    treeLocation?: {
        type: string;
        coordinates: [number, number]
    };
    image?: string;
    byUser?: mongoose.Schema.Types.ObjectId,
    plantedRecently?: boolean
}

export type TDeleteReason = 'Died'| 'Cut Down'| 'False Record'