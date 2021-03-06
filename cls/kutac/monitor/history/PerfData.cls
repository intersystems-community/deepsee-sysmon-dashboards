Class kutac.monitor.history.PerfData Extends %DeepSee.DataConnector
{

Parameter SUPPORTSIDLIST = 1;

XData SourceQuery [ XMLNamespace = "http://www.intersystems.com/deepsee/connector/query" ]
{
<sql>SELECT * FROM SYS_History.PerfData</sql>
}

XData Output [ XMLNamespace = "http://www.intersystems.com/deepsee/connector/output" ]
{
<connector>
<property name="%ID" sourceProperty="ID" description="Record ID" />
<property name="mTS" sourceProperty="DateTime" type="%TimeStamp" description="Measurement DateTime"/>
<property name="PerfGloRef" sourceProperty="Perf_GloRef" type="%Numeric" description="Global - local references"/>
<property name="PerfGloUpdate" sourceProperty="Perf_GloUpdate" type="%Numeric" description="Global - local updates (set / kill)"/>
<property name="PerfGloRefRem" sourceProperty="Perf_GloRefRem" type="%Numeric" description="Global - remote references"/>
<property name="PerfGloUpdateRem" sourceProperty="Perf_GloUpdateRem" type="%Numeric" description="Global - remote updates (set / kill)"/>
<property name="PerfPhysReads" sourceProperty="Perf_PhysReads" type="%Numeric" description="Global - physical reads" />
<property name="PerfPhysWrites" sourceProperty="Perf_PhysWrites" type="%Numeric" description="Global - physical writes"/>
<property name="PerfLogReads" sourceProperty="Perf_LogReads" type="%Numeric" description="Logical database reads"/>

<property name="PerfRtnCallLocal" sourceProperty="Perf_RtnCallLocal" type="%Numeric" description="Routines - local calls"/>
<property name="PerfRtnCallRemote" sourceProperty="Perf_RtnCallRemote" type="%Numeric" description="Routines - remote calls"/>
<property name="PerfRtnLoad" sourceProperty="Perf_RtnLoad" type="%Numeric" description="Routines - local loads and saves to disc"/>
<property name="PerfRtnLoadRem" sourceProperty="Perf_RtnLoadRem" type="%Numeric" description="Routines - remote loads and saves to disc"/>

<property name="PerfWIJWrites" sourceProperty="Perf_WIJWrites" type="%Numeric" description="WIJ - physical block writes"/>

<property name="PerfObjLoad" sourceProperty="Perf_ObjLoad" type="%Numeric" description="Object loaded from disc"/>
<property name="PerfObjHit" sourceProperty="Perf_ObjHit" type="%Numeric" description="Object references (found in memory)"/>
<property name="PerfObjMiss" sourceProperty="Perf_ObjMiss" type="%Numeric" description="Object references (not in memory)"/>
<property name="PerfObjNew" sourceProperty="Perf_ObjNew" type="%Numeric" description="Object initialized"/>
<property name="PerfObjDel" sourceProperty="Perf_ObjDel" type="%Numeric" description="Object deleted"/>

<property name="PerfECPBlockAdd" sourceProperty="Perf_ECPBlockAdd" type="%Numeric" description="ECP - block added to cache"/>
<property name="PerfECPBlockPurgeBuff" sourceProperty="Perf_ECPBlockPurgeBuff" type="%Numeric" description="ECP - block purged from buffer"/>
<property name="PerfECPBlockPurgeSvr" sourceProperty="Perf_ECPBlockPurgeSvr" type="%Numeric" description="ECP - block rurge by server request"/>
<property name="PerfECPByteRcvd" sourceProperty="Perf_ECPByteRcvd" type="%Numeric" description="ECP - bytes received"/>
<property name="PerfECPByteSent" sourceProperty="Perf_ECPByteSent" type="%Numeric" description="ECP - bytes sent"/>
<property name="PerfECPConn" sourceProperty="Perf_ECPConn" type="%Numeric" description="ECP - active connections"/>

<property name="PerfGloASeize" sourceProperty="Perf_GloASeize" type="%Numeric" description="Seize A - Globals"/>
<property name="PerfGloNSeize" sourceProperty="Perf_GloNSeize" type="%Numeric" description="Seize N - Globals"/>
<property name="PerfGloSeize" sourceProperty="Perf_GloSeize" type="%Numeric" description="Seize - Globals"/>
<property name="PerfObjASeize" sourceProperty="Perf_ObjASeize" type="%Numeric" description="Seize A - Objects"/>
<property name="PerfObjSeize" sourceProperty="Perf_ObjSeize" type="%Numeric" description="Seize - Objects"/>
<property name="PerfRtnASeize" sourceProperty="Perf_RtnASeize" type="%Numeric" description="Seize A - Routines"/>
<property name="PerfRtnSeize" sourceProperty="Perf_RtnSeize" type="%Numeric" description="Seize - Routines"/>

<property name="PerfJrnBlock" sourceProperty="Perf_JrnBlock" type="%Numeric" description="Journal - blocks written to disc"/>
<property name="PerfJrnEntry" sourceProperty="Perf_JrnEntry" type="%Numeric" description="Journal - number of entries created"/>
</connector>
}

}

