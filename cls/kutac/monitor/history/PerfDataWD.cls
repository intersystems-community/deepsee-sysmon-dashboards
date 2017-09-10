Class kutac.monitor.history.PerfDataWD Extends %DeepSee.DataConnector
{

Parameter SUPPORTSIDLIST = 1;

XData SourceQuery [ XMLNamespace = "http://www.intersystems.com/deepsee/connector/query" ]
{
<sql>SELECT wd.*,d.datetime FROM SYS_History.PerfData_WD wd, SYS_History.PerfData d WHERE wd.PerfData = d.id</sql>
}

XData Output [ XMLNamespace = "http://www.intersystems.com/deepsee/connector/output" ]
{
<connector>
<property name="%ID" sourceProperty="ID" displayName="Record ID" />
<property name="mTS" sourceProperty="DateTime" type="%TimeStamp" displayName="Measurement DateTime"/>
<property name="WDBufferRedirty" sourceProperty="WD_BufferRedirty" type="%Numeric" description="No. of database buffers written during the cycle that were also written in the priort cycle"/>
<property name="WDBufferWrite" sourceProperty="WD_BufferWrite" type="%Numeric" description="Number of database buffers written during the cycle"/>
<property name="WDCycleTime" sourceProperty="WD_CycleTime" type="%Numeric" description="Time (in milliseconds) for the Write Daemon cycle to complete"/>
<property name="WDprocInGlobal" sourceProperty="WD_ProcInGlobal" type="%Numeric" description="Number of processes actively holding global buffers at the start of the cycle"/>
<property name="WDSizeWrite" sourceProperty="WD_SizeWrite" type="%Numeric" description="The size of database buffers (in KB) written during the cycle"/>
<property name="WDSleep" sourceProperty="WD_Sleep" type="%Numeric" description="Time (in milliseconds) that the Write Daemon was inactive before this cycle began"/>
<property name="WDStartTime" sourceProperty="WD_StartTime" type="%TimeStamp" description="Time that this Write Daemon cycle began"/>
<property name="WDStatusFlags" sourceProperty="WD_StatusFlags" type="%Numeric" description=""/>
<property name="WDTempQueue" sourceProperty="WD_TempQueue" type="%Numeric" description="Number of 'in-memory' (i.e. CacheTemp) buffers used at the start of the cycle"/>
<property name="WDTempWrite" sourceProperty="WD_TempWrite" type="%Numeric" description="Number of 'in-memory' buffers written during the cycle (typically none written)"/>
<property name="WDWIJTime" sourceProperty="WD_WIJTime" type="%Numeric" description="Time (in milliseconds) that the Write Daemon was writing the Write Image Journal (WIJ) file"/>
<property name="WDWriteTime" sourceProperty="WD_WriteTime" type="%Numeric" description="Time (in milliseconds) that the Write Daemon was writing buffers to the database(s)"/>
</connector>
}

}

