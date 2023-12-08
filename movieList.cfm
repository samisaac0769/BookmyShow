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
                <div></div>
            </div>
        </div>
    </div>

    <cfinclude  template="footer.cfm">
</body>
</html>