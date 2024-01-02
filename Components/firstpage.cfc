<cfcomponent>
    <cffunction  name="mainPageMovieList" returntype="query">
        <cfquery name="qrymainPageMovieList">
            SELECT TOP 5
                ml.movieId,
                ml.moviename,
                ml.movieposter,
                ml.rating,
                ml.votings,
                STRING_AGG(mg.moviegenres, ', ') AS moviegenres
            FROM
                movielist ml
            JOIN
                MGMapping mgm ON ml.movieId = mgm.movieid
            JOIN
                movieGenresList mg ON mgm.genresid = mg.genresId
            GROUP BY
                ml.movieId, ml.moviename, ml.movieposter, ml.rating, ml.votings
            ORDER BY
                ml.movieId DESC; 
        </cfquery>
        <cfreturn qrymainPageMovieList>
    </cffunction>

    <cffunction  name="mainPageEventList" returntype="query">
        <cfquery name="qrymainPageEventList">
            SELECT TOP 5 el.eventid,el.eventname,el.eventposter,el.fromdate,el.venue,el.price,ec.catagery
            FROM
                fullEventList el
            JOIN
                eventCatagery ec ON ec.cataid = el.cataid
            GROUP BY
                el.eventid, el.eventname, el.eventposter, el.fromdate, el.venue, el.price, ec.catagery
            ORDER BY
                el.eventId DESC;
        </cfquery>
        <cfreturn qrymainPageEventList>
    </cffunction>

    <cffunction  name="movieList" returntype="query">
        <cfquery name="qrymovieList">
            SELECT
                ml.movieId,
                ml.moviename,
                ml.movieposter,
                ml.rating,
                ml.votings,
                STRING_AGG(mg.moviegenres, ', ') AS moviegenres
            FROM
                movielist ml
            JOIN
                MGMapping mgm ON ml.movieId = mgm.movieid
            JOIN
                movieGenresList mg ON mgm.genresid = mg.genresId
            GROUP BY
                ml.movieId, ml.moviename, ml.movieposter, ml.rating, ml.votings
            ORDER BY
                ml.movieId DESC;
        </cfquery>
        <cfreturn qrymovieList>
    </cffunction>

    <cffunction  name="eventList" returntype="query">
        <cfargument  name="date" default="">
        <cfargument  name="language"  default="">
        <cfargument  name="catagery"  default="">

        <cfquery name="qryeventList">
            SELECT
                el.eventid,el.eventname,el.eventposter,el.fromdate,el.venue,el.price,ec.catagery
            FROM
                fullEventList el
            JOIN
                eventCatagery ec ON ec.cataid = el.cataid
            GROUP BY
                el.eventid, el.eventname, el.eventposter, el.fromdate, el.venue, el.price, ec.catagery
            ORDER BY
                el.eventId DESC;
        </cfquery>
        
        <cfreturn qryeventList>
    </cffunction>


</cfcomponent>