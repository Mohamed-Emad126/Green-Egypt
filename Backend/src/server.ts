import http from 'http';
import { Server } from 'socket.io';
import connectDB from './config/db';
import app from './app';
import CommentService from "./services/commentService";

//* Connect to database
connectDB();

//* Create HTTP Server
const httpServer = http.createServer(app);

//* Initialize Socket.io
const io = new Server(httpServer);

//* Handle socket connections
const commentService = new CommentService();

io.on('connection', (socket) => {

    socket.on("newComment", async (comment) => {
        try {
            const savedComment = await commentService.createComment({
                reportID: comment.reportID,
                createdBy: comment.createdBy,
                content: comment.content,
            });

            io.emit("commentBroadcast", savedComment);
        } catch (error) {
            console.error("Failed to save comment:", error);
        }
    });
});

//* Running The Server
const PORT = process.env.PORT || 3000;
const server = httpServer.listen(PORT, () => console.log(`Server running on http://localhost:${PORT}`));

//* Handle Rejection outside express
process.on('unhandledRejection', (err : Error) => {
    console.error(`Rejection: ${err.name} - ${err.message}`);
    server.close(() => {
        console.log('Shutting down server...');
        process.exit(1);
    });
});
