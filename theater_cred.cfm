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
    <script src=""></script>
</head>
<body>
    <cfinclude  template="nav_bar.cfm"/>
    <cfoutput>
        <div class="px-5 py-4">
            <div class="d-flex justify-content-between align-items-center">
                <div class="tittle">Theater CRED</div>
                <div>
                    <button class="add">Add Movie</button>
                </div>
            </div>
            <div class="mt-4">
                <table class="table table-striped">
                    <thead>
                        <tr>
                        <th scope="col">MOvie Id</th>
                        <th scope="col">Movie Name</th>
                        <th scope="col">Languages</th>
                        <th scope="col">Running Time</th>
                        <th></th>
                        </tr>
                    </thead>
                    <tbody>
                        <cfloop from="1" to="5" index="i">
                            <tr>
                                <td class="fw-bold">#i#</td>
                                <td>Salaar: Cease Fire - Part 1</td>
                                <td>Telugu,Hindi,Malayalam,Kannada,Tamil</td>
                                <td>2h 55m</td>
                                <td class="alter-btns">
                                    <button data-bs-toggle="modal" data-bs-target="##viewpage"><i class="fa-solid fa-eye fa-lg" style="color: ##1522d5;"></i></button>
                                    <button><i class="fa-solid fa-pen-to-square fa-lg" style="color: ##1bb125;"></i></button>
                                    <button  data-bs-toggle="modal" data-bs-target="##deletePage"><i class="fa-solid fa-trash fa-lg" style="color: ##f70202;"></i></button>
                                </td>
                            </tr>
                        </cfloop>
                    </tbody>
                </table>
            </div>
            <!-- Modal -->
            <div class="modal fade" id="viewpage" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="staticBackdropLabel">Modal title</h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <div class="modal-body row mt-2 ">
                                <div class="col-5 d-flex justify-content-center border-end" >
                                    <div class="posterImg d-flex flex-column">
                                        <img src="Assets/movieposter/animal-poster.jpg" width="250">
                                        <div class="Incinemas">In cinemas</div>
                                    </div>
                                </div>
                                <div class="col-7 px-2">
                                    <table>
                                        <tr>
                                            <th>Movie Name:</th>
                                            <td>Salaar: Cease Fire - Part 1</td>
                                        </tr>
                                        <tr>
                                            <th>Languages:</th>
                                            <td>Telugu,Hindi,Malayalam,Kannada,Tamil</td>
                                        </tr>
                                        <tr>
                                            <th>Running Time:</th>
                                            <td>2h 22m</td>
                                        </tr>
                                        <tr>
                                            <th>Release Date:</th>
                                            <td>12-11-2023</td>
                                        </tr>
                                    </table>
                                </div>
                            </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                            <button type="button" class="btn btn-primary">Understood</button>
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
                            <p>Are you sure you want to delete this movie</p>

                            <p>Once you delete id you can't retrive it !..</p>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">No</button>
                            <button type="button" class="btn btn-danger">Yes</button>
                        </div>
                    </div>
                </div>
            </div>
            
        </div>
    </cfoutput>
    <cfinclude template="footer.cfm"/>
</body>
</html>