import { IReport, IReportInput } from "../interfaces/iReport";
import Report from "../models/reportModel";
import trashReport from "../models/trash/trashReportModel";
import uploadToCloud from "../config/cloudinary";
import fs from "fs";
import { ObjectId } from "mongoose";
import { report } from "process";

// TODO: Compare the input report with previously created reports (createdReport)
// TODO: Sort reports by the nearest location (getReports)

export default class ReportService {
    async getReports(page : number, limit : number, filters : any) {
        const offset : number = (page - 1) * limit;
        return await Report
            .find(filters)
            .skip(offset)
            .limit(limit)
            .sort({ upVotes : -1 , createdAt : -1});
    }

    async getReportById(reportID : string) {
        return await Report.findById(reportID);
    }

    async createNewReport(newReport : IReportInput) {
        return await Report.create(newReport);
    }

    async uploadReportImages(reportID: string, imageFiles: Express.Multer.File[]) {
        const report = await Report.findById(reportID);
        if (!report) {
            return false;
        }
    
        const uploadedImages = [];
        for (const imageFile of imageFiles) {
            const imageUploadResult = await uploadToCloud(imageFile.path);
    
            uploadedImages.push(imageUploadResult.url);

            fs.unlinkSync(imageFile.path);
        }
    
        report.images = [...(report.images || []), ...uploadedImages];
        await report.save();
    
        return true;
    }
    

    async updateReport(reportID : string, updateData : IReportInput) {
        const report = await Report.findById(reportID);
        if (!report) {
            return null;
        }

        report.modificationHistory.push({
            oldData: {
                reportType: report.reportType,
                description: report.description,
                location: report.location,
                images: report.images,
                treeID: report.treeID,
                createdAt: report.id.getTimestamp()
            },
            updatedAt: new Date(),
        });

        Object.assign(report, updateData);
        await report.save();
        return true;
    }

    async deleteReport(reportID : string) {
        const report = await Report.findById(reportID);
        if (!report){
            return false;
        }
        
        const toTrash = new trashReport({...report.toObject()});
        await toTrash.save();

        await report.deleteOne();
        return true;
    }

    async toggleUpvote(reportID: string, userID: ObjectId) {
        const report = await Report.findById(reportID);
        if (!report) {
            return null;
        }
    
        const userIndex = report.upVoters.indexOf(userID);
    
        if (userIndex === -1) {
            report.upVoters.push(userID);
            report.upVotes += 1;
            await report.save();
            return "Upvote added successfully";

        } else {
            report.upVoters.splice(userIndex, 1);
            report.upVotes -= 1;
            await report.save();
            return "Upvote removed successfully";
        }
    }

    async deleteImage(reportID : string, imagePath: string) {
        const report = await Report.findById(reportID);
        if (!report){
            return "Report not found";
        }

        const imageIndex = report.images.indexOf(imagePath);
        if (imageIndex === -1) {
            return "Image not found in report";
        }

        report.images.splice(imageIndex, 1);
        await report.save();

        return true;
    }
}