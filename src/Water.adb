With Calendar;
Use Calendar;
With Pump;
With Sump;

package body Water is

   task body WaterSimulation is

      Interval: Duration:= Duration(1);
      Next_Time : Calendar.Time := Calendar.Clock;
      WaterValue: Integer range 1..100 := 50;
   begin
      loop
         delay until Next_Time;
         if Direction = UP then
            Sump.Sump.UpdateWaterLevelValue()
         else

         end if;
      end loop;
   end WaterSimulation;

   protected body WaterResource is

   end WaterResource;


end Water;
