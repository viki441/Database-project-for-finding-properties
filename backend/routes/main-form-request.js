const express = require("express");
const router = express.Router();

const ibmdb = require("ibm_db");
const connStr = require("../db");

// GET all users
// router.get("/", (req, res) => {

//     ibmdb.open(connStr, (err, conn) => {

//         if (err) {
//             return res.status(500).json(err);
//         }

//         conn.query("SELECT username, names, email FROM FN3MI0700328.USERS", (err, data) => {

//             conn.close();

//             if (err) {
//                 return res.status(500).json(err);
//             }

//             res.json(data);
//         });
//     });
// });


router.post("/search", (req, res) => {
    const { type, minPrice, maxPrice, distinct } = req.body;

    let sql = `
    SELECT *
    FROM OFFERS O
    JOIN PROPERTIES P ON O.PROPERTYID = P.PROPERTYID
    JOIN LOCATIONS L ON P.LOCATIONID = L.LOCATIONID
    WHERE 1=1`;

    let params = [];

    if (type) {
        sql += `AND O.OFFERTYPE = ?`;
        params.push(type);
    }
    if (minPrice) {
        sql += `AND O.AMOUNT >= ?`;
        params.push(minPrice);
    }
    if (maxPrice) {
        sql += `AND O.AMOUNT <= ?`;
        params.push(maxPrice);
    }
    if (distinct) {
        sql += `AND L.REGION = ?`;
        params.push(distinct);
    }

    ibmdb.open(connStr, (err, conn) => {
        if (err) return res.status(500).json(err);

        conn.query(sql, params, (err, data) => {
            conn.closeSync();
            if (err) return res.status(500).json(err);

            res.json(data);
        });
    });


});

module.exports = router;