With Ada.Integer_Text_IO, Ada.Text_IO;
Use Ada.Integer_Text_IO, Ada.Text_IO;

package body Pump is

   task body WaterPump is

      Status: BOOLEAN := FALSE;
      FlowIndex: Integer := 0;
   begin
      loop
         select
            accept TurnOnPump  do
               --Put_Line("Pump On");
               Status := TRUE;
            end TurnOnPump;
         or
            accept TurnOffPump do
               --Put_Line("Pump Off");
               Status := FALSE;
            end TurnOffPump;
         or
            accept FlowStatus(Stat: out BOOLEAN; Flow: out Integer) do
               Stat := Status;
               Flow := FlowIndex;
            end FlowStatus;
         or
            accept UpdateFlow(Flow: in Integer) do
               FlowIndex := Flow;
            end UpdateFlow;
         end select;
      end loop;
   end WaterPump;
end Pump;
