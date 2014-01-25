local Missile = Class{
   init = function(self, x, y, direction)
      self.position = Vector(x, y)
      self.direction = direction:normalized()
      self.boundingBox = Collider:addCircle(x, y, self.RADIUS)
      self.damage = 1
   end;
   RADIUS = 10;
   
   update = function(self, dt)
      self.position = self.position + self.direction
      self.boundingBox:moveTo(self.position.x, self.position.y)
   end;

   draw = function(self, time)
      -- Store colors for later resetting.
      r, g, b, a = love.graphics.getColor()
      
      love.graphics.setColor(255, 187, 28, 255) -- Random orange.
      love.graphics.circle('fill', self.position.x, self.position.y, self.RADIUS, 100)
      
      love.graphics.setColor(r, g, b, a)
   end;
}

return Missile

