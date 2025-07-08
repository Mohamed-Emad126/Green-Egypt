import express from "express";
import dotenv from 'dotenv';
import morgan from 'morgan';
import cors from 'cors';
import swaggerUi from 'swagger-ui-express';
import path from 'path';
import fs from 'fs';
import { limiter } from "./middlewares/securityMiddleware";
import { globalErrorMiddleware, notFoundErrorMiddleware } from "./middlewares/errorMiddleware";
import userRouter from "./routes/userRoute";
import rootRouter from "./routes/authRoute";
import treeRouter from "./routes/treeRoute";
import partnerRouter from "./routes/partnerRoute";
import couponRouter from "./routes/couponRoute";
import reportRouter from "./routes/reportRoute";
import eventRouter from "./routes/eventRoute";
import commentRouter from "./routes/commentRoute";
import responseRouter from "./routes/responseRoute";
import taskRouter from "./routes/taskRoute";
import guideRouter from "./routes/guideRoute";
import searchRouter from "./routes/searchRoute";
import nurseryRouter from "./routes/nurseryRoute";
import notificationRouter from "./routes/notificationRoute";
import modelRouter from "./routes/modelRoute";
import objectRouter  from "./routes/ODModelRoute";
import chatbotRouter from "./routes/chatbotRoute";


//* Environment variables
dotenv.config();

//* Create Express App
const app = express();

//* Middlewares
//? -----Allow cross-origin requests
app.use(cors());

//? -----Body Parser
app.use(express.json());

//? -----Static Folder
app.use("/uploads", express.static(path.join(__dirname, 'uploads')));

//? -----Limit Request From Same IP
app.use(limiter);

//? -----Logging HTTP request
if (process.env.NODE_ENV === 'development') {
    app.use(morgan('dev'));
    console.log(`mode: ${process.env.NODE_ENV}`);
}

//? -----Mount Routes
app.use('/api/auth', rootRouter);
app.use('/api/users', userRouter);
app.use('/api/trees', treeRouter);
app.use('/api/partners', partnerRouter);
app.use('/api/coupons', couponRouter);
app.use('/api/reports', reportRouter);
app.use('/api/events', eventRouter);
app.use('/api/comments', commentRouter);
app.use('/api/responses', responseRouter);
app.use('/api/tasks', taskRouter);
app.use('/api/guide', guideRouter);
app.use('/api/search', searchRouter);
app.use('/api/nursery', nurseryRouter);
app.use('/api/notifications', notificationRouter);
app.use('/api/model', modelRouter);
app.use('/api/object', objectRouter);
app.use('/api/chatbot', chatbotRouter);

app.get("/comment", (req, res) => {
    res.sendFile(path.join(__dirname, "uploads", "comment.html"));
});

//? -----swagger
const swaggerDocument = JSON.parse(
    fs.readFileSync(path.join(__dirname, 'swagger.json'), 'utf-8')
);
app.use('/api-docs', swaggerUi.serve, swaggerUi.setup(swaggerDocument));

//? -----Error Handler
app.use(notFoundErrorMiddleware);
app.use(globalErrorMiddleware); // for express errors

export default app;