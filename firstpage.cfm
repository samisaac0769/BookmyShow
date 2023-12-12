<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>BookMyShow</title>
    <script src="JavaScript/bootstrap-js.js"></script>
    <script src="JavaScript/jquery-3.7.1.js" ></script>
    <link href="CSS/firstpage.css" rel="stylesheet">
    <script src="JavaScript/firstpage.js"></script>
</head>
<body>
    <cfinclude  template="nav_bar.cfm">
    <cfinclude  template="slide.cfm">
    <cfoutput>
        <div class="d-flex flex-column mx-5 py-5 gap-5"> 
            <div class="d-flex flex-column gap-1">
                <div class="d-flex justify-content-between "> 
                    <h2 class="reco-movie">Recommended Movies<h2>
                    <div class="seeall">See All ></div>
                </div>
                <div class="d-flex gap-4">
                    <cfinvoke component="Components/firstpage"  method="mainPageMovieList" returnvariable="movieList"></cfinvoke>
                    
                    <cfloop query="movieList" >
                        <!---<cfif currentRow eq 2>
                            <cfbreak>
                        </cfif>--->
                        <div id="moviecard">
                            <form action="moviedetailpage.cfm" method="post"> 
                                <input type="hidden"name="id" value="#movielist.movieid#">
                                <button class="movie-card-btn">
                                        <div class="">
                                            <div class="movie-poster">
                                                <img src="Assets/movieposter/#movieList.movieposter#" width="240">
                                                <div class="rating  d-flex justify-content-around">
                                                    <span class="d-flex"><img class="me-2" src="Assets/icons8-star-50.png" height="20" width="20">#movieList.rating#/10</span>
                                                    <span>#formatVotings(movieList.votings)# Votes</span>
                                                </div>
                                                
                                            </div>
                                            <div class="d-flex flex-column gap-1 mt-3">
                                                <div class="movie-name">#movieList.moviename#</div>
                                                <div class="movie-geners">
                                                    <cfloop list="#movieList.moviegenres#" item="item" index="index">
                                                        #item# <cfif index lt listLen(movieList.moviegenres)>/</cfif>
                                                    </cfloop>
                                                </div>
                                            </div>
                                        </div>
                                    </button class="movie-card-btn">
                            </form>
                        </div>
                    </cfloop>
                </div>
            </div>
            <div class="">
                <img src="Assets/stream-leadin-web-collection.png" class="" width="100%" height="100%">
            </div>
            <div class="d-flex flex-column gap-1">
                <div class="d-flex justify-content-between "> 
                    <h2 class="reco-movie">Recommended Events<h2>
                    <div class="seeall">See All ></div>
                </div>
                <div class="d-flex gap-4">
                    <cfinvoke component="Components/firstpage"  method="mainPageEventList" returnvariable="eventList"></cfinvoke>
                    <cfloop query="eventList">
                        <div>
                            <a href="">
                                <div class="cards">
                                    <div class="movie-poster">
                                        <img src="Assets/eventposter/#eventList.eventposter#" width="240">
                                        <div class="rating event-date  d-flex gap-2">
                                            <cfset local.day = DateFormat(eventList.fromdate, 'ddd')>
                                            <cfset local.datemonth = DateFormat(eventList.fromdate, 'dd') & " " & DateFormat(eventList.fromdate, 'mmm')>
                                            <span class="d-flex ms-2">#local.day#, </span>
                                            
                                            <span> #local.datemonth# onwards</span>
                                        </div>
                                        
                                    </div>
                                    <div class="d-flex flex-column gap-1 mt-3">
                                        <div class="movie-name">#eventList.eventname#</div>
                                        <div class="venue">#eventlist.venue#</div>
                                        <div class="catprice">#eventlist.catagery#</div>
                                        <div class="catprice">$ #eventlist.price#</div>

                                    </div>
                                </div>
                            </a>
                        </div>
                    </cfloop>
                </div>
            </div>
        </div>
    </cfoutput>
    <cfscript>
        function formatVotings(votings) {
            var formattedVotings = "";

            if (votings gte 1000) {
                formattedVotings = numberFormat(votings / 1000, "9.9") & "K";
            } else {
                formattedVotings = votings;
            }

            return formattedVotings;
        }
    </cfscript>
    <cfinclude  template="footer.cfm">
</body>
</html>