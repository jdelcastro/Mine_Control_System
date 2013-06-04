package Water is

   type WaterDirection is (UP, DOWN);
   task WaterSimulation;

   protected WaterResource is

      procedure TurnWater;
      procedure GetWaterDirection(Dir: out WaterDirection);

      private
     	Direction: WaterDirection:= UP;
   end WaterResource;

end Water;
