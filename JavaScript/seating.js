$(document).ready(function () {
    $(".back-btn, .close").click(function () {
        window.history.back();
    });

    $("#payment").hide();

    let bookedSeats = $("#bookedSeats").val();

    let seatsArray = bookedSeats.split(',');

    for (let i = 0; i < seatsArray.length; i++) {
        let seatValue = seatsArray[i];
        let seat = document.getElementById(seatValue);

        $(seat).css({
            // "visibility": "hidden"
            "border-color": "#e0dbdb",
            "background-color": "#e0dbdb",
            "color": "white"
        });
    }
});


var selectedSeats = {};
var totalPrice = 0;

function selectseat(price, seatCategory, index) {
    var seatId = seatCategory + index;
    var seatdiv = $("#" + seatId);

    // prevent selected seat from get select again
    if (seatdiv.css("background-color") === "rgb(224, 219, 219)") {
        console.log("Seat is already booked. Choose another seat.");
        return;
    }


    if (seatdiv.hasClass("selected")) {
        // Deselect the seat
        seatdiv.removeClass("selected");
        delete selectedSeats[seatId];
        totalPrice -= price;
    } else {
        // Select the seat
        seatdiv.addClass("selected");
        selectedSeats[seatId] = true;
        totalPrice += price;
    }

    updateTotalPrice();
}

function updateTotalPrice() {
    // Update the Pay button text and show/hide the payment div
    $("#paybtn").text("Pay Rs." + totalPrice.toFixed(2));
    $("#payment").toggle(totalPrice > 0);

}

function paymentBooking(movieid, theaterid, selectedDate, time) {
    console.log(selectedSeats);
    // alert(totalPrice);

    var selectedSeatsJSON = JSON.stringify(selectedSeats);
    $.ajax({
        url: "Components/seating.cfc?method=ticketBooking",
        type: "post",
        data: {
            movieId: movieid,
            theaterId: theaterid,
            selectedDate: selectedDate,
            selectedTime: time,
            seats: selectedSeatsJSON,
            totalcost: totalPrice
        },
        success: function (data) {
            let result = $(data).find("boolean").attr("value")

            if (result == "true") {
                alert("Your Tickets Booked Successfully...");
                document.location.href = "firstpage.cfm";
            }
            else {
                alert("Your Tickets Not Booked Successfully...");
                window.history.back();
            }

        },
        error: function (error) {

        }

    });
}