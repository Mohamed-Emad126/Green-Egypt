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
        longitiude:{
            type: Number,

        }
    },
    description: {
        type: String,
        required: true
    },
    eventImage: {
        type: String,
        required: true
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
    }
})

const trashEventModel: Model<IEvent> = mongoose.model<IEvent>('Trash', TrashEventSchema);
export default trashEventModel;