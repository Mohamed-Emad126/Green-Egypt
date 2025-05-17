import mongoose, { Schema, Model } from "mongoose";
import { ICoupon } from "../../interfaces/iCoupon";

const TrashCouponSchema: Schema = new mongoose.Schema({
    codes: {
        type: [String],
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
    cost: {
        type: Number,
        required: true,
        min: [50, 'Cost cannot be negative or less than 50'],
    },
    usedCodes: [{
        user: {
            type: mongoose.Types.ObjectId,
            ref: 'User'
        },
        code: String,
        redeemedAt: {
            type: Date,
            default: Date.now
        }
    }],
    expiryDate: {
        type: Date,
        required: true,
    },
    // redeemed:{
    //     type: Boolean,
    //     default: false
    // },
    addByAdmin: {
        type : mongoose.Schema.Types.ObjectId,
        ref : 'User',
        required : true
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

const TrashCouponModel: Model<ICoupon> = mongoose.model<ICoupon>('TrashCoupon', TrashCouponSchema);
export default TrashCouponModel;
