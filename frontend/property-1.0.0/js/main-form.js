const form = document.getElementById("main-form");

form.addEventListener("submit", function (event) {
    event.preventDefault(); // Don't reload the page

    const filters = {
        type: document.getElementById("property-type").value,
        minPrice: document.getElementById("min-price").value,
        maxPrice: document.getElementById("max-price").value,
        city: document.getElementById("district").value
    };

    fetch("http://localhost:3000/main-form-request/search", {
        method: "POST",
        headers: {
            "Content-Type": "application/json"
        },
        body: JSON.stringify(filters)
    });

    const properties = await response.json();

    console.log(filters);





    
});



