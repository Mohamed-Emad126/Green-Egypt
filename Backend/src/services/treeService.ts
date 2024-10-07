import { ITreeInput } from "../interfaces/iTree";
import Tree from "../models/treeModel";
import uploadToCloud from "../config/cloudinary";
import fs from "fs";

// TODO: Compare the input tree with previously located trees (locatedTree)

export default class TreesService {
    async getTrees(page : number, limit : number, filters : any) {
        const offset : number = (page - 1) * limit;
        return await Tree.find(filters).skip(offset).limit(limit);
    }

    async getTreeById(treeID : string) {
        const tree = await Tree.findById(treeID);
        return tree ? tree : null;
    }

    async LocateTree(newTree : ITreeInput) {
        const tree = new Tree(newTree);
        await tree.save();
        return true;
    }

    async updateTree(treeID : string, updateData : ITreeInput) {
        return await Tree.findByIdAndUpdate(treeID, updateData, {new : true, runValidators : true});
    }

    async deleteTree(TreeID : string) {
        return await Tree.findByIdAndDelete(TreeID);
    }

    async uploadTreePicture(treeID: string, imageFile: any) {
        const tree = await Tree.findById(treeID);
        if (!tree){
            return false;
        }

        const imageUploadResult = await uploadToCloud(imageFile.path);

        tree.image = {
            imageName: imageFile.filename,
            imageUrl: imageUploadResult.url
        };
        await tree.save();
        fs.unlinkSync(imageFile.path);
        
        return true;
    }

}