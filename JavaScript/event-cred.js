$(document).ready(function () {
    $(".view-btn").click(function () {
        let eventid = $(this).data("eventid");
        console.log(eventid);

        $.ajax({
            url: "Components/event_cred.cfc?method=getEventDetailById   ",
            type: "post",
            data: {
                eventId: eventid
            },
            success: function (data) {
                console.log(data);
                let eventimg = $(data).find("field[name='EVENTPOSTER'] string").text();
                let path = "Assets/eventposter/" + eventimg;
                $("#eventposter").attr("src", path);

                $("#Label").text($(data).find("field[name='EVENTNAME'] string").text());
                $("#eventname").text($(data).find("field[name='EVENTNAME'] string").text());
                $("#age").text($(data).find("field[name='AGELIMIT'] string").text() + " yrs+");
                let hours = $(data).find("field[name='HOURS'] number").text();
                var inthours = parseInt(hours);
                $("#hours").text(inthours + "h");
                $("#fromdatelabel").text("From Date:");
                let fromdate = $(data).find("field[name='FROMDATE'] dateTime").text();
                $("#fromdate").text(dateformate(fromdate));
                // $("#fromdate").text($(data).find("field[name='FROMDATE'] dateTime").text());
                let todate = $(data).find("field[name='TODATE'] dateTime").text();
                if (todate.trim() !== "") {

                    $("#todiv").css("display", "flex");
                    $("#todate").text(dateformate(todate));
                }
                else {
                    $("#fromdatelabel").text("Event Date:");
                    $("#todiv").css({
                        "display": "none"
                    });
                }
                //$("#todate").text($(data).find("field[name='TODATE'] dateTime").text());
                $("#price").text($(data).find("field[name='PRICE'] number").text() + "/-");
                $("#venue").text($(data).find("field[name='VENUE'] string").text());
                $("#likes").text(parseInt($(data).find("field[name='LIKES'] number").text()) + " Likes");
                $("#catagery").text($(data).find("field[name='CATAGERY'] string").text());
                $("#language").text($(data).find("field[name='LANGUAGES'] string").text());
                let time = $(data).find("field[name='TIME'] dateTime").text();
                $("#time").text(gettime(time));
                //$("#time").text($(data).find("field[name='TIME'] dateTime").text());
                var why = $(data).find("field[name='WHY'] string").text();

                if (why.trim() !== "") {
                    $("#whydiv").css("display", "flex");
                    $("#why").text(why);
                }
                else {
                    $("#whydiv").css({
                        "display": "none"
                    });
                }
                $("#about").text($(data).find("field[name='ABOUT'] string").text());

            },
            error: function (error) {
                console.log(error);
            }
        });
    });

    
    $(".delete-btn").click(function () { 
        var selectedEvent = $(this).data("eventid");
        console.log(selectedEvent);
        $("#deleteEvent").click(function () {
            $.ajax({
                url: "Components/event_cred.cfc?method=deleteEventById",
                type: "post",
                data: {
                    eventId: selectedEvent
                },
                success: function (data) {
                    console.log(data);
                    var result = $(data).find("string").text();
                    if (result == "true") {
                        alert("The event Deleted Successfully....");
                        location.reload();
                    }
                }
            });
        });

    });
    

});

function dateformate(datetimeString) {
    var datetime = new Date(datetimeString);

    // Format the date as YYYY-MM-DD
    var formattedDate = datetime.toISOString().split('T')[0];
    return formattedDate;
}

function gettime(inputTime) {
    var dateTime = new Date(inputTime);

    // Format the time in 12-hour format with AM/PM
    var formattedTime = dateTime.toLocaleTimeString([], { hour: '2-digit', minute: '2-digit', hour12: true });

    return formattedTime
}