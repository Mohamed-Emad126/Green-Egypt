import GuideService from "../services/guideService";
import { Request, Response, NextFunction } from "express";
import asyncHandler from 'express-async-handler';
import ApiError from "../utils/apiError";
import { IGuideInput } from "../interfaces/iGuide";


export default class GuideController {

    constructor(private guideService: GuideService) {
        this.getArticles = this.getArticles.bind(this);
        
    }

    /**
     * @desc      Get all articles
     * @route     GET /api/guide
     * @access    Public
    */

    getArticles = asyncHandler(async (req: Request, res: Response, next: NextFunction) => {
        const page: number = req.query.page ? +req.query.page : 1;
        const limit: number = req.query.limit ? +req.query.limit : 6;
        const filters = req.query.filters ? JSON.parse(req.query.filters as string) : {};
        const articles = await this.guideService.getArticles(page, limit);
        res.json({ length: articles.length, page: page, articles: articles });
});

    /**
     * @desc      Get article by id
     * @route     GET /api/guide/:id
     * @access    Public
     */

    getArticleById = asyncHandler(async (req: Request, res: Response, next: NextFunction) => {
        const article = await this.guideService.getArticleById(req.params.id);
            if (article) {
                res.json(article);
            } else {
                return next(new ApiError("article not found", 404));
        }
    });

    /**
     * @desc      Create article
     * @route     POST /api/guide
     * @access    Public
     */
    createArticle = asyncHandler(async (req: Request, res: Response, next: NextFunction) => {
        const {articletitle,content,articlePic}: IGuideInput = req.body;
        const article = await this.guideService.createArticle({articletitle,content,articlePic,createdAt: new Date(Date.now())});
        if (article) {
            res.json({ message: 'article created successfully' });
        } else {
            return next(new ApiError("Error creating article", 500));
        }
    });

    /**
     * @desc      Update article
     * @route     PATCH /api/guide/:id
     * @access    Public
     */

    updateArticle = asyncHandler(async (req: Request, res: Response, next: NextFunction) => {
        const articleAfterUpdate = await this.guideService.updateArticle(req.params.id, req.body);
        if (articleAfterUpdate) {
            res.json({ message: 'article updated successfully' });
        } else {
            return next(new ApiError("article not found", 404));
        }
    });

    /**
     * @desc      Delete article
     * @route     DELETE /api/guide/:id
     * @access    Public
     */

    deleteArticle = asyncHandler(async (req: Request, res: Response, next: NextFunction) => {
        const article = await this.guideService.deleteArticle(req.params.id);
        if (article) {
            res.json({ message: 'Article deleted successfully' });
        } else {
            return next(new ApiError("Article not found", 500));
        }
    });

    /**
     * @desc      Upload article picture
     * @route     POST /api/guide/:id/picture
     * @access    Puiblic
     */
    uploadArticlePicture = asyncHandler(async (req: Request, res: Response, next: NextFunction) => {
        const result = await this.guideService.uploadArticlePicture(req.params.id, req.file);
        if (result) {
            res.json({ message: "Picture updated successfully"});
        } else {
            return next(new ApiError("Event not found", 404));
        }
    });

}