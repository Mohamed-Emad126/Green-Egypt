import TreeService from "../services/treeService";
import { Request, Response, NextFunction } from "express";
import asyncHandler from 'express-async-handler';
import ApiError from "../utils/apiError";
import { ITreeInput } from "../interfaces/iTree";



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
        const page: number = req.query.page ? +req.query.page : 1;
        const limit: number = req.query.limit ? +req.query.limit : 5;
        const filters = req.query.filters ? JSON.parse(req.query.filters as string) : {};
        console.log(filters);
        const trees = await this.treeService.getTrees(page, limit , filters);
        res.json({ length: trees.length, page: page, trees: trees });
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
     * @route     POST /api/trees
     * @access    Public
    */
    LocateTree = asyncHandler(async (req: Request, res: Response) => {
        const { species, location, healthStatus, image }: ITreeInput = req.body;
        const createdTree = await this.treeService.LocateTree({ species , location, healthStatus, image });
        if (createdTree) {
            res.status(201).json({ message: 'Tree located successfully' });
        } else {
            res.status(400).json({ message: 'Tree already exists'});
        }
    });

    /**
     * @desc      Update tree
     * @route     patch /api/trees/:id
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
     * @route     post /api/trees/:id/image
     * @access    Public
    */
    uploadTreePicture = asyncHandler(async (req: Request, res: Response, next: NextFunction) => {
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
        const deletedTree = await this.treeService.deleteTree(req.params.id);
        if (deletedTree) {
            res.json({ message: "Tree deleted successfully"});
        } else {
            return next(new ApiError("Tree not found", 404));
        }

    });

}
