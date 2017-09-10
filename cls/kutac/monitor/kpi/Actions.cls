/// kutac.monitor.kpi.Actions
Class kutac.monitor.kpi.Actions Extends %DeepSee.KPI
{

Parameter DOMAIN = "SYSMON";

Parameter RESOURCE;

/// This XData definition defines the KPI.
XData KPI [ XMLNamespace = "http://www.intersystems.com/deepsee/kpi" ]
{
<kpi xmlns="http://www.intersystems.com/deepsee/kpi"
 name="SYSMON Actions" sourceType="manual">
 
 <property name="Monitor" displayName="System Monitor" columnNo="1" />
 <property name="Sensors" displayName="System Sensors" columnNo="2" />
 <property name="AppMonSensor" displayName="Application Monitor Sensor" columnNo="3" />
 <property name="HealthControl" displayName="Health Control" columnNo="4" />
 <property name="Subscriber" displayName="System Subscriber" columnNo="5" />
 <property name="LastCubeBuildTime" displayName="Last Cubes Build Time" columnNo="6" />
 <property name="LastCubeBuildStatus" displayName="Last Cubes Build Status" columnNo="7" />
 
 <action name="SyncCubes" />
 
</kpi>
}

/// Notification that this KPI is being executed.
/// This is a good place to override properties, such as range and threshold.
Method %OnLoadKPI() As %Status
{
	Quit $$$OK
}

/// Return an MDX statement to execute.
Method %OnGetSQL(ByRef pSQL As %String) As %Status
{
	
	Quit $$$OK
}

/// This callback is invoked from a dashboard when an action defined by this dashboard is invoked.
ClassMethod %OnDashboardAction(pAction As %String, pContext As %ZEN.proxyObject) As %Status
{
	// pAction is the name of the action (as defined in the XML list).
	// pContext contains information from the client
	// and can be used to return information.
	s tSC=$$$OK
	try {
		if pAction="SyncCubes" {
			set tTask=##class(kutac.monitor.task.Builder).%New()
			$$$THROWONERROR(tSC,tTask.OnTask())
		}
	} catch (e) {
		set tSC=$$$ADDSC(tSC,e.AsStatus())	
	}
	Quit tSC
}

/// Get data for this KPI manually.
/// This is implemented by subclasses that provide manual data.
Method %OnExecute() As %Status
{
	Set tSC = $$$OK
	#define D1	"|"
	#define D2 "^"
	Try {
		set ..%seriesCount=1
		set ..%seriesNames(1)="State Info"
		set tState=##class(%SYS.Monitor).State()
		set i=1 s ..%data(1,"Monitor")=$p($p(tState,$$$D2,i),$$$D1,2)
		set i=2 s ..%data(1,"Sensors")=$p($p(tState,$$$D2,i),$$$D1,2)
		set i=3 s ..%data(1,"AppMonSensor")=$s($p($p(tState,$$$D2,i),$$$D1,2)=" ":"none",1:$p($p(tState,$$$D2,i),$$$D1,2))
		set i=4 s ..%data(1,"HealthControl")=$p($p(tState,$$$D2,i),$$$D1,2)
		set i=5 s ..%data(1,"Subscriber")=$p($p(tState,$$$D2,i),$$$D1,2)
		set i=6 s ..%data(1,"LastCubeBuildTime")=$s($lg(^kutac("SYSMON","LastCubeBuild"))="":"n/a",1:$zdt($lg(^kutac("SYSMON","LastCubeBuild"),2)))
		set i=7 s ..%data(1,"LastCubeBuildStatus")=$lg(^kutac("SYSMON","LastCubeBuild"),1)
	}
	Catch(ex) {
		Set tSC = ex.AsStatus()
	}
	Quit tSC
}

}

