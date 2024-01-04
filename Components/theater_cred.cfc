<cfcomponent>
    <cffunction name="theaterList" access="public" returntype="query" >
        <cfquery name="qryTheaterList">
            SELECT *FROM theaters WHERE STATUS = <cfqueryparam value="true" cfsqltype="bit"> ;
        </cfquery>
        <cfreturn qryTheaterList>
    </cffunction>

    <cffunction name="deleteTheaterById" returntype="string" access="remote">
        <cfargument  name="theaterId">
        <cfquery name="deleteEventById">
            UPDATE theaters
            SET status = 0
            WHERE theaterid = <cfqueryparam value="#arguments.theaterId#" cfsqltype="integer">;
        </cfquery>
        <cfreturn "true">
    </cffunction>
</cfcomponent>