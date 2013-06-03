package body Sump is

   protected body Sump is

      procedure WaterLevelValue(Value: out Integer) is
      begin
         Value := WaterLevel;
      end WaterLevelValue;

      procedure UpdateWaterLevelValue(Value: in Integer) is
      begin
         WaterLevel := Value;
      end UpdateWaterLevelValue;

   end Sump;

end Sump;
