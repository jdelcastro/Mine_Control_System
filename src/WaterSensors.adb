With Calendar;
Use Calendar;
With Pump;
With Controller;
With Sump;

With Ada.Integer_Text_IO, Ada.Text_IO;
Use Ada.Integer_Text_IO, Ada.Text_IO;

package body WaterSensors is
   HIGHWATER: constant Integer := 95;
   LOWWATER: constant Integer := 10;

   task body WaterFlowSensor is
      Interval: Duration:= Duration(12);
      Next_Time : Calendar.Time := Calendar.Clock;
      Status: BOOLEAN;
      Flow: Integer;
   begin
      loop
         --Entrar no Pump para ver o FLOW
         delay until Next_Time;
         Pump.WaterPump.FlowStatus(Status,Flow);
      end loop;
   end WaterFlowSensor;

   task body HighWaterSensor is
      WValue: Integer;
      Flag: BOOLEAN := TRUE;
   begin
      loop
         Sump.Sump.HighLevelWater(WValue);
         if WValue >= HIGHWATER then
            Put_Line("High");
            Put(WValue);
            if Flag = TRUE then
               Controller.SystemController.Interrupt(TRUE);
               Flag:=FALSE;
            end if;
         elsif WValue < HIGHWATER then
            if Flag = FALSE then
               Flag := TRUE;
            end if;
         end if;
      end loop;
   end HighWaterSensor;

   task body LowWaterSensor is
      WValue: Integer;
      Flag: BOOLEAN := TRUE;
   begin
      loop
         Sump.Sump.LowLevelWater(WValue);
         if WValue <= LOWWATER then
            Put_Line("Low");
            if Flag = TRUE then
               Put_Line("Low Interrupt");
               Controller.SystemController.Interrupt(FALSE);
               Flag:=FALSE;
            end if;
         elsif WVALUE > LOWWATER then
            if Flag = FALSE then
               Flag := TRUE;
            end if;
         end if;
      end loop;
   end LowWaterSensor;


end WaterSensors;
