import { Router } from "express";
import { verifyToken, verifyRespondentMiddleware} from "../middlewares/authMiddleware";
import ResponseController from "../controllers/responseController";
import ResponseService from "../services/responseService";
import { getResponseByIdValidator, deleteResponseValidator, voteResponseValidator} from "../utils/validators/responseValidator";

const responseRouter = Router();

const responseService = new ResponseService();
const { getResponseById, deleteResponse, voteResponse} = new ResponseController(responseService);

responseRouter.route('/:id')
    .get(verifyToken, getResponseByIdValidator, getResponseById)
    .delete(verifyRespondentMiddleware, deleteResponseValidator, deleteResponse)

responseRouter.route('/:id/vote')
    .post(verifyToken, voteResponseValidator, voteResponse);


export default responseRouter;