const express = require("express");
const router = express.Router();

const ibmdb = require("ibm_db");
const connStr = require("../db");

// GET all users
router.get("/", (req, res) => {

    ibmdb.open(connStr, (err, conn) => {

        if (err) {
            return res.status(500).json(err);
        }

        conn.query("SELECT username, names, email FROM FN3MI0700328.USERS", (err, data) => {

            conn.close();

            if (err) {
                return res.status(500).json(err);
            }

            res.json(data);
        });
    });
});

module.exports = router;