/// 
Class kutac.monitor.cubes.CurrentSysDataDB Extends %DeepSee.CubeDefinition [ DependsOn = kutac.monitor.current.SysDataDB, ProcedureBlock ]
{

Parameter DOMAIN = "SYSMON";

/// Cube definition from Architect.
XData Cube [ XMLNamespace = "http://www.intersystems.com/deepsee" ]
{
<cube xmlns="http://www.intersystems.com/deepsee" name="CurrentSysDataDB" displayName="CurrentSysDataDB" disabled="false" abstract="false" sourceClass="kutac.monitor.current.SysDataDB" countMeasureName="%COUNT" bucketSize="8" bitmapChunkInMemory="false" precompute="0">
  <dimension name="DB Name" disabled="false" hasAll="false" allCaption="All DB Name" allDisplayName="DB Name" type="data" hidden="false" showHierarchies="default">
    <hierarchy name="H1" disabled="false">
      <level sourceProperty="Name" name="DB Name" disabled="false" list="false" useDisplayValue="true" useAsFilter="true">
      </level>
    </hierarchy>
  </dimension>
  <measure sourceProperty="FileSize" name="DB File Size" disabled="false" aggregate="SUM" type="integer" hidden="false" searchable="false"></measure>
  <measure sourceProperty="FreeSpace" name="DB Free Space" disabled="false" aggregate="SUM" type="integer" hidden="false" searchable="false"></measure>
</cube>
}

}

