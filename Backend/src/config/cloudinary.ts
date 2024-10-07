import { v2 as cloudinary } from 'cloudinary';

cloudinary.config({
    cloud_name: process.env.CLOUDINARY_CLOUD_NAME,
    api_key: process.env.CLOUDINARY_API_KEY,
    api_secret: process.env.CLOUDINARY_API_SECRET
});

interface CloudinaryUploadResult {
    url: string;
    id: string;
}

const uploadToCloud = (file: string): Promise<CloudinaryUploadResult> => {
    return new Promise((resolve, reject) => {
        cloudinary.uploader.upload(file, { resource_type: "auto" }, (error, result) => {
            if (error) {
                console.error('Cloudinary upload error:', error);
                return reject(error);
            }
            if (!result) {
                return reject(new Error('Cloudinary result is undefined'));
            }
            resolve({
                url: result.secure_url,
                id: result.public_id
            });
        });
    });
};

export default uploadToCloud;
