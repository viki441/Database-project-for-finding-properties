
function renderPage(page) 
{
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
    sessionStorage.clear();
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


