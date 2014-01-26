-- Singleton to draw a sanity meter on the screen.
Player = require 'Entities.player'

local MAX = 110

-- Sanity is out of 110 points (11 models)
local draw = function(self)
   local percent = Player.player.sanity / MAX
   local redPercent = -percent * percent + 1                -- y = -x^2 + 1
   local greenPercent = -(percent - 1) * (percent - 1) + 1  -- y - -(x-1)^2 + 1
   local r, g, b, a = love.graphics.getColor()
   love.graphics.setColor(255 * redPercent, 255 * greenPercent, 0, 255)
   love.graphics.circle("fill", 60, 60, 50, 50)
   love.graphics.setColor(255, 255, 255, 255)
   love.graphics.circle("line", 60, 60, 50, 50)
   love.graphics.setColor(r, g, b, a)
end

return draw
