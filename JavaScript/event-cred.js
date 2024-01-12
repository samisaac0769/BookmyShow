$(document).ready(function () {
    $("#form-fromdate").datepicker();
    $("#form-todate").datepicker();
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
                if (todate.trim() !== "" && todate.trim() !== fromdate.trim()) {

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

    $("#addeventbtn").click(function () {
        $("#EventFormLabel").text("ADD EVENTS");
        $("#posterDiv").show();
        $("#bgPosterDiv").show();
        $("#from-eventid").val("");
    });

    $(".update-btn").click(function () {
        $("#EventFormLabel").text("UPDATE EVENTS");
        let eventid = $(this).data("eventid");

        $("#posterDiv").hide();
        $("#bgPosterDiv").hide();
        $.ajax({
            url: "Components/event_cred.cfc?method=getEventDetailById",
            type: "post",
            data: {
                eventId: eventid
            },
            success: function (data) {
                //console.log(data);
                var numberid = $(data).find("field[name='EVENTID'] number").text();
                var eventid = floatConvert(numberid)
                $("#from-eventid").val(eventid);
                var id = $("#from-eventid").val()
                
                $("#form-eventname").val($(data).find("field[name='EVENTNAME'] string").text());
                $("#form-age").val($(data).find("field[name='AGELIMIT'] string").text());

                var hour = $(data).find("field[name='HOURS'] number").text();
                let converthour = floatConvert(hour);
                $("#form-hour").val(converthour);

                var fromDateValue = $(data).find("field[name='FROMDATE'] dateTime").text();
                $("#form-fromdate").datepicker("setDate", new Date(fromDateValue));

                var toDateValue = $(data).find("field[name='TODATE'] dateTime").text();
                $("#form-todate").datepicker("setDate", new Date(toDateValue));

                var price = $(data).find("field[name='PRICE'] number").text();
                let convertprice = floatConvert(price);
                $("#form-price").val(convertprice);

                $("#form-venue").val($(data).find("field[name='VENUE'] string").text());
                $("#form-about").val($(data).find("field[name='ABOUT'] string").text());
                $("#form-why").val($(data).find("field[name='WHY'] string").text());

                var cataId = $(data).find("field[name='CATAID'] number").text();
                var Cataid = floatConvert(cataId)
                $("#form-catagery").val(Cataid);

                var langId = $(data).find("field[name='LANGID'] number").text();
                var langid = floatConvert(langId)
                $("#form-language").val(langid);

                var time = $(data).find("field[name='TIME'] dateTime").text()
                $("#form-time").val(timeFromISO(time));

                //$("#form-bgposter").val($(data).find("field[name='ABOUT'] string").text());
            },
            error: function (error) {   
                console.log(error);
            }
        });
    });
});

function floatConvert(number) {
    var Id = parseFloat(number);
    var convertid = Id.toFixed(0);
    return convertid;
}


function clearForm() {
    $("#form-eventname").val("");
    $("#form-age").val("");
    $("#form-hour").val("");
    $("#form-fromdate").val("");
    $("#form-todate").val("");
    $("#form-price").val("");
    $("#form-venue").val("");
    $("#form-about").val("");
    $("#form-why").val("");
    $("#form-catagery").val("");
    $("#form-language").val("");
    $("#form-time").val("");
    $("#form-poster").val("");
    $("#form-bgposter").val("");
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
