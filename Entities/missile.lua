local Missile = Class{
   init = function(self, x, y)
      self.position = Vector(x, y)
   end;
   
   update = function(self, dt)
      self.position.x = self.position.x + (math.random(-1, 1) * Player.MOVE_DISTANCE)
      self.position.y = self.position.y + (math.random(-1, 1) * Player.MOVE_DISTANCE)
   end;

   draw = function(self, time)
      -- Store colors for later resetting.
      r, g, b, a = love.graphics.getColor()
      
      love.graphics.setColor(255, 187, 28, 255) -- Random orange.
      love.graphics.circle('fill', self.position.x, self.position.y, 50, 100)
      
      love.graphics.setColor(r, g, b, a)
   end;
}

return Missile

