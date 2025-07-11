import { Request, Response, NextFunction } from "express";
import asyncHandler from "express-async-handler";
import ChatbotService from "../services/chatbotService";
import ApiError from "../utils/apiError";

export default class ChatbotController {
    constructor(private service: ChatbotService) {
        this.chat = this.chat.bind(this);
        this.classifyIntent = this.classifyIntent.bind(this);
        this.getHistory = this.getHistory.bind(this);
    }

    /**
     * @desc      Get chatbot response
     * @route     POST /api/chatbot/chat
     * @access    Public
     */
    chat = asyncHandler(async (req: Request, res: Response, next: NextFunction) => {
        const result = await this.service.getChatResponse(req.body);

        if (result.status !== 200) {
            return next(new ApiError(result.error, result.status));
        }

        res.json({
            message: "Chatbot response generated successfully",
            data: result.data
        });
    });

    /**
     * @desc      Classify user intent
     * @route     POST /api/chatbot/intent
     * @access    Public
     */
    classifyIntent = asyncHandler(async (req: Request, res: Response, next: NextFunction) => {
        const result = await this.service.classifyUserIntent(req.body);

        if (result.status !== 200) {
            return next(new ApiError(result.error, result.status));
        }

        res.json({
            message: "Intent classified successfully",
            data: result.data
        });
    });

    /**
     * @desc      Get chat history for user
     * @route     GET /api/chatbot/history/:id
     * @access    Public
     */
    getHistory = asyncHandler(async (req: Request, res: Response, next: NextFunction) => {
        const result = await this.service.getChatHistory(req.params.id);

        if (result.status !== 200) {
            return next(new ApiError(result.error, result.status));
        }

        res.json({
            message: "Chat history fetched successfully",
            data: result.data
        });
    });
}
