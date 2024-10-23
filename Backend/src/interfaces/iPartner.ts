import { Document } from 'mongoose';

export interface IPartner extends Document {
    partnerName: string;
    startDate: Date;
    duration: number;
    durationUnit: 'days' | 'months' | 'years' | 'one-time';
    endDate?: Date;
    website?: string;
    description?: string;
    logo: {
        imageName: string;
        imageUrl: string;
    };
    hasExpired: boolean;
}

export interface IPartnerInput {
    partnerName: string;
    startDate: Date;
    duration: number;
    durationUnit: 'days' | 'months' | 'years' | 'one-time';
    website?: string;
    description?: string;
}
