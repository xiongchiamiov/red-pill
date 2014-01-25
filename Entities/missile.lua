local Missile = Class{
   init = function(self, x, y, direction)
      self.position = Vector(x, y)
      self.direction = direction:normalized()
   end;
   
   update = function(self, dt)
      self.position = self.position + self.direction
   end;

   draw = function(self, time)
      -- Store colors for later resetting.
      r, g, b, a = love.graphics.getColor()
      
      love.graphics.setColor(255, 187, 28, 255) -- Random orange.
      love.graphics.circle('fill', self.position.x, self.position.y, 10, 100)
      
      love.graphics.setColor(r, g, b, a)
   end;
}

return Missile

