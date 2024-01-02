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
    <script src="JavaScript/eventlist_filter.js"></script>


</head>
<body>
    <cfinclude  template="nav_bar.cfm">
    <cfinvoke component="Components/firstpage"  method="eventList" returnvariable="eventList"></cfinvoke>
    <cfset local.qryResponce = eventList>
    <cfparam name="form.date" default="">
    <cfparam name="form.language" default="">
    <cfparam name="form.catagery" default="">
    <cfoutput>
        <div class="d-flex m-5" >
            <div class="me-3 col-3">
                <div class=" d-flex flex-column ">
                    <div class="heading">Filters</div>
                    <cfinvoke component="Components/eventfilter"  method="allLanguage" returnvariable="allanguage"></cfinvoke>
                    <cfinvoke component="Components/eventfilter"  method="allEventCatagery" returnvariable="allCatagery"></cfinvoke>
                    <div class="filter mt-3">
                        <div class="filt-date p-3">
                            <div class="d-flex justify-content-between mb-3" >
                                <div class="d-flex" id="filt-date">
                                    <span id="date_more" class="material-symbols-outlined more">expand_more</span>
                                    <span class="filt-head date-head">Date</span>
                                </div>
                                <div class="clear" id="dateclear">Clear</div>
                            </div>
                            <div class="dateoption d-flex" id="dateoption">
                                <form>
                                    <input class="datepicker" type="text" id="datepicker" name="datepicker" placeholder="Select the date">
                                </form>
                            </div>
                        </div>
                        <div class="filt-lang p-3">
                            <div class="d-flex justify-content-between mb-3" >
                                <div class="d-flex" id="lang-date">
                                    <span id="lang_more" class="material-symbols-outlined more">expand_more</span>
                                    <span class="filt-head">Language</span>
                                </div>
                                <div class="clear" id="langclear">Clear</div>
                            </div>
                            <div class="langoption">
                                <div class="d-flex flex-wrap gap-2">
                                    <cfloop query="allanguage">
                                        <div class="filt-language" value="#allanguage.languageid#">#allanguage.languages#</div>
                                    </cfloop>
                                </div>
                            </div>
                        </div>
                        <div class="catagery-filt p-3">
                            <div class="d-flex justify-content-between mb-3" >
                                <div class="d-flex" id="filt-cata">
                                    <span id="cata_more" class="material-symbols-outlined more">expand_more</span>
                                    <span class="filt-head">Catagery</span>
                                </div>
                                <div class="clear" id="cataclear">Clear</div>
                            </div>
                            <div class="cataoption">
                                <div class="d-flex flex-wrap gap-2">
                                    <cfloop query="allCatagery">
                                        <div class="cata-language" value="#allCatagery.cataId#">#allCatagery.catagery#</div>
                                    </cfloop>
                                </div>
                            </div>
                        </div>
                        <form class="d-flex justify-content-center">
                            <input type="hidden" value="" id="selected-date" name="date">
                            <input type="hidden" value="" id="selected-lang" name="language">
                            <input type="hidden" value="" id="selected-cate" name="catagery">
                            <button class="filter-btn" type="button" onclick=filter()>Filter</button>
                        </form>
                    </div>
                </div>    
            </div>
            <div class="col-9 heading">
                <div class=" d-flex flex-column ">
                    <div class="heading">Events in Trivandrum</div>
                    <div class=" d-flex mx-2 my-4 flex-wrap">
                        <div class="language mb-2" id="all">All</div>
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
                    
                    <div class="queryupdate">
                        <table class="" id="eventTableBody">
                            <cfloop query="local.qryResponce">
                                <cfif currentRow % 4 eq 1>
                                    <tr class="movie-card-row d-flex flex-row">
                                </cfif>
                                <td class="movie-card-data ">
                                    <div id="moviecard" class="mb-3 d-flex me-3">
                                        <form action="eventDetailpage.cfm" method="post"> 
                                            <input type="hidden"name="eventid" value="#local.qryResponce.eventid#">
                                            <button class="movie-card-btn">
                                                <div class="movie-card">
                                                    <div class="movie-poster">
                                                        <img src="Assets/eventposter/#local.qryResponce.eventposter#" width="220">
                                                        <div class="rating  d-flex justify-content-around">
                                                            <cfset local.day = DateFormat(local.qryResponce.fromdate, 'ddd')>
                                                            <cfset local.datemonth = DateFormat(local.qryResponce.fromdate, 'dd') & " " & DateFormat(local.qryResponce.fromdate, 'mmm')>
                                                            <span class="d-flex ms-2">#local.day#, </span>
                                                            <span> #local.datemonth# onwards</span>
                                                        </div>
                                                    </div>
                                                    <div class="d-flex flex-column mt-3 align-items-start">
                                                        <div class="movie-name text-align-start">#local.qryResponce.eventname#</div>
                                                        <div class="venue">#local.qryResponce.venue#</div>
                                                        <div class="catprice">$ #local.qryResponce.price#</div>
                                                    </div>
                                                </div>
                                            </button>
                                        </form>
                                    </div>
                                </td>
                                <cfif currentRow % 4 eq 0 >
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