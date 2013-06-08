With Ada.Integer_Text_IO, Ada.Text_IO;
Use Ada.Integer_Text_IO, Ada.Text_IO;
With Calendar;
Use Calendar;
With Pump;
With Sump;

package body Water is

   FLOWMAX: constant Integer:= 10;
   FLOWMIN: constant Integer:= 0;
   WATER_MAX: constant Integer:= 100;
   WATER_MIN: constant Integer:= 0;
   WATER_VALUE: constant Integer:=6;

   FLOW_VALUE: constant Integer:=1;

   --SIMULATION
   task body WaterSimulation is

      Interval: Duration:= Duration(1);
      Next_Time : Calendar.Time := Calendar.Clock;
      WaterValue: Integer := 50;
      PumpFlow: Integer := 0;
      Dir: BOOLEAN;
   begin
      loop
         delay until Next_Time;
         Pump.WaterPump.FlowStatus(Dir,PumpFlow);
         if Dir = FALSE then
            -- GERAR VALOR ALEATORIO PARA POR NA AGUA
            if PumpFlow /= 0 then
               PumpFlow:= PumpFlow-FLOW_VALUE;
               Pump.WaterPump.UpdateFlow(PumpFlow);
            end if;
            WaterValue:= WaterValue+WATER_VALUE;
         else
            if PumpFlow /= FLOWMAX then
               PumpFlow:= PumpFlow+FLOW_VALUE;
               Pump.WaterPump.UpdateFlow(PumpFlow);
            end if;
            WaterValue:= WaterValue-WATER_VALUE;
         end if;
         if WaterValue > WATER_MAX then
            WaterValue := WATER_MAX;
         elsif WaterValue <WATER_MIN then
            WaterValue := WATER_MIN;
         end if;
         Sump.Sump.UpdateWaterLevelValue(WaterValue);
         Put(WaterValue); Put_Line(" Water value");
         Next_Time := Next_Time + Interval;
      end loop;
   end WaterSimulation;


   --RESOURCE
   protected body WaterResource is
      procedure TurnWater is
      begin
         if Direction = UP then
            Direction:=DOWN;
         else
            Direction:=UP;
         end if;
      end TurnWater;

      procedure GetWaterDirection(Dir: out WaterDirection) is
      begin
         Dir:= Direction;
      end GetWaterDirection;
   end WaterResource;


end Water;
