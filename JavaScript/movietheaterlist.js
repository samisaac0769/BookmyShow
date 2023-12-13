$(document).ready(function () {
    var currentDate = $.datepicker.formatDate('yy/mm/dd', new Date());
    $("#datepicker").val(currentDate);

    $("#datepicker").datepicker({
        minDate: 0, 
        maxDate: "+4D",
        onSelect: function (dateText) {
            // var selectedDate = $("#datepicker").val();  
            // var movieid = $("#movieid").val();
            

            // location.reload();
        }
                                                              
    });
    
});
