import mongoose, { Schema, Model } from "mongoose";
import { ICoupon } from "../../interfaces/iCoupon";

const TrashCouponSchema: Schema = new mongoose.Schema({
    code: {
        type: String,
        required: true,
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
    }
});

const TrashCouponModel: Model<ICoupon> = mongoose.model<ICoupon>('TrashCoupon', TrashCouponSchema);
export default TrashCouponModel;
