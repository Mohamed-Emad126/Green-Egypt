import mongoose, { Schema, Model } from 'mongoose';
import { ITask } from '../interfaces/iTask';

const TaskSchema: Schema = new Schema({
    title: {
        type: String,
        required: true,
        maxLength: [30, 'Title cannot be more than 30 characters']
    },
    tree: {
        type: mongoose.Types.ObjectId,
        ref : 'Tree',
        required: true,
    },
    user: {
        type: mongoose.Schema.Types.ObjectId,
        ref: 'User',
        required: true,
    },
    date: {
        type: Date,
        required: true,
    },
    isDone: {
        type: Boolean,
        default: false
    }
    
});

const TaskModel: Model<ITask> = mongoose.model<ITask>('Task', TaskSchema);
export default TaskModel;