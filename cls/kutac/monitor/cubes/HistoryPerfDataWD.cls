/// 
Class kutac.monitor.cubes.HistoryPerfDataWD Extends %DeepSee.CubeDefinition [ DependsOn = kutac.monitor.history.PerfDataWD, ProcedureBlock ]
{

/// Cube definition from Architect.
XData Cube [ XMLNamespace = "http://www.intersystems.com/deepsee" ]
{
<cube xmlns="http://www.intersystems.com/deepsee" name="HistoryPerfDataWD" displayName="HistoryPerfDataWD" disabled="false" abstract="false" sourceClass="kutac.monitor.history.PerfDataWD" countMeasureName="%COUNT" bucketSize="8" bitmapChunkInMemory="false" precompute="0" disableListingGroups="false">
  <dimension name="WDStatusFlags" disabled="false" hasAll="false" allCaption="All WDStatusFlags" allDisplayName="WDStatusFlags" type="data" hidden="false" showHierarchies="default">
    <hierarchy name="H1" disabled="false" hidden="false">
      <level name="WDStatusFlags" disabled="false" sourceProperty="WDStatusFlags" list="false" useDisplayValue="true" useAsFilter="true" hidden="false">
      </level>
    </hierarchy>
  </dimension>
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
  <measure name="WDBufferRedirty" disabled="false" sourceProperty="WDBufferRedirty" aggregate="AVG" type="number" hidden="false" searchable="false">
  </measure>
  <measure name="WDBufferWrite" disabled="false" sourceProperty="WDBufferWrite" aggregate="AVG" type="number" hidden="false" searchable="false">
  </measure>
  <measure name="WDCycleTime" disabled="false" sourceProperty="WDCycleTime" aggregate="AVG" type="number" hidden="false" searchable="false">
  </measure>
  <measure name="WDprocInGlobal" disabled="false" sourceProperty="WDprocInGlobal" aggregate="AVG" type="number" hidden="false" searchable="false">
  </measure>
  <measure name="WDSizeWrite" disabled="false" sourceProperty="WDSizeWrite" aggregate="AVG" type="integer" hidden="false" searchable="false">
  </measure>
  <measure name="WDSleep" disabled="false" sourceProperty="WDSleep" aggregate="AVG" type="integer" hidden="false" searchable="false">
  </measure>
  <measure name="WDTempQueue" disabled="false" sourceProperty="WDTempQueue" aggregate="AVG" type="number" hidden="false" searchable="false">
  </measure>
  <measure name="WDTempWrite" disabled="false" sourceProperty="WDTempWrite" aggregate="AVG" type="number" hidden="false" searchable="false">
  </measure>
  <measure name="WDWIJTime" disabled="false" sourceProperty="WDWIJTime" aggregate="AVG" type="number" hidden="false" searchable="false">
  </measure>
  <measure name="WDWriteTime" disabled="false" sourceProperty="WDWriteTime" aggregate="AVG" type="number" hidden="false" searchable="false">
  </measure>
</cube>
}

Parameter DOMAIN = "SYSMON";

}

