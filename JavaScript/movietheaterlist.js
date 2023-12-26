$(document).ready(function () {
    var currentDate = $.datepicker.formatDate('mm/dd/yy', new Date());
    $("#datepicker").val(currentDate);
    const myDate = new Date(currentDate);
    // Get the day, month, and year
    const day = myDate.getDate();
    const month = myDate.getMonth() + 1; // Months are zero-indexed, so we add 1
    const year = myDate.getFullYear();
    aligndate(myDate);
    // $("#selectedDay").text($.datepicker.formatDate("D", myDate).toUpperCase());
    // $("#selectedDate").text($.datepicker.formatDate("d", myDate));
    // $("#selectedMonth").text($.datepicker.formatDate("M", myDate).toUpperCase());
    // let data = $("#datepicker").val();
    // console.log(data);

    $("#datepicker").datepicker({
        minDate: 0,
        maxDate: "+4D",
        defaultDate: 0,
        onSelect: function (dateText, inst) {
            var selectedDate = $("#datepicker").datepicker("getDate");
            aligndate(selectedDate);
            // $("#selectedDay").text($.datepicker.formatDate("D", selectedDate).toUpperCase());
            // $("#selectedDate").text($.datepicker.formatDate("d", selectedDate));
            // $("#selectedMonth").text($.datepicker.formatDate("M", selectedDate).toUpperCase());
            // // Additional code if needed
            // // var movieid = $("#movieid").val();
            // // location.reload();
            // let data = $("#datepicker").val();
            // console.log(data);

        }
    });


    // $(".showtime-pill").click(function () {
    //     // var index = $(this).data("index");
    //     // alert(index);
    //     var movieid = $("#movieid").val();
    //     var theaterId = $("#theaterId").val();
    //     var time = $(".time").val();
        
    //     var bookdate = $("#bookdate").val();
    //     alert(time);
    //     // document.location.href = "seating.cfm?movieid=" + movieid + "&theaterId=" + theaterId + "&time=" + time + "&bookdate=" + bookdate +"";
    // })


});

function aligndate(selectedDate) {
    $("#selectedDay").text($.datepicker.formatDate("D", selectedDate).toUpperCase());
    $("#selectedDate").text($.datepicker.formatDate("d", selectedDate));
    $("#selectedMonth").text($.datepicker.formatDate("M", selectedDate).toUpperCase());
    // Additional code if needed
    // var movieid = $("#movieid").val();
    // location.reload();
    let data = $("#datepicker").val();
    console.log(data);
    $(".bookdate").val(data);

}

function formatDate(date) {
    var day = date.getDate();
    var month = date.getMonth() + 1; // Months are zero-indexed, so add 1
    var year = date.getFullYear();

    // Ensure leading zeros for day and month
    day = day < 10 ? "0" + day : day;
    month = month < 10 ? "0" + month : month;

    return day + "/" + month + "/" + year;
}