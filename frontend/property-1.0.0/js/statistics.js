window.addEventListener("load", async () => {
    try {
        const res = await fetch("http://localhost:3000/main-form-request/statistics");

        const text = await res.text();

        if (!res.ok) {
            throw new Error("Request failed");
        }

        const stats = JSON.parse(text);

        //overall statistics
        document.getElementById("buy-count").textContent = stats.BUY_COUNT;
        document.getElementById("rent-count").textContent = stats.RENT_COUNT;
        document.getElementById("all-count").textContent = stats.ALL_PROPERTIES;
        document.getElementById("agents-count").textContent = stats.AGENTS_COUNT;

       


    } catch (err) {
        console.error("Failed to load stats:", err);
    }
});