Class kutac.monitor.history.SysDataDB Extends %DeepSee.DataConnector
{

Parameter SUPPORTSIDLIST = 1;

XData SourceQuery [ XMLNamespace = "http://www.intersystems.com/deepsee/connector/query" ]
{
<sql>SELECT db.*,d.datetime FROM SYS_History.SysData_DB db,SYS_History.SysData d WHERE db.SysData = d.id order by datetime desc</sql>
}

XData Output [ XMLNamespace = "http://www.intersystems.com/deepsee/connector/output" ]
{
<connector>
<property name="%ID" sourceProperty="ID" description="Record ID" />
<property name="mTS" sourceProperty="DateTime" type="%TimeStamp" description="Measurement DateTime"/>
<property name="Name" sourceProperty="element_key" type="%String" description="Database name"/>
<property name="FileSize" sourceProperty="DB_FileSize" type="%Numeric" description="Database file size (in MB)"/>
<property name="FreeSpace" sourceProperty="DB_FreeSpace" type="%Numeric" description="Database free space (in MB)"/>
</connector>
}

}

