export interface ChatRequest {
    user_id: string;
    text: string;
}

export interface ChatResponse {
    response: string;
}

export interface IntentResponse {
    intent: string;
}

export interface ChatHistory {
    text: string;
    label: string;
    timestamp: string;
}
