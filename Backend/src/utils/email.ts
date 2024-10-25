import nodemailer from 'nodemailer';
import { TransportOptions } from 'nodemailer';

const sendEmail = async (option: any): Promise<void> => {
    // create transporter
    const transporter = nodemailer.createTransport({
        host: process.env.EMAIL_HOST as string,
        port: process.env.EMAIL_PORT,                 
        auth: {
            user: process.env.EMAIL_USER as string,
            pass: process.env.EMAIL_PASS as string
        }
    } as TransportOptions);

    // email options
    const emailOptions =({
        from: "gogreenfci2025@gmail.com",
        to: option.email,
        subject: option.subject,
        text: option.message,
    });

    // send email
    await transporter.sendMail(emailOptions);

}

export default sendEmail;
