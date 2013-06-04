With Ada.Integer_Text_IO, Ada.Text_IO;
Use Ada.Integer_Text_IO, Ada.Text_IO;

package body Pump is

   protected body WaterPump is

      entry TurnOnPump when Status = FALSE is
      begin
         Put_Line("Pump On");
         Status := TRUE;
      end TurnOnPump;

      entry TurnOffPump when Status = TRUE is
      begin
         Put_Line("Pump Off");
         Status := FALSE;
      end TurnOffPump;

      procedure FlowStatus(Stat: out BOOLEAN; Flow: out Integer) is
      begin
         Stat := Status;
         Flow := FlowIndex;
      end FlowStatus;

      procedure UpdateFlow(Flow: in Integer) is
      begin
         FlowIndex := Flow;
      end UpdateFlow;

   end WaterPump;
end Pump;
