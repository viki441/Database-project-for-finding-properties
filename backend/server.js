const express = require("express");
const cors = require("cors");

const app = express();

app.use(cors());
app.use(express.json());

// better naming
const mainFormRoute = require("./routes/main-form-request");

// route prefix
app.use("/search", mainFormRoute);

app.get("/", (req, res) => {
    res.send("Backend is working");
});

app.listen(3000, () => {
    console.log("Server running on port 3000");
});