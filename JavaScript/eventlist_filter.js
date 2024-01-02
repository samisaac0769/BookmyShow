$(document).ready(function () {
    $("#datepicker").val("");
    $("#datepicker").datepicker({
        minDate: 0,
        maxDate: "+4D",
        defaultDate: 0,
        onSelect: function (date) {
            console.log(date);
            $("#selected-date").val(date);
        }
    });

    $("#all").click(function () {
        window.location.reload();
        
    })

    // date filter

    $("#filt-date").click(function () {

        let explore = $("#date_more").text();
        if (explore == "expand_more") {
            $("#date_more").text("expand_less");
            $("#datepicker").show();
        }
        else {
            $("#date_more").text("expand_more");
            $("#datepicker").hide();
        }
    });

    $("#dateclear").click(function () {
        $("#datepicker").val("");
    });

    // language filter

    $("#lang-date").click(function () {
        let explore = $("#lang_more").text();
        if (explore == "expand_more") {
            $("#lang_more").text("expand_less");
            $(".langoption").show();
        }
        else {
            $("#lang_more").text("expand_more");
            $(".langoption").hide();
        }

    });

    $("#langclear").click(function () {
        $(".filt-language").css({
            "background-color": "rgba(0, 0, 0, 0)",
            "color": "#dc354b"
        });
        $("#selected-lang").val("");
    });

    $(".filt-language").click(function () {
        // Deselect all elements with class 'filt-language'
        $(".filt-language").css({
            "background-color": "rgba(0, 0, 0, 0)",
            "color": "#dc354b"
        });

        // Select the clicked element
        $(this).css({
            "background-color": "#dc354b",
            "color": "white"
        });

        let langid = $(this).attr('value');
        console.log(langid);
        $("#selected-lang").val(langid)
    });

    //catagery filter

    $("#filt-cata").click(function () {
        let explore = $("#cata_more").text();
        if (explore == "expand_more") {
            $("#cata_more").text("expand_less");
            $(".cataoption").show();
        }
        else {
            $("#cata_more").text("expand_more");
            $(".cataoption").hide();
        }

    });

    $("#cataclear").click(function () {
        $(".cata-language").css({
            "background-color": "rgba(0, 0, 0, 0)",
            "color": "#dc354b"
        });

        $("#selected-cate").val("");
    });

    $(".cata-language").click(function () {
        // Deselect all elements with class 'cata-language'
        $(".cata-language").css({
            "background-color": "rgba(0, 0, 0, 0)",
            "color": "#dc354b"
        });

        // Select the clicked element
        $(this).css({
            "background-color": "#dc354b",
            "color": "white"
        });

        let cateid = $(this).attr('value');
        $("#selected-cate").val(cateid)
    });
});

function filter() {
    let selecteddate = $("#datepicker").val();
    let selectedlang = $("#selected-lang").val();
    let selectedcate = $("#selected-cate").val();

    console.log(selecteddate);
    console.log(selectedlang);
    console.log(selectedcate);

    $.ajax({
        url: "Components/eventfilter.cfc?method=filter",
        type: "post",
        data: {
            date: selecteddate,
            language: selectedlang,
            catagery: selectedcate
        },
        success: function (response) {
            var eventTableBody = $('#eventTableBody');
            eventTableBody.empty();
            console.log(response);

            // Use DOMParser to parse the XML string
            var parser = new DOMParser();
            var xmlDoc = parser.parseFromString(response, "text/xml");

            // Extract data from the XML and store in a JavaScript structure
            var events = [];
            var recordset = xmlDoc.querySelector("recordset");
            var rowCount = parseInt(recordset.getAttribute("rowCount"));

            if (rowCount == 0) {
                eventTableBody.append("<tr><td colspan='4'>No events found</td></tr>");
            }

            var fields = recordset.querySelectorAll("field");

            for (var i = 0; i < rowCount; i++) {
                var event = {};

                fields.forEach(function (field, index) {
                    var fieldName = field.getAttribute("name");
                    var value = field.children[i].textContent;

                    // Handle date-related properties
                    if (fieldName === 'FROMDATE') {
                        value = new Date(value).toLocaleString('en-US', {
                            weekday: 'short',
                            day: '2-digit',
                            month: 'short'
                        });
                        var parts = value.split(', ');
                        event['day'] = parts[0];
                        event['datemonth'] = parts[1];
                    } else {
                        event[fieldName] = value;
                    }
                });

                events.push(event);
            }

            console.log("Events:", events);  // Log events for debugging

            let count = 0;
            var currentRow;

            events.forEach(function (event) {
                
                count++;

                if (count % 4 === 1) {
                    currentRow = $('<tr class="movie-card-row d-flex flex-row"></tr>');
                    eventTableBody.append(currentRow);
                }

                var eventHtml = `
                        <td class="movie-card-data">
                            <div id="moviecard" class="mb-3 d-flex me-3">
                                <form action="eventDetailpage.cfm" method="post"> 
                                    <input type="hidden" name="eventid" value="${event.EVENTID}">
                                    <button class="movie-card-btn">
                                        <div class="movie-card">
                                            <div class="movie-poster">
                                                <img src="Assets/eventposter/${event.EVENTPOSTER}" width="220">
                                                <div class="rating d-flex justify-content-around">
                                                    <span class="d-flex ms-2">${event.day}, </span>
                                                    <span>${event.datemonth} onwards</span>
                                                </div>
                                            </div>
                                            <div class="d-flex flex-column mt-3 align-items-start">
                                                <div class="movie-name text-align-start">${event.EVENTNAME}</div>
                                                <div class="venue">${event.VENUE}</div>
                                                <div class="catprice">$ ${event.PRICE}</div>
                                            </div>
                                        </div>
                                    </button>
                                </form>
                            </div>
                        </td>
                    `;

                currentRow.append($(eventHtml));

                if (count % 4 === 0 || count === events.length) {
                    // Append the completed row to the table
                    eventTableBody.append(currentRow);
                }
            });
        },
        error: function () {
            alert("Error occurred during AJAX request");
        }
    });
}

