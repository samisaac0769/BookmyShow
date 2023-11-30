<cfcomponent>
    <cffunction  name="signup" access="remote" returntype="any">
        <cfargument  name="loginNumber">

        <cfquery name="qryCheckUserExist">
            SELECT userId FROM userTable WHERE phone = <cfqueryparam value="#arguments.loginNumber#" cfsqltype="CF_SQL_VARCHAR">
        </cfquery>

        <cfif queryRecordCount(qryCheckUserExist)>
            <!-- User exists, retrieve details -->
            <cfquery name="qryUserDetails">
                SELECT * FROM userTable WHERE phone = <cfqueryparam value="#arguments.loginNumber#" cfsqltype="CF_SQL_VARCHAR">
            </cfquery>
            

            <cfset session.loginid = "#qryUserDetails.userId#">
            
            <cfreturn true>
        <cfelse>
            <!-- User does not exist, insert user details -->
            <cfquery name="qryInsertUserDetails">
                INSERT INTO userTable (phone) VALUES (<cfqueryparam value="#arguments.loginNumber#" cfsqltype="CF_SQL_VARCHAR">)
            </cfquery>
            <!-- Retrieve the newly inserted user details, including the user ID -->
            <cfquery name="qryAndGetUserId">
                SELECT userId FROM userTable WHERE phone = <cfqueryparam value="#arguments.loginNumber#" cfsqltype="CF_SQL_VARCHAR">
            </cfquery>

            <cfset session.loginid = "#qryAndGetUserId.userId#">
            
            <cfreturn true>
        </cfif>
        
    </cffunction>
</cfcomponent>