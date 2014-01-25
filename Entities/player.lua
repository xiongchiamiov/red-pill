Tile = require 'Entities.tile'

local Player = Class{
   init = function(self)
      self.position = Vector(13 * Tile.SIZE, 7 * Tile.SIZE)
      self.image = love.graphics.newImage('Assets/player.png')
      self.direction = Vector(0, 0) -- Start off standing still.
      self.boundingBox = Collider:addRectangle(
         self.position.x - Tile.SIZE / 2,
         self.position.y - Tile.SIZE / 2,
         Tile.SIZE,
         Tile.SIZE)
   end;
   
   update = function(self, dt)
      player.position.x = player.position.x + player.direction.x
      player.position.y = player.position.y + player.direction.y
      self.boundingBox:moveTo(self.position.x, self.position.y)
   end;

   draw = function(self, time)
      love.graphics.draw(self.image, self.position.x - Tile.SIZE / 2, self.position.y - Tile.SIZE, 0, 1, 1, Tile.SIZE / 2, Tile.SIZE)
   end;
   
   fire = function(self, targetX, targetY)
      local target = Vector(targetX, targetY)
      local direction = target - self.position
      return Missile(self.position.x, self.position.y - Tile.SIZE, direction)
   end;
   MOVE_DISTANCE = 1;
}

return Player

