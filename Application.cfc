<cfcomponent>    
    <cfset this.name = "BookMyShow" /> 
    <cfset this.applicationTimeout = createTimeSpan(0, 2, 0, 0) /> 
    <cfset this.sessionManagement = true />  
    <cfset this.sessionTimeout = createTimeSpan(0, 0, 60, 0) /> 
    <cfset this.datasource = "BookMyShow" />
    <cfset this.ormenabled = true />
    <cfset this.ormsettings = {} />
    <cfset this.ormsettings.cfclocation = "Components" />
    <cfset this.ormsettings.dbcreate = "update" />
    
    
    <cffunction name="onApplicationStart" returntype="boolean">
        <cfset application.key = "Yk42vN81BMLbIjWZFpUsZw==">
        <cfreturn true>
    </cffunction>

    <cffunction name="onSessionStart">
        <cfset session.login = "">
    </cffunction>    

    

    <cffunction name="onRequestStart" access="public" returntype="boolean">
        <cfargument name="targetPage" type="string" required="false">
        
        <!--- Check if it's an AJAX request
        <cfif NOT IsAjaxRequest()>
            <cfif (!StructKeyExists(session, "login") || session.login EQ "") && arguments.targetPage NEQ '/BookmyShow/firstpage.cfm'>
                <cflocation url="firstpage.cfm">
            </cfif>
        </cfif> --->
        
        <cfreturn true>
    </cffunction>

    <cffunction name="IsAjaxRequest" access="public" returntype="boolean">
        <cfreturn StructKeyExists(getHttpRequestData().headers, "x-requested-with") 
        AND getHttpRequestData().headers["x-requested-with"] EQ "XMLHttpRequest">
    </cffunction>


    <cffunction name="onRequestEnd">  
    </cffunction>

    <cffunction name="onSessionEnd">
    </cffunction>

    <cffunction name="onApplicationEnd" > 
    </cffunction>
</cfcomponent>
