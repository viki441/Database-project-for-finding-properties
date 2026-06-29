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


    //description
    document.getElementById("description").textContent = data.DESCRIPTION;

    let userType = "User";
    if (data.USERTYPE == 'agency') {
        userType = "Agent";
    }


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