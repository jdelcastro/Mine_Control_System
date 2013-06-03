package Sump is

   protected Sump is

      procedure WaterLevelValue(Value: out Integer);
      procedure UpdateWaterLevelValue(Value: in Integer);

      private
      	WaterLevel: Integer range 1..100;
   end Sump;


end Sump;
