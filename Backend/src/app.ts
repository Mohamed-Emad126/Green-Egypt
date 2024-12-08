import express from "express";
import dotenv from 'dotenv';
import morgan from 'morgan';
import path from 'path';
import connectDB from "./config/db";
import pug from 'pug';
import rateLimit from 'express-rate-limit';
import { globalErrorMiddleware, notFoundErrorMiddleware } from "./middlewares/errorMiddleware";
import userRoute from "./routes/userRoute";
import rootRoute from "./routes/authRoute";
import treeRoute from "./routes/treeRoute";
import partnerRoute from "./routes/partnerRoute";
import couponRouter from "./routes/couponRoute";
import reportRouter from "./routes/reportRoute";
import eventRouter from "./routes/eventRoute";


//* Environment variables
dotenv.config();

//* Connect to database
connectDB();

//* Create Express App
const app = express();

//* limit request from same IP
const limiter = rateLimit({
    windowMs: 15 * 60 * 1000,
    max: 100,
    message: 'Too many accounts created from this IP, please try again after an hour',
});

//* Middlewares
//? -----Body Parser
app.use(express.json());

//? -----Static Folder
app.use("/uploads", express.static(path.join(__dirname, 'uploads')));

//? -----Logging HTTP request
if (process.env.NODE_ENV === 'development') {
    app.use(morgan('dev'));
    console.log(`mode: ${process.env.NODE_ENV}`);
}

//? -----Rate Limiting
app.use(limiter);

//? -----Mount Routes
app.use('/api/auth', rootRoute);
app.use('/api/users', userRoute);
app.use('/api/trees', treeRoute);
app.use('/api/partners', partnerRoute);
app.use('/api/coupons', couponRouter);
app.use('/api/reports', reportRouter);
app.use('/api/events', eventRouter);

//? -----Error Handler
app.use(notFoundErrorMiddleware);
app.use(globalErrorMiddleware); // for express errors

export default app;