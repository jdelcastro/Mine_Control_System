package Pump is

   type PumpStatus is (ON, OFF);

   protected WaterPump is

      entry TurnOnPump();
      entry TurnOffPump();
      entry FlowStatus(Status: out PumpSatus, Flow: out Integer);

   private
      Status: PumpStatus := OFF;
      FlowIndex: Integer := 0;

   end WaterPump;

end Pump;
