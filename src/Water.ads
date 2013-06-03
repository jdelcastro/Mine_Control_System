package Water is

   type WaterDirection is (UP, DOWN):
   task WaterSimulation;

   protected WaterResource is

      private
     	Direction: WaterDirection:= UP;
   end WaterResource;

end Water;
