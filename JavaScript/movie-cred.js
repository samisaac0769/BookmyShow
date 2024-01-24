$(document).ready(function () {

    new MultiSelectTag('multiGenres');
    new MultiSelectTag('multiLanguage');
    new MultiSelectTag('multiTheater');
    new MultiSelectTag('multiScreen');
    new MultiSelectTag('multiCast');

    $("#addMovieBtn").click(function () {
        $("#from-movieId").val("");
    });

    $(".edit-btn").click(function () {
        let movieid = $(this).data("movieid");
        $("#fromEdit-movieId").val(movieid);

        $.ajax({
            url: "Components/movie_cred.cfc?method=getMovieByIdToEdit",
            type: "post",
            data: {
                MovieId: movieid
            },
            success: function (data) {
                console.log(">>>>>" + data);
                $("#formEdit-movieName").val($(data).find("field[name='MOVIENAME'] string").text());

                let time = $(data).find("field[name='TIME'] datetime").text();
                $("#formEdit-runTime").val(timeFromISO(time));

                let date = $(data).find("field[name='RELESEDATE'] datetime").text();
                $("#formEdit-releDate").val(dateformate(date));

                $("#formEdit-certificate").val($(data).find("field[name='CERTIFICATE'] string").text());
                $("#formEdit-about").val($(data).find("field[name='ABOUT'] string").text());

                let genres = $(data).find("field[name='MOVIEGENRES'] string").text().trim();
                $("#editMultiGenres").val(arangeInArray(genres));

                let language = $(data).find("field[name='MOVIELANGUAGES'] string").text().trim();
                console.log(language+ ">>>>");
                $("#editMultiLanguage").val(arangeInArray(language));

                let theater = $(data).find("field[name='MOVIETHEATER'] string").text().trim();
                $("#editMultiTheater").val(arangeInArray(theater));

                let screen = $(data).find("field[name='MOVIESCREEN'] string").text().trim();
                $("#editMultiScreen").val(arangeInArray(screen));

                let cast = $(data).find("field[name='MOVIECAST'] string").text().trim();
                $("#editMultiCast").val(arangeInArray(cast));

                new MultiSelectTag('editMultiGenres');
                new MultiSelectTag('editMultiLanguage');
                new MultiSelectTag('editMultiTheater');
                new MultiSelectTag('editMultiScreen');
                new MultiSelectTag('editMultiCast');
            },
            error: function (error) {
                console.log("Something went wrong" + error);
            }
        });
    });


    $("#addSubmitBtn").click(function (e) {

        //e.preventDefault();
        var genres = $("#multiGenres").val();
        var Language = $("#multiLanguage").val();
        var theater = $("#multiTheater").val();
        var screen = $("#multiScreen").val();
        if (genres == "" || Language == "" || theater == "" || screen == "") {
            alert("all the fields are required")
            return false;
        }
        else {
            return true;
        }
    });

    $(".view-btn").click(function () {
        let movieid = $(this).data("movieid");
        console.log(movieid);

        $.ajax({
            url: "Components/movie_cred.cfc?method=getMovieByIdforAdmin",
            type: "post",
            data: {
                movieId: movieid
            },
            success: function (data) {
                console.log(data);
                let movieimage = $(data).find("field[name='MOVIEPOSTER'] string").text();
                let path = "Assets/movieposter/" + movieimage;
                $("#movieposter").attr("src", path);
                $("#Label").text($(data).find("field[name='MOVIENAME'] string").text());
                $("#moviename").text($(data).find("field[name='MOVIENAME'] string").text());
                $("#lang").text($(data).find("field[name='MOVIELANGUAGES'] string").text());
                $("#genres").text($(data).find("field[name='MOVIEGENRES'] string").text());
                $("#screen").text($(data).find("field[name='MOVIESCREEN'] string").text());
                $("#cert").text($(data).find("field[name='CERTIFICATE'] string").text());
                var datetimeString = $(data).find("field[name='RELESEDATE'] dateTime").text();
                var datetime = new Date(datetimeString);

                // Format the date as YYYY-MM-DD
                var formattedDate = datetime.toISOString().split('T')[0];

                // Update the text of the #runtime element with the formatted date
                $("#reldate").text(formattedDate);
                // $("#reldate").text($(data).find("field[name='RELESEDATE'] dateTime").text());

                $("#runtime").text($(data).find("field[name='TIME'] dateTime").text());
                $("#vote").text($(data).find("field[name='VOTINGS'] number").text());
                $("#rating").text($(data).find("field[name='RATING'] number").text() + "/10");
                $("#about").text($(data).find("field[name='ABOUT'] string").text());
            },
            error: function (error) {
                console.log(error);
            }
        });
    });

    $(".delete-btn").click(function () {
        var selectedmovie = $(this).data("movieid");
        $("#deletemovie").click(function () {
            $.ajax({
                url: "Components/movie_cred.cfc?method=deleteMovieById",
                type: "post",
                data: {
                    movieId: selectedmovie
                },
                success: function (data) {
                    console.log(data);
                    var result = $(data).find("string").text();
                    if (result == "true") {
                        alert("This Movie is Deleted Successfully....");
                        location.reload();
                    }
                }
            });
        });

    });

    $("#closeEditBtn").click(function () {
        document.location.reload();
    });

    // $("#editSubmitBtn").click(function () {
    //     let result = $("#updateResult").val();
    //     console.log(result);
    //     if (result == 1) {
    //         alert("Update Successfully....");
    //         $("#updateResult").val("");
    //         window.location.href = "movie_CRED.cfm";
    //         // location.reload();
    //     }
    //     else {
    //         $("#updateResult").val("");
    //     }
    // })
});

function arangeInArray(value) {
    
    let genresArray = value.split(',');
    let genresIntArray = genresArray.map(value => parseInt(value, 10));
    console.log(genresIntArray);
    return genresIntArray
}

function clearForm() {
    document.getElementById("myForm").reset();
}

function dateformate(datetimeString) {
    var datetime = new Date(datetimeString);

    // Convert to local time without considering the time zone offset
    var localDatetime = new Date(datetime.getTime() - datetime.getTimezoneOffset() * 60000);

    // Format the date as YYYY-MM-DD
    var formattedDate = localDatetime.toISOString().split('T')[0];
    return formattedDate;
}

function gettime(inputTime) {
    var dateTime = new Date(inputTime);

    // Format the time in 12-hour format with AM/PM
    var formattedTime = dateTime.toLocaleTimeString([], { hour: '2-digit', minute: '2-digit', hour12: true });

    return formattedTime
}

function timeFromISO(dateTimeString) {
    var date = new Date(dateTimeString);
    var hours = date.getUTCHours().toString().padStart(2, '0');
    var minutes = date.getUTCMinutes().toString().padStart(2, '0');

    return hours + ':' + minutes;
}
