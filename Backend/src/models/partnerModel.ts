import mongoose, { Schema, Model } from 'mongoose';
import { IPartner } from '../interfaces/iPartner';



const PartnerSchema : Schema = new Schema({
    partnerName: {
        type: String,
        trim: true,
        required: [true, 'Partner name is required'],
        unique: true,
        maxLength: [35, 'Partner name cannot be more than 35 characters'],
        minLength: [3, 'Partner name cannot be less than 3 characters']
    },
    startDate: {
        type: Date,
        required: [true, 'Start date is required'],
    },
    duration: {
        type: Number,
        required: [true, 'Duration is required'],
    },
    durationUnit: {
        type: String,
        enum: ['days', 'months', 'years', 'one-time'],
        required: [true, 'Duration unit is required'],
    },
    endDate: {
        type: Date,
    },
    website: String,
    description: {
        type: String,
        required: [true, 'Description is required'],
        maxLength: [700, 'Description cannot be more than 700 characters'],
    },
    logo: {
        type: String,
        default: '../uploads/not-found-image.png'
    },
    hasExpired: {
        type: Boolean,
        default: false
    },
    addByAdmin: {
        type : mongoose.Schema.Types.ObjectId,
        ref : 'User',
        require : true
    }
});


PartnerSchema.pre('save', function (next) {

    if (this.isNew || this.isModified('startDate') || this.isModified('duration') || this.isModified('durationUnit')) {
        const startDate = new Date(this.startDate as Date);
        let endDate: Date;

        switch (this.durationUnit) {
            case 'days':
                endDate = new Date(startDate.setDate(startDate.getDate() + (this.duration as number)));
                break;
            case 'months':
                endDate = new Date(startDate.setMonth(startDate.getMonth() + (this.duration as number)));
                break;
            case 'years':
                endDate = new Date(startDate.setFullYear(startDate.getFullYear() + (this.duration as number)));
                break;
            case 'one-time':
                endDate = startDate;
                break;
            default:
                throw new Error('Invalid duration unit');
        }

        this.endDate = endDate;

        const currentDate = new Date();
        this.hasExpired = currentDate > endDate;
    }
    next();
});


const PartnerModel : Model<IPartner> = mongoose.model<IPartner>('Partner', PartnerSchema);
export default PartnerModel;
