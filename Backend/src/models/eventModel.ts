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
        longitiude:{
            type: Number,

        }
    },
    description: {
        type: String,
        required: true
    },
    eventImage: {
        imageName: {
            type: String,
            default: 'not-found-image.png'
        },
        imageUrl: {
            type: String,
            default: '../uploads/not-found-image.png'
        } 
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
});

const EventModel: Model<IEvent> = mongoose.model<IEvent>('Event', EventSchema);

export default EventModel;

