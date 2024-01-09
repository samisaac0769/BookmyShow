<cfcomponent>
    <cffunction name="theaterList" access="public" returntype="query" >
        <cfquery name="qryTheaterList">
            SELECT *FROM theaters WHERE STATUS = <cfqueryparam value="true" cfsqltype="bit"> ;
        </cfquery>
        <cfreturn qryTheaterList>
    </cffunction>

    <cffunction name="deleteTheaterById" returntype="string" access="remote">
        <cfargument  name="theaterId">
        <cfquery name="qryDeleteEventById">
            UPDATE theaters
            SET status = 0
            WHERE theaterid = <cfqueryparam value="#arguments.theaterId#" cfsqltype="integer">;
        </cfquery>
        <cfreturn "true">
    </cffunction>

    <cffunction  name="getTheaterById" access="remote" returntype="query">
        <cfargument  name="theaterId">
        <cfquery name="qryGetTheaterById">
            SELECT th.*, 
                (SELECT 
                    STRING_AGG(CONVERT(varchar(MAX), TT.timing), ', ')
                FROM 
                    theatertiming AS TT
                WHERE 
                    th.theaterid = TT.theaterId
                ) AS theaterTimings
            FROM 
                theaters AS th
            WHERE 
                th.theaterid = <cfqueryparam value="#arguments.theaterId#" cfsqltype="integer">;
        </cfquery>
        <cfreturn qryGetTheaterById>
    </cffunction>
</cfcomponent>