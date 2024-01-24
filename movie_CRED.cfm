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

    <!-- Multi Select plugin -->
    <link rel="stylesheet" href="CSS/multi-select-tag.css">
    <script src="JavaScript/multi-select-tag.js"></script>

    <!-- Include Others -->
    <link href="CSS/movie_cred.css" rel="stylesheet">
    <script src="JavaScript/movie-cred.js"></script>
</head>
<body>
    <cfinclude  template="nav_bar.cfm"/>
    <cfoutput>
        <cfobject component="Components/movie_cred" name="movieCred">
        <cfset local.movielist = movieCred.getMovieList()>
        <div class="px-5 py-4">
            <div class="d-flex justify-content-between align-items-center">
                <div class="tittle">Movie CRUD</div>
                <div>
                    <button id="addMovieBtn" class="btn btn-outline-success" data-bs-toggle="modal" href="##movieForm">Add Movie</button>
                </div>
            </div>
            <div class="mt-4">
                <table class="table table-striped">
                    <thead>
                        <tr>
                        <th scope="col">Movie Id</th>
                        <th scope="col">Movie Name</th>
                        <th scope="col">Languages</th>
                        <th scope="col">Release Date</th>
                        <th></th>
                        </tr>
                    </thead>
                    <tbody>
                        <cfloop query="#local.movielist#">
                            <tr>
                                <td class="fw-bold">#local.movielist.movieid#</td>
                                <td>#local.movielist.moviename#</td>
                                <td>#local.movielist.movielanguages#</td>
                                <td>#local.movielist.relesedate#</td>
                                <td class="alter-btns">
                                    <button class="view-btn" data-movieid="#local.movielist.movieid#"  data-bs-toggle="modal" data-bs-target="##viewpage"><i class="fa-solid fa-eye fa-lg" style="color: ##1522d5;"></i></button>
                                    <button class="edit-btn" data-movieid="#local.movielist.movieid#"  data-bs-toggle="modal" data-bs-target="##movieEditForm"><i class="fa-solid fa-pen-to-square fa-lg" style="color: ##1bb125;"></i></button>
                                    <button class="delete-btn" data-movieid="#local.movielist.movieid#" data-bs-toggle="modal" data-bs-target="##deletePage"><i class="fa-solid fa-trash fa-lg" style="color: ##f70202;"></i></button>
                                </td>
                            </tr>
                        </cfloop>
                    </tbody>
                </table>
            </div>
            <!-- Modal -->
            <div class="modal fade" id="viewpage" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
                <div class="modal-dialog modal-dialog-additional">
                    <div class="modal-content modal-content-width ">
                        <div class="modal-header">
                            <h5 class="modal-title" id="Label"></h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <div class="modal-body row mt-2 ">
                                <div class="col-5 d-flex justify-content-center border-end" >
                                    <div class="posterImg d-flex flex-column">
                                        <img id="movieposter" width="250">
                                        <div class="Incinemas">In cinemas</div>
                                    </div>
                                </div>
                                <div class="col-7 px-2">
                                    <div class="d-flex flex-column gap-2">
                                        <div class="d-flex align-items-center">
                                            <span class="label">Name:</span>
                                            <span class="tdvalue" id="moviename"></span>
                                        </div>
                                        <div class="d-flex align-items-center">
                                            <span class="label">Languages:</span>
                                            <span class="tdvalue" id="lang"></span>
                                        </div>
                                        <div class="d-flex align-items-center">
                                            <span class="label">Genres:</span>
                                            <span class="tdvalue" id="genres"></span>
                                        </div>
                                        <div class="d-flex align-items-center">
                                            <span class="label">Screens:</span>
                                            <span class="tdvalue" id="screen"></span>
                                        </div>
                                        <div class="d-flex align-items-center">
                                            <span class="label">Certificate:</span>
                                            <span class="tdvalue" id="cert"></span>
                                        </div>
                                        <div class="d-flex align-items-center">
                                            <span class="label">Release Date:</span>
                                            <span class="tdvalue" id="reldate"></span>
                                        </div>
                                        <div class="d-flex align-items-center">
                                            <span class="label">Running Time:</span>
                                            <span class="tdvalue" id="runtime"></span>
                                        </div>
                                        <div class="d-flex align-items-center">
                                            <span class="label">Votings:</span>
                                            <span class="tdvalue" id="vote"></span>
                                        </div>
                                        <div class="d-flex align-items-center">
                                            <span class="label">Rating:</span>
                                            <span class="tdvalue" id="rating"></span>
                                        </div>
                                        <div class="d-flex align-items-center">
                                            <span class="label me-2">About:</span>
                                            <span class="tdvalue f-flex flex-wrap" id="about"></span>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-success" data-bs-dismiss="modal">OK</button>
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

                            <p>Once you delete it you can't retrive it !..</p>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">No</button>
                            <button type="button" id="deletemovie" class="btn btn-danger" data-bs-dismiss="modal">Yes</button>
                        </div>
                    </div>
                </div>
            </div>

            <cfobject  name="commonFunction" component="Components/common">
            <cfset local.genres = commonFunction.getGeneres()>
            <cfset local.language = commonFunction.getLanguage()>
            <cfset local.theater = commonFunction.getTheater()>
            <cfset local.screen = commonFunction.getScreens()>
            <cfset local.cast = commonFunction.getCast()>
            <div class="modal fade " id="movieForm" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="movieFormLabel" aria-hidden="true">
                <div class="modal-dialog modal-dialog-add">
                    <div class="modal-content modal-content-add">
                        <div class="modal-header">
                            <h5 class="modal-title" id="movieFormLabel">ADD MOVIE</h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close" onclick="clearForm()" id="form-btn-close"></button>
                        </div>
                        <div class="modal-body row">
                            <form id="myForm" action="movie_CRED.cfm" method="post" enctype="multipart/form-data">
                                <div class="d-flex justify-content-between p-2 align-items-center">
                                    <div class="form-label">Movie Name:</div>
                                    <input class="p-1 form-input" name="movieName" id="form-movieName" type="text" placeholder="Enter movie name">
                                </div>
                                <div class="d-flex justify-content-between p-2 align-items-center">
                                    <div class="form-label">Run Time:</div>
                                    <input required class="p-1 form-input" name="runTime" id="form-runTime" type="time">
                                </div>
                                <div class="d-flex justify-content-between p-2 align-items-center">
                                    <div class="form-label">Release Date:</div>
                                    <input required class="p-1 form-input" name="releDate" id="form-releDate" type="date">
                                </div>
                                <div class="d-flex justify-content-between p-2 align-items-center">
                                    <div class="form-label">Certificate:</div>
                                    <select required class="certificate" name="certificate" id="form-certificate" >
                                        <option  value="">Select movie certificate</option>
                                        <option value="A">A</option>
                                        <option value="U">U</option>
                                        <option value="UA">UA</option>
                                    </select>
                                </div>
                                <div class="d-flex justify-content-between p-2 align-items-center">
                                    <div class="form-label">Genres:</div>
                                    <select required name="genres" id="multiGenres" multiple>
                                        <cfloop query="#local.genres#"> 
                                            <option value="#local.genres.genresId#">#local.genres.movieGenres#</option>
                                        </cfloop>
                                    </select>
                                </div>
                                <div class="d-flex justify-content-between p-2 align-items-center">
                                    <div class="form-label">Languages:</div>
                                    <select required name="language" id="multiLanguage" multiple>
                                        <cfloop query="#local.language#"> 
                                            <option value="#local.language.languageId#">#local.language.languages#</option>
                                        </cfloop>
                                    </select>
                                </div>
                                <div class="d-flex justify-content-between p-2 align-items-center">
                                    <div class="form-label">Theaters:</div>
                                    <select required name="theater" id="multiTheater" multiple>
                                        <cfloop query="#local.theater#"> 
                                            <option value="#local.theater.theaterid#">#local.theater.theatername#</option>
                                        </cfloop>
                                    </select>
                                </div>
                                <div class="d-flex justify-content-between p-2 align-items-center">
                                    <div class="form-label">Screens:</div>
                                    <select required name="screen" id="multiScreen" multiple>
                                        <cfloop query="#local.screen#"> 
                                            <option value="#local.screen.screenId#">#local.screen.screentype#</option>
                                        </cfloop>
                                    </select>
                                </div>
                                <div class="d-flex justify-content-between p-2 align-items-center">
                                    <div class="form-label">Cast:</div>
                                    <select required name="cast" id="multiCast" multiple>
                                        <cfloop query="#local.cast#"> 
                                            <option value="#local.cast.castId#">#local.cast.castname#</option>
                                        </cfloop>
                                    </select>
                                </div>
                                <div class="d-flex justify-content-between p-2 align-items-center">
                                    <div class="form-label">About:</div>
                                    <textarea required class="p-1 form-input" name="about" id="form-about" type="number" placeholder="Tell something about the movie"></textarea>
                                </div>
                                <div id="movPoster">
                                    <div class="d-flex justify-content-between p-2 align-items-center">
                                        <div class="form-label">Movie Poster:</div>
                                        <input  class="p-1 form-input" name="movPoster" id="form-MovPoster" type="file" accept=".jpg, .jpeg, .png">
                                    </div>
                                </div>
                                <div id="bgPoster">
                                    <div class="d-flex justify-content-between p-2 align-items-center">
                                        <div class="form-label">Movie bgPoster:</div>
                                        <input  class="p-1 form-input" name="bgPoster" id="form-bgPoster" type="file" accept=".jpg, .jpeg, .png">
                                    </div>
                                </div>
                                <input id="from-movieId" type="hidden" name="movieid">
                                <div class="d-flex justify-content-center mt-2">
                                    <button name="formsubmit" id="addSubmitBtn" type="submit" class="btn btn-success" >Submit</button>
                                </div>
                            </form>
                            <cfif structKeyExists(form, "formsubmit") && len(trim(form.movieid)) eq 0>
                                <cfinvoke component="Components/movie_cred"  method="addMovie" fileuploadposter="form.movPoster" fileuploadbg="form.bgPoster">
                                    <cfinvokeargument  name="movieName"  value="#form.movieName#">
                                    <cfinvokeargument  name="runTime"  value="#form.runTime#">
                                    <cfinvokeargument  name="releDate"  value="#form.releDate#">
                                    <cfinvokeargument  name="certificate"  value="#form.certificate#">
                                    <cfinvokeargument  name="genres"  value="#form.genres#">
                                    <cfinvokeargument  name="language"  value="#form.language#">
                                    <cfinvokeargument  name="theater"  value="#form.theater#">
                                    <cfinvokeargument  name="screen"  value="#form.screen#">
                                    <cfinvokeargument  name="cast"  value="#form.cast#">
                                    <cfinvokeargument  name="about"  value="#form.about#">
                                </cfinvoke>
                            </cfif>
                        </div>  
                    </div>
                </div>
            </div>
            <div class="modal fade " id="movieEditForm" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="movieEditFormLabel" aria-hidden="true">
                <div class="modal-dialog modal-dialog-add">
                    <div class="modal-content modal-content-add">
                        <div class="modal-header">
                            <h5 class="modal-title" id="movieEditFormLabel">EDIT MOVIE</h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close" id="closeEditBtn"></button>
                        </div>
                        <div class="modal-body row">
                            <form action="movie_CRED.cfm" method="post" >
                                <div class="d-flex justify-content-between p-2 align-items-center">
                                    <div class="form-label">Movie Name:</div>
                                    <input class="p-1 form-input" name="editMovieName" id="formEdit-movieName" type="text" placeholder="Enter movie name">
                                </div>
                                <div class="d-flex justify-content-between p-2 align-items-center">
                                    <div class="form-label">Run Time:</div>
                                    <input class="p-1 form-input" name="editRunTime" id="formEdit-runTime" type="time">
                                </div>
                                <div class="d-flex justify-content-between p-2 align-items-center">
                                    <div class="form-label">Release Date:</div>
                                    <input class="p-1 form-input" name="editReleDate" id="formEdit-releDate" type="date">
                                </div>
                                <div class="d-flex justify-content-between p-2 align-items-center">
                                    <div class="form-label">Certificate:</div>
                                    <select class="certificate" name="editCertificate" id="formEdit-certificate" >
                                        <option  value="">Select movie certificate</option>
                                        <option value="A">A</option>
                                        <option value="U">U</option>
                                        <option value="UA">UA</option>
                                    </select>
                                </div>
                                <div class="d-flex justify-content-between p-2 align-items-center">
                                    <div class="form-label">Genres:</div>
                                    <select name="editGenres" id="editMultiGenres" multiple>
                                        <cfloop query="#local.genres#"> 
                                            <option value="#local.genres.genresId#">#local.genres.movieGenres#</option>
                                        </cfloop>
                                    </select>
                                </div>
                                <div class="d-flex justify-content-between p-2 align-items-center">
                                    <div class="form-label">Languages:</div>
                                    <select name="editLanguage" id="editMultiLanguage" multiple>
                                        <cfloop query="#local.language#"> 
                                            <option value="#local.language.languageId#">#local.language.languages#</option>
                                        </cfloop>
                                    </select>
                                </div>
                                <div class="d-flex justify-content-between p-2 align-items-center">
                                    <div class="form-label">Theaters:</div>
                                    <select name="editTheater" id="editMultiTheater" multiple>
                                        <cfloop query="#local.theater#"> 
                                            <option value="#local.theater.theaterid#">#local.theater.theatername#</option>
                                        </cfloop>
                                    </select>
                                </div>
                                <div class="d-flex justify-content-between p-2 align-items-center">
                                    <div class="form-label">Screens:</div>
                                    <select name="editScreen" id="editMultiScreen" multiple>
                                        <cfloop query="#local.screen#"> 
                                            <option value="#local.screen.screenId#">#local.screen.screentype#</option>
                                        </cfloop>
                                    </select>
                                </div>
                                <div class="d-flex justify-content-between p-2 align-items-center">
                                    <div class="form-label">Cast:</div>
                                    <select name="editCast" id="editMultiCast" multiple>
                                        <cfloop query="#local.cast#"> 
                                            <option value="#local.cast.castId#">#local.cast.castname#</option>
                                        </cfloop>
                                    </select>
                                </div>
                                <div class="d-flex justify-content-between p-2 align-items-center">
                                    <div class="form-label">About:</div>
                                    <textarea class="p-1 form-input" name="editAbout" id="formEdit-about" type="number" placeholder="Tell something about the movie"></textarea>
                                </div>
                                <input id="fromEdit-movieId" type="hidden" name="editMovieId">
                                <div class="d-flex justify-content-center mt-2">
                                    <button name="editFormSubmit" id="editSubmitBtn" type="submit" class="btn btn-success" >Submit</button>
                                </div>
                            </form>
                            <cfif structKeyExists(form, "editFormSubmit") && len(trim(form.editMovieId))>
                                <cfinvoke component="Components/movie_cred"  method="updateMovieById" returnvariable="result">
                                    <cfinvokeargument  name="editMovieId"  value="#form.editMovieId#">
                                    <cfinvokeargument  name="editMovieName"  value="#form.editMovieName#">
                                    <cfinvokeargument  name="editRunTime"  value="#form.editRunTime#">
                                    <cfinvokeargument  name="editReleDate"  value="#form.editReleDate#">
                                    <cfinvokeargument  name="editCertificate"  value="#form.editCertificate#">
                                    <cfinvokeargument  name="editGenres"  value="#form.editGenres#">
                                    <cfinvokeargument  name="editLanguage"  value="#form.editLanguage#">
                                    <cfinvokeargument  name="editTheater"  value="#form.editTheater#">
                                    <cfinvokeargument  name="editScreen"  value="#form.editScreen#">
                                    <cfinvokeargument  name="editCast"  value="#form.editCast#">
                                    <cfinvokeargument  name="editAbout"  value="#form.editAbout#">
                                </cfinvoke>
                                <!---<input type="hidden" value="#result#" id="updateResult">
                                <span>#result#</span>--->
                            </cfif>
                            
                        </div>  
                    </div>
                </div>
            </div>
        </div>
    </cfoutput>
    <cfinclude template="footer.cfm"/>
</body>
</html>