$(document).ready(function () {
    $("#menu-toggle").click(function () {
        $("#sidebar").toggleClass("active");
        $(".content").toggleClass("active");
    });
});