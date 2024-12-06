import http from 'http';
import { Server } from 'socket.io';
import app from './app';

//* Create HTTP Server
const httpServer = http.createServer(app);

//* Initialize Socket.io
const io = new Server(httpServer);

//* Handle socket connections
io.on('connection', (socket) => {
    console.log(`Socket connected: ${socket.id}`);
    socket.on('disconnect', () => {
        console.log(`Socket disconnected: ${socket.id}`);
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
