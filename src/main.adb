with Logger, Ada.Strings.Unbounded, Ada.Text_IO;
use  Logger, Ada.Strings.Unbounded, Ada.Text_IO;
With Ada.Calendar.Formatting;
With Calendar;
Use Calendar;

With Pump;
With Sump;
With Water;
With WaterSensors;
With Sensors;
With Controller;

procedure Main is
   --line : Unbounded_String := To_Unbounded_String (Integer'Image(17));
   --line : Unbounded_String := To_Unbounded_String("METHANE :: CRITICAL WITH VALUE " & Integer'Image(2) & <);
   opt  : String := "1";
   clean : String :="";
begin
      while opt /= "0" loop
   Put_Line ("1- Ligar a Bomba");
   Put_Line ("2- Desligar a Bomba");
   Put_Line ("3- Ver logs metano");
   Put_Line ("4- Ver logs monoxido carbono");
   Put_Line ("5- Ver logs do Air Flow");
   Put_Line ("6- Ver logs do Mineração");
   Put_Line ("7- Ler valores da agua");
      Put_Line ("0- Sair");
      Get (opt);

      if opt = "1" then
         Controller.SystemController.Interrupt(TRUE);
         get(clean);
      elsif opt="2" then
         Controller.SystemController.Interrupt(FALSE);
         get(clean);
      elsif opt = "3" then
         Read (To_Unbounded_String ("METHANE "));
         get(clean);
      elsif opt = "4" then
         Read (To_Unbounded_String ("CBMONOX "));
         get(clean);
      elsif opt = "5" then
         Read (To_Unbounded_String ("AIRFLOW "));
         get(clean);
      elsif opt="6" then
         Read (To_Unbounded_String ("PUMPLOG "));
         get(clean);
      elsif opt="7" then
         declare
            Data: Controller.FlowData;
         begin
            Controller.FlowController.ReadFlow(Data);
            if Data.Flowing = FALSE then
               Put_Line("PIPES FLOW INDEX: " & Integer'Image(Data.FlowIndex) & " :: WITH PUMP OFF");
            else
               Put_Line("PIPES FLOW INDEX: " & Integer'Image(Data.FlowIndex) & " :: WITH PUMP ON");
            end if;
            get(clean);
         end;
      end if;

     end loop;
end Main;with Logger, Ada.Strings.Unbounded, Ada.Text_IO;
use  Logger, Ada.Strings.Unbounded, Ada.Text_IO;
With Ada.Calendar.Formatting;
With Calendar;
Use Calendar;

With Pump;
With Sump;
With Water;
With WaterSensors;
With Sensors;
With Controller;

procedure Main is
   --line : Unbounded_String := To_Unbounded_String (Integer'Image(17));
   --line : Unbounded_String := To_Unbounded_String("METHANE :: CRITICAL WITH VALUE " & Integer'Image(2) & <);
   opt  : String := "1";
   clean : String :="";
begin
      while opt /= "0" loop
   Put_Line ("1- Ligar a Bomba");
   Put_Line ("2- Desligar a Bomba");
   Put_Line ("3- Ver logs metano");
   Put_Line ("4- Ver logs monoxido carbono");
   Put_Line ("5- Ver logs do Air Flow");
   Put_Line ("6- Ver logs do Mineração");
   Put_Line ("7- Ler valores da agua");
      Put_Line ("0- Sair");
      Get (opt);

      if opt = "1" then
         Controller.SystemController.Interrupt(TRUE);
         get(clean);
      elsif opt="2" then
         Controller.SystemController.Interrupt(FALSE);
         get(clean);
      elsif opt = "3" then
         Read (To_Unbounded_String ("METHANE "));
         get(clean);
      elsif opt = "4" then
         Read (To_Unbounded_String ("CBMONOX "));
         get(clean);
      elsif opt = "5" then
         Read (To_Unbounded_String ("AIRFLOW "));
         get(clean);
      elsif opt="6" then
         Read (To_Unbounded_String ("PUMPLOG "));
         get(clean);
      elsif opt="7" then
         declare
            Data: Controller.FlowData;
         begin
            Controller.FlowController.ReadFlow(Data);
            if Data.Flowing = FALSE then
               Put_Line("PIPES FLOW INDEX: " & Integer'Image(Data.FlowIndex) & " :: WITH PUMP OFF");
            else
               Put_Line("PIPES FLOW INDEX: " & Integer'Image(Data.FlowIndex) & " :: WITH PUMP ON");
            end if;
            get(clean);
         end;
      end if;

     end loop;
end Main;
