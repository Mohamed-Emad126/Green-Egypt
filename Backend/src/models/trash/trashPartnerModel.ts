import mongoose, { Schema, Model } from 'mongoose';
import { IPartner } from '../../interfaces/iPartner';

const TrashPartnerSchema : Schema = new Schema({
    partnerName: {
        type: String,
        trim: true,
        required: true,
        unique: true
    },
    startDate: {
        type: Date,
        required: true
    },
    duration: {
        type: Number,
    },
    durationUnit: {
        type: String,
        enum: ['days', 'months', 'years', 'one-time'],
        required: true
    },
    endDate: {
        type: Date
    },
    website: String,
    description: {
        type: String,
        required: [true, 'Description is required'],
    },
    logo: {
        imageName: {
            type: String,
            default: 'default-logo.png'
        },
        imageUrl: {
            type: String,
            default: '../../uploads/default-logo.png'
        }
    },
    hasExpired: {
        type: Boolean,
        default: true
    }
});

const TrashPartnerModel : Model<IPartner> = mongoose.model<IPartner>('TrashPartner', TrashPartnerSchema);
export default TrashPartnerModel;
