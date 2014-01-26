Missile = require 'Entities.missile'


printTable = require 'Util.printTable'

local levels = {
   { size = 4, damage = 1, speed = 200 },
   { size = 6, damage = 2, speed = 250 }
}

local Fireball = Class{
   __includes = { Missile };

   init = function(self, x, y, direction, level)
      Missile.init(self, x, y, direction, levels[level].size)
      self.level = level
      self.damage = levels[level].damage
      self.speed = levels[level].speed
   end;

   draw = function(self, time)
      -- Store colors for later resetting.
      r, g, b, a = love.graphics.getColor()

      love.graphics.setColor(255, 187, 28, 255) -- Random orange.
      love.graphics.circle('fill', self.position.x, self.position.y, levels[self.level].size, 100)

      love.graphics.setColor(r, g, b, a)
   end;
}

return Fireball
