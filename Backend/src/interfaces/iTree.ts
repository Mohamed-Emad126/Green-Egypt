import mongoose, { Document } from "mongoose";

export interface ITree extends Document {
    treeName: string;
    treeLocation: {
        type: string;
        coordinates: [number, number]
    };
    healthStatus: 'Healthy' | 'Diseased' | 'Dying';
    problem?: string;
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
    reportsAboutIt: mongoose.Schema.Types.ObjectId[];
}

export interface ITreeInput {
    treeName: string;
    treeLocation: {
        type: string;
        coordinates: [number, number]
    };
    healthStatus: 'Healthy' | 'Diseased' | 'Dying';
    problem: string;
    image: string;
    plantedRecently: boolean,
    byUser: mongoose.Schema.Types.ObjectId,
}

export type TDeleteReason = 'Died'| 'Cut Down'| 'False Record'