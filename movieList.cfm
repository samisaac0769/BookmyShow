<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Movie List</title>
    <link href="CSS/bootstrap-css.css" rel="stylesheet">
    <script src="JavaScript/bootstrap-js.js"></script>
    <script src="JavaScript/jquery-3.7.1.js" ></script>
    <link href="CSS/Googleicon.css" rel="stylesheet">
    <link href="CSS/movielist.css" rel="stylesheet">

</head>
<body>
    <cfinclude  template="nav_bar.cfm">
    <cfinclude  template="slide.cfm">
    <cfoutput>
        <div class="d-flex m-5" >
            <div class="me-3 col-3">
                <div class=" d-flex flex-column ">
                    <div class="heading">Filters</div>
                </div>    
            </div>
            <div class="col-9 heading">
                <div class=" d-flex flex-column ">
                    <div class="heading">Movies in Trivandrum</div>
                    <div class=" d-flex mx-2 my-4">
                        <div class="language">Malayalam</div>
                        <div class="language">Tamil</div>
                        <div class="language">English</div>
                        <div class="language">Hindi</div>
                        <div class="language">Telugu</div>
                        <div class="language">Multi language</div>
                    </div>
                    <div class="">
                        <cfinvoke component="Components/firstpage"  method="movieList" returnvariable="movieList"></cfinvoke>
                        <table class="">
                            <cfloop query="movieList" >
                                <cfif currentRow % 4 eq 1>
                                    <tr class="movie-card-row d-flex flex-row">
                                </cfif>
                                <td class="movie-card-data ">
                                    <div id="moviecard" class="mb-3 d-flex me-3">
                                        <form action="moviedetailpage.cfm" method="post"> 
                                            <input type="hidden"name="id" value="#movielist.movieid#">
                                            <button class="movie-card-btn">
                                                <div class="movie-card">
                                                    <div class="movie-poster">
                                                        <img src="Assets/movieposter/#movieList.movieposter#" width="220">
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