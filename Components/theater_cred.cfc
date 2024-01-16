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

    <cffunction name="insertTheater" access="remote" returntype="boolean">
        <cfargument  name="theatername">
        <cfargument  name="location">
        <cfargument  name="address">
        <cfargument  name="showTimes">

        <cfset local.theaterName = trim(arguments.theatername)>
        <cfset local.location = trim(arguments.location)> 
        
        <cfquery name="qryCheckTheaterExist">
            SELECT theaterid FROM Theaters
            WHERE TheaterName = <cfqueryparam value="#local.theaterName#" cfsqltype="varchar">
            <!---AND location = <cfqueryparam value="#local.location#" cfsqltype="varchar">--->
        </cfquery>
        <cfif qryCheckTheaterExist.recordcount>
            <cfreturn false>
        <cfelse>
            <cfquery name="qryInsertTheater" result="insertResult">
                INSERT INTO Theaters (TheaterName,location,address,status)
                VALUES(
                    <cfqueryparam value="#local.theaterName#" cfsqltype="varchar">,
                    <cfqueryparam value="#local.location#" cfsqltype="varchar">,
                    <cfqueryparam value="#arguments.address#" cfsqltype="varchar">,
                    <cfqueryparam value="True" cfsqltype="bit">
                )
            </cfquery>
            <cfset local.newTheaterId =insertResult.GENERATEDKEY>
            <cfdump var="#local.newTheaterId#">
            <cfif len(trim(local.newTheaterId))>
                <cfloop list="#arguments.showTimes#" index="i">
                    <cfquery name="qryInsertShowTimes">
                    INSERT INTO theatertiming(theaterId, timing)
                    VALUES(
                        <cfqueryparam value="#local.newTheaterId#" cfsqltype="integer">,
                        <cfqueryparam value="#i#" cfsqltype="cf_sql_time">
                    )
                </cfquery>
                </cfloop>
            </cfif>
            <cfreturn true>
        </cfif>
        
    </cffunction>

    <cffunction name="updateTheater" access="remote" returntype="boolean">
        <cfargument  name="theaterId">
        <cfargument  name="theatername">
        <cfargument  name="location">
        <cfargument  name="address">
        <cfquery name="qryUpdateTheater">
            UPDATE Theaters 
            SET theatername = <cfqueryparam value="#arguments.theaterName#" cfsqltype="varchar">, 
                location = <cfqueryparam value="#arguments.location#" cfsqltype="varchar">, 
                address = <cfqueryparam value="#arguments.address#" cfsqltype="varchar">
            WHERE theaterid = <cfqueryparam value="#arguments.theaterId#" cfsqltype="integer">
        </cfquery>
        <cfreturn true>
    </cffunction>
</cfcomponent>