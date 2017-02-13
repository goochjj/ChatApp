<cfsetting enablecfoutputonly="true" />
<cfset ret = { "channel":"", "error":false, "message":"", "sender":"" } />
<cfif not StructKeyExists(FORM,"ClientID")>
  <cfset ret.error = "true" />
  <cfset ret.message = "Invalid Client ID" />
  <cfcontent type="application/json" reset="true" />
  <cfoutput>#SerializeJSON(ret)#</cfoutput>
  <cfabort />
</cfif>

<cfif not StructKeyExists(Application.rooms, FORM.room)>
  <cfset ret.error = "true" />
  <cfset ret.message = "Invalid Room" />
  <cfcontent type="application/json" reset="true" />
  <cfoutput>#SerializeJSON(ret)#</cfoutput>
  <cfabort />
</cfif>

<cfset msg = { channel=FORM.ROOM, sender=FORM.ClientID, message=FORM.message, sentts=now() } />
<cfset room = Application.rooms[FORM.ROOM] />
<!--- Broadcast to all clients --->
<cfloop item="key" collection="#room#">
  <cfset room[key].offer(msg) />
</cfloop>

<cfset ret.message = "Message Sent" />
<cfcontent type="application/json" reset="true" />
<cfoutput>#SerializeJSON(ret)#</cfoutput>
<cfabort />

