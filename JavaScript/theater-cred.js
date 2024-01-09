$(document).ready(function () {

    $(".view-btn").click(function () {
        var theaterid = $(this).data("theaterid");
        console.log(theaterid);

        $.ajax({
            url: "Components/theater_cred.cfc?method=getTheaterById",
            type: "post",
            data: {
                theaterId :theaterid
            },
            success: function (data) {
                console.log(data);
                $("#theatername").text($(data).find("field[name='THEATERNAME'] string").text());
                $("#location").text($(data).find("field[name='LOCATION'] string").text());
                $("#time").text(gettime($(data).find("field[name='THEATERTIMINGS'] string").text()));
                $("#address").text($(data).find("field[name='ADDRESS'] string").text());
            },
            error: function (error) {
                console.log(">>>>>>> Something went wrong......" + error );
            }

        })
    });



    $(".delete-btn").click(function () {
        var selectedTheater = $(this).data("theaterid");
        console.log(selectedTheater);
        $("#deleteTheater").click(function () {
            $.ajax({
                url: "Components/theater_cred.cfc?method=deleteTheaterById",
                type: "post",
                data: {
                    theaterId: selectedTheater
                },
                success: function (data) {
                    console.log(data);
                    var result = $(data).find("string").text();
                    if (result == "true") {
                        alert("This theatre is Deleted Successfully....");
                        location.reload();
                    }
                }
            });
        });

    });
});

function gettime(timesString) {
    var times = timesString.split(',');
    console.log(times);
    var formattedTimes = [];

    for (let index = 0; index < times.length; index++) {
        const element = times[index].trim();
        console.log(element);
        var validDateString = '1970-01-01T' + element + 'Z';
        var dateTime = new Date(validDateString);
        var formattedTime = dateTime.toLocaleTimeString([], { hour: '2-digit', minute: '2-digit', hour12: true });

        formattedTimes.push(formattedTime);
    }

    // Join the formatted times into a single string
    var result = formattedTimes.join(', ');

    return result;
}