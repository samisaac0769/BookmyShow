<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Theater</title>
    <link rel="icon" type="image/x-icon" href="Assets/fovicon.png">
    
    <!-- Include jQuery library -->
    <script src="JavaScript/jquery-3.7.1.js"></script>

    <!-- Include jQuery UI CSS -->
    <link rel="stylesheet" href="CSS/jquery-ui.css">

    <!-- Include jQuery UI library -->
    <script src="JavaScript/jquery-ui.js"></script>

    <!-- Your existing Bootstrap and Bootstrap JS -->
    <link href="CSS/bootstrap-css.css" rel="stylesheet">
    <script src="JavaScript/bootstrap-js.js"></script>

    <!-- Your other CSS and JS files -->
    <link href="CSS/Googleicon.css" rel="stylesheet">
    <link href="CSS/movietheaterlist.css" rel="stylesheet">
    <script src="JavaScript/movietheaterlist.js"></script>

</head>
<body>
    <cfinclude  template="nav_bar.cfm">
    <cfoutput>
        <cfset local.movieid = id>
        <cfset local.callMFunction = createObject("component", "Components/moviedetail")>
        <cfset local.callFunction = createObject("component", "Components/movietheaterlist")>
        <cfset local.movieDetail = local.callMFunction.getMovieById(local.movieid)>
        <cfset local.theaterDetail = local.callFunction.getTheaterByMovieId(local.movieid)>
        <div class="">
            <div class="d-flex flex-column  moviehead">
                <div class="movietitle ">#local.movieDetail.moviename#</div>
                <div class="d-flex align-items-center gap-2">
                    <div class="certificate">#local.movieDetail.certificate#</div>
                    <cfloop list="#local.movieDetail.moviegenres#" item="item">
                        <div class="genres">#ucase(item)#</div>
                    </cfloop>
                </div>
            </div>
            <div class="d-flex flex-column">
                <div class="d-flex justify-content-between mx-4 my-2">
                    <form class="d-flex">
                        <div>
                            <input class="datepicker" type="text" id="datepicker" name="datepicker">
                        </div>
                        <div class="datedisplay d-flex flex-column ms-2">
                            <span id="selectedDay"></span>
                            <span class="fs-6" id="selectedDate"></span>
                            <span id="selectedMonth"></span>
                        </div>
                    </form>
                    <div class="d-flex">
                        <div class="d-flex p-3 border-danger border-3 border-bottom">
                            <span class="me-4 language">Language</span>
                            <span class="material-symbols-outlined">keyboard_arrow_down</span>
                        </div>
                        <div class="d-flex p-3">
                            <span class="priceFilter me-2">Filter Price Range</span>
                            <span class="material-symbols-outlined">keyboard_arrow_down</span>
                        </div>
                        <div class="d-flex p-3">
                            <span class="priceFilter ">Filter Show Timings</span>
                        </div>
                        <div class="d-flex p-3">
                            <span class="material-symbols-outlined">search</span>
                        </div>
                    </div>
                </div>
                <div class="mx-4 d-flex justify-content-end p-2">
                    <div class="d-flex align-items-center filterOption me-2">
                        <span class="dotgreen"></span>
                        <span>Available</span>
                    </div>
                    <div class="d-flex align-items-center filterOption me-2">
                        <span class="dotorange"></span>
                        <span>Fast Filling</span>
                    </div>
                    <div class="lan ">LAN</div>
                    <div class="filterOption d-flex align-items-center">
                        <span>Subtitles Language</span>
                    </div>
                </div>
                <cfloop query="#local.theaterDetail#">
                    <div class="m-2">
                        <div class="p-4 row">
                            <div class="col-3 d-flex"> 
                                <span class="material-symbols-outlined me-2"> favorite</span>
                                <p class="moviename me-2">#local.theaterDetail.TheaterName#</p>
                                <div class="d-flex info">
                                    <span class="material-symbols-outlined me-1 infoicon">info</span>
                                    <span>INFO</span>
                                </div>
                            </div>
                            <div class="col ms-4 d-flex flex-column">
                                <div class="d-flex flex-row align-items-center gap-3">
                                    <cfloop list="#local.theaterDetail.TheaterTimings#" item="item">
                                        <cfset local.parsedTime = ParseDateTime(item)>
                                        <cfset local.startTimeFormatted = TimeFormat(local.parsedTime, "hh:mm tt")>
                                        <form action="seating.cfm" method="post">
                                            <input type="hidden" value="#local.movieid#" name="movieid" id="movieid">
                                            <input type="hidden" value="#local.theaterDetail.theaterId#" name="theaterId" id="theaterId">
                                            <input type="hidden" value="#local.startTimeFormatted#" name="time" class="time">
                                            <input type="hidden" class="bookdate" name="bookdate" id="bookdate">
                                            <button class="showtime-pill" type="submit" >#local.startTimeFormatted#</button>
                                        </form>
                                    </cfloop>
                                </div>
                                <div class="mt-3 d-flex align-items-center">
                                    <span class="dotyellow"></span>
                                    <span class="cancel">Non-cancelable</span>
                                </div>
                            </div>
                        </div>
                    </div>
                </cfloop>
            </div>
        </div>
    </cfoutput>
    <cfinclude  template="footer.cfm">
</body>
</html>