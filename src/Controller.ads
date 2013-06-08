With Ada.Strings.Unbounded;
Use Ada.Strings.Unbounded;

package Controller is

   type FlowData is
      record
         FlowIndex: Integer;
         Flowing: Boolean;
      end record;

   task SystemController is
      entry Interrupt(Action: in BOOLEAN);
      entry EnvironmentEvent(Action: in BOOLEAN; MethaneLevel: in Integer);
      entry CriticalAlarms(Alarm: in Unbounded_String);
   end SystemController;

   task FlowController is
      entry FlowUpdate(FlowValue : in Integer);
      entry ReadFlow(Data: out FlowData);
   end FlowController;

end Controller;
