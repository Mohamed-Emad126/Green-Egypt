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
        type: String,
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

