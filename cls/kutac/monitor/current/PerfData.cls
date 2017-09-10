/// kutac.monitor.current.PerfData
Class kutac.monitor.current.PerfData Extends %DeepSee.KPI
{

Parameter DOMAIN = "SYSMON";

Parameter RESOURCE;

/// This XData definition defines the KPI.
XData KPI [ XMLNamespace = "http://www.intersystems.com/deepsee/kpi" ]
{
<kpi xmlns="http://www.intersystems.com/deepsee/kpi"
 name="CurrPerfData" sourceType="sql"
 caption="Current Performance Data"
>
<property columnNo="1" name="ID" />
<property columnNo="2" name="DateTime" />
<property columnNo="3" name="PerfGloRef" />
<property columnNo="4" name="PerfPhysReads" />
<property columnNo="5" name="PerfPhysWrites" />
<property columnNo="6" name="PerfObjHit" />
<property columnNo="7" name="PerfObjDel" />
<property columnNo="8" name="PerfObjMiss" />
<property columnNo="9" name="PerfObjNew" />
<property columnNo="10" name="PerfObjLoad" />
<property columnNo="11" name="PerfRtnLoad" />
<property columnNo="12" name="PerfRtnCallLocal" />
<property columnNo="13" name="PerfWIJWrites" />
</kpi>
}

/// Notification that this KPI is being executed.
/// This is a good place to override properties, such as range and threshold.
Method %OnLoadKPI() As %Status
{
	Quit $$$OK
}

/// Return an SQL statement to execute.
Method %OnGetSQL(ByRef pSQL As %String) As %Status
{
	set pSQL = "SELECT top 1 ID, DateTime, Perf_GloRef, Perf_PhysReads, Perf_PhysWrites, Perf_ObjHit, Perf_ObjDel, Perf_ObjMiss, Perf_ObjNew,"_
	" Perf_ObjLoad, Perf_RtnLoad, Perf_RtnCallLocal, Perf_WIJWrites FROM SYS_History.PerfData order by DateTime Desc"
	Quit $$$OK
}

/// This callback is invoked from a dashboard when an action defined by this dashboard is invoked.
ClassMethod %OnDashboardAction(pAction As %String, pContext As %ZEN.proxyObject) As %Status
{
	// pAction is the name of the action (as defined in the XML list).
	// pContext contains information from the client
	// and can be used to return information.
	Quit $$$OK
}

}

