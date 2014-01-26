Tile = require 'Entities.tile'
Fireball = require 'Entities.Weapons.fireball'

local sanityDirection = -1

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
      self.sanity = 110
      self.abilities = { fireball = { class = Fireball, level = 1, lastFired = -10 } }

      Player.player = self
   end;
   
   update = function(self, dt)
      if self.sanity < 0 and sanityDirection == -1 then
         self.sanity = 0
         sanityDirection = 1
      end

      if self.sanity > 110 and sanityDirection == 1 then
         self.sanity = 110
         sanityDirection = -1
      end

      self.sanity = self.sanity + dt * 10 * sanityDirection

      self:move(player.direction.x, player.direction.y)
      self:checkCollisions()
   end;
   
   checkCollisions = function(self)
      for i, character in ipairs(characters) do
         if self.boundingBox:collidesWith(character.boundingBox) then
            if DEBUG then
               print(string.format('Hit while at (%s, %s) by enemy at (%s, %s)',
                  self.position.x, self.position.y,
                  character.position.x, character.position.y))
            end
            self.health = self.health + character:effect()
         end
      end
   end;
   
   effect = function(self)
   end;

   fire = function(self, targetX, targetY)
      local weapon = self.abilities.fireball
      if weapon.class.CooldownAtLevel(weapon.level) >= time - weapon.lastFired then
         return nil
      end
      weapon.lastFired = time

      local target = Vector(targetX, targetY)
      local direction = target - self.position
      return weapon.class(self.position.x, self.position.y - Tile.SIZE, direction, weapon.level)
   end;
   MOVE_DISTANCE = 4;
   player = nil;
}

return Player

