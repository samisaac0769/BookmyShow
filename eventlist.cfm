<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="icon" type="image/x-icon" href="Assets/fovicon.png">
    <title>EventList</title>
    <!-- Include jQuery library -->
    <script src="JavaScript/jquery-3.7.1.js"></script>

    <link href="CSS/Googleicon.css" rel="stylesheet">

    <!-- Your existing Bootstrap and Bootstrap JS -->
    <link href="CSS/bootstrap-css.css" rel="stylesheet">
    <script src="JavaScript/bootstrap-js.js"></script>

    <!-- Include Others -->
    <link href="CSS/eventlist.css" rel="stylesheet">


</head>
<body>
    <cfinclude  template="nav_bar.cfm">
    <cfoutput>
        <div class="d-flex m-5" >
            <div class="me-3 col-3">
                <div class=" d-flex flex-column ">
                    <div class="heading">Filters</div>
                </div>    
            </div>
            <div class="col-9 heading">
                <div class=" d-flex flex-column ">
                    <div class="heading">Events in Trivandrum</div>
                    <div class=" d-flex mx-2 my-4 flex-wrap">
                        <div class="language mb-2">Workshops</div>
                        <div class="language mb-2">New Year Parties</div>
                        <div class="language mb-2">Comedy Shows</div>
                        <div class="language mb-2">Performances</div>
                        <div class="language mb-2">Online Streaming Events</div>
                        <div class="language mb-2">Talks</div>
                        <div class="language mb-2">Music Shows</div>
                        <div class="language mb-2">Kids</div>
                        <div class="language mb-2">Meetups</div>
                        <div class="language mb-2">Beer Festival</div>
                    </div>
                    <div class="">
                        <cfinvoke component="Components/firstpage"  method="eventList" returnvariable="eventList"></cfinvoke>
                        <!---<cfset session.eventQuerys = eventList>--->
                        <table class="">
                            <cfloop query="eventList" >
                                <cfif currentRow % 4 eq 1>
                                    <tr class="movie-card-row d-flex flex-row">
                                </cfif>
                                <td class="movie-card-data ">
                                    <div id="moviecard" class="mb-3 d-flex me-3">
                                        <form action="eventDetailpage.cfm" method="post"> 
                                            <input type="hidden"name="eventid" value="#eventList.eventid#">
                                            <button class="movie-card-btn">
                                                <div class="movie-card">
                                                    <div class="movie-poster">
                                                        <img src="Assets/eventposter/#eventList.eventposter#" width="220">
                                                        <div class="rating  d-flex justify-content-around">
                                                            <cfset local.day = DateFormat(eventList.fromdate, 'ddd')>
                                                            <cfset local.datemonth = DateFormat(eventList.fromdate, 'dd') & " " & DateFormat(eventList.fromdate, 'mmm')>
                                                            <span class="d-flex ms-2">#local.day#, </span>
                                                            <span> #local.datemonth# onwards</span>
                                                        </div>
                                                    </div>
                                                    <div class="d-flex flex-column mt-3 align-items-start">
                                                        <div class="movie-name text-align-start">#eventList.eventname#</div>
                                                        <div class="venue">#eventlist.venue#</div>
                                                        <div class="catprice">$ #eventlist.price#</div>
                                                    </div>
                                                </div>
                                            </button>
                                        </form>
                                    </div>
                                </td>
                                <cfif currentRow % 4 eq 0 or currentRow eq recordCount>
                                    </tr>
                                </cfif>
                            </cfloop>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </cfoutput>
    <cfinclude  template="footer.cfm">
</body>
</html>