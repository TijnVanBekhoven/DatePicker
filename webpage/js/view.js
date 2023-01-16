function sharePlanner(id) {
    var url = "https://planner.treinio.nl/join/id";

    navigator.clipboard.writeText(url);
    window.alert("URL copied to clipboard");
}