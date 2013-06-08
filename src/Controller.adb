With Ada.Integer_Text_IO, Ada.Text_IO;
Use Ada.Integer_Text_IO, Ada.Text_IO;

With Pump;
With Environment;

package body Controller is

   task body SystemController is
      Can_Pump_Operate: BOOLEAN := TRUE;
      Pump_Operating: BOOLEAN := FALSE;
      Pump_Interrupted : BOOLEAN := FALSE;
   begin
      loop
         select
            accept Interrupt(Action: in BOOLEAN) do
               if Action = TRUE then
                  if Can_Pump_Operate = TRUE then
                     Pump.WaterPump.TurnOnPump;
                     Pump_Operating := TRUE;
                  else
                     Pump_Interrupted := TRUE;
                  end if;
               else
                  Pump.WaterPump.TurnOffPump;
                  Pump_Operating := FALSE;
               end if;
            end Interrupt;
         or
            accept EnvironmentEvent(Action: in BOOLEAN) do
               --Put_Line("Event");
               Can_Pump_Operate := Action;
               if Pump_Operating = TRUE and Can_Pump_Operate = FALSE and Pump_Interrupted = FALSE then
                  --Put_Line("NOK");
                  Pump.WaterPump.TurnOffPump;
                  --Put_Line("Pump Turned OFF");
                  Pump_Operating := FALSE;
                  Pump_Interrupted := TRUE;
               elsif Can_Pump_Operate= TRUE and Pump_Interrupted = TRUE and Pump_Operating = FALSE then
                  --Put_Line("Ok");
                  Pump.WaterPump.TurnOnPump;
                  --Put_Line("Pump Turned ON");
                  Pump_Operating := TRUE;
                  Pump_Interrupted := FALSE;
               end if;
            end EnvironmentEvent;
         end select;
         Put_Line("Yoo");
      end loop;
   end SystemController;

end Controller;
