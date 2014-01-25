local Monster = Class{
   __includes = {Character};
   init = function(self, x, y)
      self.position = Vector(x, y)
      self.image = love.graphics.newImage('Assets/monster11.png')
      self:addBoundingBox()
   end;
   
   update = function(self, dt)
      self:move(math.random(-1, 1) * Player.MOVE_DISTANCE, math.random(-1, 1) * Player.MOVE_DISTANCE)
   end;
}

return Monster

