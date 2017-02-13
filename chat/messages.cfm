<cfsetting enablecfoutputonly="true" />
<cfcontent type="text/event-stream" reset="true" />
<cfset ret = { "channel":"", "error":false, "message":"", "sender":"" } />
<cfset id = 1 />
<cfif not StructKeyExists(URL,"ClientID")>
  <cfset ret.error = "true" />
  <cfset ret.message = "Invalid Client ID" />
  <cfset pkt = "id: #id#"&chr(10)&"data: "&SerializeJSON(ret)&Chr(10) />
  <cfoutput>#pkt##Chr(10)#</cfoutput>
  <cfset id = id + 1/>
  <cfabort />
</cfif>

<cfif not StructKeyExists(Application.Clients, url.clientID)>
  <cfset Application.Clients[url.clientID] = createobject("java", "java.util.concurrent.LinkedBlockingQueue").init() />
  <cfset Application.rooms["general"][URL.ClientID] = Application.Clients[url.clientID] />
</cfif>
<cfset q = Application.Clients[url.clientID] />

<cfset ret.message="Hello #URL.ClientID#" />
<cfset pkt = "id: #id#"&chr(10)&"data: "&SerializeJSON(ret)&Chr(10) />
<cfoutput>#pkt##Chr(10)#</cfoutput>
<cfset id = id + 1/>
<cfflush />

<cfset ret.message="Starting to listen for client #URL.ClientID#" />
<cfset pkt = "id: #id#"&chr(10)&"data: "&SerializeJSON(ret)&Chr(10) />
<cfoutput>#pkt##Chr(10)#</cfoutput>
<cfset id = id + 1/>
<cfflush />

<cfloop condition="1 is 1">
  <cfset msg = q.take() />
  <cfset pkt = "id: #id#"&chr(10)&"data: "&SerializeJSON(msg)&Chr(10) />
  <cfoutput>#pkt##Chr(10)#</cfoutput>
  <cfset id = id + 1/>
  <cfflush />
</cfloop>

