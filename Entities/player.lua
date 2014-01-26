Tile = require 'Entities.tile'
Fireball = require 'Entities.fireball'

local Player = Class{
   __includes = {Character};
   init = function(self, x, y)
      if self.player then
         print("ERR: player already created!!")
      end
      self:setPositionFromTopLeft(x, y)
      self.image = love.graphics.newImage('Assets/player.png')
      self.direction = Vector(0, 0) -- Start off standing still.
      self:addBoundingBox()
      self.health = 10
      self.abilities = { fireball = 1 }

      Player.player = self
   end;
   
   update = function(self, dt)
      self:move(player.direction.x, player.direction.y)
      self:checkMonsters()
   end;
   
   checkMonsters = function(self)
      for i, character in ipairs(characters) do
         if self.boundingBox:collidesWith(character.boundingBox) then
            self.health = self.health - character.damage
         end
      end
   end;

   fire = function(self, targetX, targetY)
      local target = Vector(targetX, targetY)
      local direction = target - self.position
      return Fireball(self.position.x, self.position.y - Tile.SIZE, direction, self.abilities.fireball)
   end;
   MOVE_DISTANCE = 4;
   player = nil;
}

return Player

