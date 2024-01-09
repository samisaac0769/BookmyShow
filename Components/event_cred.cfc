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

    <cffunction  name="insertEventValue" access='public' >
       
        <cfargument name="eventname" type="string">
        <cfargument name="age" type="string">
        <cfargument name="hour" type="integer">
        <cfargument name="fromdate" type="date">
        <cfargument name="todate" type="date">
        <cfargument name="price" type="integer">
        <cfargument name="venue" type="string">
        <cfargument name="about" type="string">
        <cfargument name="why" type="string">
        <cfargument name="catagery" type="integer">
        <cfargument name="language" type="integer">
        <cfargument name="time" type="date">
        <cfargument name="likes" type="integer">
        <cfargument name="status" type="boolean">
        <cfargument name="fileuploadbg" type="string">
        <cfargument name="fileuploadimg" type="string">
        
      
                 
         
        
         <cflocation  url="event_cred.cfm">
        
    </cffunction>   
</cfcomponent>