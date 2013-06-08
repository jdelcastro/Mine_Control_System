
package Environment is

   task EnvironmentResource is
      entry WriteMethane(X: in Integer);
      entry Methane(X: out Integer);
      entry AirFlow(X: in Integer);
      entry CarbonMonoxide(X: in Integer);
   end EnvironmentResource;


end Environment;
