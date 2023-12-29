<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <link rel="icon" type="image/x-icon" href="Assets/fovicon.png">
    <!-- Include jQuery library -->
    <script src="JavaScript/jquery-3.7.1.js"></script>

    <link href="CSS/Googleicon.css" rel="stylesheet">

    <!-- Your existing Bootstrap and Bootstrap JS -->
    <link href="CSS/bootstrap-css.css" rel="stylesheet">
    <script src="JavaScript/bootstrap-js.js"></script>

    <!-- Include Others -->
    <link href="CSS/seating.css" rel="stylesheet">
    <script src="JavaScript/seating.js"></script>

</head>
<body>
    <cfoutput>
        <cfset local.movieId = form.movieid>
        <cfset local.theaterId = form.theaterId>
        <cfset local.time = form.time>
        <cfset local.bookdate = form.bookdate>

        <cfobject component="Components/moviedetail" name="movieDetails">
        <cfobject component="Components/seating" name="theaterDetails">
        <cfset local.movieDetail = movieDetails.getMovieById(local.movieId)>
        <cfset local.theaterDetail = theaterDetails.getTheaterById(local.theaterId)>
        <cfset local.formateDate = theaterDetails.dateFormate(local.bookdate)>
        <cfset local.seatings = theaterDetails.seatings()>
        <cfset local.bookedSeats = theaterDetails.getBookedSeats(local.movieId,local.theaterId,local.bookdate,local.time)>

        <input type="hidden" id="bookedSeats" value="#local.bookedSeats.bookedSeats#">

        <div>
            <div class="p-3 d-flex justify-content-between border-bottom">
                <div class="d-flex gap-2"> 
                    <button class="back-btn"><span class="material-symbols-outlined back">arrow_back_ios</span></button>
                    <div class="d-flex flex-column gap-1">
                        <div class="d-flex">
                            <span class="m-name">#local.movieDetail.moviename#</span>
                            <div class="certificate ms-2">#local.movieDetail.certificate#</div>
                        </div>
                        <div class="d-flex f-12 gap-2">
                            <span>#local.theaterDetail.TheaterName#</span>
                            <span> | </span>
                            <span>#local.formateDate#, #local.time#</span>
                        </div>
                    </div>  
                </div> 
                <div class="d-flex align-items-center gap-3">
                    <div class="tickets gap-2">
                        <span>1 Tickets</span>
                        <div class="__icon">
                            <svg xmlns="http://www.w3.org/2000/svg" width="12" height="12" viewBox="0 0 12 12" fill="none">
                                <path fill-rule="evenodd" clip-rule="evenodd" d="M9.33553 0.667038C9.86628 0.663445 10.3765 0.872109 10.7526 1.24661L10.7536 1.24769C11.1283 1.62367 11.337 2.13383 11.3335 2.66459C11.3299 3.19456 11.1149 3.70112 10.7362 4.07184L4.36668 10.4414C4.31723 10.4908 4.25541 10.5261 4.18768 10.5434L1.15372 11.3216C1.02013 11.3559 0.878365 11.3171 0.780834 11.2195C0.683303 11.122 0.644488 10.9803 0.678735 10.8467L1.45645 7.81271C1.46062 7.79644 1.46582 7.78051 1.47201 7.765C1.49101 7.71707 1.51989 7.67213 1.55863 7.63332C1.5615 7.63044 1.5644 7.62763 1.56733 7.62486L7.92814 1.26405C8.29899 0.885543 8.80558 0.670626 9.33553 0.667038ZM2.04291 8.66817L1.59853 10.4017L3.3337 9.9567L2.04291 8.66817ZM4.09271 9.61154L2.3871 7.90891L8.02348 2.27256L9.72758 3.97666L4.09271 9.61154ZM10.2013 1.79914C9.97281 1.57193 9.66305 1.44535 9.34082 1.44753C9.06135 1.44942 8.79258 1.54804 8.57913 1.7244L10.2758 3.42104C10.4523 3.20766 10.5511 2.93885 10.553 2.65931C10.5551 2.33715 10.4285 2.02748 10.2013 1.79914Z" fill="##666"></path>
                            </svg>
                        </div>
                    </div>
                    <span class="material-symbols-outlined close">close</span>
                </div>
            </div>
            <div class="p-3 d-flex justify-content-center">
                <div class="seatset p-2 d-flex flex-column justify-content-between gap-3" >
                    <table>
                        <cfloop query="#local.seatings#">
                            <tr>
                                <td>
                                    <span class="seatCatagery">#local.seatings.seatcatagery#-Rs. #price#.00</span>
                                </td>
                            </tr>
                            <tr class="d-flex gap-3 mb-3 ">
                                <cfloop index="index" from="1" to="#local.seatings.Totalseats#">
                                    <td>
                                        <div class="seat" id="#local.seatings.seatcatagery##index#" onclick="selectseat(#local.seatings.price#,'#local.seatings.seatcatagery#',#index#)">#index#</div>
                                    </td>
                                    <cfif index % 15 eq 0>
                                        </tr><tr class="d-flex gap-3 mb-3">
                                    </cfif>
                                </cfloop>
                            </tr>
                        </cfloop>
                    </table>
                </div>
            </div>
            <div class="screen-this-way">
                <span class="screenicon">
                    <svg xml:space="preserve" enable-background="new 0 0 100 100" viewBox="0 0 260 20" y="0px" x="0px" width="260px" height="20px" xmlns:xlink="http://www.w3.org/1999/xlink" xmlns="http://www.w3.org/2000/svg" version="1.1" style="fill: rgba(0, 0, 0, 0.6);">
                        <use xlink:href="/icons/seatlayout-icons.svg##icon-screen"></use>
                    </svg>
                </span>
                <span class="eyes">All eyes this way please!</span>
                <div class="d-flex align-items-center justify-content-center gap-4 my-2">
                    <div class="d-flex align-items-center">
                        <div class="Bestseller infobox"></div>
                        <div class="d-flex align-items-center ms-2 seatinfo gap-1">
                            <span>Bestseller</span>
                            <span class="material-symbols-outlined infoicon ">info</span>
                        </div>
                    </div>
                    <div class="d-flex align-items-center gap-2">
                        <div class="Available infobox"></div>
                        <span class="seatinfo">Available</span>
                    </div>
                    <div class="d-flex align-items-center gap-2">
                        <div class="Selected infobox"></div>
                        <span class="seatinfo">Selected</span>
                    </div>
                    <div class="d-flex align-items-center gap-2">
                        <div class="sold infobox"></div>
                        <span class="seatinfo">Sold</span>
                    </div>
                </div>
            </div>
            <div class="payment" id="payment">
                <form>
                    <input type="hidden" value="#local.movieId#" id="movieId" >
                    <input type="hidden" value="#local.theaterId#" id="theaterId" >
                    <input type="hidden" value="#local.bookdate#" id="selectedDate" >
                    <input type="hidden" value="#local.time#" id="time" >
                    <button type="button"  onclick="paymentBooking(#local.movieId#,#local.theaterId#,'#local.bookdate#','#local.time#')" id="paybtn" class="pay-btn"></button>
                </form>
            </div>
        </div>
    </cfoutput>
</body>
</html>
