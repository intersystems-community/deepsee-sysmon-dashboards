/// 
Class kutac.monitor.cubes.HistorySysDataDB Extends %DeepSee.CubeDefinition [ DependsOn = kutac.monitor.current.SysDataDB, ProcedureBlock ]
{

Parameter DOMAIN = "SYSMON";

/// Cube definition from Architect.
XData Cube [ XMLNamespace = "http://www.intersystems.com/deepsee" ]
{
<cube xmlns="http://www.intersystems.com/deepsee" name="HistorySysDataDB" displayName="HistorySysDataDB" disabled="false" abstract="false" sourceClass="kutac.monitor.history.SysDataDB" countMeasureName="%COUNT" bucketSize="8" bitmapChunkInMemory="false" precompute="0">
  <dimension name="DB Name" disabled="false" hasAll="false" allCaption="All DB Name" allDisplayName="DB Name" type="data" hidden="false" showHierarchies="default">
    <hierarchy name="H1" disabled="false">
      <level sourceProperty="Name" name="DB Name" disabled="false" list="false" useDisplayValue="true" useAsFilter="true">
      </level>
    </hierarchy>
  </dimension>
  <dimension name="Measurement Date" disabled="false" hasAll="false" allCaption="All Measurement Date and Time" allDisplayName="Measurement Date and Time" sourceExpression="$zdth(%source.mTS,3)" type="time" iKnowType="entity" hidden="false" showHierarchies="default">
    <hierarchy name="H1" disabled="false">
      <level name="Month" disabled="false" timeFunction="MonthYear" list="false" useDisplayValue="true" useAsFilter="true">
      </level>
      <level name="Day" disabled="false" timeFunction="DayNumber" list="false" useDisplayValue="true" useAsFilter="true">
      </level>
    </hierarchy>
  </dimension>
  <dimension name="Measurement Time" disabled="false" hasAll="false" allCaption="All TM" allDisplayName="TM" sourceExpression="$zdth(%source.mTS,3)" type="time" iKnowType="entity" hidden="false" showHierarchies="default">
    <hierarchy name="H1" disabled="false">
      <level name="Hour" disabled="false" timeFunction="HourNumber" list="false" useDisplayValue="true" useAsFilter="true">
      </level>
      <level name="Minute" disabled="false" timeFunction="MinuteNumber" list="false" useDisplayValue="true" useAsFilter="true">
      </level>
    </hierarchy>
  </dimension>
  <measure sourceProperty="FileSize" name="DB File Size (MAX)" disabled="false" aggregate="MAX" type="integer" hidden="false" searchable="false"></measure>
  <measure sourceProperty="FreeSpace" name="DB Free Space (MIN)" disabled="false" aggregate="MIN" type="integer" hidden="false" searchable="false"></measure>
</cube>
}

}

