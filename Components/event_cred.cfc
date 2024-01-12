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

    <cffunction  name="insertEventValue" access='remote' returntype="boolean">
        <cfargument default="" name="eventname">
        <cfargument default="" name="age">
        <cfargument default="" name="hour">
        <cfargument default="" name="fromdate">
        <cfargument default="" name="todate">
        <cfargument default="" name="price">
        <cfargument default="" name="venue" >
        <cfargument default="" name="about" >
        <cfargument default="" name="why" >
        <cfargument default="" name="catagery">
        <cfargument default="" name="language">
        <cfargument default="" name="time">
        <cfargument default="" name="fileuploadbg">
        <cfargument default="" name="fileuploadimg">

        <cfset local.eventname = trim(arguments.eventname)>
        <cfset local.venue = trim(arguments.venue)>

        <cfquery name="checkTheEventExist">
            SELECT *FROM fullEventList WHERE eventname = <cfqueryparam value="#local.eventname#" cfsqltype="varchar">
            AND venue = <cfqueryparam value="#arguments.venue#" cfsqltype="varchar">
        </cfquery>

        <cfif checkTheEventExist.recordcount>
            <cfreturn true>
        <cfelse>
            <cfset local.poster = ExpandPath("/BookmyShow/Assets/eventposter")>
            <cfset local.bgposter = ExpandPath("/BookmyShow/Assets/eventBGposter")>

            <cffile action = "upload" 
            fileField = "#arguments.fileuploadimg#" 
            destination = "#local.poster#"  
            nameConflict = "MakeUnique"
            allowedextensions=".jpg, .png, .jpeg">

            <cfset local.getPoster = cffile.clientFile>

            <cffile action = "upload" 
            fileField = "#arguments.fileuploadbg#" 
            destination = "#local.bgposter#"  
            nameConflict = "MakeUnique"
            allowedextensions=".jpg, .png, .jpeg">

            <cfset local.getBgPoster = cffile.clientFile>

            <cfquery name="qryInsertEventValue">
                INSERT INTO fullEventList(eventname,agelimit,eventposter,hours,fromdate,todate,price,venue,about,why,likes,eventbgposter,cataid,langid,time,status)
                VALUES (<cfqueryparam value="#arguments.eventname#" cfsqltype="varchar">,
                        <cfqueryparam value="#arguments.age#" cfsqltype="varchar">,
                        <cfqueryparam value="#local.getPoster#" cfsqltype="varchar">,
                        <cfqueryparam value="#arguments.hour#" cfsqltype="integer">,
                        <cfqueryparam value="#arguments.fromdate#" cfsqltype="date">,
                        <cfqueryparam value="#arguments.todate#" cfsqltype="date">,
                        <cfqueryparam value="#arguments.price#" cfsqltype="integer">,
                        <cfqueryparam value="#arguments.venue#" cfsqltype="varchar">,
                        <cfqueryparam value="#arguments.about#" cfsqltype="varchar">,
                        <cfqueryparam value="#arguments.why#" cfsqltype="varchar">,
                        <cfqueryparam value="2548" cfsqltype="integer">,
                        <cfqueryparam value="#local.getBgPoster#" cfsqltype="varchar">,
                        <cfqueryparam value="#arguments.catagery#" cfsqltype="integer">,
                        <cfqueryparam value="#arguments.language#" cfsqltype="integer">,
                        <cfqueryparam value="#arguments.time#" cfsqltype="time">,
                        <cfqueryparam value="True" cfsqltype="bit">
                    );
            </cfquery>
        </cfif>
        <cflocation  url="event_cred.cfm">
    </cffunction>  
    
    <cffunction  name="updateEventById" access="public">
        
        <cfargument default="" name="eventid">
        <cfargument default="" name="eventname">
        <cfargument default="" name="age">
        <cfargument default="" name="hour">
        <cfargument default="" name="fromdate">
        <cfargument default="" name="todate">
        <cfargument default="" name="price">
        <cfargument default="" name="venue" >
        <cfargument default="" name="about" >
        <cfargument default="" name="why" >
        <cfargument default="" name="catagery">
        <cfargument default="" name="language">
        <cfargument default="" name="time">



        <cfquery name="qryUpdateEventById">
            UPDATE fullEventList
            SET eventname = <cfqueryparam value="#arguments.eventname#" cfsqltype="varchar">,
                agelimit = <cfqueryparam value="#arguments.age#" cfsqltype="varchar">,
                hours = <cfqueryparam value="#arguments.hour#" cfsqltype="integer">,
                fromdate = <cfqueryparam value="#arguments.fromdate#" cfsqltype="date">,
                todate = <cfqueryparam value="#arguments.todate#" cfsqltype="date">,
                price = <cfqueryparam value="#arguments.price#" cfsqltype="integer">,
                venue = <cfqueryparam value="#arguments.venue#" cfsqltype="varchar">,
                about = <cfqueryparam value="#arguments.about#" cfsqltype="varchar">,
                why = <cfqueryparam value="#arguments.why#" cfsqltype="varchar">,
                cataid = <cfqueryparam value="#arguments.catagery#" cfsqltype="integer">,
                langid = <cfqueryparam value="#arguments.language#" cfsqltype="integer">,
                time = <cfqueryparam value="#arguments.time#" cfsqltype="time">
            WHERE eventId = <cfqueryparam value="#arguments.eventid#" cfsqltype="integer">;
        </cfquery>
        <cflocation  url="event_cred.cfm">
    </cffunction> 

    <cffunction  name="getAlllanguage" accrss="public" returntype="query">
        <cfquery name='qryGetAlllanguage'>
            SELECT *FROM movieLanguages
        </cfquery>
        <cfreturn qryGetAlllanguage>
    </cffunction>

    <cffunction  name="getAllCatagery" accrss="public" returntype="query">
        <cfquery name='qryGetAllCatagery'>
            SELECT *FROM eventCatagery
        </cfquery>
        <cfreturn qryGetAllCatagery>
    </cffunction>

</cfcomponent>