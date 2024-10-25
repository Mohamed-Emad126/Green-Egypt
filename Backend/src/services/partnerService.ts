import { IPartner, IPartnerInput } from "../interfaces/iPartner";
import Partner from "../models/partnerModel";
import trashPartner from "../models/trash/trashPartnerModel";
import fs from "fs";
import uploadToCloud from "../config/cloudinary";


export default class PartnerService {
    async getPartners(page : number, limit : number, filters : any) {
        const offset : number = (page - 1) * limit;
        return await Partner.find(filters).skip(offset).limit(limit);
    }

    async getPartnerById(partnerID : string) {
        return await Partner.findById(partnerID);
    }

    async createNewPartner(newPartner : IPartnerInput) {
        return await Partner.create(newPartner);
    }

    async updatePartner(partnerID : string, updateData : IPartnerInput) {
        const partner = await Partner.findById(partnerID);
        if (!partner){
            return false;
        }

        partner.partnerName = updateData.partnerName || partner.partnerName;
        partner.startDate = updateData.startDate || partner.startDate;
        partner.duration = updateData.duration || partner.duration;
        partner.durationUnit = updateData.durationUnit || partner.durationUnit;
        partner.website = updateData.website || partner.website;
        partner.description = updateData.description || partner.description;

        await partner.save();    
        return true;
    }

    async deletePartner(partnerID : string) {
        const partner = await Partner.findById(partnerID);
        if (!partner){
            return false;
        }
        
        const toTrash = new trashPartner({...partner.toObject()});
        toTrash.hasExpired = true;
        await toTrash.save();

        await partner.deleteOne();
        return true;
    }

    async uploadPartnerLogo(partnerID: string, imageFile: any) {
        const partner = await Partner.findById(partnerID);
        if (!partner){
            return false;
        }

        const imageUploadResult = await uploadToCloud(imageFile.path);

        partner.logo = {
            imageName: imageFile.filename,
            imageUrl: imageUploadResult.url
        };
        await partner.save();
        fs.unlinkSync(imageFile.path);

        return true;
    }

}