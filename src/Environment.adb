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
   begin
      loop
         select
            accept WriteMethane(X: in Integer) do
               MethaneLevel:=X;
               if MethaneLevel >= CRITICAL_METHANE then
                  Can_Proceed := FALSE;
                  if CRITICAL = FALSE then
                     CRITICAL := TRUE;
                     Controller.SystemController.EnvironmentEvent(FALSE);
                  end if;
               else
                  Can_Proceed:= TRUE;
                  if CRITICAL = TRUE then
                     CRITICAL := FALSE;
                     Controller.SystemController.EnvironmentEvent(TRUE);
                  end if;
               end if;
            end ;
         or
            when Can_Proceed = TRUE =>
               accept Methane(X: out Integer)  do
                  X:= MethaneLevel;
               end ;
         end select;
      end loop;
   end EnvironmentResource;

end Environment;
