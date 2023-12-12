<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Theater</title>
    
    <!-- Include jQuery library -->
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>

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
        <cfset local.movieid = form.id>
        <cfset local.moviename = form.moviename>
        <cfset local.certificate = form.certificate>
        <cfset local.genres = form.genres>
        <cfset local.relisedate = form.relisedate>
        <div class="">
            <div class="d-flex flex-column  moviehead">
                <div class="movietitle ">#local.moviename#</div>
                <div class="d-flex align-items-center gap-2">
                    <div class="certificate">#local.certificate#</div>
                    <cfloop list="#local.genres#" item="item">
                        <div class="genres">#ucase(item)#</div>
                    </cfloop>
                </div>
            </div>
            <div class="d-flex flex-column">
                <div class="d-flex justify-content-between pe-5">
                    <div><input type="text" id="datepicker"></div>
                    <div>dfgsdf</div>
                </div>
                <div></div>
            </div>

        </div>
    </cfoutput>
    <!---<cfinclude  template="footer.cfm">--->
</body>
</html>