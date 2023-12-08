$(document).ready(function () {
    const myElement = $(".movie-details");
    const Backgroungd = $('#movieBg').val();
    myElement.css({
        background: `linear-gradient(90deg, #1A1A1A 24.97%, #1A1A1A 38.3%, rgba(26, 26, 26, 0.0409746) 97.47%, #1A1A1A 100%), url('${Backgroungd}')`,
        backgroundRepeat: "no-repeat",
        backgroundSize: "cover",
        backgroundPosition: "center",  // Corrected property name
    });

});