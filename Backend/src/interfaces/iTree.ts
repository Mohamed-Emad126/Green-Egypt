import { Document } from "mongoose";

export interface ITree extends Document {
    species: string;
    location: string;
    healthStatus: 'Healthy' | 'Diseased' | 'Dying';
    problem?: string;
    image: {
        imageName: string;
        imageUrl: string;
    };
    deletionReason?: 'Died'| 'Cut Down'| 'False Record';
}

export interface ITreeInput {
    species?: string;
    location?: string;
    healthStatus?: 'Healthy' | 'Diseased' | 'Dying';
    problem?: string;
    image?: {
        imageName: string;
        imageUrl: string;
    };
}

export type TDeleteReason = 'Died'| 'Cut Down'| 'False Record'