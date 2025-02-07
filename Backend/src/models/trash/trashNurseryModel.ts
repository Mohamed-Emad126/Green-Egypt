import mongoose, { Schema, Model } from "mongoose";
import { INursery } from "../../interfaces/iNursery";

const TrashNurserySchema: Schema = new Schema({

    nurseryname:  {
        type: String,
    },
    nurseryPic: {
        type: String,
    },
    location:  {
        type: String,
    },

})

const TrashNurseryModel: Model<INursery> = mongoose.model<INursery>('TrashNursery', TrashNurserySchema);
export default TrashNurseryModel;