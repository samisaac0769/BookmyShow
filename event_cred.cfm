<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="icon" type="image/x-icon" href="Assets/fovicon.png">
    <title>Movie CRED</title>

    <!-- Include jQuery library -->
    <script src="JavaScript/jquery-3.7.1.js"></script>

    <!-- Google icons -->
    <link href="CSS/Googleicon.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css" />

    <!-- Your existing Bootstrap and Bootstrap JS -->
    <link href="CSS/bootstrap-css.css" rel="stylesheet">
    <script src="JavaScript/bootstrap-js.js"></script>

    <!-- Include Others -->
    <link href="CSS/movie_cred.css" rel="stylesheet">
    <script src="JavaScript/event-cred.js"></script>
</head>
<body>
    <cfinclude  template="nav_bar.cfm"/>
    <cfoutput>
        <cfobject component="Components/event_cred" name="eventCred">
        <cfset local.eventList = eventCred.getAllEventForAdmin()>
        <div class="px-5 py-4">
            <div class="d-flex justify-content-between align-items-center">
                <div class="tittle">Event CRED</div>
                <div>
                    <button class="add">Add Event</button>
                </div>
            </div>
            <div class="mt-4">
                <table class="table table-striped">
                    <thead>
                        <tr>
                        <th scope="col">Event Id</th>
                        <th scope="col">Event Name</th>
                        <th scope="col">Location</th>
                        <th scope="col">Price</th>
                        <th></th>
                        </tr>
                    </thead>
                    <tbody>
                        <cfloop query="#local.eventList#">
                            <tr>
                                <td class="fw-bold">#local.eventList.eventid#</td>
                                <td>#local.eventList.eventname#</td>
                                <td>#local.eventList.venue#</td>
                                <td>Rs: #local.eventList.price#/-</td>
                                <td class="alter-btns">
                                    <button class="view-btn" data-eventid="#local.eventList.eventid#" data-bs-toggle="modal" data-bs-target="##viewpage"><i class="fa-solid fa-eye fa-lg" style="color: ##1522d5;"></i></button>
                                    <button><i class="fa-solid fa-pen-to-square fa-lg" style="color: ##1bb125;"></i></button>
                                    <button class="delete-btn" data-eventid="#local.eventList.eventid#" data-bs-toggle="modal" data-bs-target="##deletePage"><i class="fa-solid fa-trash fa-lg" style="color: ##f70202;"></i></button>
                                </td>
                            </tr>
                        </cfloop>
                    </tbody>
                </table>
            </div>
            <!-- Modal -->
            <div class="modal fade" id="viewpage" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
                <div class="modal-dialog modal-dialog-additional">
                    <div class="modal-content  modal-content-width">
                        <div class="modal-header">
                            <h5 class="modal-title" id="Label"></h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <div class="modal-body row mt-2 ">
                                <div class="col-5 d-flex justify-content-center border-end" >
                                    <div class="posterImg d-flex flex-column">
                                        <img id="eventposter" width="250">
                                        <div class="Incinemas">In Theater</div>
                                    </div>
                                </div>
                                <div class="col-7 px-2">
                                    <div class="d-flex flex-column gap-2">
                                        <div class="d-flex align-items-center">
                                            <span class="label">Name:</span>
                                            <span class="tdvalue" id="eventname"></span>
                                        </div>
                                        <div class="d-flex align-items-center">
                                            <span class="label">Age Limit:</span>
                                            <span class="tdvalue" id="age"></span>
                                        </div>
                                        <div class="d-flex align-items-center">
                                            <span class="label">Hours:</span>
                                            <span class="tdvalue" id="hours"></span>
                                        </div>
                                        <div class="d-flex align-items-center">
                                            <span class="label" id="fromdatelabel"></span>
                                            <span class="tdvalue" id="fromdate"></span>
                                        </div>
                                        <div class=" align-items-center" id="todiv">
                                            <span class="label">To Date:</span>
                                            <span class="tdvalue" id="todate"></span>
                                        </div>
                                        <div class="d-flex align-items-center">
                                            <span class="label">Price:</span>
                                            <span class="tdvalue" id="price"></span>
                                        </div>
                                        <div class="d-flex align-items-center">
                                            <span class="label">Venue:</span>
                                            <span class="tdvalue" id="venue"></span>
                                        </div>
                                        <div class="d-flex align-items-center">
                                            <span class="label">Likes:</span>
                                            <span class="tdvalue" id="likes"></span>
                                        </div>
                                        <div class="d-flex align-items-center">
                                            <span class="label">Catagery:</span>
                                            <span class="tdvalue" id="catagery"></span>
                                        </div>
                                        <div class="d-flex align-items-center">
                                            <span class="label me-2">Language:</span>
                                            <span class="tdvalue f-flex flex-wrap" id="language"></span>
                                        </div>
                                        <div class="d-flex align-items-center">
                                            <span class="label me-2">Time:</span>
                                            <span class="tdvalue f-flex flex-wrap" id="time"></span>
                                        </div>
                                        <div class="align-items-center" id="whydiv">
                                            <span class="label me-2" id="whyid">Why:</span>
                                            <span class="tdvalue f-flex flex-wrap" id="why"></span>
                                        </div>
                                        <div class="d-flex align-items-center">
                                            <span class="label me-2">About:</span>
                                            <span class="tdvalue f-flex flex-wrap" id="about"></span>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-success" data-bs-dismiss="modal">Ok</button>
                        </div>
                    </div>
                </div>
            </div>

            <div class="modal fade" id="deletePage" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
                <div class="modal-dialog  modal-dialog-centered">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title">Modal title</h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <div class="modal-body">
                            <p>Are you sure you want to delete this event</p>

                            <p>Once you delete it you can't retrive it !..</p>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">No</button>
                            <button  type="button" class="btn btn-danger" data-bs-dismiss="modal" id="deleteEvent">Yes</button>
                        </div>
                    </div>
                </div>
            </div>
            
        </div>
    </cfoutput>
    <cfinclude template="footer.cfm"/>
</body>
</html>