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
            <cfset session.userid = "#qryUserDetails.userid#">
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

    <cffunction name="signInWithMail" access="remote">
		<cfset clientID ="40215559594-e2h9dfq5lmvc1hhkqlpu6muk10cv4jf6.apps.googleusercontent.com">
		<cfset clientSecret ="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">
		<cfset redirectURI ="http://127.0.0.1:8500/BookmyShow/firstpage.cfm">
		<cfset authURL ="https://accounts.google.com/o/oauth2/auth">
		<cfset responseType ="code">		
		<cfset scope ="https://www.googleapis.com/auth/userinfo.email https://www.googleapis.com/auth/userinfo.profile">
		<cfset local.url="#authURL#?client_id=#clientID#&redirect_uri=#redirectURI#&scope=#scope#&response_type=#responseType#">
		<cfset session.clientID=clientID>
        <cfset session.clientSecret=clientSecret>
        <cfset session.redirectURI=redirectURI>
        <cfreturn local.url>
	</cffunction>

    <cffunction name="getGoogleUserInfo" access="remote">
        <cfargument name="code" required="true">    
        <cfhttp url="https://accounts.google.com/o/oauth2/token" method="post">
            <cfhttpparam type="url" name="code" value="#code#">
            <cfhttpparam type="url" name="client_id" value="#session.clientID#">
            <cfhttpparam type="url" name="client_secret" value="#session.clientSecret#">
            <cfhttpparam type="url" name="redirect_uri" value="#session.redirectURI#">
            <cfhttpparam type="url" name="grant_type" value="authorization_code">
        </cfhttp>

        <cfset accessToken = deserializeJSON(cfhttp.filecontent).access_token>    
        <cfhttp url="https://www.googleapis.com/oauth2/v1/userinfo" method="get">
            <cfhttpparam type="url" name="access_token" value="#accessToken#">
        </cfhttp>            
        <cfset local.userInfo = deserializeJSON(cfhttp.filecontent)> 
        
        <cfset local.name = local.userInfo.name>
        <cfset local.email = local.userInfo.email>

        <cfquery name="checkUserExistbyMail">
            SELECT userId,roleid FROM userTable WHERE email = <cfqueryparam value="#local.email#" cfsqltype="VARCHAR">
        </cfquery>
        
        <cfif checkUserExistbyMail.recordcount eq 0>
            <cfquery name="insertUserFromMail" result="insertResult">
                INSERT INTO userTable(fullname, email,roleid)
                VALUES(
                    <cfqueryparam value="#local.name#" cfsqltype="VARCHAR">,
                    <cfqueryparam value="#local.email#" cfsqltype="VARCHAR">,
                    <cfqueryparam value="1" cfsqltype="integer">
                )
            </cfquery>
            <cfset session.userid = insertResult.GENERATEDKEY>
            <cfset session.userDetail = local.name>
            <cfset session.login = 1>
        <cfelse>
            <cfset session.userid = checkUserExistbyMail.userId>
            <cfset session.userDetail = local.name>
            <cfset session.login = checkUserExistbyMail.roleId>
        </cfif>

        <cflocation url="firstpage.cfm">

    </cffunction>
</cfcomponent>