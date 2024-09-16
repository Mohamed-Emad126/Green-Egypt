import { Document } from "mongoose";

export interface ITree extends Document {
    species: string;
    location: string;
    healthStatus: 'Healthy' | 'Diseased' | 'Dying';
    image?: string;
}