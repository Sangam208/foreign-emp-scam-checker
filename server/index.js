const express = require("express");

const mongoose = require("mongoose");

require('dotenv').config();

const PORT = process.env.PORT | 3001;

const app = express();

const DB = process.env.DB_URI;

mongoose.connect(DB).then(() => {
    console.log("Connection successful");
}).catch((err) => {
    console.log(err);
});

app.listen(PORT, "0.0.0.0", () => {
    console.log(`Connected at port ${PORT}`);
});