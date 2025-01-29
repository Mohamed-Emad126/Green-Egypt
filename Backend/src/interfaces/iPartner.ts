import mongoose, { Document } from 'mongoose';

export interface IPartner extends Document {
    partnerName: string;
    startDate: Date;
    duration: number;
    durationUnit: 'days' | 'months' | 'years' | 'one-time';
    endDate?: Date;
    website?: string;
    description?: string;
    logo: string;
    hasExpired: boolean;
    addByAdmin: mongoose.Schema.Types.ObjectId;
    createdAt?: Date
    updatedAt?: Date
}

export interface IPartnerInput {
    partnerName: string;
    startDate: Date;
    duration: number;
    durationUnit: 'days' | 'months' | 'years' | 'one-time';
    website?: string;
    description?: string;
    addByAdmin?: mongoose.Schema.Types.ObjectId;
}
