import mongoose, { Document } from 'mongoose';

export interface ITask extends Document {
    title: string;
    tree: mongoose.Types.ObjectId;
    user: mongoose.Types.ObjectId;
    date: Date;
    isDone: boolean;
}