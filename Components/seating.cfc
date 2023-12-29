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

    <cffunction  name="ticketBooking" access="remote" returntype="boolean" >
        <cfargument  name="movieId">
        <cfargument  name="theaterId">
        <cfargument  name="selectedDate">
        <cfargument  name="selectedTime">
        <cfargument  name="seats">
        <cfargument  name="totalcost">
        <cfset local.userid = session.userid>


        <cfset selectedSeatsStruct = deserializeJSON(arguments.seats)>

        <cfset local.seatList = "">

        <cfloop item="seatKey" collection="#selectedSeatsStruct#">
            <cfset local.seatList = listAppend(local.seatList, seatKey)>
        </cfloop>

        <cfquery name="qryMovieBooking">
            INSERT INTO MovieBooking (userid,movieid,theaterid,date,time,totalprice,Selectedseats)
            VALUES (<cfqueryparam value="#local.userid#" cfsqltype="integer">,
                    <cfqueryparam value="#arguments.movieId#" cfsqltype="integer">,
                    <cfqueryparam value="#arguments.theaterId#" cfsqltype="integer">,
                    <cfqueryparam value="#arguments.selectedDate#" cfsqltype="date">,
                    <cfqueryparam value="#arguments.selectedTime#" cfsqltype="time">,
                    <cfqueryparam value="#arguments.totalcost#" cfsqltype="integer">,
                    <cfqueryparam value="#local.seatList#" cfsqltype="varchar">)
        </cfquery>
        
        <cfreturn true>
    </cffunction>

    <cffunction  name="getBookedSeats" access="public" returntype="query">
        <cfargument  name="movieId">
        <cfargument  name="theaterId">
        <cfargument  name="selectedDate">
        <cfargument  name="selectedTime">
        
        <cfquery name="qryGetBookedSeats">
            SELECT STRING_AGG(SelectedSeats, ',') AS bookedSeats
            FROM MovieBooking
            WHERE movieid = '#arguments.movieid#'
            AND theaterid = '#arguments.theaterId#'
            AND date = '#arguments.selectedDate#'
            AND time = '#arguments.selectedTime#';
        </cfquery>

        <cfreturn qryGetBookedSeats>
    </cffunction>
</cfcomponent>