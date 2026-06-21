const ibmdb = require("ibm_db");
const connStr = require("./db");

console.log("Connecting to DB...");

ibmdb.open(connStr, (err, conn) => {

    if (err) {
        console.log("❌ CONNECTION FAILED");
        console.log(err);
        return;
    }

    console.log("✅ DB CONNECTED SUCCESSFULLY");

    conn.query("SELECT 1 FROM sysibm.sysdummy1", (err, data) => {

        if (err) {
            console.log("Query error:", err);
        } else {
            console.log("Test query result:", data);
        }

        conn.close();
    });
});