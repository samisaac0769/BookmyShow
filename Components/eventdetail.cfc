<cfcomponent>
    <cffunction  name="getEventDetailById" access="public" returntype="query">
        <cfargument  name="eventid">
        <cfquery name="qryGetEventDetailById">
            SELECT 
                fullEventList.*,
                movieLanguages.Languages,
                eventCatagery.catagery
            FROM 
                fullEventList
            JOIN 
                movieLanguages ON fullEventList.langid = movieLanguages.languageid
            JOIN 
                eventCatagery ON fullEventList.cataId = eventCatagery.cataId
            WHERE 
                fullEventList.eventid = <cfqueryparam value="#arguments.eventid#" cfsqltype="integer">;
        </cfquery>
        <cfreturn qryGetEventDetailById>
    </cffunction>
</cfcomponent>