Class kutac.monitor.current.SysData Extends %DeepSee.KPI
{

Parameter DOMAIN = "SYSMON";

Parameter RESOURCE;

/// This XData definition defines the KPI.
XData KPI [ XMLNamespace = "http://www.intersystems.com/deepsee/kpi" ]
{
<kpi xmlns="http://www.intersystems.com/deepsee/kpi"
 name="CurrSysData" sourceType="manual"
 caption="Current System Data"
>
<property columnNo="1" name="ID" />
<property columnNo="2" name="DateTime" />
<property columnNo="3" name="SysCPUIdle" />
<property columnNo="4" name="SysCPUKernel" />
<property columnNo="5" name="SysCPUUser" />
<property columnNo="6" name="SysLicUsedDist" />
<property columnNo="7" name="SysLicUsedLocal" />
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
	set pSQL = "SELECT top 1 ID, DateTime, Sys_CPUIdle, Sys_CPUKernel, Sys_CPUUser, Sys_LicUsedDist "_
				"FROM SYS_History.SysData order by DateTime Desc"
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

/// Get data for this KPI manually.
/// This is implemented by subclasses that provide manual data.
Method %OnExecute() As %Status
{
	Set tSC = $$$OK
	Try {
		&sql(SELECT top 1 ID, DateTime, Sys_CPUIdle, Sys_CPUKernel, Sys_CPUUser, Sys_LicUsedDist
				INTO :ID, :DateTime, :SysCPUIdle, :SysCPUKernel, :SysCPUUser, :SysLicUsedDist
				FROM SYS_History.SysData
				ORDER BY DateTime DESC)
		set ..%data(1,"ID") = ID
		set ..%data(1,"DateTime") = DateTime
		set ..%data(1,"SysCPUIdle") = SysCPUIdle
		set ..%data(1,"SysCPUKernel") = SysCPUKernel
		set ..%data(1,"SysCPUUser") = SysCPUUser
		set ..%data(1,"SysLicUsedDist") = SysLicUsedDist
		set ..%data(1,"SysLicUsedLocal") = $system.License.GetUserLimit()
	}
	Catch(ex) {
		Set tSC = ex.AsStatus()
	}
	Quit tSC
}

}

