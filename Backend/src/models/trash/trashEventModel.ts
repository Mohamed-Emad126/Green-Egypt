import mongoose, { Schema, Model } from "mongoose";
import { IEvent } from "../../interfaces/iEvent";

const TrashEventSchema: Schema = new Schema({
    eventName: {
        type: String,
        required: true
    },
    eventDate: {
        type: Date,
        required: true
    },
    location: {
        type: {
            type: String,
            enum: ['Point'],
            required: true,
        },
        coordinates: {
            type: [Number],
            required: true,
        }
    },
    city: {
        type: String,
        required: true
    },
    description: {
        type: String,
        required: true
    },
    eventImage: {
        type: String,
    },
    eventStatus: {
        type: String,
        enum: ['upcoming' , 'ongoing' , 'completed' , 'cancelled'],
        required: true
    },
    organizedWithPartnerID: {
        type: mongoose.Schema.Types.ObjectId,
        ref: 'Partner',
        required: true
    },
    interestedIn: [{
        type: mongoose.Types.ObjectId,
        ref: 'User',
    }],
    deletedAt: {
        type: Date,
        default: Date.now
    },
    deletedBy: {
        type: mongoose.Schema.Types.ObjectId,
        ref: 'User'
    }
}, { timestamps: true });

const trashEventModel: Model<IEvent> = mongoose.model<IEvent>('TrashEvent', TrashEventSchema);
export default trashEventModel;