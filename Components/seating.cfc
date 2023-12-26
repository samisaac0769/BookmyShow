<cfcomponent>
    <cffunction  name="getTheaterById" access="public" returntype="query">
        <cfargument  name="theaterId">

        <cfquery name="qryGetTheaterById">
            SELECT  *FROM 
                Theaters
            WHERE 
                theaterId = <cfqueryparam value="#arguments.theaterId#" cfsqltype="integer">
        </cfquery>
        <cfreturn qryGetTheaterById>
    </cffunction>

    <cffunction  name="dateFormate" access="public" returntype="any">
        <cfargument  name="date">
        <cfset local.formattedDate = DateTimeFormat(arguments.date,"eeee")&", " & Day(arguments.date) & " " & DateTimeFormat(arguments.date,"mmm")>
        <cfreturn local.formattedDate>
    </cffunction>

    <cffunction  name="seatings" access="public" returntype="query">
        <cfquery name="qrySeating">
            SELECT *FROM seatingcatagery
        </cfquery>
        <cfreturn qrySeating>
    </cffunction>

    <cffunction  name="ticketBooking" access="remote" returntype="any" >
        <cfargument  name="movieId">
        <cfargument  name="theaterId">
        <cfargument  name="selectedDate">
        <cfargument  name="selectedTime">
        <cfargument  name="seats">

        <cfset local.userid = session.userid>
        <cfreturn local.userid>
    </cffunction>
</cfcomponent>