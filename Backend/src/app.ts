import express from "express";
import mongoose from "mongoose";
import { IUser } from "./interfaces/interface";
import AuthService from "./services/authService";
import AuthController from "./controllers/authController";
//todo: database - authModel - validation
const app = express();
app.use(express.json());
const PORT: number = 5000;

const users : IUser[] = [];
const authService = new AuthService(users);
const authController = new AuthController(authService);


app.post('/register', authController.createNewUser);

app.post('/login', authController.login);

app.get('/users', (req, res) => res.send(authService.getUsers()));

mongoose.connect('mongodb+srv://hagarelessawy0:Co1yxyGMtKKtyH9M@cluster0.9ysc6.mongodb.net/?retryWrites=true&w=majority&appName=Cluster0')
    .then(() => app.listen(PORT, () => console.log(`Server running on http://localhost:${PORT}`)))
    .catch((err) => console.error(err));

