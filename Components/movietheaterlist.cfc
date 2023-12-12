<cfcomponent>
    <cffunction  name="getTheaterByMovieId">
        <cfargument  name="movieId">
        <cfquery>
        SELECT
            t.TheaterName,
            STRING_AGG(CONVERT(VARCHAR, tt.timing), ', ') WITHIN GROUP (ORDER BY tt.timing) AS TheaterTimings
        FROM
            movielist ml
        JOIN
            movietheater mt ON ml.movieId = mt.movieId
        JOIN
            Theaters t ON mt.theaterid = t.theaterId
        JOIN
            theatertiming tt ON t.theaterId = tt.theaterId
        WHERE
            ml.movieId = <cfqueryparam value="#arguments.movieId#" CFSQLType ="CF_SQL_INTEGER">;
        GROUP BY
            t.TheaterName;

        </cfquery>
    </cffunction>
</cfcomponent>