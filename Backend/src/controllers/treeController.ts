import TreeService from "../services/treeService";
import { Request, Response, NextFunction } from "express";
import asyncHandler from 'express-async-handler';
import ApiError from "../utils/apiError";




export default class TreeController {

    constructor(private treeService: TreeService) {
        this.getTrees = this.getTrees.bind(this);
        this.getTreeById = this.getTreeById.bind(this);
        this.LocateTree = this.LocateTree.bind(this);
        this.updateTree = this.updateTree.bind(this);
        this.deleteTree = this.deleteTree.bind(this);
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
     * @desc      Locate tree
     * @route     POST /api/users/:id/trees
     * @access    Public
    */
    LocateTree = asyncHandler(async (req: Request, res: Response) => {
        let { treeName, treeLocation, healthStatus, problem } = req.body;
        treeLocation = JSON.parse(treeLocation);

        const createdTree = await this.treeService.LocateTree(
            {treeName, treeLocation, healthStatus, problem },
            req.file as Express.Multer.File, 
            req.params.id);

        if (createdTree) {
            res.status(201).json({ message: 'Tree located successfully' });
        } else {
            res.status(400).json({ message: 'Tree already exists'});
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
        const deletedTree = await this.treeService.deleteTree(req.params.id, req.body.deletionReason);
        if (deletedTree) {
            res.json({ message: "Tree deleted successfully"});
        } else {
            return next(new ApiError("Tree not found", 404));
        }
    });

}
