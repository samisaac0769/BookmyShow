<cfcomponent>
    <cffunction  name="getMovieById" returntype="query">
        <cfargument  name="movieId">
        <cfquery name="qryMovieDetails">
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
        <cfreturn qryMovieDetails>
    </cffunction>

    <cffunction  name="getCast" returntype="query">
        <cfargument  name="movieId">
        <cfquery name="qryGetCast">
        SELECT
            mc.castname,
            mc.castImage,
            mcm.castNameInMovie
        FROM
            moviecast mc
        JOIN
            mcmapping mcm ON mc.castId = mcm.castId
        WHERE
            mcm.movieId =  <cfqueryparam value="#arguments.movieId#" CFSQLType ="CF_SQL_INTEGER">;
        </cfquery>
        <cfreturn qryGetCast>
    </cffunction>
</cfcomponent>