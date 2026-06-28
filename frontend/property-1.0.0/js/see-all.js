const seeAll = document.getElementById("see-all-properties");

seeAll.addEventListener("click", async (e) => {
    e.preventDefault();

    const filters = {
        type: "",
        district: "",
        minPrice: "",
        maxPrice: ""
    };

    sessionStorage.setItem("filters", JSON.stringify(filters));

    window.location.href = "search.html";
});


const seeAllRent = document.getElementById("see-all-rent");

seeAllRent.addEventListener("click", async (e) => {
    e.preventDefault();

    const filters = {
        type: "rent",
        district: "",
        minPrice: "",
        maxPrice: ""
    };

    sessionStorage.setItem("filters", JSON.stringify(filters));

    window.location.href = "search.html";
});


const seeAllBuy = document.getElementById("see-all-buy");

seeAllBuy.addEventListener("click", async (e) => {
    e.preventDefault();

    const filters = {
        type: "buy",
        district: "",
        minPrice: "",
        maxPrice: ""
    };

    sessionStorage.setItem("filters", JSON.stringify(filters));

    window.location.href = "search.html";
});
