<cfcomponent>
    <cffunction  name="login" access="remote" returntype="string">
        <cfargument  name="loginNumber">

        <cfquery name="qryCheckUserExist">
            SELECT userId FROM userTable WHERE phone = <cfqueryparam value="#arguments.loginNumber#" cfsqltype="CF_SQL_VARCHAR">
        </cfquery>

        <cfif queryRecordCount(qryCheckUserExist)>
            <cfquery name="qryUserDetails">
                SELECT * FROM userTable WHERE phone = <cfqueryparam value="#arguments.loginNumber#" cfsqltype="CF_SQL_VARCHAR">
            </cfquery>
            
            <cfset session.login = "#qryUserDetails.roleid#">
            <cfset session.userDetail = "#qryUserDetails.fullName#">
            <cfreturn "true">
        <cfelse>
            <cfreturn "false">
        </cfif>
    </cffunction>

    <cffunction  name="signIn" access="remote" returntype="boolean">
        <cfargument  name="userName">       
        <cfargument  name="phoneNo">
        <cfargument  name="emailId">
        <cfargument  name="roleId">

        <cfquery name="qryCheckUser">
            SELECT userid FROM userTable WHERE phone = <cfqueryparam value="#arguments.phoneNo#" cfsqltype="CF_SQL_VARCHAR">
        </cfquery>

        <cfif qryCheckUser.recordCount>
            <cfset local.result = true>
        <cfelse>
            <cfquery name="qrySignInInsert">
                INSERT INTO userTable (fullname, email, phone, roleid)
                VALUES (
                    <cfqueryparam value="#arguments.userName#" cfsqltype="CF_SQL_VARCHAR">,
                    <cfqueryparam value="#arguments.emailId#" cfsqltype="CF_SQL_VARCHAR">,
                    <cfqueryparam value="#arguments.phoneNo#" cfsqltype="CF_SQL_VARCHAR">,
                    <cfqueryparam value="#arguments.roleId#" cfsqltype="CF_SQL_INTEGER">
                )
            </cfquery>
            <cfset local.result = false>
        </cfif>
        <cfreturn local.result>
    </cffunction>
</cfcomponent>