import Response from "../models/responseModel";
import Report from "../models/reportModel";
import trashResponse from "../models/trash/trashResponseModel";
import mongoose from "mongoose";
import uploadToCloud from "../config/cloudinary";
import fs from "fs";
import User from "../models/userModel";
import Tree from "../models/treeModel";
import notificationService from "./notificationService";


export default class ResponseService {

    async createResponse(reportID: string, userID: string, imageFiles: Express.Multer.File[]) {
        const report = await Report.findById(reportID);
        if (!report) {
            return 404;
        }
    
        if (report.status === "Resolved") {
            return 400;
        }

        const uploadedImages = [];
        for (const imageFile of imageFiles) {
            const imageUploadResult = await uploadToCloud(imageFile.path);
    
            uploadedImages.push(imageUploadResult.url);

            fs.unlinkSync(imageFile.path);
        }
    
        const response = await Response.create({
            reportID,
            respondentID: userID,
            images : uploadedImages,
            note: null
        });

        report.responses.push(response.id);
        report.status = "Awaiting Verification";
        report.volunteering = { volunteer: null, at: null };
        await report.save();
        
        const user = await User.findById(userID);
        const existing = user!.savedReports.some(reportId => reportId.toString() === reportID.toString())
        if (!existing) {
            user!.savedReports.push(report.id);
            await user!.save();
        }

        // Send notification to report owner if response submitted by someone else
        if (report.createdBy.toString() !== userID.toString()) {
            const responder = await User.findById(userID); 
            const responderName = responder ? responder.username : "Someone";

            const notificationServiceInstance = new notificationService();
            await notificationServiceInstance.sendNotificationWithSave({
                userId: report.createdBy.toString(),
                type: "community",
                title: "Response to your report",
                message: `${responderName} submitted a response to your report.`,
                reportId: reportID
            });
        }

        return response;
    }
    

    async getReportResponses(page : number, limit : number, reportID: string) {
        const report = await Report.findById(reportID);
        if(!report) {
            return false;
        }
        const offset : number = (page - 1) * limit;

        return await Response.find({reportID: reportID})
            .skip(offset)
            .limit(limit)
            .sort({ createdAt: -1, votes: -1 })
            .populate("respondentID", "username profilePic _id")
    }

    async getLastResponseToReport( reportID: string) {
        const report = await Report.findById(reportID);
        if(!report) {
            return false;
        }

        return await Response.findOne({reportID: reportID, "note.status": { $nin: ["rejected", "accepted but rejected"] }})
            .sort({ createdAt: 1 })
            .populate("respondentID", "username profilePic _id")
    }

    async getResponseById(ResponseID: string) {
        return await Response.findById(ResponseID).populate("respondentID", "username profilePic _id");
    }

    async deleteResponse(ResponseID : string, deletedBy : {role : string, id : string}) {
        const response = await Response.findById(ResponseID);

        if (!response){
            return {status: 404, message: 'Response not found'};
        } else if (response.isVerified) {
            return {status: 400, message: 'Cannot delete a verified response'};
        }
        
        const toTrash = new trashResponse({...response.toObject(), deletedBy : {role : deletedBy.role, hisID : new mongoose.Types.ObjectId(deletedBy.id)}});
        await toTrash.save();

        const report = await Report.findById(response.reportID);
        report!.responses.filter((v: any) => v.toString() !== response.id);
        if (report!.responses.length === 1) {
            report!.status = 'Pending';
        }
        await report!.save();

        await response.deleteOne();
        return {status: 200, message: 'Response deleted successfully'};
    }

    async voteResponse(responseID: string, userID: string, vote: boolean) {
        const response = await Response.findById(responseID);
        if (!response) {
            return { status: 404, message: "Response not found" };
        }

        if (response.isVerified) {
            return { status: 400, message: "Cannot vote on a verified response" };
        }

        if (response.respondentID.toString() === userID) {
            return { status: 400, message: "Cannot vote on your own response" };
        }
        
        const express = vote === true ? 'positive' : 'negative';
        let msg;
        const existingVoteIndex = response.votes.findIndex((v) => v.userID.toString() === userID);
    
        if (existingVoteIndex !== -1) {
            const existingVote = response.votes[existingVoteIndex];
    
            if (existingVote.vote === vote) {
                response.votes.splice(existingVoteIndex, 1);
                msg = `The vote has been cancelled`; 

                vote === true ? response.upVotes -= 1 : response.downVotes -= 1;

            } else {
                response.votes[existingVoteIndex].vote = vote;
                msg = `The vote has been updated to ${express}`;

                if (vote === true) {
                    response.upVotes += 1;
                    response.downVotes -= 1;
                } else {
                    response.downVotes += 1;
                    response.upVotes -= 1;
                }

            }
        } else {
            const objectIdUserID = new mongoose.Types.ObjectId(userID)
            response.votes.push({ userID: objectIdUserID, vote: vote });
            msg = `Successfully voted ${express}`;

            vote === true ? response.upVotes += 1 : response.downVotes += 1;
        }
    
        await response.save();
    
        return { status: 200, message: msg };
    }

    async deleteResponseImage(responseID: string, imageURL: string) {
        const response = await Response.findById(responseID);
        if (!response) {
            return { status: 404, message: "Response not found" };
        }

        if (response.isVerified) {
            return { status: 400, message: "Cannot modify a verified response" };
        }

        const imageIndex = response.images.findIndex((image) => image === imageURL);
        if (imageIndex === -1) {
            return { status: 400, message: "Image not found in response" };
        }

        response.images.splice(imageIndex, 1);
        await response.save();
        return { status: 200, message: "Image deleted successfully" };
    }

    async addResponseImages(responseID: string, imageFiles: Express.Multer.File[]) {
        const response = await Response.findById(responseID);
        if (!response) {
            return { status: 404, message: "Response not found" };
        }

        if (response.isVerified) {
            return { status: 400, message: "Cannot modify a verified response" };
        }
        
        const uploadedImages = [];
        for (const imageFile of imageFiles) {
            const imageUploadResult = await uploadToCloud(imageFile.path);
    
            uploadedImages.push(imageUploadResult.url);

            fs.unlinkSync(imageFile.path);
        }

        response.images.push(...uploadedImages);
        await response.save();
        return { status: 200, message: "New images uploaded successfully" }; 
    }

    async analysisResponse(responseID: string) { 
        const response = await Response.findById(responseID);
        
        if (!response!.isVerified) {
            return false;
        }

        const report = await Report.findById(response!.reportID);

        let action = "";
        if (report!.reportType=== "A tree needs care") {
            action = "care";
        } else if (report!.reportType === "A place needs tree") {
            action = "plant";
        }

        if (action === "plant") {
            return { 
                status: 200,
                return: {
                    action: "plant",
                    user: response!.respondentID,
                    message: "Make user locate it on the map to reward 50 points and he/she can unsave the report",
                    requiredField: "treeName , treeLocation { type, coordinates }, treeImage",
                    defaultValues: {
                        plantedRecently: true,
                        byUser: response!.respondentID
                    }
                }
            };
        }

        const tree = await Tree.findById(report!.treeID);
        
        tree!.healthStatus = "Healthy";
        tree!.problem = undefined;
        await tree!.save();

        return { 
            status: 200, 
            return: {
                action: "care", 
                message: "Tree health status become healthy and the user reward 20 points, Make user chick whether the tree location or image needs modification or not and he/she can unsave the report",
                user: response!.respondentID
            }
        };
    }
    
    async verifyResponse(responseID: string) {
        const response = await Response.findById(responseID);
        const report = await Report.findById(response!.reportID);

        if (response!.isVerified && response!.note !== null) {
            return { status: 400, message: "Response already verified" };
        } else if (response!.note!.status !== "rejected" || response!.note === null) {
            return { status: 400, message: "Response not verified by the system yet, Please wait" };
        }

        const upVotes = response!.upVotes;
        const downVotes = response!.downVotes;
        if (upVotes > downVotes && upVotes >= 5) {
            if(report!.status !== "Resolved") {
                response!.isVerified = true;
                response!.note = {
                    message: "Request an analysis of your response to get your reward",
                    status: "accepted"
                };

                report!.status = "Resolved";
                await report!.save();

                if(report!.reportType === "A tree needs care") {
                    await Tree.findByIdAndUpdate(
                        report!.treeID,
                        {
                            $pull: { 'reportsAboutIt.unresolved': report!._id },
                            $push: { 'reportsAboutIt.resolved': report!._id }
                        },
                        { new: true }
                    );
                }
            } else {
                response!.note = {
                    message: "Response has been accepted but the report is already resolved, you can unsaved the report",
                    status: "accepted but rejected"
                };
            }

            await response!.save();
        }

        return response!.note!;
    }
}
