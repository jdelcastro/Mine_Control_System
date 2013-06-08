With Ada.Integer_Text_IO, Ada.Text_IO;
Use Ada.Integer_Text_IO, Ada.Text_IO;
With Ada.Strings.Unbounded;
Use Ada.Strings.Unbounded;
With Ada.Calendar.Formatting;
With Calendar;
Use Calendar;

With Controller;

package body Environment is

   --Critical Environment Values
   CRITICAL_METHANE: constant Integer := 25;
   CRITICAL_AIR_FLOW: constant Integer := 75;
   CRITICAL_CARBON_MONOXIDE: constant Integer := 1000;

   task body EnvironmentResource is
      MethaneLevel: Integer := 0;
      Can_Proceed: BOOLEAN := TRUE;
      CRITICAL: BOOLEAN := FALSE;
      Air: BOOLEAN := FALSE;
      Cb: BOOLEAN := FALSE;
   begin
      loop
         select
            accept WriteMethane(X: in Integer) do
               MethaneLevel:=X;
               if MethaneLevel >= CRITICAL_METHANE then
                  Can_Proceed := FALSE;
                  if CRITICAL = FALSE then
                     CRITICAL := TRUE;
                     Controller.SystemController.EnvironmentEvent(FALSE, MethaneLevel);
                  end if;
               else
                  Can_Proceed:= TRUE;
                  if CRITICAL = TRUE then
                     CRITICAL := FALSE;
                     Controller.SystemController.EnvironmentEvent(TRUE, MethaneLevel);
                  end if;
               end if;
            end ;
         or
            when Can_Proceed = TRUE =>
               accept Methane(X: out Integer)  do
                  X:= MethaneLevel;
               end ;
         or
            accept AirFlow(X: in Integer) do
               if X >= CRITICAL_AIR_FLOW then
                  declare
                     Alarm: Unbounded_String;
                  begin
                     Alarm := To_Unbounded_String("AIRFLOW :: " &Ada.Calendar.Formatting.Image(Calendar.Clock)& " CRITICAL WITH VALUE " & Integer'Image(X));
                     Controller.SystemController.CriticalAlarms(Alarm);
                  end;
               end if;
            end;
         or
            accept CarbonMonoxide(X: in Integer) do
               if X >= CRITICAL_CARBON_MONOXIDE then
                  declare
                     Alarm: Unbounded_String;
                  begin
                     Alarm := To_Unbounded_String("CBMONOX :: " &Ada.Calendar.Formatting.Image(Calendar.Clock)& " CRITICAL WITH VALUE " & Integer'Image(X));
                     Controller.SystemController.CriticalAlarms(Alarm);
                  end;
               end if;
            end;
         end select;
      end loop;
   end EnvironmentResource;

end Environment;
