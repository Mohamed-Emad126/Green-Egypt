import mongoose, { Schema, Model } from 'mongoose';
import { IDonation } from '../interfaces/iDonation';

const DonationSchema: Schema = new Schema({
    amount: {
        type: Number,
        required: true
    },
    donationDate: {
        type: Date,
        default: Date.now
    },
    donatedByUserID: {
        type: mongoose.Schema.Types.ObjectId,
        ref: 'User',
        required: true
    },
    receiptNumber: {
        type: String
    }
});

const DonationModel: Model<IDonation> = mongoose.model<IDonation>('Donation', DonationSchema);
export default DonationModel;
