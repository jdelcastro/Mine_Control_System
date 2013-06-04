package Pump is


   protected WaterPump is

      entry TurnOnPump;
      entry TurnOffPump;
      procedure FlowStatus(Stat: out BOOLEAN; Flow: out Integer);
      procedure UpdateFlow(Flow: in Integer);

   private
      Status: BOOLEAN := FALSE;
      FlowIndex: Integer := 0;

   end WaterPump;

end Pump;
