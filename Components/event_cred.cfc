<cfcomponent>
    <cffunction name="getAllEventForAdmin" access="public" returntype="query">
        <cfquery name="qryeventList">
            SELECT
                el.eventid,el.eventname,el.eventposter,el.fromdate,el.venue,el.price,ec.catagery
            FROM
                fullEventList el
            JOIN
                eventCatagery ec ON ec.cataid = el.cataid
            WHERE
                status = <cfqueryparam value="true" cfsqltype="bit"> 
            GROUP BY
                el.eventid, el.eventname, el.eventposter, el.fromdate, el.venue, el.price, ec.catagery
            ORDER BY
                el.eventId DESC;
        </cfquery>
        <cfreturn qryeventList>
    </cffunction>

    <cffunction  name="getEventDetailById" access="remote" returntype="query">
        <cfargument  name="eventId">
        <cfquery name="qryGetEventByIdForAdmin">
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
                fullEventList.eventid = <cfqueryparam value="#arguments.eventId#" cfsqltype="integer">;
        </cfquery>
        <cfreturn qryGetEventByIdForAdmin>
    </cffunction>

    <cffunction name="deleteEventById" returntype="string" access="remote">
        <cfargument  name="eventId">
        <cfquery name="deleteEventById">
            UPDATE fullEventList
            SET status = 0
            WHERE eventid = <cfqueryparam value="#arguments.eventId#" cfsqltype="integer">;
        </cfquery>
        <cfreturn "true">
    </cffunction>
</cfcomponent>