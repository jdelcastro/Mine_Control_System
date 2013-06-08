With Ada.Integer_Text_IO, Ada.Text_IO;
Use Ada.Integer_Text_IO, Ada.Text_IO;
With Ada.Numerics.Discrete_Random;
With Calendar;
Use Calendar;
With Environment;

package body Sensors is

   task body MethaneSensor is
      Interval: constant Duration := Duration(3);
      Next_Time: Calendar.Time := Calendar.Clock;

      --Generating Ranfom Methane Values
      subtype Rand_Range is Integer range 0..30;
      package Rand_Int is new Ada.Numerics.Discrete_Random(Rand_Range);
      seed: Rand_Int.Generator;
      Num: Rand_Range;
   begin
      loop
         delay until Next_Time;
         Rand_Int.Reset(seed);
         Num := Rand_Int.Random(seed);
         Environment.EnvironmentResource.WriteMethane(Num);
         Next_Time:= Next_Time + Interval;
      end loop;
   end MethaneSensor;

end Sensors;
