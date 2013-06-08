package Pump is


   task WaterPump is

      entry TurnOnPump;
      entry TurnOffPump;
      entry FlowStatus(Stat: out BOOLEAN; Flow: out Integer);
      entry UpdateFlow(Flow: in Integer);

   end WaterPump;

end Pump;
