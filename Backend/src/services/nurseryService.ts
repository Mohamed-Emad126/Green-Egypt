import Nursery from "../models/nurseryModel";
import trashNursery from "../models/trash/trashNurseryModel";
import uploadToCloud from "../config/cloudinary";
import { INurseryInput } from "../interfaces/iNursery";
import fs from "fs";
import mongoose from "mongoose";

export default class NurseryService {
    async getNurseries(page : number, limit : number) {
        const offset : number = (page - 1) * limit;
        return await Nursery.find().skip(offset).limit(limit);
    }

    async getNurseryById(nurseryID : string) {
        const nursery =await Nursery.findById(nurseryID);
        return nursery ? nursery : null;
    }
    async createNursery(nurseryData : Partial<INurseryInput>) {
        const nursery = new Nursery({
            nurseryName: nurseryData.nurseryName,
            address: nurseryData.address,
            nurseryPic: nurseryData.nurseryPic,
        });
        await nursery.save();
        return nursery;
    }

    async updateNursery(nurseryID : string, nurseryData : Partial<INurseryInput>) {
        return await Nursery.findByIdAndUpdate(
            nurseryID, 
            {nurseryName: nurseryData?.nurseryName, nurseryPic: nurseryData?.nurseryPic, address: nurseryData?.address},
            {new : true, runValidators : true})
    }

    async deleteNursery(nurseryID : string, deletedBy : string) {
        const nursery = await Nursery.findById(nurseryID);
        if (!nursery){
            return false;
        }
        
        const toTrash = new trashNursery({...nursery.toObject(), deletedBy : new mongoose.Types.ObjectId(deletedBy)});
        await toTrash.save();

        await nursery.deleteOne();
        return true;
    }

    async uploadNurseryPicture(nurseryID : string, imageFile: any) {
        const nursery = await Nursery.findById(nurseryID);
        if (!nursery){
            return false;
        }

        const imageUploadResult = await uploadToCloud(imageFile.path);

        nursery.nurseryPic = imageUploadResult.url
        await nursery.save();
        fs.unlinkSync(imageFile.path);

        return true;
    }

}

