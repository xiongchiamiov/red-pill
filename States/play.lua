Player = require 'Entities.player'

local play = {}

function play:init()
   player = Player()
   world = Vector(500, 500)
   camera = Camera(player.position.x, player.position.y)
end

function play:draw()
   love.graphics.print('hai~', 400, 300)
   player:draw(time)
   
   local dx, dy = player.position.x - camera.x, player.position.y - camera.y
   camera:move(dx / 2, dy / 2)
end

return play

