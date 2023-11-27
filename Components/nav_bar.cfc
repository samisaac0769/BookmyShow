<cfcomponent>
    <cffunction  name="signup" access="remote" returntype="any">
        <cfargument  name="loginNumber">
        <cfquery name="checkLogin">
            SELECT *FROM userTable WHERE phone = <cfqueryparam value="#arguments.loginNumber#" cf_query_type="">
        </cfquery>
        
        
    </cffunction>
</cfcomponent>