const express = require("express");

const mongoose = require("mongoose");
const authRouter = require("./routes/auth");
const agencyRouter = require("./routes/agency");

require('dotenv').config();

const PORT = process.env.PORT | 3001;

const app = express();

app.use(express.json());
app.use(authRouter);
app.use(agencyRouter);

const DB = process.env.DB_URI;

mongoose.connect(DB).then(() => {
    console.log("Connection successful");
}).catch((err) => {
    console.log(err);
});

app.listen(PORT, "0.0.0.0", () => {
    console.log(`Connected at port ${PORT}`);
});