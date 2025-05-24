import mongoose, { Schema, Model } from 'mongoose';
import { IPartner } from '../../interfaces/iPartner';

const TrashPartnerSchema : Schema = new Schema({
    partnerName: {
        type: String,
        trim: true,
        required: true,
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
        type: String,
    },
    hasExpired: {
        type: Boolean,
        default: true
    },
    addByAdmin: {
        type: mongoose.Schema.Types.ObjectId,
        ref: 'User',
        require : true
    },
    deletedAt: {
        type: Date,
        default: Date.now
    },
    deletedBy: {
        type: mongoose.Types.ObjectId,
        ref: 'User'
    }
}, { timestamps: true });

const TrashPartnerModel : Model<IPartner> = mongoose.model<IPartner>('TrashPartner', TrashPartnerSchema);
export default TrashPartnerModel;
