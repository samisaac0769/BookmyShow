<cfcomponent>
    <cffunction  name="getTheaterByMovieId" returntype="query" access="remote">
        <cfargument  name="id">
        <cfargument  name="date">
        <cfquery name="qryGetTheaterByMovieId">
            SELECT
                t.theaterId,
                t.TheaterName,
                STRING_AGG(CONVERT(VARCHAR, tt.timing), ', ') AS TheaterTimings
            FROM
                movielist ml
            JOIN
                movietheater mt ON ml.movieId = mt.movieId
            JOIN
                Theaters t ON mt.theaterid = t.theaterId
            JOIN
                theatertiming tt ON t.theaterId = tt.theaterId
            WHERE
                ml.movieId = <cfqueryparam value="#arguments.id#" CFSQLType ="CF_SQL_INTEGER">
            GROUP BY
                t.theaterId,
                t.TheaterName;
        </cfquery>
        <cfreturn qryGetTheaterByMovieId>
    </cffunction>
</cfcomponent>