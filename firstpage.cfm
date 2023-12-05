<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>BookMyShow</title>
    <link href="CSS/firstpage.css" rel="stylesheet">
    <script src="JavaScript/firstpage.js"></script>
</head>
<body>
    <cfinclude  template="nav_bar.cfm">
    <cfoutput>
        <div class="d-flex flex-column mx-5 pt-5"> 
            <div class="d-flex flex-column gap-1">
                <div class="d-flex justify-content-between "> 
                    <h2 class="reco-movie">Recommended Movies<h2>
                    <div class="seeall">See All ></div>
                </div>
                <div class="d-flex gap-5">
                    <div>
                        <a href="">
                            <div class="">
                                <div class="movie-poster">
                                    <img src="Assets/movieposter/antony-poster.jpg" width="240">
                                    <div class="rating  d-flex justify-content-around">
                                        <span class="d-flex"><img class="me-2" src="Assets/icons8-star-50.png" height="20" width="20">6.8/10</span>
                                        <span>698 Votes</span>
                                    </div>
                                </div>
                                <div class="d-flex flex-column gap-1 mt-3">
                                    <div class="movie-name">Antony</div>
                                    <div class="movie-geners">Drama/Family</div>
                                </div>
                            </div>
                        </a>
                    </div>
                    <div>
                        <a href="">
                            <div class="">
                                <div class="movie-poster">
                                    <img src="Assets/movieposter/tiger-3-poster.jpg" width="240">
                                    <div class="rating d-flex justify-content-around">
                                        <span class="d-flex"><img class="me-2" src="Assets/icons8-star-50.png" height="20" width="20">6.8/10</span>
                                        <span>698 Votes</span>
                                    </div>
                                </div>
                                <div class="d-flex flex-column gap-1 mt-3">
                                    <div class="movie-name">Antony</div>
                                    <div class="movie-geners">Drama/Family</div>
                                </div>
                            </div>
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </cfoutput>
</body>
</html>