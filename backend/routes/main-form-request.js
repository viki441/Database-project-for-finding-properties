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
    const { type, minPrice, maxPrice, district } = req.body;

    let sql = `
SELECT * FROM FN3MI0700328.OFFERS O JOIN FN3MI0700328.PROPERTIES P ON O.PROPERTYID = P.PROPERTYID JOIN FN3MI0700328.LOCATIONS L ON P.LOCATIONID = L.LOCATIONID JOIN FN3MI0700328.IMAGES I ON I.OFFERID = O.OFFERID WHERE 1=1
`;

    let params = [];

    if (type) {
        sql += " AND O.OFFERTYPE = ?";
        params.push(type);
    }

    if (district) {
        sql += " AND L.REGION = ?";
        params.push(district);
    }

    if (minPrice) {
        sql += " AND O.AMOUNT >= ?";
        params.push(minPrice);
    }

    if (maxPrice) {
        sql += " AND O.AMOUNT <= ?";
        params.push(maxPrice);
    }

    ibmdb.open(connStr, (err, conn) => {
        if (err) return res.status(500).json(err);

        console.log("SQL:", sql);
        console.log("PARAMS:", params);

        conn.query(sql, params, (err, data) => {
            conn.closeSync();
            if (err) return res.status(500).json(err);

            res.json(data);
        });
    });


});

module.exports = router;