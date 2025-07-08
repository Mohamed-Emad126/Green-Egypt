import { IPartner, IPartnerInput } from "../interfaces/iPartner";
import Partner from "../models/partnerModel";
import trashPartner from "../models/trash/trashPartnerModel";
import fs from "fs";
import uploadToCloud from "../config/cloudinary";
import mongoose from "mongoose";
import Coupon from "../models/couponModel";
import CouponService from "./couponService";
import Event from "../models/eventModel";
import EventService from "./eventService";


export default class PartnerService {
    async getPartners(page : number, limit : number, filters : any) {
        const offset : number = (page - 1) * limit;
        return await Partner.find(filters).skip(offset).limit(limit);
    }

    async getPartnerById(partnerID : string) {
        return await Partner.findById(partnerID);
    }

    async createNewPartner(newPartner : Partial<IPartnerInput>, imageFile: Express.Multer.File) {
        const imageUploadResult = await uploadToCloud(imageFile.path);
        newPartner.logo = imageUploadResult.url;
        fs.unlinkSync(imageFile.path);

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

    async deletePartner(partnerID : string, deletedBy : string, options : { deleteCoupons: boolean, deleteFutureEvents: boolean, cancelFutureEvents: boolean }) {
        const partner = await Partner.findById(partnerID);
        if (!partner){
            return false;
        }
        
        if (options.deleteCoupons) {
            const partnerCoupons = await Coupon.find({ brand: partnerID });
            if (partnerCoupons.length > 0) {
                const couponService = new CouponService();
                await Promise.all(partnerCoupons.map(async (coupon) => {
                    await couponService.deleteCoupon(coupon.id, deletedBy);
                }));
            }
        }
        
        if (options.cancelFutureEvents || options.deleteFutureEvents) {
            const partnerFutureEvents = await Event.find({ organizedWithPartnerID : partnerID, eventDate : { $gt : new Date() }});
            if (partnerFutureEvents.length > 0) {
                await Promise.all(partnerFutureEvents.map(async (event) => {
                    event.eventStatus = "cancelled";
                    await event.save();
                }));
            }
        }

        if (options.deleteFutureEvents) {
            const partnerFutureEvents = await Event.find({ organizedWithPartnerID : partnerID, eventDate : { $gt : new Date() }});
            if (partnerFutureEvents.length > 0) {
                const eventService = new EventService();
                await Promise.all(partnerFutureEvents.map(async (event) => {
                    await eventService.deleteEvent(event.id, deletedBy);
                }));
            }
        }

        const toTrash = new trashPartner({...partner.toObject(), deletedBy : new mongoose.Types.ObjectId(deletedBy)});
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

        partner.logo = imageUploadResult.url;
        await partner.save();
        fs.unlinkSync(imageFile.path);

        return true;
    }

}