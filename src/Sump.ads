package Sump is

   protected Sump is

      procedure WaterLevelValue(Value: out Integer);
      entry LowLevelWater(Value: out Integer);
      entry HighLevelWater(Value: out Integer);
      entry UpdateWaterLevelValue(Value: in Integer);

      private
      WaterLevel: Integer range 1..100;
      HighRead, LowRead: BOOLEAN := FALSE;

   end Sump;


end Sump;
