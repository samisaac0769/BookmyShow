<cfcomponent>    
    <cfset this.name = "BookMyShow"> 
    <cfset this.applicationTimeout = createTimeSpan(0, 0, 10, 0)> 
    <cfset this.sessionManagement = true> 
    <cfset this.sessionTimeout = createTimeSpan(0, 0, 30, 0)> 
    <cfset this.datasource = "BookMyShow">
    
    <cffunction name="onApplicationStart">
    </cffunction>

    <cffunction name="onSessionStart">
        <cfset session.login = "">
    </cffunction>    

    <cffunction name="onRequestStart">
    </cffunction>

    <cffunction name="onRequestEnd">  
    </cffunction>

    <cffunction name="onSessionEnd">
    </cffunction>

    <cffunction name="onApplicationEnd" > 
    </cffunction>
</cfcomponent>
