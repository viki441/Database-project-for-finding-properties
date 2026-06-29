const containerOffers = document.getElementById("top-3-offers");

window.addEventListener("DOMContentLoaded", async () => {
    
    if (!containerOffers) {
        console.error("Container not found!");
        return;
    }

    const res = await fetch("http://localhost:3000/main-form-request/latest-properties");
    const data = await res.json();

    containerOffers.innerHTML = "";

    data.forEach(card => {      
        containerOffers.appendChild(prepareCard(card));
    });
});