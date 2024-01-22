
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
</head>
<body>
<cfoutput>
        <cfset users = entityLoad("userlist") />
        <div style="display:flex; flex-direction:row; flex-wrap:wrap; width:100%"> 
            <cfloop array="#users#" index="user">
                <cfoutput>
                    <div style="padding: 10px">
                        <p>User ID: #user.getuserid()#</p>
                        <p>Full Name: #user.getfullname()#</p>
                        <p>Email: #user.getemail()#</p>
                        <p>Phone: #user.getphone()#</p>
                        <p>DOB: #user.getDOB()#</p>
                        <p>Address: #user.getaddress()#</p>

                    </div>
                </cfoutput>
            </cfloop>
        </div>
        <button type="button">get detail</button>

    <form action="sample.cfm" method="post">
        <input type="text" name="name" >
        <input type="text" name="address">
        <input type="text" name="phone">
        <input type="text" name="mail">
        <input type="date" name="dater">
        <button name="addbtn" type="submit">submit</button>
    </form>
    <cfif structKeyExists(form, "addbtn") && len(trim(form.name)) gt 0 >
        <cfset user = entityNew("userlist") />

        <!-- Use the correct casing for setFullname method -->
        <cfset user.setFullname(form.name)>
        <cfset user.setAddress(form.address)>
        <cfset user.setPhone(form.phone)>
        <cfset user.setEmail(form.mail)>
        <cfset user.setDOB(form.dater)>

        <cfset entitySave(user)>
        <cflocation  url="sample.cfm">
    <cfelse>
        <p>no data</p>
    </cfif>
    

</cfoutput>






    

</body>
</html>