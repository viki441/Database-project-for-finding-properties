console.log("JS FILE LOADED");

const form = document.getElementById("main-form");

form.addEventListener("submit", async (e) => {
    e.preventDefault();

    const filters = {
        type: document.getElementById("property-type").value,
        minPrice: document.getElementById("min-price").value,
        maxPrice: document.getElementById("max-price").value,
        city: document.getElementById("district").value
    };

    const response = await fetch("http://localhost:3000/main-form-request/search", {
        method: "POST",
        headers: {
            "Content-Type": "application/json"
        },
        body: JSON.stringify(filters)
    });

    const properties = await response.json();

    console.log("FILTERS:", filters);
    console.log("RESULTS:", properties);
});