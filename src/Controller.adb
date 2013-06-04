With Pump;

package body Controller is

   task body SystemController is

   begin
      loop
         accept Interrupt(Action: in BOOLEAN) do
            if Action then
               Pump.WaterPump.TurnOnPump;
            else
               Pump.WaterPump.TurnOffPump;
            end if;
         end Interrupt;
      end loop;
   end SystemController;

end Controller;
