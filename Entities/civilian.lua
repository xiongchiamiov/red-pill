image = love.graphics.newImage('Assets/monster1.png')

local Civilian = Class{
   __includes = {Character};
   init = function(self, x, y)
      self:setPositionFromTopLeft(x, y)
      self.image = image
      self:addBoundingBox()
      self.health = 3
      self.damage = 0
   end;
   
   update = function(self, dt)
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
   
   effect = function(self)
      return -self.damage
   end;

   VISION_DISTANCE = 3 * Tile.SIZE;
   MOVE_DISTANCE = 2 * Tile.SIZE;
}

return Civilian

