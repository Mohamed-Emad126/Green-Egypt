import { IReport, IReportInput } from "../interfaces/iReport";
import Report from "../models/reportModel";
import trashReport from "../models/trash/trashReportModel";
import uploadToCloud from "../config/cloudinary";
import fs from "fs";
import Tree from "../models/treeModel"
import mongoose from "mongoose";
import User from "../models/userModel";
import CommentService from "./commentService";
import Comment from "../models/commentModel";
import Response from "../models/responseModel";
import trashResponse from "../models/trash/trashResponseModel";


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

        if(newReport.treeID && newReport.reportType === "A tree needs care" ) {
            const tree = await Tree.findById(newReport.treeID);
            if(!tree) {
                return false;
            }

            newReport.location = tree.treeLocation;
            report = await Report.create({...newReport, images: uploadedImages});

            tree.problem = newReport.description;
            tree.healthStatus = "Diseased";
            tree.reportsAboutIt.push(report.id);
            await tree.save();

        } else {
            if (newReport.treeID) {
                newReport.treeID = undefined;
            }
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

        report.images = [...(report.images || []), ...uploadedImages];
        await report.save();
    
        return true;
    }
    

    async updateReport(reportID : string, updateData : IReportInput) {
        const report = await Report.findById(reportID);
        if (!report) {
            return {status: 404, message: "Report not found"};
        }

        let newTree
        if (updateData.treeID && (updateData.reportType === "A tree needs care" || ((!updateData.reportType) && report.reportType === "A tree needs care"))) {
            newTree = await Tree.findById(updateData.treeID);
            if(!newTree) {
                return {status: 404, message: "Tree not found"};
            }

            newTree.reportsAboutIt.push(report.id);
            await newTree.save();

            const oldTree = await Tree.findById(report.treeID);
            if (oldTree) {
                let reportIndex = oldTree.reportsAboutIt.findIndex((v) => v.toString() === report.id.toString());
                oldTree.reportsAboutIt.splice(reportIndex, 1);
                await oldTree.save();
            }

            updateData.location = report.location;

        } else if (updateData.location && (updateData.reportType === "A place needs tree" || ((!updateData.reportType) && report.reportType === "A place needs tree"))) {
            updateData.treeID = undefined;

            if(report.treeID) {
                const oldTree = await Tree.findById(report.treeID);
                if (oldTree) {
                    let reportIndex = oldTree.reportsAboutIt.findIndex((v) => v.toString() === report.id.toString());
                    oldTree.reportsAboutIt.splice(reportIndex, 1);
                    await oldTree.save();
                }
            }
        } else {
            updateData.treeID = report.treeID;
            updateData.location = report.location;
        }

        if (updateData.images) {
            updateData.images = report.images
        }

        if (!(updateData.description || updateData.reportType || updateData.location != report.location || updateData.treeID != report.treeID)) {
            return {status: 400, message: "No changes made to the report"};
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

    async deleteReportAndContent(reportID : string, deletedBy : {role : string, id : string}) {
        const report = await Report.findById(reportID);
        if (!report){
            return false;
        }

        if(report.comments.length > 0) {
            const commentService = new CommentService();
            const reportComments = await Comment.find({ reportID });
            await Promise.all(reportComments.map(async (comment) => {
                await commentService.deleteCommentAndReplies(comment.id, deletedBy);
            }));
            
        }

        if (report.responses.length > 0) {
            const reportResponses = await Response.find({ reportID });
            const toTrash = reportResponses.map((response) => {
                return new trashResponse({
                    ...response.toObject(),
                    deletedBy: { role: deletedBy.role, hisID: new mongoose.Types.ObjectId(deletedBy.id) }
                });
            });
            await trashResponse.insertMany(toTrash);
            await Response.deleteMany({ reportID });
        }
        
        const toTrash = new trashReport({...report.toObject(), deletedBy : {role : deletedBy.role, hisID : new mongoose.Types.ObjectId(deletedBy.id)}});
        await toTrash.save();

        await report.deleteOne();
        return true;
    }

    async toggleUpvote(reportID: string, userID: mongoose.Types.ObjectId) {
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
            if (report.status === "In Progress" && report.volunteering.volunteer?.toString() === userID) {
                report.volunteering = { volunteer: null, at: null };
                report.status = "Pending";
                await report.save();

                user!.savedReports = user!.savedReports.filter((v) => v.toString() !== reportID);
                await user!.save();
                
                return { message: "Volunteering cancelled", status: 200 };
            } else {
                return { message: "Report is not pending for volunteering", status: 400};
            }
            
        }

        report.volunteering = { volunteer: objectIdUserID, at: new Date()};
        report.status = "In Progress";
        await report.save();
        user!.savedReports.push(ObjectIdReportID);
        await user!.save();
        
        return { message: "Volunteering registered successfully", status: 200 };
    }

    async saveReport(reportID: string, userID: mongoose.Types.ObjectId) {
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