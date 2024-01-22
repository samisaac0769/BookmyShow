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
</cfcomponent>