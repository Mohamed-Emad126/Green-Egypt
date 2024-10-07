import mongoose from 'mongoose';
import dotenv from 'dotenv';

dotenv.config();

const connectDB = async (): Promise<void> => {
    await mongoose.connect(process.env.MONGO_URI as string).then(() => console.log('Database connected successfully'));
};

export default connectDB;