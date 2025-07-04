import axios from "axios";
import { ChatRequest, ChatResponse, IntentResponse, ChatHistory } from "../interfaces/iChatbot";

const CHATBOT_API_URL = process.env.CHATBOT_API_URL || "http://127.0.0.1:4002";

export default class ChatbotService {

    async getChatResponse(data: ChatRequest) {
        try {
            const response = await axios.post<ChatResponse>(`${CHATBOT_API_URL}/chat`, data, {
                timeout: 10000
            });

            return { status: 200, data: response.data };

        } catch (error: any) {
            return { status: error.response?.status || 500, error: error.message };
        }
    }

    async classifyUserIntent(data: ChatRequest) {
        try {
            const response = await axios.post<IntentResponse>(`${CHATBOT_API_URL}/classify_embedding`, data, {
                timeout: 10000
            });

            return { status: 200, data: response.data };

        } catch (error: any) {
            return { status: error.response?.status || 500, error: error.message };
        }
    }

    async getChatHistory(user_id: string) {
        try {
            const response = await axios.get<ChatHistory[]>(`${CHATBOT_API_URL}/history/${user_id}`, {
                timeout: 10000
            });

            return { status: 200, data: response.data };

        } catch (error: any) {
            return { status: error.response?.status || 500, error: error.message };
        }
    }
}
