<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Theater</title>
    <link rel="icon" type="image/x-icon" href="Assets/fovicon.jpg">
    
    <!-- Include jQuery library -->
    <script src="JavaScript/jquery-3.7.1.js"></script>

    <!-- Include jQuery UI CSS -->
    <link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">

    <!-- Include jQuery UI library -->
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

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
                <div class="d-flex justify-content-between pe-5 m-4">
                    <form class="d-flex">
                        <input type="hidden" value="#local.movieid#" id="movieid">
                        <div>
                            <input class="datepicker" type="text" id="datepicker">
                        </div>
                        <div class="datedisplay d-flex flex-column ms-2">
                            <span>MON</span>
                            <span>16</span>
                            <span>DEC</span>
                        </div>
                    </form>
                    <div>
                        <div>Language-Screen</div>
                    </div>
                </div>
                <div></div>
            </div>
        </div>
    </cfoutput>
    <cfinclude  template="footer.cfm">
</body>
</html>