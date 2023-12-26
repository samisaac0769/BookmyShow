$(document).ready(function () {
    const myElement = $(".movie-details");
    const Backgroungd = $('#movieBg').val();
    myElement.css({
        background: `linear-gradient(90deg, #1A1A1A 24.97%, #1A1A1A 38.3%, rgba(26, 26, 26, 0.0409746) 97.47%, #1A1A1A 100%), url('${Backgroungd}')`,
        backgroundRepeat: "no-repeat",
        backgroundSize: "cover",
        backgroundPosition: "center",  // Corrected property name
    });

    // function encryptMovieId(movieId) {
    //     // Replace this with a more secure encryption algorithm
    //     return btoa(movieId); // Using base64 encoding for simplicity
    // }

    // $(document).ready(function () {
    //     $("#bookmovie").on("click", function () {
    //         var movieId = $("#movieId").val();
    //         var encryptedMovieId = encryptMovieId(movieId);

    //         // Append encrypted movie ID to the URL
    //         var url = "movietheaterlist.cfm?theatermovieid=" + encodeURIComponent(encryptedMovieId);

    //         // Redirect to the new URL
    //         document.location.href = url;
    //     });
    // });


});

// function formatVotings(votings) {
//     var formattedVotings = "";

//     if (votings >= 1000) {
//         formattedVotings = numberFormat(votings / 1000, "9.9") & "K";
//     } else {
//         formattedVotings = votings;
//     }

//     return formattedVotings;
// }