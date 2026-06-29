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
    U.PHONENUMBER,
    A.WEBSITE,
        COUNT(O.OFFERID) AS OFFER_COUNT
FROM FN3MI0700328.USERS U
         JOIN FN3MI0700328.AGENCIES A
              ON A.USERNAME = U.USERNAME
         LEFT JOIN FN3MI0700328.OFFERS O
                   ON O.USERNAME = U.USERNAME
GROUP BY
    U.USERNAME,
    U.NAMES,
    U.PHONENUMBER,
    A.WEBSITE  
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

//INDIVIDUAL PROPERTY
router.get("/property/:id", (req, res) => {

    const id = req.params.id;


    console.log("ID:", `"${id}"`);
    console.log("Length:", id.length);


    //

    const sql = `
    SELECT *
FROM FN3MI0700328.OFFERS O
JOIN FN3MI0700328.PROPERTIES P ON O.PROPERTYID = P.PROPERTYID
JOIN FN3MI0700328.USERS U ON U.USERNAME = O.USERNAME
JOIN FN3MI0700328.LOCATIONS L ON P.LOCATIONID = L.LOCATIONID
JOIN FN3MI0700328.IMAGES I ON I.OFFERID = O.OFFERID
LEFT JOIN FN3MI0700328.AGENCIES A ON U.USERNAME = A.USERNAME
LEFT JOIN FN3MI0700328.HOUSES H ON H.PROPERTYID = P.PROPERTYID
LEFT JOIN FN3MI0700328.APARTMENTS AP ON AP.PROPERTYID = P.PROPERTYID
WHERE O.OFFERID = ?
`;

    ibmdb.open(connStr, (err, conn) => {
        if (err) return res.status(500).json({ error: err.message });

        conn.query(sql, [String(id)], (err, data) => {
            conn.closeSync();

            if (err) return res.status(500).json({ error: err.message });

            console.log("RESULT:", data);

            if (!data || data.length === 0) {
                return res.status(404).json({ error: "Property not found" });
            }

            res.json(data[0] || null);
        });
    });
});


//TOP 3 OFFERS
router.get("/latest-properties", (req, res) => {

    const sql = `
        SELECT 
            O.OFFERID,
            O.AMOUNT,
            O.OFFERTYPE,
            O.HEADING,
            P.AREA,
            P.ROOMCOUNT,
            P.PROPERTYID,
            L.CITY,
            L.REGION,
            I.LINKTOSERVER
        FROM FN3MI0700328.OFFERS O
        JOIN FN3MI0700328.PROPERTIES P 
            ON O.PROPERTYID = P.PROPERTYID
        JOIN FN3MI0700328.LOCATIONS L 
            ON P.LOCATIONID = L.LOCATIONID
        LEFT JOIN FN3MI0700328.IMAGES I 
            ON I.OFFERID = O.OFFERID
        ORDER BY O.OFFERID DESC
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