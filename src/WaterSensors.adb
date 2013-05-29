With Calendar;
Use Calendar;
With Pump;
Use Pump;


package body WaterSensors is

   task WaterFlowSensor is
      Interval: Duration:= Duration(12);
      Next_Time : Calendar.Time := Calendar.Clock;

   begin
      loop
         --Entrar no Pump para ver o FLOW
         delay until Next_Time;
         WaterPump.FlowStatus()
      end loop;

   end WaterFlowSensor;

end WaterSensors;
