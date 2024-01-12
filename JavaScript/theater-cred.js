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
                $("#time").text(getTime($(data).find("field[name='THEATERTIMINGS'] string").text()));
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

    $("#submitBtn").click(function () {

        // Get values from all cloned input elements
        const clonedValues = [];
        const clonedInputs = document.querySelectorAll(".showtime-input");
        clonedInputs.forEach(function (input) {
            clonedValues.push(input.value);
        });

        if (clonedValues == "") {
            alert("Add Show Time");
            return false;
        }

        var theaterName = $("#form-theatername").val();
        var location = $("#form-location").val();
        var address = $("#form-address").val();

        // Display or use the list of values as needed
        console.log(">>>>" + theaterName);
        console.log(">>>>" + location);
        console.log(">>>>" + address);
        console.log(">>>>" + clonedValues);

        
        //document.location.reload();

        $.ajax({
            url: "Components/theater_cred.cfc?method=insertTheater",
            type: "post",
            data: {
                theatername: theaterName,
                location: location,
                address: address,
                showTimes:clonedValues
            },
            success: function (data) {
                console.log(data);
                var extractData = $(data).find("boolean").attr("value");
                console.log(extractData);

                if (extractData == "true") {
                    alert("This theater already registered...");
                }
            },
            error: function (error) {
                console.log(">>>>error>>>"+ error);
            }
        });
    });

});

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