const container = document.getElementById("top-3-agents");

window.addEventListener("load", async () => {
    try {
        const res = await fetch("http://localhost:3000/main-form-request/agents");

        const data = await res.json();

        const container = document.getElementById("top-3-agents");
        container.innerHTML = "";

        data.forEach(agent => {
            const card = prepareAgent(agent);
            container.appendChild(card);
        });

    } catch (err) {
        console.error("Failed to load agents:", err);
    }
});


function prepareAgent(agent) {

    const main = document.createElement("div");
    main.classList.add("col-sm-6", "col-md-6", "col-lg-4", "mb-5");

    const subMain = document.createElement("div");
    subMain.classList.add("h-100", "person");

    main.appendChild(subMain);

    const image = document.createElement("img");
    image.src = "images/person_1-min.jpg";
    image.classList.add("img-fluid");
    subMain.appendChild(image);

    const personContents = document.createElement("div");
    personContents.classList.add("person-contents");
    subMain.appendChild(personContents);

    const name = document.createElement("h2");
    name.classList.add("mb-0");
    name.textContent = agent.NAMES;
    personContents.appendChild(name);

    const email = document.createElement("span");
    email.classList.add("meta", "d-block", "mb-3");
    email.textContent = agent.EMAIL;
    personContents.appendChild(email);

    const address = document.createElement("span");
    address.classList.add("meta", "d-block", "mb-3");
    address.textContent = "Agency address: " + (agent.ADDRESS || "");
    personContents.appendChild(address);

    const ulSocials = document.createElement("ul");
    ulSocials.classList.add("social", "list-unstyled", "list-inline", "dark-hover");
    personContents.appendChild(ulSocials);

    const socials = ["twitter", "facebook", "linkedin", "instagram"];

    for (let i = 0; i < socials.length; i++) {
        const li = document.createElement("li");
        li.classList.add("list-inline-item");

        const a = document.createElement("a");

        const icon = document.createElement("span");
        icon.classList.add("icon-" + socials[i]);

        a.appendChild(icon);
        li.appendChild(a);
        ulSocials.appendChild(li);
    }

    return main;
}