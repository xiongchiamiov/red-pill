Player = require 'Entities.player'
Tile = require 'Entities.tile'

local Monster = Class{
   __includes = {Character};
   init = function(self, x, y)
      self:setPositionFromTopLeft(x, y)
      self.image = love.graphics.newImage('Assets/monster11.png')
      self:addBoundingBox()
      self.health = 3
      self.damage = 1
   end;
   
   update = function(self, dt)
      self:checkMissiles()

      local vecToPlayer = Player.player.position - self.position
      if vecToPlayer:len() <= Monster.VISION_DISTANCE then
         vecToPlayer = vecToPlayer:normalize_inplace() * Monster.MOVE_DISTANCE * dt
         self:move(vecToPlayer.x, vecToPlayer.y)
      end
   end;
   
   checkMissiles = function(self)
      for i, missile in ipairs(missiles) do
         if self.boundingBox:collidesWith(missile.boundingBox) then
            self.health = self.health - missile.damage
            table.remove(missiles, i)
         end
      end
   end;
   VISION_DISTANCE = 3 * Tile.SIZE;
   MOVE_DISTANCE = 2 * Tile.SIZE;
}

return Monster

