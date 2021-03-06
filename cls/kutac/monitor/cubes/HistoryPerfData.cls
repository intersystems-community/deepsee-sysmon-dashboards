/// 
Class kutac.monitor.cubes.HistoryPerfData Extends %DeepSee.CubeDefinition [ DependsOn = kutac.monitor.history.PerfData, ProcedureBlock ]
{

/// Cube definition from Architect.
XData Cube [ XMLNamespace = "http://www.intersystems.com/deepsee" ]
{
<cube xmlns="http://www.intersystems.com/deepsee" name="HistoryPerfData" displayName="HistoryPerfData" disabled="false" abstract="false" sourceClass="kutac.monitor.history.PerfData" countMeasureName="%COUNT" bucketSize="8" bitmapChunkInMemory="false" precompute="0" disableListingGroups="false">
  <dimension name="Measurement Date" disabled="false" hasAll="false" allCaption="All Measurement Date and Time" allDisplayName="Measurement Date and Time" sourceExpression="$zdth(%source.mTS,3)" type="time" calendar="gregorian" iKnowType="entity" hidden="false" showHierarchies="default">
    <hierarchy name="H1" disabled="false" hidden="false">
      <level name="Month" disabled="false" timeFunction="MonthYear" list="false" useDisplayValue="true" useAsFilter="true" hidden="false">
      </level>
      <level name="Day" disabled="false" timeFunction="DayNumber" list="false" useDisplayValue="true" useAsFilter="true" hidden="false">
      </level>
    </hierarchy>
  </dimension>
  <dimension name="Measurement Time" disabled="false" hasAll="false" allCaption="All TM" allDisplayName="TM" sourceExpression="$zdth(%source.mTS,3)" type="time" calendar="gregorian" iKnowType="entity" hidden="false" showHierarchies="default">
    <hierarchy name="H1" disabled="false" hidden="false">
      <level name="Hour" disabled="false" timeFunction="HourNumber" list="false" useDisplayValue="true" useAsFilter="true" hidden="false">
      </level>
      <level name="Minute" disabled="false" timeFunction="MinuteNumber" list="false" useDisplayValue="true" useAsFilter="true" hidden="false">
      </level>
    </hierarchy>
  </dimension>
  <dimension name="mTS" disabled="false" hasAll="false" allCaption="All mTS" allDisplayName="mTS" type="data" hidden="false" showHierarchies="default">
    <hierarchy name="H1" disabled="false" hidden="false">
      <level name="mTS" disabled="false" sourceExpression="%source.mTS" list="false" useDisplayValue="true" useAsFilter="true" hidden="false">
      </level>
    </hierarchy>
  </dimension>
  <measure name="PerfGloRef" disabled="false" sourceProperty="PerfGloRef" aggregate="AVG" type="integer" hidden="false" searchable="false" iKnowSource="string">
  </measure>
  <measure name="PerfGloRefRem" disabled="false" sourceProperty="PerfGloRefRem" aggregate="AVG" type="integer" hidden="false" searchable="false" iKnowSource="string">
  </measure>
  <measure name="PerfPhysReads" disabled="false" sourceProperty="PerfPhysReads" aggregate="AVG" type="integer" hidden="false" searchable="false">
  </measure>
  <measure name="PerfPhysWrite" disabled="false" sourceProperty="PerfPhysWrites" aggregate="AVG" type="integer" hidden="false" searchable="false">
  </measure>
  <measure name="PerfRtnCallLocal" disabled="false" sourceProperty="PerfRtnCallLocal" aggregate="AVG" type="integer" hidden="false" searchable="false">
  </measure>
  <measure name="PerfRtnCallRemote" disabled="false" sourceProperty="PerfRtnCallRemote" aggregate="AVG" type="integer" hidden="false" searchable="false">
  </measure>
  <measure name="PerfRtnLoad" disabled="false" sourceProperty="PerfRtnLoad" aggregate="AVG" type="integer" hidden="false" searchable="false">
  </measure>
  <measure name="PerfRtnLoadRem" disabled="false" sourceProperty="PerfRtnLoadRem" aggregate="AVG" type="integer" hidden="false" searchable="false">
  </measure>
  <measure name="PerfObjLoad" disabled="false" sourceProperty="PerfObjLoad" aggregate="AVG" type="integer" hidden="false" searchable="false">
  </measure>
  <measure name="PerfObjMiss" disabled="false" sourceProperty="PerfObjMiss" aggregate="AVG" type="integer" hidden="false" searchable="false">
  </measure>
  <measure name="PerfObjNew" disabled="false" sourceProperty="PerfObjNew" aggregate="AVG" type="integer" hidden="false" searchable="false">
  </measure>
  <measure name="PerfObjDel" disabled="false" sourceProperty="PerfObjDel" aggregate="AVG" type="integer" hidden="false" searchable="false">
  </measure>
  <measure name="PerfWIJWrites" disabled="false" sourceProperty="PerfWIJWrites" aggregate="AVG" type="integer" hidden="false" searchable="false">
  </measure>
  <measure name="PerfECPBlockPurgeBuff" disabled="false" sourceProperty="PerfECPBlockPurgeBuff" aggregate="AVG" type="integer" hidden="false" searchable="false">
  </measure>
  <measure name="PerfECPBlockPurgeSvr" disabled="false" sourceProperty="PerfECPBlockPurgeSvr" aggregate="AVG" type="integer" hidden="false" searchable="false">
  </measure>
  <measure name="PerfECPByteRcvd" disabled="false" sourceProperty="PerfECPByteRcvd" aggregate="AVG" type="integer" hidden="false" searchable="false">
  </measure>
  <measure name="PerfECPByteSent" disabled="false" sourceProperty="PerfECPByteSent" aggregate="AVG" type="integer" hidden="false" searchable="false">
  </measure>
  <measure name="PerfECPConn" disabled="false" sourceProperty="PerfECPConn" aggregate="AVG" type="integer" hidden="false" searchable="false">
  </measure>
  <measure name="PerfGloASeize" disabled="false" sourceProperty="PerfGloASeize" aggregate="AVG" type="integer" hidden="false" searchable="false">
  </measure>
  <measure name="PerfGloNSeize" disabled="false" sourceProperty="PerfGloNSeize" aggregate="AVG" type="integer" hidden="false" searchable="false">
  </measure>
  <measure name="PerfGloSeize" disabled="false" sourceProperty="PerfGloSeize" aggregate="AVG" type="integer" hidden="false" searchable="false">
  </measure>
  <measure name="PerfObjASeize" disabled="false" sourceProperty="PerfObjASeize" aggregate="AVG" type="integer" hidden="false" searchable="false">
  </measure>
  <measure name="PerfObjSeize" disabled="false" sourceProperty="PerfObjSeize" aggregate="AVG" type="integer" hidden="false" searchable="false">
  </measure>
  <measure name="PerfRtnASeize" disabled="false" sourceProperty="PerfRtnASeize" aggregate="AVG" type="integer" hidden="false" searchable="false">
  </measure>
  <measure name="PerfRtnSeize" disabled="false" sourceProperty="PerfRtnSeize" aggregate="AVG" type="integer" hidden="false" searchable="false">
  </measure>
  <measure name="PerfJrnBlock" disabled="false" sourceProperty="PerfJrnBlock" aggregate="AVG" type="integer" hidden="false" searchable="false">
  </measure>
  <measure name="PerfJrnEntry" disabled="false" sourceProperty="PerfJrnEntry" aggregate="AVG" type="integer" hidden="false" searchable="false">
  </measure>
  <measure name="PerfObjHit" disabled="false" sourceProperty="PerfObjHit" aggregate="AVG" type="integer" hidden="false" searchable="false">
  </measure>
  <calculatedMember name="Perf_PhysReads" displayName="Phys Reads" disabled="false" dimension="Measures" valueExpression="%KPI(&quot;CurrPerfData&quot;,&quot;PerfPhysReads&quot;,1)" formatString="#,#" hidden="false">
  </calculatedMember>
  <calculatedMember name="Perf_GloRef" displayName="Gloref Performance" disabled="false" dimension="Measures" valueExpression="%KPI(&quot;CurrPerfData&quot;,&quot;PerfGloRef&quot;,1)" formatString="#,#" hidden="false">
  </calculatedMember>
  <calculatedMember name="DateTime" disabled="false" dimension="Measures" valueExpression="%KPI(&quot;CurrPerfData&quot;,&quot;DateTime&quot;,1)" hidden="false">
  </calculatedMember>
  <calculatedMember name="ID" disabled="false" dimension="Measures" valueExpression="%KPI(&quot;CurrPerfData&quot;,&quot;ID&quot;,1)" hidden="false">
  </calculatedMember>
  <calculatedMember name="Perf_PhysWrites" displayName="Phys Writes" disabled="false" dimension="Measures" valueExpression="%KPI(&quot;CurrPerfData&quot;,&quot;PerfPhysWrites&quot;,1)" formatString="#,#" hidden="false">
  </calculatedMember>
  <calculatedMember name="Perf_WIJWrites" displayName="WIJ Writes" disabled="false" dimension="Measures" valueExpression="%KPI(&quot;CurrPerfData&quot;,&quot;PerfWIJWrites&quot;,1)" formatString="#,#" hidden="false">
  </calculatedMember>
  <calculatedMember name="Perf_RtnCallLocal" displayName="Routine Call Local" disabled="false" dimension="Measures" valueExpression="%KPI(&quot;CurrPerfData&quot;,&quot;PerfRtnCallLocal&quot;,1)" formatString="#,#" hidden="false">
  </calculatedMember>
  <calculatedMember name="Perf_RtnLoad" displayName="Routine Load" disabled="false" dimension="Measures" valueExpression="%KPI(&quot;CurrPerfData&quot;,&quot;PerfRtnLoad&quot;,1)" formatString="#,#" hidden="false">
  </calculatedMember>
  <calculatedMember name="Perf_ObjLoad" displayName="Objects Load" disabled="false" dimension="Measures" valueExpression="%KPI(&quot;CurrPerfData&quot;,&quot;PerfObjLoad&quot;,1)" formatString="#,#" hidden="false">
  </calculatedMember>
  <calculatedMember name="Perf_ObjNew" displayName="New Objects" disabled="false" dimension="Measures" valueExpression="%KPI(&quot;CurrPerfData&quot;,&quot;PerfObjNew&quot;,1)" formatString="#,#" hidden="false">
  </calculatedMember>
  <calculatedMember name="Perf_ObjMiss" displayName="Miss Objects" disabled="false" dimension="Measures" valueExpression="%KPI(&quot;CurrPerfData&quot;,&quot;PerfObjMiss&quot;,1)" formatString="#,#" hidden="false">
  </calculatedMember>
  <calculatedMember name="Perf_ObjDel" displayName="Deleted Objects" disabled="false" dimension="Measures" valueExpression="%KPI(&quot;CurrPerfData&quot;,&quot;PerfObjDel&quot;,1)" formatString="#,#" hidden="false">
  </calculatedMember>
  <calculatedMember name="Perf_ObjHit" displayName="Object Hit" disabled="false" dimension="Measures" valueExpression="%KPI(&quot;CurrPerfData&quot;,&quot;PerfObjHit&quot;,1)" formatString="#,#" hidden="false">
  </calculatedMember>
  <listing name="Details" disabled="false" listingType="table" fieldList="%ID,mDate,mTime,PerfGloRef">
  </listing>
</cube>
}

Parameter DOMAIN = "SYSMON";

}

