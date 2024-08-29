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

const checkExist = async (req, res) => {
    try {
        let {user_email} = req.body;
        const pool = await connectDB();
        const result = await pool.request().query(`select * from UserAccount where user_email = '${user_email}'`);
        if (result.rowsAffected[0] > 0) {
            console.log(user_email);
            return res.status(400).json({ message: "Email already exists" });
        }
        else {
            return res.status(200).json({ message: "Email is available" });
        }
    } catch (err) {
        console.log(err);
    }
}

const updatePassword = async (req, res) => {
    try {
        let {user_email, user_password} = req.body;
        const pool = await connectDB();
        const result = await pool.request().query(`select * from UserAccount where user_email = '${user_email}'`);
        if (result.rowsAffected[0] < 0) {
            return res.status(404).json({ message: "Email not found" });
        }

        const result1 = await pool.request().query(`update UserAccount set user_password = '${user_password}' where user_email = '${user_email}'`);
        return res.status(200).json({ message: "Success" });

    } catch (err) {
        console.log(err);
    }
}

const saveUserInfo = async (req, res) => {
    try {
        let { gender, weight, height, age, DoB, user_image, user_id, goal_id, level_id } = req.body;
        const pool = await connectDB();

        // const userCheck = await pool.request().query(`SELECT * FROM UserAccount WHERE user_id = '${user_id}'`);
        // if (userCheck.rowsAffected[0] === 0) {
        //     return res.status(404).json({ message: "User not found" });
        // }

        const result = await pool.request().query(`
            INSERT INTO UserInfor (gender, weight, height, age, DoB, user_image, user_id, goal_id, level_id)
            VALUES (N'${gender}', ${weight}, ${height}, ${age}, '${DoB}', N'${user_image}', '${user_id}', ${goal_id}, ${level_id})`);

        return res.status(200).json({ message: "User info saved successfully" });
    } catch (err) {
        console.log(err);
        return res.status(500).json({ message: "An error occurred", error: err.message });
    }
}

module.exports = {
    test,
    signup,
    checkExist,
    updatePassword,
    saveUserInfo
}