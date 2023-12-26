$(document).ready(function () {
    $(".back-btn, .close").click(function () {
        window.history.back();
    });

    $("#payment").hide();
});


var selectedSeats = {};
var totalPrice = 0;

function selectseat(price, seatCategory, index) {
    var seatId = seatCategory + index;
    var seatdiv = $("#" + seatId);
    

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

function paymentBooking(movieid,theaterid,selectedDate,time) {
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
            seats: selectedSeatsJSON
            

        },
        success: function (data) {
            console.log(data);
            
        },
        error: function (error) {
            
        }

    });
}