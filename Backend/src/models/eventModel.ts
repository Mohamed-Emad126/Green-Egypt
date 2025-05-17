import mongoose, { Schema, Model} from "mongoose";
import { IEvent } from "../interfaces/iEvent";

const EventSchema: Schema = new mongoose.Schema({
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
            length: 2
        }
    },
    description: {
        type: String,
        required: true
    },
    eventImage: {
        type: String,
        default: '../uploads/not-found-image.png'
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
    interestedIn: {
        type: [String],
        default: [] 
    }
}, { timestamps: true });

const EventModel: Model<IEvent> = mongoose.model<IEvent>('Event', EventSchema);

export default EventModel;

