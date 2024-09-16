import express from "express";
import dotenv from 'dotenv';
import connectDB from "./config/db";
import usersRoute from "./routes/usersRoute";
import rootRoute from "./routes/rootRoute";

dotenv.config();
const app = express();
connectDB();
app.use(express.json());


app.use('/api', rootRoute);

app.use('/api/users', usersRoute);


const PORT = process.env.PORT;
app.listen(PORT, () => console.log(`Server running on http://localhost:${PORT}`))


