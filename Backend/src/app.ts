import express from "express";
import dotenv from 'dotenv';
import morgan from 'morgan';
import path from 'path';
import connectDB from "./config/db";
import { globalErrorMiddleware , notFoundErrorMiddleware } from "./middlewares/errorMiddleware";
import userRoute from "./routes/userRoute";
import rootRoute from "./routes/authRoute";
import treeRoute from "./routes/treeRoute";
import partnerRoute from "./routes/partnerRoute";
import couponRouter from "./routes/couponRoute";
import eventRouter from "./routes/eventRoute";


//* Environment variables
dotenv.config();

//* Connect to database
connectDB();

//* Express app
const app = express();

//* Middlewares
//? -----Body Parser
app.use(express.json());

//? -----Static Folder
app.use("/uploads", express.static(path.join(__dirname, 'uploads'))); //********* */

//? -----Logging HTTP request
if (process.env.NODE_ENV === 'development') {
    app.use(morgan('dev'));
    console.log(`mode: ${process.env.NODE_ENV}`);
}

//? -----Mount Routes
app.use('/api/auth', rootRoute);
app.use('/api/users', userRoute);
app.use('/api/trees', treeRoute);
app.use('/api/partners', partnerRoute);
app.use('/api/coupons', couponRouter);
app.use('/api/events', eventRouter);

//? -----Error Handler
app.use(notFoundErrorMiddleware);
app.use(globalErrorMiddleware);     // for express errors

//* Running The Server
const PORT = process.env.PORT || 3000;
const server = app.listen(PORT, () => console.log(`Server running on http://localhost:${PORT}`));

//* Handle Rejection outside express
process.on('unhandledRejection', (err : Error) => {
    console.error(`Rejection: ${err.name} - ${err.message}`);
    server.close(() => {
        console.log('Shutting down server...');
        process.exit(1);
    })
});

