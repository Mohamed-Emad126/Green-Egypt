import Response from "../models/responseModel";
import Report from "../models/reportModel";
import trashResponse from "../models/trash/trashResponseModel";
import mongoose from "mongoose";
import uploadToCloud from "../config/cloudinary";
import fs from "fs";


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
        });

        report.responses.push(response.id);
        await report.save();
    
        return response;
    }
    

    async getReportResponses(reportID: string) {
        const report = await Report.findById(reportID);
        if(!report) {
            return false;
        }

        return await Response.find({reportID: reportID})
            .sort({ createdAt: -1, votes: -1 })
            .populate("respondentID")
    }

    async getResponseById(ResponseID: string) {
        return await Response.findById(ResponseID).populate("respondentID").populate("reportID");
    }

    async deleteResponse(ResponseID : string) {
        const response = await Response.findById(ResponseID);

        if (!response){
            return false;
        }
        
        const toTrash = new trashResponse({...response.toObject()});
        await toTrash.save();

        await response.deleteOne();
        return true;
    }

    async voteResponse(responseID: string, userID: string, vote: boolean) {
        const response = await Response.findById(responseID);
        if (!response) {
            return false;
        }
        
        const express = vote === true ? 'positive' : 'negative';
        let msg;
        const existingVoteIndex = response.votes.findIndex((v) => v.userID.toString() === userID);
    
        if (existingVoteIndex !== -1) {
            const existingVote = response.votes[existingVoteIndex];
    
            if (existingVote.vote === vote) {
                response.votes.splice(existingVoteIndex, 1);
                msg = `The vote has been cancelled`; 
            } else {
                response.votes[existingVoteIndex].vote = vote;
                msg = `The vote has been updated to ${express}`;
            }
        } else {
            const objectIdUserID = new mongoose.Types.ObjectId(userID)
            response.votes.push({ userID: objectIdUserID, vote: vote });
            msg = `Successfully voted ${express}`;
        }
    
        await response.save();
    
        return msg;
    }

}
