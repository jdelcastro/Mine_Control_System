package body Sump is

   HIGHLEVEL: constant Integer :=95;
   LOWLEVEL: constant Integer :=10;

   protected body Sump is

      procedure WaterLevelValue(Value: out Integer) is
      begin
         Value := WaterLevel;
      end WaterLevelValue;

      entry UpdateWaterLevelValue(Value: in Integer) when LowRead=FALSE and HighRead=FALSE is
      begin
         WaterLevel := Value;
         HighRead:=TRUE;
         LowRead:=TRUE;
      end UpdateWaterLevelValue;

      entry LowLevelWater(Value: out Integer) when LowRead is
      begin
         Value:= WaterLevel;
         LowRead:= False;
      end LowLevelWater;

      entry HighLevelWater(Value: out Integer) when HighRead is
      begin
         Value:= WaterLevel;
         HighRead:= FALSE;
      end HighLevelWater;

   end Sump;

end Sump;
