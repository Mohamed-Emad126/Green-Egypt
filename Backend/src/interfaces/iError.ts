export interface ICustomError extends Error {
    statusCode?: number;
    status?: string;
}

