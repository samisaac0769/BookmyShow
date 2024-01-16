$(document).ready(function () {

    $(".view-btn").click(function () {
        var theaterid = $(this).data("theaterid");
        console.log(theaterid);

        $.ajax({
            url: "Components/theater_cred.cfc?method=getTheaterById",
            type: "post",
            data: {
                theaterId: theaterid
            },
            success: function (data) {
                console.log(data);
                $("#theatername").text($(data).find("field[name='THEATERNAME'] string").text());
                $("#location").text($(data).find("field[name='LOCATION'] string").text());
                $("#time").text(getTime($(data).find("field[name='THEATERTIMINGS'] string").text()));
                $("#address").text($(data).find("field[name='ADDRESS'] string").text());
            },
            error: function (error) {
                console.log(">>>>>>> Something went wrong......" + error);
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

    $("#add-btn").click(function () {
        $("#theaterFormLabel").text("ADD THEATER:");
        $("#showTimes").show();
        $("#add-cloneDiv").show();
        $("#submitAddBtn").show();
        $("#submitEditBtn").hide();


        $("#submitAddBtn").click(function (e) {
            // console.log(e);
            //    e.preventDefault();

            // Get values from all cloned input elements
            const clonedValues = [];
            const clonedInputs = document.querySelectorAll(".showtime-input");
            clonedInputs.forEach(function (input) {
                clonedValues.push(input.value);
            });

            var theaterName = $("#form-theatername").val();
            var location = $("#form-location").val();
            var address = $("#form-address").val();
            if (theaterName == "" || location == "" || address == "") {
                alert("All fields are Required");
                return false;
            }
            else if (clonedValues == "") {
                alert("Add show time...");
                return false;
            }

            var myShowTimeList = clonedValues.join(', ');
            //document.location.reload();

            $.ajax({
                url: "Components/theater_cred.cfc?method=insertTheater",
                type: "post",
                data: {
                    theatername: theaterName,
                    location: location,
                    address: address,
                    showTimes: myShowTimeList
                },
                success: function (data) {
                    var extractData = $(data).find("boolean").attr("value");
                    console.log(extractData);
                    if (extractData == "true") {
                        alert("The theater registered successfully...");
                    }
                    if (extractData == "false") {
                        alert("This theater already registered...");
                    }

                },
                error: function (error) {
                    console.log(">>>>error>>>" + error);
                }
            });
        });
    });

    $(".edit-btn").click(function () {
        $("#theaterFormLabel").text("EDIT THEATER:")
        $("#showTimes").hide();
        $("#add-cloneDiv").hide();
        $("#submitEditBtn").show();
        $("#submitAddBtn").hide();
        var theaterId = $(this).data("theaterid");

        $.ajax({
            url: "Components/theater_cred.cfc?method=getTheaterById",
            type: "post",
            data: {
                theaterId: theaterId
            },
            success: function (data) {
                console.log(data);

                $("#form-theatername").val($(data).find("field[name='THEATERNAME'] string").text());
                $("#form-location").val($(data).find("field[name='LOCATION'] string").text());
                $("#form-address").val($(data).find("field[name='ADDRESS'] string").text());
                $("#submitEditBtn").click(function (e) {
                    editTheater(theaterId, e);
                });

            },
            error: function (error) {
                console.log(">>>Something went wrong>>>" + error);
            }

        });
    });

    $("#add-cloneDiv").click(function () {
        const formShowtimeContainer = document.getElementById("show-group");
        const clonedInputsContainer = document.getElementById("cloned-inputs-container");

        // Toggle the visibility of the cloned input and delete button
        const clonedInput = document.createElement("input");
        clonedInput.required = true;
        clonedInput.className = "p-1 form-input-showTimes mb-1 showtime-input";
        clonedInput.type = "time";
        clonedInput.placeholder = "Add Show timings";

        const clonedDeleteButton = document.createElement("button");
        clonedDeleteButton.className = "btn btn-outline-danger mb-1 delete-cloneDiv";
        clonedDeleteButton.type = "button";
        clonedDeleteButton.textContent = "Delete";

        // Create a new container div
        const newContainer = document.createElement("div");
        newContainer.className = "d-flex gap-2";

        // Append cloned input and delete button to the new container
        newContainer.appendChild(clonedInput);
        newContainer.appendChild(clonedDeleteButton);

        // Append the new container to the parent
        clonedInputsContainer.appendChild(newContainer);

        // Toggle the visibility of the cloned input and delete button
        $(formShowtimeContainer).show();

        clonedInput.value = "";
        clonedDeleteButton.style.display = 'block';
    });

    $("#cloned-inputs-container").on("click", ".delete-cloneDiv", function () {
        const containerToDelete = this.parentNode;

        // Remove the corresponding container when the delete button is clicked
        containerToDelete.remove();

        // If there are no more cloned elements, hide the container
        const clonedInputsContainer = document.getElementById("cloned-inputs-container");
        if (clonedInputsContainer.childElementCount === 0) {
            $("#show-group").hide();
        }
    });


});

function editTheater(theaterId) {
    var theaterName = $("#form-theatername").val();
    var location = $("#form-location").val();
    var address = $("#form-address").val();
    $.ajax({
        url: "Components/theater_cred.cfc?method=updateTheater",
        type: "post",
        data: {
            theaterId: theaterId,
            theatername: theaterName,
            location: location,
            address: address
        },
        success: function (data) {
            var extractData = $(data).find("boolean").attr("value");
            console.log(extractData);
            if (extractData == "true") {
                alert("The theater update successfully...");
            }
        },
        error: function (error) {
            console.log(">>>>error>>>" + error);
        }
    });
}

function clearForm() {
    $("#form-theatername").val("");
    $("#form-location").val("");
    $("#form-address").val("");
    // Clear values of cloned elements and remove them
    $("#cloned-inputs-container").empty();

    // Hide the container after removing all cloned elements
    $("#show-group").hide();
}

function getTime(timesString) {
    // Convert timesString to an array
    var times = timesString.split(',');

    var formattedTimes = times.map(function (element) {
        // Split the time and take only the hours and minutes
        var timeParts = element.trim().split(':');
        var hours = parseInt(timeParts[0], 10);
        var minutes = parseInt(timeParts[1], 10);

        // Create a new Date object with the same date but adjusted hours and minutes
        var dateTime = new Date(1970, 0, 1, hours, minutes);

        // Format the time in 12-hour format with AM/PM indication
        var formattedTime = dateTime.toLocaleTimeString([], { hour: '2-digit', minute: '2-digit' });

        return formattedTime;
    });

    // Join the formatted times into a single string
    var result = formattedTimes.join(', ');

    return result;
}

function timeFromISO(timeString) {
    console.log("<<formate time: " + timeString);

    // Split the time and take only the hours and minutes
    var timeParts = timeString.trim().split(':');

    // Convert the hours and minutes to numbers
    var hours = parseInt(timeParts[0], 10);
    var minutes = parseInt(timeParts[1], 10);

    // Format the hours and minutes to always have two digits
    hours = hours.toString().padStart(2, '0');
    minutes = minutes.toString().padStart(2, '0');

    // Return the formatted time as a string
    return hours + ':' + minutes;
}

