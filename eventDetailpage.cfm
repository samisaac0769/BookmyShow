<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="icon" type="image/x-icon" href="Assets/fovicon.png">
    <title>Event Detail</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css" />
    
    <!-- Include jQuery library -->
    <script src="JavaScript/jquery-3.7.1.js"></script>

    <link href="CSS/Googleicon.css" rel="stylesheet">

    <!-- Your existing Bootstrap and Bootstrap JS -->
    <link href="CSS/bootstrap-css.css" rel="stylesheet">
    <script src="JavaScript/bootstrap-js.js"></script>

    <!-- Include Others -->
    <link href="CSS/eventdetail.css" rel="stylesheet">
    <script src="JavaScript/firstpage.js"></script>
</head>
<body>
    <cfinclude  template="nav_bar.cfm">
    <cfoutput>
        
        <cfif structKeyExists(form , "eventid")>
               <cfset local.eventId = form.eventid>
            <cfelse>
                <cfparam name="URl.id" default="">
                <cfset local.encryptedeventId = replace(id,"!","+", "all")>
                <cfset local.encryptedeventId = replace(local.encryptedeventId,"@","\", "all")>
                <cfset local.decryptedeventId = decrypt(local.encryptedeventId,#application.key#, 'AES', 'Base64')> 
                <cfset local.eventId = local.decryptedeventId> 
            </cfif>
        <cfobject component="Components/eventdetail" name="eventDetails">
        <cfset local.event = eventDetails.getEventDetailById(local.eventId)>
        <div class="eventdetails"> 
            <div class="eventPoster d-flex justify-content-center" style="background-image:url('Assets/eventBGposter/#local.event.eventbgposter#');">
                <img src="Assets/eventBGposter/#local.event.eventbgposter#" alt="eventposter"/>
            </div>
            <div class="booking d-flex justify-content-between p-3">
                <div class="d-flex flex-column ">
                    <span class="eventname">#local.event.eventname#</span>
                    <span class="eventcatagerytime">#local.event.catagery# | #local.event.Languages# | #local.event.agelimit#yrs + | #local.event.hours#hr</span>
                </div>
                <div>
                    <input type="hidden" value="#local.eventId#" id="selectedEventId">
                    <button class="booking-btn" id="eventBooking">Book</button>
                </div>
            </div>
            <div class="d-flex flex-column px-3">
                <div class="d-flex gap-2 align-item-center dateLocation">
                    <cfset local.fromdate = local.event.fromdate>
                    <cfset local.todate = local.event.todate>
                    <cfif len(local.todate) eq 0 || local.fromdate eq local.todate>
                        <span>#DateFormat(local.fromdate,"eee")# #DateFormat(local.fromdate,"dd")# #DateFormat(local.fromdate,"mmm")# #DateFormat(local.fromdate,"yyyy")#</span>
                    <cfelse>
                        <span>#DateFormat(local.fromdate,"eee")# #DateFormat(local.fromdate,"dd")# #DateFormat(local.fromdate,"mmm")# #DateFormat(local.fromdate,"yyyy")#</span>
                        <span>to</span>
                        <span>#DateFormat(local.todate,"eee")# #DateFormat(local.todate,"dd")# #DateFormat(local.todate,"mmm")# #DateFormat(local.todate,"yyyy")#</span>
                    </cfif>
                    <cfset local.time = ParseDateTime(local.event.time)>
                    <cfset local.eventime = TimeFormat(local.time, "hh:mm tt")>
                    <span> at #local.eventime#</span>
                    <i class="fa-solid fa-location-dot ms-4 "></i>
                    <span>#local.event.venue#</span>
                    <span> | </span>
                    <span class="price">$ #local.event.price#</span>
                </div>
                <label class="howfast">Filling Fast</label>
            </div>
            <div class="row d-flex mt-5 px-3">
                <div class="col-3 d-flex flex-column ">
                    <div class="share">Share this event</div>
                    <div class="d-flex pt-4 gap-4 socialmedia">
                        <i class="fa-brands fa-facebook-f fa-lg" ></i>
                        <i class="fa-brands fa-twitter fa-lg" ></i>
                    </div>
                </div>
                <div class="col-6">
                    <div class="pb-3">
                        <div class="interest">Click on Interested to stay updated about this event.</div>
                        <div class="d-flex justify-content-between mt-3">
                            <div class="d-flex flex-column">
                                <div class="d-flex align-items-center">
                                    <i class="fa-solid fa-thumbs-up" style="color: ##4abd5d;"></i>
                                    <span class="interest ms-2">#local.event.likes#</span>
                                </div>
                                <div class="likemsg">People have shown interest recently</div>
                            </div>
                            <div>
                                <button class="Interest-btn">Interested?</button>
                            </div>
                        </div>
                    </div>
                    <div class="py-3">
                        <div class="interest">About</div>
                        <p class="about mt-3 d-flex flex-wrap">#local.event.about#</p>
                    </div>
                    <div class="pb-3">
                        <cfif len(local.event.why) gt 0>
                            <div class="interest">Why should you attend?</div>
                            <p class="about mt-3 d-flex flex-wrap">#local.event.why#</p>
                        </cfif>
                    </div>
                </div>
                <div class="col-3">
                    <div class="d-flex flex-column">
                        <div class="interest">#local.event.venue#</div>
                        <div class="d-flex flex-column py-3">
                            <div class="d-flex align-items-center"> 
                                <span class="collocation d-flex flex-wrap">#local.event.venue#</span>
                                <span class="material-symbols-outlined">expand_less</span>
                            </div>
                            <div class="mt-2">
                                <img src="Assets/map.PNG" alt="map">
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </cfoutput>
    <cfinclude template="footer.cfm">
</body>
</html>