import e from 'express';
import { connectDB } from '../configs/connectDB';
import axios from "axios";

let test = async (req, res) => {
    return res.status(200).send("Hello World");
}

module.exports = {

}