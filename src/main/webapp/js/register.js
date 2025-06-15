//console.log("load");
document.addEventListener("DOMContentLoaded", function () {
    const form = document.querySelector("form");
    const usernameInput = form.querySelector("input[name='username']");
    const passwordInput = form.querySelector("input[name='password']");
    const confirmPasswordInput = form.querySelector("input[name='confirmPassword']");
    const errorDiv = document.querySelector(".error");

    form.addEventListener("submit", function (e) {
        const username = usernameInput.value.trim();
        const password = passwordInput.value;
        const confirmPassword = confirmPasswordInput.value;

        let errors = [];

        if (username.length < 4) {
            errors.push("Username must be at least 4 characters long.");
        }

        if (password.length < 6) {
            errors.push("Password must be at least 6 characters long.");
        }

        if (password !== confirmPassword) {
            errors.push("Passwords do not match.");
        }

        if (errors.length > 0) {
            e.preventDefault();
            errorDiv.innerHTML = errors.map(err => `<div>${err}</div>`).join('');
        }
    });
});
