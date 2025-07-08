import Guide from "../models/guideModel";
import trashGuide from "../models/trash/trashGuideModel";
import uploadToCloud from "../config/cloudinary";
import { IGuideInput } from "../interfaces/iGuide";
import fs from "fs";
import mongoose from "mongoose";

export default class GuideService {
    async getArticles(page : number, limit : number) {
        const offset : number = (page - 1) * limit;
        return await Guide.find().skip(offset).limit(limit);
    }

    async getArticleById(articleID : string) {
        const article =await Guide.findById(articleID);
        return article ? article : null;
    }
    async createArticle(articleData : IGuideInput) {
        const article = new Guide({
            articleTitle: articleData.articleTitle,
            content: articleData.content,
            articlePic: articleData.articlePic,
            createdAt:Date.now()
        });
        await article.save();
        return article;
    }

    async updateArticle(articleID : string, articleData : IGuideInput) {
        return await Guide.findByIdAndUpdate(
            articleID, 
            {articleTitle: articleData?.articleTitle, content: articleData?.content, articlePic: articleData?.articlePic,createdAt:Date.now()},
            {new : true, runValidators : true})
    }

    async deleteArticle(articleID : string, deletedBy : string) {
        const article = await Guide.findById(articleID);
        if (!article){
            return false;
        }
        
        const toTrash = new trashGuide({...article.toObject(), deletedBy : new mongoose.Types.ObjectId(deletedBy)});
        await toTrash.save();

        await article.deleteOne();
        return true;
    }

    async uploadArticlePicture(articleID : string, imageFile: any) {
        const article = await Guide.findById(articleID);
        if (!article){
            return false;
        }

        const imageUploadResult = await uploadToCloud(imageFile.path);

        article.articlePic = imageUploadResult.url
        await article.save();
        fs.unlinkSync(imageFile.path);

        return true;
    }

}

