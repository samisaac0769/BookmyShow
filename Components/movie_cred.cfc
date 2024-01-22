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
    
</cfcomponent>