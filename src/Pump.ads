package Pump is

   type PumpStatus is (ON, OFF);

   protected WaterPump is

      procedure TurnOnPump;
      procedure TurnOffPump;
      procedure FlowStatus(Status: out PumpStatus; Flow: out Integer);

   private
      Status: PumpStatus := OFF;
      FlowIndex: Integer := 0;

   end WaterPump;

end Pump;
