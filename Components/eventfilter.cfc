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
            DECLARE @FrmDt DATETIME
            SELECT @FrmDt = <cfqueryparam value="#arguments.date#" cfsqltype="date">

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
            <cfif arguments.date neq "" >
                AND (@FrmDt BETWEEN el.fromdate AND el.todate)
            </cfif>
            GROUP BY
                el.eventid, el.eventname, el.eventposter, el.fromdate, el.venue, el.price, ec.catagery
            ORDER BY
                el.eventId DESC;
        </cfquery>  
        <cfreturn qryFilterEventList>
    </cffunction>
    
    <cffunction name="search" access="remote" returntype="string">
        <cfargument name="searchword" default="">

        <cfquery name="qrySearchMovie">
            SELECT movieid from movielist Where moviename  = <cfqueryparam value="#arguments.searchword#" cfsqltype="varchar">
        </cfquery>
        <cfif qrySearchMovie.recordcount gt 0>
            <cfset local.movieid = qrySearchMovie.movieid>
            <cfset local.encryptedMovieId= encrypt(local.movieid,application.key,'AES', 'Base64')>
            <cfset local.encryptedMovieId = replace(local.encryptedMovieId, "+", "!", "all")>
            <cfset local.encryptedMovieId = replace(local.encryptedMovieId, "\", "@", "all")>--->
            <cfset local.redirectURL = "moviedetailpage.cfm?id=#local.encryptedMovieId#">
            <cfreturn local.redirectURL>
        </cfif>

        <cfquery name="qrySearchEvent">
            SELECT eventid from fullEventList Where eventname  = <cfqueryparam value="#arguments.searchword#" cfsqltype="varchar">
        </cfquery>
        <cfif qrySearchEvent.recordcount gt 0>
            <cfset local.eventid = qrySearchEvent.eventid>
            <cfset local.encryptedeventId= encrypt(local.eventid,application.key,'AES', 'Base64')>
            <cfset local.encryptedeventId = replace(local.encryptedeventId, "+", "!", "all")>
            <cfset local.encryptedeventId = replace(local.encryptedeventId, "\", "@", "all")>--->
            <cfset local.redirectURL = "eventDetailpage.cfm?id=#local.encryptedeventId#">
            <cfreturn local.redirectURL>
        </cfif>

    </cffunction>

</cfcomponent>