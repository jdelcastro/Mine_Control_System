With Ada.Integer_Text_IO, Ada.Text_IO;
Use Ada.Integer_Text_IO, Ada.Text_IO;
With Ada.Calendar.Formatting;
With Calendar;
Use Calendar;

With Pump;
With Environment;
With Logger;

package body Controller is


   task body SystemController is
      Can_Pump_Operate: BOOLEAN := TRUE;
      Pump_Operating: BOOLEAN := FALSE;
      Pump_Interrupted : BOOLEAN := FALSE;
   begin
      loop
         select
            accept Interrupt(Action: in BOOLEAN) do
               declare
                  MSG: Unbounded_String;
               begin

                  if Action = TRUE then
                     if Can_Pump_Operate = TRUE then
                        Pump.WaterPump.TurnOnPump;
                        Pump_Operating := TRUE;
                        MSG := To_Unbounded_String("PUMPLOG :: " &Ada.Calendar.Formatting.Image(Calendar.Clock)& " TURNED ON ");
                        Logger.Write(MSG);
                     elsif Can_Pump_Operate = FALSE then
                        Pump_Interrupted := TRUE;
                     end if;
                  else
                     if Pump_Operating = TRUE then
                        Pump.WaterPump.TurnOffPump;
                        Pump_Operating := FALSE;
                        MSG := To_Unbounded_String("PUMPLOG :: " &Ada.Calendar.Formatting.Image(Calendar.Clock)& " TURNED OFF ");
                        Logger.Write(MSG);
                     end if;
                  end if;
               end;
            end Interrupt;
         or
            accept EnvironmentEvent(Action: in BOOLEAN; MethaneLevel: in Integer) do
               declare
                 MSG: Unbounded_String;
               begin
                  if Action = FALSE then
                     MSG := To_Unbounded_String("METHANE :: " &Ada.Calendar.Formatting.Image(Calendar.Clock)& " CRITICAL WITH VALUE " & Integer'Image(MethaneLevel));
                     Put_Line(To_String(MSG));
                  else
                     MSG := To_Unbounded_String("METHANE :: " &Ada.Calendar.Formatting.Image(Calendar.Clock)& " OK WITH VALUE " & Integer'Image(MethaneLevel));
                  end if;
                  Logger.Write(MSG);
               end;
               Can_Pump_Operate := Action;
               if Pump_Operating = TRUE and Can_Pump_Operate = FALSE and Pump_Interrupted = FALSE then
                  --Put_Line("NOK");
                  Pump.WaterPump.TurnOffPump;
                  --Put_Line("Pump Turned OFF");
                  Pump_Operating := FALSE;
                  Pump_Interrupted := TRUE;
                  declare
                     MSG: Unbounded_String;
                  begin
                     MSG := To_Unbounded_String("PUMPLOG :: " &Ada.Calendar.Formatting.Image(Calendar.Clock)& " INTERRUPTED DUE METHANE LEVELS ");
                     Logger.Write(MSG);
                  end;
               elsif Can_Pump_Operate= TRUE and Pump_Interrupted = TRUE and Pump_Operating = FALSE then
                  --Put_Line("Ok");
                  Pump.WaterPump.TurnOnPump;
                  --Put_Line("Pump Turned ON");
                  Pump_Operating := TRUE;
                  Pump_Interrupted := FALSE;
                  declare
                     MSG: Unbounded_String;
                  begin
                     MSG := To_Unbounded_String("PUMPLOG :: " &Ada.Calendar.Formatting.Image(Calendar.Clock)& " RESUMED ");
                     Logger.Write(MSG);
                  end;
               end if;
            end EnvironmentEvent;
         or
            accept CriticalAlarms (Alarm : in Unbounded_String) do
               declare
                  Msg : Unbounded_String;
               begin
                  Msg := Alarm;
                  Put_Line(To_String(Msg));
                  Logger.Write(Msg);
               end;
            end CriticalAlarms;
         end select;
      end loop;
   end SystemController;

   task body FlowController is
      Flow: FlowData;
   begin
      Flow.FlowIndex := 0;
      Flow.Flowing := FALSE;
      loop
         select
            accept FlowUpdate (FlowValue : in Integer) do
               if FlowValue > Flow.FlowIndex then
                  if Flow.Flowing = FALSE then
                     Flow.Flowing := TRUE;
                  end if;
               elsif FlowValue < Flow.FlowIndex then
                  if Flow.Flowing = TRUE then
                     Flow.Flowing := FALSE;
                  end if;
               end if;
               Flow.FlowIndex := FlowValue;
            end FlowUpdate;
         or
            accept ReadFlow (Data : out FlowData) do
               Data := Flow;
            end ReadFlow;
         end select;
      end loop;
   end FlowController;

end Controller;
