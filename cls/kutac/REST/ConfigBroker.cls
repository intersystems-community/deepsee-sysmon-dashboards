Import kutac.REST

Include %ZEN.Utils

Class kutac.REST.ConfigBroker Extends %CSP.REST
{

XData UrlMap
{
<Routes>
<Route Url="/classes" Method="GET" Call="getClasses"/>
<Route Url="/class" Method="POST" Call="toggleClass"/>
<Route Url="/mon" Method="GET" Call="checkMon"/>
<Route Url="/mon" Method="POST" Call="toggleMon"/>
<Route Url="/email" Method="GET" Call="getEmailSettings"/>
<Route Url="/email" Method="POST" Call="setEmailSettings"/>
<Route Url="/email_toggle" Method="POST" Call="toggleEmail"/>
<Route Url="/test_mail" Method="GET" Call="testMail"/>
<Route Url="/recipient" Method="GET" Call="getRecipients"/>
<Route Url="/recipient" Method="POST" Call="addRecipient"/>
<Route Url="/recipient" Method="DELETE" Call="deleteRecipient"/>
</Routes>
}

ClassMethod getClasses() As %Status
{
	quit ##class(Utils).getClasses()
}

ClassMethod toggleClass() As %Status
{
	do ..ConvertRequestBody()
	quit ##class(Utils).toggleClass(%request.Content.classname, %request.Content.check)
}

ClassMethod checkMon() As %Status
{
	quit ##class(Utils).checkMon()
}

ClassMethod toggleMon() As %Status
{
	do ..ConvertRequestBody()
	quit ##class(Utils).toggleMon(%request.Content.toggle)
}

ClassMethod getEmailSettings()
{
	quit ##class(kutac.REST.Utils).getEmailSettings()
}

ClassMethod setEmailSettings()
{
	do ..ConvertRequestBody()	
	set obj = %request.Content
	
	quit ##class(Utils).setEmailSettings(obj)
}

ClassMethod toggleEmail()
{
	do ..ConvertRequestBody()
	quit ##class(Utils).toggleEmail(%request.Content.toggle)
}

ClassMethod getRecipients()
{
	quit ##class(Utils).getRecipients()
}

ClassMethod addRecipient()
{
	do ..ConvertRequestBody()
	quit ##class(Utils).addRecipient(%request.Content.rec)
}

ClassMethod deleteRecipient()
{
	do ..ConvertRequestBody()
	quit ##class(Utils).deleteRecipient(%request.Content.rec)
}

ClassMethod testMail()
{
	quit ##class(Utils).testMail()
}

ClassMethod ConvertRequestBody() As %Status
{
	#dim %request As %CSP.Request
	#dim obj As %ZEN.proxyObject

	return:'$isobject(%request.Content) $$$OK //empty request body - nothing to do

	// Convert request body into UTF8 proxyObject
	set content = %request.Content.Read($$$MaxStringLength)
	set content = $ZCVT(content,"I","UTF8")
	set st = ##class(%ZEN.Auxiliary.jsonProvider).%ConvertJSONToObject(content,,.obj,1)
	return:$$$ISERR(st) st
	return:'$IsObject(obj) $$$ERROR($$$ArgumentIsNotAnObject,"Body")

	set %request.Content = obj // obj here is a valid UTF8 proxyObject with required property
	return $$$OK
}

/// Specifies the default character set for the page.  This can be overriden using the
/// &lt;CSP:CONTENT CHARSET=&gt; tag, or by setting the <b>%response</b>.CharSet property
/// in the <method>OnPreHTTP</method> method.  If this parameter is not specified, then
/// for the default charset is utf-8.
Parameter CHARSET = "UTF-8";

}

