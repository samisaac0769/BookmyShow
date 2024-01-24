<cfcomponent>
    <cffunction name="getMovieList" access="public" returntype="query">
        <cfquery name="quyGetMovieList">
            SELECT 
                ml.movieid,
                ml.moviename,
                ml.movieposter,
                ml.moviebgposter,
                ml.rating,
                ml.votings,
                ml.relesedate,
                ml.about,
                ml.certificate,
                ml.time,  
                (
                    SELECT STRING_AGG(mg.moviegenres, ', ')
                    FROM MGMapping mgm
                    JOIN movieGenresList mg ON mgm.genresid = mg.genresId
                    WHERE ml.movieId = mgm.movieid
                ) AS moviegenres,
                (
                    SELECT STRING_AGG(mla.languages, ', ')
                    FROM MLMapping mlm
                    JOIN movieLanguages mla ON mlm.languageid = mla.languageId
                    WHERE ml.movieId = mlm.movieid
                ) AS movielanguages,
                (
                    SELECT STRING_AGG(ms.screentype, ', ')
                    FROM MSMapping msm
                    JOIN moviescreen ms ON msm.screenid = ms.screenid
                    where ml.movieId = msm.movieid
                ) AS moviescreen
            FROM
                movielist ml
            WHERE
                status = <cfqueryparam value="true" cfsqltype="bit">;
        </cfquery>
        <cfreturn quyGetMovieList>
    </cffunction>

    <cffunction  name="getMovieByIdforAdmin" access="remote" returntype="query">
        <cfargument  name="movieId">
        <cfquery name="qryMovieDetailsforAdmin">
            SELECT 
                ml.moviename,
                ml.movieposter,
                ml.moviebgposter,
                ml.rating,
                ml.votings,
                ml.relesedate,
                ml.about,
                ml.certificate,
                ml.time,  
                (
                    SELECT STRING_AGG(mg.moviegenres, ', ')
                    FROM MGMapping mgm
                    JOIN movieGenresList mg ON mgm.genresid = mg.genresId
                    WHERE ml.movieId = mgm.movieid
                ) AS moviegenres,
                (
                    SELECT STRING_AGG(mla.languages, ', ')
                    FROM MLMapping mlm
                    JOIN movieLanguages mla ON mlm.languageid = mla.languageId
                    WHERE ml.movieId = mlm.movieid
                ) AS movielanguages,
                (
                    SELECT STRING_AGG(ms.screentype, ', ')
                    FROM MSMapping msm
                    JOIN moviescreen ms ON msm.screenid = ms.screenid
                    where ml.movieId = msm.movieid
                ) AS moviescreen
            FROM
                movielist ml
            WHERE 
                ml.movieId = <cfqueryparam value="#arguments.movieId#" CFSQLType ="CF_SQL_INTEGER">;
        </cfquery>
        <cfreturn qryMovieDetailsforAdmin>
    </cffunction>

    <cffunction name="deleteMovieById" returntype="string" access="remote">
        <cfargument  name="movieId">
        <cfquery name="deleteMovieById">
            UPDATE movielist
            SET status = 0
            WHERE movieId = <cfqueryparam value="#arguments.movieId#" cfsqltype="integer">;
        </cfquery>
        <cfreturn "true">
    </cffunction>
    
    <cffunction  name="addMovie" access="public" returntype="string">
        <cfargument  name="movieName">
        <cfargument  name="runTime">
        <cfargument  name="releDate">
        <cfargument  name="certificate">
        <cfargument  name="genres">
        <cfargument  name="language">
        <cfargument  name="theater">
        <cfargument  name="screen">
        <cfargument  name="cast">
        <cfargument  name="about">
        <cfargument  name="fileuploadposter">
        <cfargument  name="fileuploadbg">

        <cfquery name="qryCheckMovieExist">
            SELECT movieId FROM movielist WHERE moviename = <cfqueryparam value="#arguments.movieName#" cfsqltype="varchar">
        </cfquery>
       
        <cfif !qryCheckMovieExist.recordcount>
            <cfset local.moviePoster = ExpandPath("/BookmyShow/Assets/movieposter")>
            <cfset local.bgMoviePoster = ExpandPath("/BookmyShow/Assets/moviebgposter")>

            <cffile action = "upload" 
            fileField = "#arguments.fileuploadposter#" 
            destination = "#local.moviePoster#"  
            nameConflict = "MakeUnique"
            allowedextensions=".jpg, .png, .jpeg">

            <cfset local.getMoviePoster = cffile.clientFile>

            <cffile action = "upload" 
            fileField = "#arguments.fileuploadbg#" 
            destination = "#local.bgMoviePoster#"  
            nameConflict = "MakeUnique"
            allowedextensions=".jpg, .png, .jpeg">

            <cfset local.getMovieBgPoster = cffile.clientFile>

            <cfset local.rating = 7.8/>
            <cfset local.voting = 75480/>
            <cfset local.status = "True"/>

            <cfquery name="qryInsertMovie" result="insertResult">
                INSERT INTO movielist (movieName, time, relesedate, about, certificate, status, moviebgposter, movieposter, rating, votings)
                values(
                    <cfqueryparam value="#arguments.movieName#" cfsqltype="varchar">,
                    <cfqueryparam value="#arguments.runTime#" cfsqltype="time">,
                    <cfqueryparam value="#arguments.releDate#" cfsqltype="date">,
                    <cfqueryparam value="#arguments.about#" cfsqltype="varchar">,
                    <cfqueryparam value="#arguments.certificate#" cfsqltype="varchar">,   
                    <cfqueryparam value="#local.status#" cfsqltype="bit">,
                    <cfqueryparam value="#local.getMovieBgPoster#" cfsqltype="varchar">,
                    <cfqueryparam value="#local.getMoviePoster#" cfsqltype="varchar">,
                    <cfqueryparam value="#local.rating#" cfsqltype="float">,
                    <cfqueryparam value="#local.voting#" cfsqltype="integer">
                )
            </cfquery>

            <cfset local.newMovieId =insertResult.GENERATEDKEY>

            <cfif len(trim(local.newMovieId))>
                <cfloop list="#arguments.genres#" index="i">
                    <cfquery name="qryInsertMoveiGenres">
                        INSERT INTO MGMapping(movieid, genresid)
                        VALUES(
                            <cfqueryparam value="#local.newMovieId#" cfsqltype="integer">,
                            <cfqueryparam value="#i#" cfsqltype="integer">
                        )
                    </cfquery>
                </cfloop>
                <cfloop list="#arguments.language#" index="i">
                    <cfquery name="qryInsertMoveilanguage">
                        INSERT INTO MLMapping(movieid, languageid)
                        VALUES(
                            <cfqueryparam value="#local.newMovieId#" cfsqltype="integer">,
                            <cfqueryparam value="#i#" cfsqltype="integer">
                        )
                    </cfquery>
                </cfloop>
                <cfloop list="#arguments.theater#" index="i">
                    <cfquery name="qryInsertMoveiTheater">
                        INSERT INTO movietheater(movieid, theaterid)
                        VALUES(
                            <cfqueryparam value="#local.newMovieId#" cfsqltype="integer">,
                            <cfqueryparam value="#i#" cfsqltype="integer">
                        )
                    </cfquery>
                </cfloop>
                <cfloop list="#arguments.screen#" index="i">
                    <cfquery name="qryInsertMoveiScreen">
                        INSERT INTO MSMapping(movieid, screenid)
                        VALUES(
                            <cfqueryparam value="#local.newMovieId#" cfsqltype="integer">,
                            <cfqueryparam value="#i#" cfsqltype="integer">
                        )
                    </cfquery>
                </cfloop>
                <cfloop list="#arguments.cast#" index="i">
                    <cfquery name="qryInsertMoveiCast">
                        INSERT INTO MCMapping(movieid, castid, castNameInMovie)
                        VALUES(
                            <cfqueryparam value="#local.newMovieId#" cfsqltype="integer">,
                            <cfqueryparam value="#i#" cfsqltype="integer">,
                            <cfqueryparam value="Actor" cfsqltype="varchar">
                        )
                    </cfquery>
                </cfloop>

            </cfif>
            <cflocation  url="movie_CRED.cfm">
        </cfif>
    </cffunction>

    <cffunction  name="getMovieByIdToEdit" access="remote" returntype="query">
        <cfargument  name="movieId">
        <cfquery name="qryGetMovieByIdToEdit">
            SELECT 
                ml.moviename,
                ml.relesedate,
                ml.about,
                ml.certificate,
                ml.time,  
                (
                    SELECT STRING_AGG(mg.genresId, ',')
                    FROM MGMapping mgm
                    JOIN movieGenresList mg ON mgm.genresid = mg.genresId
                    WHERE ml.movieId = mgm.movieid
                ) AS moviegenres,
                (
                    SELECT STRING_AGG(mla.languageid, ',')
                    FROM MLMapping mlm
                    JOIN movieLanguages mla ON mlm.languageid = mla.languageId
                    WHERE ml.movieId = mlm.movieid
                ) AS movielanguages,
                (
                    SELECT STRING_AGG(ms.screenid, ',')
                    FROM MSMapping msm
                    JOIN moviescreen ms ON msm.screenid = ms.screenid
                    where ml.movieId = msm.movieid
                ) AS moviescreen,
                (
                    SELECT STRING_AGG(mc.castid, ',')
                    FROM MCMapping mcm
                    JOIN movieCast mc ON mcm.castid = mc.castid
                    where ml.movieId = mcm.movieid
                ) AS moviecast,
                (
                    SELECT STRING_AGG(mt.theaterId, ',')
                    FROM movietheater mtm
                    JOIN Theaters mt ON mtm.theaterid = mt.theaterId
                    where ml.movieId = mtm.movieid
                ) AS movietheater
            FROM
                movielist ml
            WHERE 
                ml.movieId = <cfqueryparam value="#arguments.movieId#" cfsqltype ="INTEGER">;
        </cfquery>
        <cfreturn qryGetMovieByIdToEdit>
    </cffunction>

    <cffunction name="updateMovieById" access="public" returntype="numeric">
        <cfargument  name="editMovieId">
        <cfargument  name="editMovieName">
        <cfargument  name="editRunTime">
        <cfargument  name="editReleDate">
        <cfargument  name="editCertificate">
        <cfargument  name="editGenres">
        <cfargument  name="editLanguage">
        <cfargument  name="editTheater">
        <cfargument  name="editScreen">
        <cfargument  name="editCast">
        <cfargument  name="editAbout">

        <cfquery name="resetMultiSelectOption">
            DELETE FROM MGMapping WHERE movieid = <cfqueryparam value="#arguments.editMovieId#" cfsqltype="integer">
            DELETE FROM MLMapping WHERE movieid = <cfqueryparam value="#arguments.editMovieId#" cfsqltype="integer">
            DELETE FROM MSMapping WHERE movieid = <cfqueryparam value="#arguments.editMovieId#" cfsqltype="integer">
            DELETE FROM MCMapping WHERE movieid = <cfqueryparam value="#arguments.editMovieId#" cfsqltype="integer">
            DELETE FROM movietheater WHERE movieid = <cfqueryparam value="#arguments.editMovieId#" cfsqltype="integer">
        </cfquery>
        <cfquery name="qryToUpdateMovie">
            UPDATE movielist 
            SET movieName = <cfqueryparam value="#arguments.editMovieName#" cfsqltype="varchar">,
                time = <cfqueryparam value="#arguments.editRunTime#" cfsqltype="varchar">,
                relesedate = <cfqueryparam value="#arguments.editReleDate#" cfsqltype="varchar">,
                certificate = <cfqueryparam value="#arguments.editCertificate#" cfsqltype="varchar">,
                about = <cfqueryparam value="#arguments.editAbout#" cfsqltype="varchar">
            WHERE movieId = <cfqueryparam value="#arguments.editMovieId#" cfsqltype="integer">;

            <cfloop list="#arguments.editGenres#" index="i">
                <cfquery name="qryToInsertGenres">
                    INSERT INTO MGMapping(movieid, genresid)
                        VALUES(
                            <cfqueryparam value="#arguments.editMovieId#" cfsqltype="integer">,
                            <cfqueryparam value="#i#" cfsqltype="integer">
                        )
                </cfquery>
            </cfloop>
            <cfloop list="#arguments.editLanguage#" index="i">
                <cfquery name="qryToInsertLanguage">
                    INSERT INTO MLMapping(movieid, languageid)
                        VALUES(
                            <cfqueryparam value="#arguments.editMovieId#" cfsqltype="integer">,
                            <cfqueryparam value="#i#" cfsqltype="integer">
                        )
                </cfquery>
            </cfloop>
            <cfloop list="#arguments.editTheater#" index="i">
                <cfquery name="qryToInsertTheater">
                    INSERT INTO movietheater(movieid, theaterid)
                        VALUES(
                            <cfqueryparam value="#arguments.editMovieId#" cfsqltype="integer">,
                            <cfqueryparam value="#i#" cfsqltype="integer">
                        )
                </cfquery>
            </cfloop>
            <cfloop list="#arguments.editScreen#" index="i">
                <cfquery name="qryToInsertScreen">
                    INSERT INTO MSMapping(movieid, screenid)
                        VALUES(
                            <cfqueryparam value="#arguments.editMovieId#" cfsqltype="integer">,
                            <cfqueryparam value="#i#" cfsqltype="integer">
                        )
                </cfquery>
            </cfloop>          
            <cfloop list="#arguments.editCast#" index="i">
                <cfquery name="qryToInsertCast">
                    INSERT INTO MCMapping(movieid,castid,castNameInMovie)
                    VALUES(
                        <cfqueryparam value="#arguments.editMovieId#" cfsqltype="integer">,
                        <cfqueryparam value="#i#" cfsqltype="integer">,
                        <cfqueryparam value="Actor" cfsqltype="varchar">
                    )
                </cfquery>
            </cfloop>
        </cfquery>
        <cflocation url="movie_CRED.cfm">
        <!---<cfreturn 1>--->
    </cffunction>
</cfcomponent>