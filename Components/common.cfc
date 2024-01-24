<cfcomponent>
    <cffunction  name="getLanguage" access="remote" returntype="query">
        <cfquery name="qryGetLanguage">
            SELECT *FROM movieLanguages
        </cfquery>
        <cfreturn qryGetLanguage>
    </cffunction>

    <cffunction  name="getGeneres" access="remote" returntype="query">
        <cfquery name="qryGetGeneres">
            SELECT *FROM movieGenresList
        </cfquery>
        <cfreturn qryGetGeneres>
    </cffunction>

    <cffunction  name="getTheater" access="remote" returntype="query">
        <cfquery name="qryGetTheater">
            SELECT theaterid, theatername FROM theaters where status = <cfqueryparam value="true" cfsqltype="bit">
        </cfquery>
        <cfreturn qryGetTheater>
    </cffunction>

    <cffunction  name="getScreens" access="remote" returntype="query">
        <cfquery name="qryGetScreens">
            SELECT *FROM moviescreen
        </cfquery>
        <cfreturn qryGetScreens>
    </cffunction>

    <cffunction  name="getCast" access="remote" returntype="query">
        <cfquery name="qryGetScreens">
            SELECT castid, castname FROM movieCast
        </cfquery>
        <cfreturn qryGetScreens>
    </cffunction>
</cfcomponent>