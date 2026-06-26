const express = require("express");
const cors = require("cors");

const app = express();

app.use(cors());
app.use(express.json());

const usersRoute = require("./routes/main-form-request");

app.use("/main-form-request", usersRoute);

app.get("/", (req, res) => {
    res.send("Backend is working");
});

app.listen(3000, () => {
    console.log("Server running on port 3000");
});