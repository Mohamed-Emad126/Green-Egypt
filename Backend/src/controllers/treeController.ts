import TreeService from "../services/treeService";
import { Request, Response, NextFunction } from "express";
import asyncHandler from 'express-async-handler';
import ApiError from "../utils/apiError";
import axios from 'axios';
import { ITreeInput } from "../interfaces/iTree";


export default class TreeController {

    constructor(private treeService: TreeService) {
        this.getTrees = this.getTrees.bind(this);
        this.getTreeById = this.getTreeById.bind(this);
        this.LocateTree = this.LocateTree.bind(this);
        this.updateTree = this.updateTree.bind(this);
        this.deleteTree = this.deleteTree.bind(this);
        this.getTreesByLocation = this.getTreesByLocation.bind(this);
        this.uploadTreePicture = this.uploadTreePicture.bind(this);
    }

    /**
     * @desc      Get all trees
     * @route     GET /api/trees
     * @access    Public
    */
    getTrees = asyncHandler(async (req: Request, res: Response) => {
        const filters = req.query.filters ? JSON.parse(req.query.filters as string) : {};
        const trees = await this.treeService.getTrees(filters);
        res.json({ length: trees.length, trees: trees });
    });

    /**
     * @desc      Get tree by id
     * @route     GET /api/trees/:id
     * @access    Public
    */
    getTreeById = asyncHandler(async (req: Request, res: Response, next: NextFunction) => {
        const tree = await this.treeService.getTreeById(req.params.id);
        if (tree) {
            res.json(tree);
        } else {
            return next(new ApiError("Tree not found", 404));
        }
    });

    /**
     * @desc      Get trees by location
     * @route     GET /api/trees/location
     * @access    Public
    */
    getTreesByLocation = asyncHandler(async (req: Request, res: Response, next: NextFunction) => {
        const trees = await this.treeService.getTreesByLocation(req.body.location);
        res.json({ length: trees.length, trees: trees });
    })

    /**
     * @desc      Locate tree
     * @route     POST /api/users/:id/trees
     * @access    Public
    */
    LocateTree = asyncHandler(async (req: Request, res: Response, next: NextFunction) => {
        req.body.treeLocation = JSON.parse(req.body.treeLocation);
        const { treeLocation, treeName } : ITreeInput = req.body;

        const result = await this.treeService.LocateTree(
            req.body,
            req.file as Express.Multer.File, 
            req.params.id);

        if (result.status === 201) {
            res.status(201).json({ message: 'Tree located successfully' });
            await axios.put(`http://localhost:5000/api/users/${req.params.id}/activity`, {
                activity: 'locate'
                },{
                headers: { 'Authorization': req.headers.authorization }
            });
            
        } else {
            res.status(400).json({ existingTree: result.existingTree });
        }
    });

    /**
     * @desc      Update tree
     * @route     PATCH /api/trees/:id
     * @access    Public
    */
    updateTree = asyncHandler(async (req: Request, res: Response, next: NextFunction) => {
        const treeAfterUpdate = await this.treeService.updateTree(req.params.id, req.body);
        if (treeAfterUpdate) {
            res.json({ message: "Tree updated successfully"});
        } else {
            return next(new ApiError("Tree not found", 404));
        }
        
    });

    /**
     * @desc      Upload tree picture
     * @route     PATCH /api/trees/:id/image
     * @access    Public
    */
    uploadTreePicture = asyncHandler(async (req: Request, res: Response, next: NextFunction) => {
        if(!req.file) {
            return next(new ApiError("No file uploaded", 400));
        }

        const result = await this.treeService.uploadTreePicture(req.params.id, req.file);
        if (result) {
            res.json({ message: "Picture updated successfully"});
        } else {
            return next(new ApiError("Tree not found", 404));
        }
    });

    /**
     * @desc      Delete tree
     * @route     DELETE /api/trees/:id
     * @access    Public
    */
    deleteTree = asyncHandler(async (req: Request, res: Response, next: NextFunction) => {
        const { id, role} : {id: string, role: string} = req.body.user;
        const deletedTree = await this.treeService.deleteTree(req.params.id, {role, id}, req.body.deletionReason);
        if (deletedTree) {
            res.json({ message: "Tree deleted successfully"});
        } else {
            return next(new ApiError("Tree not found", 404));
        }
    });

}
