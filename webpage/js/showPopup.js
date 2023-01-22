function showPopup() {
    const popupScreen = document.getElementById("popup");
    const body = document.querySelector("body");
    const container = document.getElementById("container");

    body.setAttribute("scroll", "no");
    body.style.overflow = "hidden";
    container.style.pointerEvents = "none";
    popupScreen.style.display = "initial";
}

function closePopup() {
    const popupScreen = document.getElementById("popup");
    const body = document.querySelector("body");
    const container = document.getElementById("container");


    body.removeAttribute("scroll");
    body.style.overflow = "initial";
    container.style.pointerEvents = "initial";
    popupScreen.style.display = "none";
}