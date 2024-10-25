import mongoose, { Schema, Model } from "mongoose";
import { ICoupon } from "../interfaces/iCoupon";

const CouponSchema: Schema = new mongoose.Schema({
    code: {
        type: String,
        required: true,
        unique: true,
        trim: true,
        length: [6, 6, 'Code must be 6 characters long'],
    },
    value: {
        type: Number,
        required: true,
    },
    brand: {
        type: mongoose.Schema.Types.ObjectId,
        ref: 'Partner',
        required: true,
    },
    expiryDate: {
        type: Date,
        required: true,
    },
    redeemed:{
        type: Boolean,
        default: false
    }
});

const CouponModel: Model<ICoupon> = mongoose.model<ICoupon>('Coupon', CouponSchema);
export default CouponModel;
