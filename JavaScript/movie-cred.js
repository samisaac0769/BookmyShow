$(document).ready(function () {
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
                $("#movieposter").attr("src",path);
                $("#Label").text("Details of : "+ $(data).find("field[name='MOVIENAME'] string").text());
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
                $("#rating").text($(data).find("field[name='RATING'] number").text()+"/10");
                $("#about").text($(data).find("field[name='ABOUT'] string").text());                
            },
            error: function (error) {
                console.log(error);
            }
        });
    });
});

    