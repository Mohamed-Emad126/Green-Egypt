import { Document } from "mongoose";

export interface ITree extends Document {
    species: string;
    treeLocation: {
        latitude: number;
        longitude: number;
    };
    healthStatus: 'Healthy' | 'Diseased' | 'Dying';
    problem?: string;
    image: string;
    deletionReason?: 'Died'| 'Cut Down'| 'False Record';
}

export interface ITreeInput {
    species?: string;
    treeLocation?: {
        latitude?: number;
        longitude?: number;
    };
    healthStatus?: 'Healthy' | 'Diseased' | 'Dying';
    problem?: string;
    image?: string;
}

export type TDeleteReason = 'Died'| 'Cut Down'| 'False Record'