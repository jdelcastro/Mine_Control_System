package Controller is

   task SystemController is
      entry Interrupt(Action: in BOOLEAN);
      entry EnvironmentEvent(Action: in BOOLEAN);
   end SystemController;

end Controller;
