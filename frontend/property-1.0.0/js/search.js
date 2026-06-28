let allData = [];
let container;
const pageLimit = 10;


window.addEventListener("load", async () => {

    const filters = JSON.parse(sessionStorage.getItem("filters"));

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


function renderPage(page) {

    container.innerHTML = "";

    const start = (page - 1) * pageLimit;
    const end = start + pageLimit;

    const currentProperties = allData.slice(start, end);

    const pageCount = Math.ceil(allData.length / pageLimit);

    document.getElementById("page-info").textContent =
        `Страница (${page} от ${pageCount})`;


    currentProperties.forEach(item => {
        const card = prepareCard(item);
        container.appendChild(card);
    });

    renderPagination(page);
}

function renderPagination(currentPage) {

    const pagination = document.getElementById("pagination");
    pagination.innerHTML = "";

    const pageCount = Math.ceil(allData.length / pageLimit);

    for (let i = 1; i <= pageCount; i++) {

        const pageButton = document.createElement("a");

        pageButton.href = "#";
        pageButton.textContent = i;

        if (i === currentPage) {
            pageButton.classList.add("active");
        }

        pageButton.addEventListener("click", function (e) {
            e.preventDefault();
            renderPage(i);
        });

        pagination.appendChild(pageButton);
    }
}


function prepareCard(item) {

    const main = document.createElement("div");
    main.classList.add("col-xs-12", "col-sm-6", "col-md-6", "col-lg-4");

    const subMain = document.createElement("div");
    subMain.classList.add("property-item", "mb-30");

    main.appendChild(subMain);

    //the image is clickable
    const topLink = document.createElement("a");
    topLink.setAttribute("href", "property-single.html");
    topLink.classList.add("img");

    const clickImage = document.createElement("img");
    clickImage.setAttribute("src", "images/" + item.LINKTOSERVER);
    clickImage.classList.add("img-fluid");
    topLink.appendChild(clickImage);
    subMain.appendChild(topLink);

    //card information content
    const propertyContent = document.createElement("div");
    propertyContent.classList.add("property-content");
    subMain.appendChild(propertyContent);
    //amount
    const priceDiv = document.createElement("div");
    const priceSpan = document.createElement("span");
    priceDiv.classList.add("price", "mb-2");
    priceSpan.innerHTML = item.AMOUNT; //OR O.AMOUNT?
    priceDiv.appendChild(priceSpan);
    propertyContent.appendChild(priceDiv);

    //heading + other info
    const otherInfo = document.createElement("div");
    propertyContent.appendChild(otherInfo);

    //city
    const spanAddress = document.createElement("span");
    spanAddress.classList.add("d-block", "mb-2", "text-black-50");
    spanAddress.innerHTML = item.REGION + ", " + item.CITY;
    otherInfo.appendChild(spanAddress);

    //heading
    const spanHeading = document.createElement("span");
    spanHeading.classList.add("city", "d-block", "mb-3");
    spanHeading.innerHTML = item.HEADING;
    otherInfo.appendChild(spanHeading);


    //container for area and room count
    const additional = document.createElement("div");
    additional.classList.add("specs", "d-flex", "mb-4");
    otherInfo.appendChild(additional);

    //area
    const spanArea = document.createElement("span");
    {
        spanArea.classList.add("d-block", "d-flex", "align-items-center", "me-3");

        const spanAreaIcon = document.createElement("span");
        spanAreaIcon.classList.add("icon-home2", "me-2");

        const spanAreaText = document.createElement("span");
        spanAreaText.classList.add("caption");
        spanAreaText.innerHTML = "area m" + `<sup>2</sup>` + ": " + item.AREA;

        spanArea.appendChild(spanAreaIcon);
        spanArea.appendChild(spanAreaText);
    }
    additional.appendChild(spanArea);

    //room count
    const spanRooms = document.createElement("span");
    {
        spanRooms.classList.add("d-block", "d-flex", "align-items-center");

        const spanRoomsIcon = document.createElement("span");
        spanRoomsIcon.classList.add("icon-home2", "me-2");

        const spanRoomsText = document.createElement("span");
        spanRoomsText.classList.add("caption");
        spanRoomsText.innerHTML = "area: " + item.ROOMCOUNT;

        spanRooms.appendChild(spanRoomsIcon);
        spanRooms.appendChild(spanRoomsText);
    }
    additional.appendChild(spanRooms);

    //add botLink
    const botLink = document.createElement("a");
    botLink.classList.add("btn", "btn-primary", "py-2", "px-3");
    botLink.setAttribute("property-single.html", "href");
    botLink.innerHTML = "Виж повече";

    otherInfo.appendChild(botLink);

    return main;
}


