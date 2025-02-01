import { ITreeInput, TDeleteReason } from "../interfaces/iTree";
import Tree from "../models/treeModel";
import trashTree from "../models/trash/trashTreeModel";
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

    async LocateTree(newTree : Partial<ITreeInput> , userID : string) {
        if (newTree.healthStatus === 'Healthy') {
            newTree.problem = 'No problem';
        }
        
        return Tree.create({ ...newTree, byUser: userID });
    }

    async updateTree(treeID : string, updateData : Partial<ITreeInput>) {
        const tree = await Tree.findById(treeID);
        if (!tree){
            return false;
        }

        if (updateData.healthStatus === 'Healthy' && updateData.problem) {
                updateData.problem = 'No problem';
        }

        Object.assign(tree, updateData);
        await tree.save();
        return true;
    }

    async deleteTree(treeID : string , reason : TDeleteReason) {
        const tree = await Tree.findById(treeID);
        if (!tree){
            return false;
        }
        
        const toTrash = new trashTree({...tree.toObject(), deletionReason : reason});
        await toTrash.save();

        await tree.deleteOne();
        return true;
    }

    async uploadTreePicture(treeID: string, imageFile: any) {
        const tree = await Tree.findById(treeID);
        if (!tree){
            return false;
        }

        const imageUploadResult = await uploadToCloud(imageFile.path);

        tree.image =  imageUploadResult.url;
        await tree.save();
        fs.unlinkSync(imageFile.path);
        
        return true;
    }

}