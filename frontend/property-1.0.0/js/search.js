let allData = [];
let container;
const pageLimit = 10;


window.addEventListener("load", async () => {

    const filters = JSON.parse(sessionStorage.getItem("filters")) || {};

    const response = await fetch("http://localhost:3000/main-form-request/search", {
        method: "POST",
        headers: {
            "Content-Type": "application/json"
        },
        body: JSON.stringify(filters)
    });

    if (!response.ok) {
        const errorText = await response.text();
        console.error("Backend error:", errorText);
        return;
    }

    allData = await response.json();

    container = document.getElementById("row-container");
    renderPage(1);
});



