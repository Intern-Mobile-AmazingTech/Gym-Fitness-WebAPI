import e from 'express';
import { connectDB } from '../configs/connectDB';
import axios from "axios";

let test = async (req, res) => {
    return res.status(200).send("Hello World");
}

const signup = async (req, res) => {
    try {
        let { user_id, user_email, user_fullname, user_phone, isNormalUser } = req.body;
        const pool = await connectDB();
        const result = await pool.request().query(`Select * from UserAccount where user_email = '${user_email}'`);
        if (result.rowsAffected[0] > 0) {
            return res.status(400).json({ message: "Email already exists" });
        }
        else {
            try {
                if (isNormalUser != null){
                    const result = await pool.request().query(`Insert into UserAccount(user_id, user_email, user_fullname, user_phone, isNormalUser) values ('${user_id}', '${user_email}', '${user_fullname}', '${user_phone}', '${isNormalUser}')`);
                    return res.status(200).json({ message: "Success" });
                }
                else {
                    const result = await pool.request().query(`Insert into UserAccount(user_id, user_email, user_fullname, user_phone) values ('${user_id}', '${user_email}', '${user_fullname}', '${user_phone}')`);
                    return res.status(200).json({ message: "Success" });
                }
            }
            catch (err) {
                console.log(err);
            }
        }
    } catch (err) {
        console.log(err);
    }
}

module.exports = {
    test,
    signup,
}