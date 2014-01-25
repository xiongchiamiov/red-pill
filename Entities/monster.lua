local Monster = Class{
   __includes = {Character};
   init = function(self, x, y)
      self.position = Vector(x, y)
      self.image = love.graphics.newImage('Assets/monster11.png')
      self:addBoundingBox()
      self.health = 3
   end;
   
   update = function(self, dt)
      self:move(math.random(-1, 1) * Player.MOVE_DISTANCE, math.random(-1, 1) * Player.MOVE_DISTANCE)
      self:checkMissiles()
   end;
   
   checkMissiles = function(self)
      for i, missile in ipairs(missiles) do
         if self.boundingBox:collidesWith(missile.boundingBox) then
            self.health = self.health - missile.damage
            table.remove(missiles, i)
         end
      end
   end;
}

return Monster

