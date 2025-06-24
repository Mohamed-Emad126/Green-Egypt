import { Router } from "express";
import ChatbotController from "../controllers/chatbotController";
import ChatbotService from "../services/chatbotService";
import { chatValidator } from "../utils/validators/chatbotValidator";
import { verifyToken } from "../middlewares/authMiddleware";

const chatbotRouter = Router();

const service = new ChatbotService();
const { chat, classifyIntent, getHistory } = new ChatbotController(service);

chatbotRouter.post("/chat", verifyToken, chatValidator, chat);

chatbotRouter.post("/intent", verifyToken, chatValidator, classifyIntent);

chatbotRouter.get("/history/:id", verifyToken, getHistory);

export default chatbotRouter;
