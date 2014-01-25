local Player = Class{
   init = function(self)
      self.position = Vector(400, 400)
      self.image = love.graphics.newImage('Assets/player.png')
      self.direction = Vector(0, 0) -- Start off standing still.
   end;
   
   update = function(self, dt)
      player.position.x = player.position.x + player.direction.x
      player.position.y = player.position.y + player.direction.y
   end;

   draw = function(self, time)
      love.graphics.draw(self.image, self.position.x, self.position.y)
   end;
   
   fire = function(self, targetX, targetY)
      local target = Vector(targetX, targetY)
      local direction = target - self.position
      return Missile(self.position.x, self.position.y, direction)
   end;
   MOVE_DISTANCE = 1;
}

return Player

