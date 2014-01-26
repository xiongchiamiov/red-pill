-- Singleton to draw a sanity meter on the screen.
Player = require 'Entities.player'

local MAX = 110
local SLICE_COUNT = 150
local RADIUS = 50
local POSITION = { x = 60, y = 60 }

local slices = {}
local points = {}

-- build points table
for i = 1, SLICE_COUNT do
   points[i] = {
      x = math.cos(math.pi * 2 * i / SLICE_COUNT - math.pi / 2) * RADIUS + POSITION.x,
      y = math.sin(math.pi * 2 * i / SLICE_COUNT - math.pi / 2) * RADIUS + POSITION.y
   }
end
-- Because the last point should link to the first
points[0] = points[SLICE_COUNT]

-- build slice table using points
for i = 0, SLICE_COUNT - 1 do
   slices[i + 1] = { points[i], points[i + 1] }
end

-- Sanity is out of 110 points (11 models)
local draw = function(self)
   local percent = Player.player.sanity / MAX
   local redPercent = -percent * percent + 1                       -- y = -x^2+1
   local greenPercent = math.sin((percent - 1) * math.pi / 2) + 1  -- y = sin((x-1) * pi/2)+1
   local visibleSlices = math.ceil(SLICE_COUNT * percent)

   local r, g, b, a = love.graphics.getColor()
   -- Draw a circle underneath so that it's completely opaque
   love.graphics.setColor(0, 0, 0, 255)
   love.graphics.circle("fill", POSITION.x, POSITION.y, RADIUS, RADIUS)
   love.graphics.setColor(255 * redPercent, 255 * greenPercent, 0, 255)

   for i = 1, visibleSlices do
      love.graphics.polygon("fill",
         POSITION.x, POSITION.y,           -- center
         slices[i][1].x, slices[i][1].y,   -- point 1
         slices[i][2].x, slices[i][2].y)   -- point 2
   end

   love.graphics.setColor(255, 255, 255, 255)
   love.graphics.circle("line", POSITION.x, POSITION.y, RADIUS, RADIUS)
   love.graphics.setColor(r, g, b, a)
end

return draw
