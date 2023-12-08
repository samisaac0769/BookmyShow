<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Movie Details</title>
        <script src="JavaScript/jquery-3.7.1.js" ></script>
        <script src="JavaScript/firstpage.js"></script>
        <link href="CSS/moviedetail.css" rel="stylesheet">
        
    </head>
    <body>
        <cfinclude  template="nav_bar.cfm">
        
            <cfset local.movieid = url.movieid>
            <cfset local.movieDetails = createObject("component", "Components/moviedetail")>
            
            <cfoutput>
                <cfset local.movie =local.movieDetails.getMovieById(local.movieid)>
                <div class="" >
                    <div class="posterbg">
                        <input class="moviebg" id="movieBg" value="Assets/moviebgposter/#local.movie.moviebgposter#">
                        <div class="movie-details">
                            <div class="movie-poster d-flex gap-4">
                                <div class="posterImg d-flex flex-column">
                                    <img src="Assets/movieposter/#local.movie.movieposter#" width="240">
                                    <div class="Incinemas" >In cinemas</div>
                                </div>
                                <div class="d-flex  flex-column ms-2">
                                    <div class="movieTitle mt-3">#local.movie.moviename#</div>
                                    <div class="d-flex mt-3 gap-3 align-items-center movieLV">
                                        <div><img class="" src="Assets/icons8-star-50.png" height="30" width="30"></div>
                                        <span class="stars">#local.movie.rating#/10</span>
                                        <span class="votes">#formatVotings(local.movie.votings)# Votes ></span>
                                    </div>
                                    <div class="d-flex p-3 gap-4 rating align-items-center">
                                        <div class="d-flex flex-column"> 
                                            <h5 class="mb-2">Add your rating & review</h5>
                                            <h6>Your ratings matter</h6>
                                        </div>
                                        <div class="ms-3"><button class="btn-rate btn btn-light">Rate Now</button></div>
                                    </div>
                                    <div class="d-flex mt-3">
                                        <div class="screen">
                                            #local.movie.moviescreen#
                                        </div>
                                        <div class="language ms-3">
                                            #local.movie.movielanguages#
                                        </div>
                                    </div>
                                    <div class="d-flex mt-3 movieTGRC"><span>#formatDbDateTime(local.movie.time)# </span>
                                        <span class="sc-2k6tnd-5 juHVhn">  &bull;  </span>
                                        <span>
                                            <cfloop list="#local.movie.moviegenres#" item="item" index="index">
                                                #item# <cfif index lt listLen(local.movie.moviegenres)>/</cfif>
                                            </cfloop>
                                        </span>
                                        <span class="sc-2k6tnd-5 juHVhn">  &bull;  </span><span>#local.movie.certificate#</span>
                                        <span class="sc-2k6tnd-5 juHVhn">  &bull;  </span><span>#DateFormat(parseDateTime(local.movie.relesedate), "dd MMM, yyyy")#</span>

                                    </div>
                                    <div class="mt-3 ms-3">
                                        <button class="btn-book">Book tickets</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="m-5 pb-4  border-bottom">
                        <h3>About the movie</h3>
                        <span class="about">#local.movie.about#</span>
                    </div>
                    <div class="mx-5 pb-4 border-bottom">
                        <h4>Cast</h4>
                        <cfset local.cast =local.movieDetails.getCast(local.movieid)>
                        <div class='d-flex p-2 gap-4'>
                            <cfloop query=#local.cast#>
                                <div class="d-flex flex-column align-items-center">
                                    <div class="acterImage"><img src="Assets/movieactor/#local.cast.castimage#"></div>
                                    <div class="acterName p-2">#local.cast.castname#</div>
                                    <div class="asName">as #local.cast.castnameinmovie#</div>
                                </div>
                            </cfloop>
                        </div>
                    </div>                 
                </div>
            </cfoutput>
        
        
        <cfinclude  template="footer.cfm">
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
            function formatDbDateTime(dbDateTime) {
                // Parse the date and time string
                var dateTimeParts = listToArray(dbDateTime, " ");
                
                // Extract the time portion
                var timeString = dateTimeParts[2];
                
                // Parse the time string
                var timeParts = listToArray(timeString, ":");
                
                // Extract hours and minutes
                var hours = int(timeParts[1]);
                var minutes = int(timeParts[2]);

                // Format the time
                var formattedTime = "";

                if (hours gt 0) {
                    formattedTime = hours & "h";
                }

                if (minutes gt 0) {
                    formattedTime = formattedTime & " " & minutes & "m";
                }

                return trim(formattedTime);
            }
        </cfscript>
    </body>
</html>