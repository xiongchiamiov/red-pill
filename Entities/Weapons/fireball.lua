Missile = require 'Entities.Weapons.missile'

local levels = {
   { size = 4, damage = 1, speed = 200, colorMod = 0, cooldown = 0.7 },
   { size = 6, damage = 2, speed = 250, colorMod = 10, cooldown = 0.4 },
   { size = 9, damage = 4, speed = 350, colorMod = 30, cooldown = 0.2 }
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
      local r, g, b, a = love.graphics.getColor()

      local colorMod = levels[self.level].colorMod
      -- colors ranging from musty to RED
      love.graphics.setColor(225 + colorMod, 177 - colorMod * 2, 35 - colorMod, 255)
      love.graphics.circle('fill', self.position.x, self.position.y, levels[self.level].size, 100)

      love.graphics.setColor(r, g, b, a)
   end;

   CooldownAtLevel = function(level)
      return levels[level].cooldown
   end;
}

return Fireball
