import { ITreeInput, TDeleteReason } from "../interfaces/iTree";
import Tree from "../models/treeModel";
import trashTree from "../models/trash/trashTreeModel";
import uploadToCloud from "../config/cloudinary";
import fs from "fs";
import mongoose from "mongoose";
import Report from "../models/reportModel";


export default class TreesService {
    async getTrees(filters : any) {
        return await Tree.find(filters);
    }

    async getTreeById(treeID : string) {
        const tree = await Tree.findById(treeID);
        return tree ? tree : null;
    }

    async getTreesByLocation(location: { type: string; coordinates: [number, number] }) {
        return await Tree.find({
            treeLocation: {
                $nearSphere: {
                    $geometry: {
                        type: "Point",
                        coordinates: location.coordinates
                    },
                    $maxDistance: 10
                }
            }
        });
    }

    async LocateTree(newTree : ITreeInput, imageFile: Express.Multer.File, userID : string) {
        const existing = await Tree.findOne({
            treeLocation: {
                $near: {
                $geometry: {
                    type: "Point",
                    coordinates: newTree.treeLocation!.coordinates
                },
                $maxDistance: 0.3
                }
            }
        });

        if (existing) {
            return {status: 400, existingTree: existing};
        }

        const imageUploadResult = await uploadToCloud(imageFile.path);
        newTree.image = imageUploadResult.url;
        fs.unlinkSync(imageFile.path);

        const theTree = await Tree.create({ 
            treeName: newTree.treeName,
            image: newTree.image,
            treeLocation: newTree.treeLocation, 
            byUser: userID,
            healthStatus: "Healthy",
            plantedRecently: newTree.plantedRecently? true : false,
        });

        return { status: 201, theTree };
    }

    async updateTree(treeID : string, updateData : Partial<ITreeInput>) {
        const allowedUpdates = ['treeName', 'treeLocation'];
        const filteredUpdates: Partial<ITreeInput> = {
            ...Object.fromEntries(
                Object.entries(updateData).filter(([key]) => allowedUpdates.includes(key))
            )
        };

        const tree = await Tree.findByIdAndUpdate(treeID, filteredUpdates, { new: true });

        if (!tree){
            return {status: 404, message: 'Tree not found'};
        }

        return {status: 200, message: 'Tree updated successfully'};
    }

    async deleteTree(treeID : string , deletedBy : {role : string, id : string}, reason : TDeleteReason) {
        const tree = await Tree.findById(treeID);
        if (!tree){
            return false;
        }
        
        const toTrash = new trashTree({
            ...tree.toObject(), 
            deletionReason : reason, 
            deletedBy : {role : deletedBy.role, hisID : new mongoose.Types.ObjectId(deletedBy.id)}
        });
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