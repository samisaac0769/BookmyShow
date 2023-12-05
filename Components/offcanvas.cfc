<cfcomponent>
    <cffunction name="logout" access="remote" returntype="boolean">
        <cfset session.login = "">
        <cfreturn true>
    </cffunction>
</cfcomponent>