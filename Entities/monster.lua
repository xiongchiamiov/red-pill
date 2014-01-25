local Monster = Class{
   init = function(self, x, y)
      self.position = Vector(x, y)
      self.image = love.graphics.newImage('Assets/monster11.png')
   end;

   draw = function(self, time)
      love.graphics.draw(self.image, self.position.x, self.position.y)
   end;
}

return Monster

