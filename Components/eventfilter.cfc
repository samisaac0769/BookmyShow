<cfcomponent>
    <cffunction  name="allLanguage" returntype="query">
        <cfquery name="qryAllLanguage">
            SELECT *FROM movieLanguages
        </cfquery>
        <cfreturn qryAllLanguage>
    </cffunction>
    
    <cffunction  name="allEventCatagery" returntype="query">
        <cfquery name="qryallEventCatagery">
            SELECT *FROM eventCatagery
        </cfquery>
        <cfreturn qryallEventCatagery>
    </cffunction>

    <cffunction name="filter" returntype="query" access="remote">
        <cfargument name="date">
        <cfargument name="language">
        <cfargument name="catagery">

        <cfquery name="qryFilterEventList">
            SELECT
                el.eventid, el.eventname, el.eventposter, el.fromdate, el.venue, el.price, ec.catagery
            FROM
                fullEventList el
            JOIN
                eventCatagery ec ON ec.cataid = el.cataid
            WHERE 1=1
            <cfif arguments.language neq "" >
                AND el.langid = <cfqueryparam value="#arguments.language#" cfsqltype="integer">
            </cfif>
            <cfif arguments.catagery neq "" >
                AND el.cataid = <cfqueryparam value="#arguments.catagery#" cfsqltype="integer">
            </cfif>
            GROUP BY
                el.eventid, el.eventname, el.eventposter, el.fromdate, el.venue, el.price, ec.catagery
            ORDER BY
                el.eventId DESC;
        </cfquery>  
        <cfreturn qryFilterEventList>
    </cffunction>

</cfcomponent>