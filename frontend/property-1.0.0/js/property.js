window.addEventListener("load", async () => {

    const params = new URLSearchParams(window.location.search);
    const id = params.get("id");
    console.log("PROPERTY ID:", id);

    const res = await fetch(`http://localhost:3000/main-form-request/property/${id}`);


    if (!res.ok) {
        const errText = await res.text();
        throw new Error(errText);
    }

    const data = await res.json();

    editProperty(data);
    console.log(data);

});

function editProperty(data) {

    //images
    const images = document.querySelectorAll(".carousel-images");

    images.forEach((el, index) => {
        el.setAttribute("src", "images/" + data.LINKTOSERVER)
    });

    //heading
    const headings = document.querySelectorAll(".heading");

    headings.forEach((el, index) => {
        el.textContent = data.HEADING;
    });
    document.getElementById("heading-small").textContent = data.HEADING;


    //status
    document.getElementById("status").textContent = "Available: " + data.STATUS;

    //description
    document.getElementById("description").textContent = data.DESCRIPTION;

    let userType = "User";
    if (data.USERTYPE == 'agency') {
        userType = "Agent";
    }

    //publish date
    document.getElementById("publish-date").textContent = "Publish date: " + data.PUBLISHDATE;

    //FLOOR
    document.getElementById("floor").textContent = "Floor: " + data.FLOOR;

    //room count
    document.getElementById("room-count").textContent = "Room count: " + data.ROOMCOUNT;

    //AREA
    document.getElementById("area").textContent = "Area: " + data.AREA;

    //location
    document.getElementById("location").textContent = "Location: " + data.CITY;

    //address
    document.getElementById("address").textContent = "Address: " + data.STREET;

    //HOUSE OR APARTMENT
    let hasYard = "No yard";
    let hasElevator = "No elevator";

    if(data.HASYARD == true)
    {
       hasYard = "Has yard";
    }
     if(data.HASELEVATOR == true)
    {
        hasElevator = "Has elevator";   
    }

    document.getElementById("yard").textContent = hasYard;
    document.getElementById("elevator").textContent = hasElevator;
    //personal
    console.log(data.PERSONALDESCRIPTION);
    document.getElementById("personal-description").textContent = data.PERSONALDESCRIPTION;

    //additionals
    document.getElementById("email").textContent = userType + " email: " + data.EMAIL;
    document.getElementById("phone").textContent = userType + " phone number: " + data.PHONENUMBER;

    if (data.USERTYPE == 'agency') {
        document.getElementById("username").textContent = "Agent username: " + data.USERNAME;
        document.getElementById("address").textContent = "Agency address: " + data.ADDRESS;
    }



    document.getElementById("agent-website").textContent = data.WEBSITE;


}
//     document.getElementById("price").textContent = data.AMOUNT + "€";
//     document.getElementById("city").textContent = data.CITY;
//     document.getElementById("image").src = "images/" + data.LINKTOSERVER;

// }