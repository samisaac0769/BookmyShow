$(document).ready(function () {
    $(".delete-btn").click(function () {
        var selectedTheater = $(this).data("theaterId");
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
                        alert("This Movie is Deleted Successfully....");
                        location.reload();
                    }
                }
            });
        });

    });
});