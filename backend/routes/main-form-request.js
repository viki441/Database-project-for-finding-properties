const express = require("express");
const router = express.Router();

const ibmdb = require("ibm_db");
const connStr = require("../db");


// =========================
// SEARCH OFFERS (FILTERS)
// =========================
router.post("/search", (req, res) => {

    const { type, minPrice, maxPrice, district } = req.body;

    let sql = `
        SELECT * 
        FROM FN3MI0700328.OFFERS O 
        JOIN FN3MI0700328.PROPERTIES P ON O.PROPERTYID = P.PROPERTYID 
        JOIN FN3MI0700328.LOCATIONS L ON P.LOCATIONID = L.LOCATIONID 
        JOIN FN3MI0700328.IMAGES I ON I.OFFERID = O.OFFERID 
        WHERE 1=1
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

        conn.query(sql, params, (err, data) => {
            conn.closeSync();

            if (err) return res.status(500).json(err);

            res.json(data);
        });
    });
});


// =========================
// STATISTICS (HOMEPAGE)
// =========================
router.get("/statistics", (req, res) => {

    const sql = `
        SELECT 
            SUM(CASE WHEN OFFERTYPE = 'buy' THEN 1 ELSE 0 END) AS BUY_COUNT,
            SUM(CASE WHEN OFFERTYPE = 'rent' THEN 1 ELSE 0 END) AS RENT_COUNT,
            COUNT(*) AS ALL_PROPERTIES,
            (SELECT COUNT(*) FROM FN3MI0700328.AGENCIES) AS AGENTS_COUNT
        FROM FN3MI0700328.OFFERS
    `;

    ibmdb.open(connStr, (err, conn) => {
        if (err) return res.status(500).json(err);

        conn.query(sql, (err, data) => {
            conn.closeSync();

            if (err) return res.status(500).json(err);

            res.json(data[0]);
        });
    });
});

//AGENTS

router.get("/agents", (req, res) => {

    const sql = `
    SELECT 
        U.USERNAME,
        U.NAMES,
        A.WEBSITE,
        COUNT(O.OFFERID) AS OFFER_COUNT
    FROM FN3MI0700328.USERS U
    JOIN FN3MI0700328.AGENCIES A ON A.USERNAME = U.USERNAME
    LEFT JOIN FN3MI0700328.OFFERS O ON O.USERNAME = U.USERNAME
    GROUP BY U.USERNAME, U.NAMES, A.WEBSITE
    ORDER BY OFFER_COUNT DESC
    FETCH FIRST 3 ROWS ONLY
`;

    ibmdb.open(connStr, (err, conn) => {
        if (err) return res.status(500).json(err);

        conn.query(sql, (err, data) => {
            conn.closeSync();

            if (err) return res.status(500).json(err);

            res.json(data);
        });
    });
});


module.exports = router;