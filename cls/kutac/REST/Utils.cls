Class kutac.REST.Utils
{

ClassMethod getClasses() As %Status
{
	set sc = $$$OK
	
	set namespace = $namespace
	zn "%SYS"
	
	set Rset = ##class(%Library.ResultSet).%New("%Monitor.ItemGroup:Classes")
	set Rset.RuntimeMode=1
	do Rset.Execute()
	
	set tObj = ##class(%ZEN.proxyObject).%New()
	set tObj.classes = ##class(%ListOfDataTypes).%New()
	
	while (Rset.Next()) {
		set tSubObj = ##class(%ZEN.proxyObject).%New()
		set tSubObj.name = Rset.GetData(1)
		set tSubObj.checked = Rset.GetData(2)
		do tObj.classes.Insert(tSubObj)
	}
	
	do tObj.%ToJSON()
	
	zn namespace
	
	quit sc
}

ClassMethod toggleClass(classname, check) As %Status
{
	set sc = $$$OK
	
	set namespace = $namespace
	zn "%SYS"
	
	do ##class(%Monitor.ItemGroup).MetricsClassItemGroup(classname,.id)
	
	set class=##class(%Monitor.ItemGroup).%OpenId(id)
	set class.Activated = check
	set sc = class.%Save()
	
	zn namespace
	
	quit sc
}

ClassMethod checkMon() As %Status
{
	set sc = $$$OK
	
	set namespace = $namespace
	zn "%SYS"
	
	set tObj = ##class(%ZEN.proxyObject).%New()
	set tObj.runned = ##class(%SYS.Monitor).State()
	
	do tObj.%ToJSON()
	
	zn namespace
	
	quit sc
}

ClassMethod toggleMon(toggle) As %Status
{
	set sc = $$$OK
	
	set namespace = $namespace
	zn "%SYS"
	if toggle {
		set sc = ##class(%SYS.Monitor).Start()
	} else {
		set sc = ##class(%SYS.Monitor).Stop()
	}
	
	quit:(sc = 0) $$$ERROR($$$GeneralError,$ZE)
	
	zn namespace
	
	quit sc
}

ClassMethod getEmailSettings() As %Status
{
	set (sc1) = $$$OK
	
	set namespace = $namespace
	zn "%SYS"
	set sslList = ##class(%ListOfDataTypes).%New()
	
	/*Get list of SSL Configurations*/
	set rs=##class(%Library.ResultSet).%New("Security.SSLConfigs:List")
	set sc1=rs.Execute()
	
	while rs.Next() {
		do sslList.Insert(rs.Data("Name"))
	}
	do rs.Close()
	
	/*Get status of Email notification*/
	set enable = ##class(%Monitor.Manager).AppEnableEmail()
	
	/*Get sender Email*/
	set email = ##class(%Monitor.Manager).AppEmailSender()
	
	/*Get server settings*/
	set server = ##class(%Monitor.Manager).AppSmtpServer(,.port,.ssl,.usetls)
	
	/*Get auth settings*/
	set username = ##class(%Monitor.Manager).AppSmtpUserName()
	
	set tObj = ##class(%ZEN.proxyObject).%New()
	set tObj."ssl_list" = sslList
	set tObj.ssl = ssl
	set tObj.enabled = enable
	set tObj.server = server
	set tObj.port = port
	set tObj.usetls = usetls
	set tObj.email = email
	set tObj.username = username	
	do tObj.%ToJSON()
	
	zn namespace
	
	set sc = $$$ADDSC(sc1,$$$OK)
	quit sc
}

ClassMethod setEmailSettings(obj As %ZEN.proxyObject) As %Status
{
	set sc = $$$OK
	set port = obj.port
	set ssl = obj.ssl
	set usetls = obj.usetls
	
	set namespace = $namespace
	zn "%SYS"
	
	/*Set sender Email*/
	do ##class(%Monitor.Manager).AppEmailSender(obj.email)
	
	/*Set server settings*/
	do ##class(%Monitor.Manager).AppSmtpServer(obj.server,.port,.ssl,.usetls)
	
	/*If auth info changed*/
	if (obj."auth_changed" & obj.auth) {
		/*Set auth settings*/
		do ##class(%Monitor.Manager).AppSmtpUserName(obj.username)
		do ##class(%Monitor.Manager).AppSmtpPassword(obj.password)
	}
	
	/*Without auth*/
	if 'obj.auth {
		/*Set auth settings*/
		do ##class(%Monitor.Manager).AppSmtpUserName("")
		do ##class(%Monitor.Manager).AppSmtpPassword("")
	}
	
	set enable = ##class(%Monitor.Manager).AppEnableEmail()
	set email = ##class(%Monitor.Manager).AppEmailSender()
	set server = ##class(%Monitor.Manager).AppSmtpServer(,.port)
	
	set tObj = ##class(%ZEN.proxyObject).%New()
	if ((enable = 1) && (email '= "") && (server '= "") && (port '= "")) {set tObj.registered = 1}
	else {set tObj.registered = 0}
	do tObj.%ToJSON()
	
	zn namespace
	
	quit sc
}

ClassMethod toggleEmail(toggle)
{
	set sc = $$$OK
	
	set namespace = $namespace
	zn "%SYS"
	
	/*Set status of Email notification*/
	do ##class(%Monitor.Manager).AppNotify(toggle)
	do ##class(%Monitor.Manager).AppEnableEmail(toggle)
	
	set enable = ##class(%Monitor.Manager).AppEnableEmail()
	set email = ##class(%Monitor.Manager).AppEmailSender()
	set server = ##class(%Monitor.Manager).AppSmtpServer(,.port)
	
	
	set tObj = ##class(%ZEN.proxyObject).%New()
	if ((enable = 1) && (email '= "") && (server '= "") && (port '= "")) {set tObj.registered = 1}
	else {set tObj.registered = 0}
	do tObj.%ToJSON()
	
	zn namespace
	
	quit sc
}

ClassMethod addRecipient(rec)
{
	set (sc1) = $$$OK
	
	set namespace = $namespace
	zn "%SYS"
	
	set rl=##class(%Monitor.Manager).AppRecipients()
	set rl=rl_$listbuild(rec)
	do ##class(%Monitor.Manager).AppRecipients(rl)
	
	zn namespace
	
	set sc = $$$ADDSC(sc1,$$$OK)
	quit sc
}

ClassMethod deleteRecipient(rec)
{
	set (sc1) = $$$OK
	
	set namespace = $namespace
	zn "%SYS"
	
	set rl=##class(%Monitor.Manager).AppRecipients()
	set ll = $listlength(rl)
	
	set ind=$listfind(rl,rec)
	quit:ind=0 $$$ERROR($$$GeneralError,"Email address not found in list")
	
 	if ind=1 {
 		if ll=1 set newlist=""
		else  set newlist=$list(rl,ind+1,$listlength(rl))
  	} elseif ind=ll {
	  	set newlist=$list(rl,1,ll-1)
  	} else {
    	set newlist=$list(rl,1,ind-1)_$list(rl,ind+1,$listlength(rl))
  	}
  	
 	do ##class(%Monitor.Manager).AppRecipients(newlist)
	
	zn namespace
	
	set sc = $$$ADDSC(sc1,$$$OK)
	quit sc
}

ClassMethod testMail()
{
	set (sc1) = $$$OK
	
	set namespace = $namespace
	zn "%SYS"
	
	s email = ##class(%SYS.Monitor.Email).%New()
	s email.Msg.Subject = "Cache %Monitor Email Test"
	d email.Msg.TextData.WriteLine("Your Cache Monitor Email test was successful")
	s sc1 = email.Mailer.Send(email.Msg)
	
	zn namespace
	
	set sc = $$$ADDSC(sc1,$$$OK)
	quit sc
}

ClassMethod getRecipients()
{
	set (sc1) = $$$OK
	
	set namespace = $namespace
	zn "%SYS"
	set recipients = ##class(%ListOfDataTypes).%New()
	
	set rl=##class(%Monitor.Manager).AppRecipients()
 	for i=1:1:$listlength(rl) do recipients.Insert($list(rl,i))
	set tObj = ##class(%ZEN.proxyObject).%New()
	set tObj.recipients = recipients
	do tObj.%ToJSON()
	
	zn namespace
	
	set sc = $$$ADDSC(sc1,$$$OK)
	quit sc
}

}

