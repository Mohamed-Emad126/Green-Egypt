import { IReport, IReportInput } from "../interfaces/iReport";
import Report from "../models/reportModel";
import trashReport from "../models/trash/trashReportModel";
import uploadToCloud from "../config/cloudinary";
import fs from "fs";
import Tree from "../models/treeModel"
import mongoose from "mongoose";
import User from "../models/userModel";

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

    async createNewReport(newReport : IReportInput, imageFiles: Express.Multer.File[]) {
        let uploadedImages = [];
        const uploadPromises = imageFiles.map(async (imageFile) => {
            const imageUploadResult = await uploadToCloud(imageFile.path);
            fs.unlinkSync(imageFile.path);
            return imageUploadResult.url;
        });
        uploadedImages = await Promise.all(uploadPromises);

        let report;

        if(newReport.treeID && newReport.reportType === "A tree needs care") {
            const tree = await Tree.findById(newReport.treeID);
            if(!tree) {
                return false;
            }

            newReport.location = tree.treeLocation;
            report = await Report.create({...newReport, images: uploadedImages});

            tree.reportsAboutIt.push(report.id);
            await tree.save();

        } else {
            report = await Report.create({...newReport, images: uploadedImages});
        }

        return true;
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
            return "Report not found";
        }

        if(updateData.treeID) {
            const newTree = await Tree.findById(updateData.treeID);
            if(!newTree) {
                return "Tree not found";
            }
            newTree.reportsAboutIt.push(report.id);
            await newTree.save();

            const oldTree = await Tree.findById(report.treeID);
            if (oldTree) {
                let reportIndex = oldTree.reportsAboutIt.findIndex((v) => v === oldTree.id);
                oldTree.reportsAboutIt.splice(reportIndex, 1);
                oldTree.save();
            }
            
        }

        report.modificationHistory.push({
            oldData: {
                reportType: report.reportType,
                description: report.description,
                location: report.location,
                images: report.images,
                treeID: report.treeID,
                createdAt: report.updatedAt
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

    async toggleUpvote(reportID: string, userID: mongoose.Schema.Types.ObjectId) {
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

    async registerVolunteering(reportID: string, userID: string) {
        const report = await Report.findById(reportID);
        const objectIdUserID = new mongoose.Types.ObjectId(userID)
        if (!report) {
            return { message: "Report not found", status: 404 };
        }

        const user = await User.findById(userID);
        const ObjectIdReportID = new mongoose.Types.ObjectId(reportID);

        if (report.status !== "Pending") {
            if (report.status === "In Progress" && report.volunteer?.toString() === userID) {
                report.volunteer = null;
                report.status = "Pending";
                await report.save();

                user!.savedReports = user!.savedReports.filter((v) => v.toString() !== reportID);
                await user!.save();
                
                return { message: "Volunteering cancelled", status: 200 };
            } else {
                return { message: "Report is not pending for volunteering", status: 400};
            }
            
        }

        report.volunteer = objectIdUserID;
        report.status = "In Progress";
        await report.save();
        user!.savedReports.push(ObjectIdReportID);
        await user!.save();
        
        return { message: "Volunteering registered successfully", status: 200 };
    }

    async saveReport(reportID: string, userID: mongoose.Schema.Types.ObjectId) {
        const report = Report.findById(reportID);
        if (!report) {
            return false;
        }

        const user = await User.findById(userID);
        const ObjectIdReportID = new mongoose.Types.ObjectId(reportID);
        const reportIndex =  user!.savedReports.indexOf(ObjectIdReportID);
        if (reportIndex === -1) {
            user!.savedReports.push(ObjectIdReportID);
            await user!.save();
            return "Report saved successfully";
        } else {
            user!.savedReports.splice(reportIndex, 1);
            await user!.save();
            return "Report removed from saved reports";
        }
    }
    
}