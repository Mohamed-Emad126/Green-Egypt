import { Document } from "mongoose";

export interface ITree extends Document {
    species: string;
    location: string;
    healthStatus: 'Healthy' | 'Diseased' | 'Dying';
    image: {
        imageName: string;
        imageUrl: string;
    };
}

export interface ITreeInput {
    species?: string;
    location?: string;
    healthStatus?: 'Healthy' | 'Diseased' | 'Dying';
    image?: {
        imageName: string;
        imageUrl: string;
    };
}