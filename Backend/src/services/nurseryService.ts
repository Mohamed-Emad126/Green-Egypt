import Nursery from "../models/nurseryModel";
import trashNursery from "../models/trash/trashNurseryModel";
import uploadToCloud from "../config/cloudinary";
import { INurseryInput } from "../interfaces/iNursery";
import fs from "fs";
import mongoose from "mongoose";

export default class NurseryService {
    async getNurseries(page: number, limit: number, location?: { type: string; coordinates: [number, number] }) {
        const offset: number = (page - 1) * limit;
        
        const aggregationPipeline: any[] = [];

        if (location) {
            aggregationPipeline.push({
                $geoNear: {
                    near: {
                        type: "Point",
                        coordinates: location.coordinates
                    },
                    distanceField: "distance",
                    maxDistance: 50000,
                    spherical: true
                }
            });
        }

        aggregationPipeline.push(
            {
                $sort: {
                    ...(location && { distance: 1 }),
                    rate: -1,
                    createdAt: -1
                }
            },
            {
                $skip: offset
            },
            {
                $limit: limit
            },
            {
                $project: {
                    _id: 1,
                    nurseryName: 1,
                    nurseryPic: 1,
                    address: 1,
                    location: 1,
                    rate: 1,
                }
            }
        );

        return await Nursery.aggregate(aggregationPipeline);
    }

    async getNurseryById(nurseryID : string) {
        const nursery =await Nursery.findById(nurseryID);
        return nursery ? nursery : null;
    }
    async createNursery(nurseryData : Partial<INurseryInput>) {
        const nursery = new Nursery({
            nurseryName: nurseryData.nurseryName,
            address: nurseryData.address,
            location: nurseryData.location,
            rate: nurseryData.rate
        });
        await nursery.save();
        return nursery;
    }

    async updateNursery(nurseryID : string, nurseryData : Partial<INurseryInput>) {
        return await Nursery.findByIdAndUpdate(
            nurseryID, 
            {nurseryName: nurseryData?.nurseryName, address: nurseryData?.address, location: nurseryData?.location, rate: nurseryData?.rate},
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

