import { Router } from "express";
import GuideService from "../services/guideService";
import GuideController from "../controllers/guideController";
import {getArticleValidator,createArticleValidator ,deleteArticleValidator ,updateArticleValidator ,uploadArticlePictureValidator} from "../utils/validators/guideValidator";
import { uploadImage } from "../middlewares/uploadImageMiddleware";
import { verifyToken } from "../middlewares/authMiddleware";

const guideRouter = Router();

const guideService = new GuideService();
const { getArticles, 
        getArticleById,
        createArticle, 
        deleteArticle, 
        updateArticle, 
        uploadArticlePicture} = new GuideController(guideService);

guideRouter.route('/')
        .get(getArticles)
        .post(verifyToken,createArticleValidator, createArticle);

guideRouter.route('/:id')
        .get(verifyToken, getArticleValidator, getArticleById)
        .patch(verifyToken, updateArticleValidator, updateArticle)
        .delete(verifyToken, deleteArticleValidator, deleteArticle);

guideRouter.route('/image/:id')
        .post(verifyToken, uploadImage, uploadArticlePictureValidator, uploadArticlePicture) 


export default guideRouter;



