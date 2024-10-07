import mongoose, { Schema, Model } from 'mongoose';
import { IToken } from '../interfaces/iToken';

const TokenSchema: Schema = new Schema({
    token: {
        type: String,
        required: true,
        unique: true,
    },
    blacklisted: {
        type: Boolean,
        default: false,
    },
    expiresAt: {
        type: Date,
    },
});

TokenSchema.index({ expiresAt: 1 }, { expireAfterSeconds: 0 }); 
export default mongoose.model<IToken>('Token', TokenSchema);