import { Router } from "express";
import { verifyToken, verifyRespondentMiddleware} from "../middlewares/authMiddleware";
import ResponseController from "../controllers/responseController";
import ResponseService from "../services/responseService";
import { getResponseByIdValidator, deleteResponseValidator, addResponseImagesValidator, deleteResponseImageValidator, voteResponseValidator, analysisResponseValidator, verifyResponseValidator} from "../utils/validators/responseValidator";
import { uploadImages } from "../middlewares/uploadImageMiddleware";

const responseRouter = Router();

const responseService = new ResponseService();
const { getResponseById, deleteResponse, addResponseImages, deleteResponseImage, voteResponse, analysisResponse, verifyResponse} = new ResponseController(responseService);

responseRouter.route('/:id')
    .get(verifyToken, getResponseByIdValidator, getResponseById)
    .delete(verifyRespondentMiddleware, deleteResponseValidator, deleteResponse)

responseRouter.route('/:id/images')
    .put(verifyRespondentMiddleware, uploadImages, addResponseImagesValidator, addResponseImages)
    .delete(verifyRespondentMiddleware, deleteResponseImageValidator, deleteResponseImage);

responseRouter.route('/:id/vote')
    .post(verifyToken, voteResponseValidator, voteResponse);

responseRouter.route('/:id/analysis')
    .put(verifyRespondentMiddleware, analysisResponseValidator, analysisResponse);

responseRouter.route('/:id/verify')
    .put(verifyRespondentMiddleware, verifyResponseValidator, verifyResponse);


export default responseRouter;