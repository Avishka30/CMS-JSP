//console.log("JS file loaded");
document.addEventListener("DOMContentLoaded", function () {
    const form = document.getElementById("complaintForm");
    const titleInput = document.getElementById("title");
    const descriptionInput = document.getElementById("description");

    const errorDiv = document.createElement("div");
    errorDiv.classList.add("error");
    errorDiv.style.marginTop = "10px";
    form.appendChild(errorDiv);

    form.addEventListener("submit", function (e) {
        const title = titleInput.value.trim();
        const description = descriptionInput.value.trim();
        const errors = [];

        if (title.length < 5) {
            errors.push("Title must be at least 5 characters long.");
        }

        if (description.length < 10) {
            errors.push("Description must be at least 10 characters long.");
        }

        if (errors.length > 0) {
            e.preventDefault();
            errorDiv.innerHTML = errors.map(err => `<div>${err}</div>`).join('');
        } else {
            errorDiv.innerHTML = "";
        }
    });
});
