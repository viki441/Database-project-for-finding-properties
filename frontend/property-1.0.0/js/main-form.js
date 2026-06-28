console.log("JS FILE LOADED");

const form = document.getElementById("main-form");

form.addEventListener("submit", async (e) => {
    e.preventDefault();

    const filters = {
        type: document.getElementById("property-type").value,
        minPrice: document.getElementById("min-price").value,
        maxPrice: document.getElementById("max-price").value,
        district: document.getElementById("district").value
    };

    sessionStorage.setItem("filters", JSON.stringify(filters));

    window.location.href = "search.html";
});


