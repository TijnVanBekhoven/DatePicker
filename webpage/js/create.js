function showPasswordField(checkbox) {
    var password = document.getElementById("password");
    
    if (checkbox.checked) {
        password.style.display = "inline";
        password.setAttribute("required", true);
    } else {
        password.style.display = "none";
        password.removeAttribute("required");
    }
}

function isValidForm() {
    var startDate = new Date(document.getElementById("startDate").value);
    var endDate = new Date(document.getElementById("endDate").value);
    var errorLine = document.getElementById("error");
    var errorSign = '<br><br><i class="fa-solid fa-triangle-exclamation"></i> ';

    if (startDate > endDate) {
        errorLine.style.display = "inline";
        errorLine.innerHTML = errorSign + "The start date should not exceed the end date";
        return false;
    }
    return true;
}