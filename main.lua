Class = require 'hump.class'
Vector = require 'hump.vector'

Player = require 'Entities/player'

function love.load()
   player = Player()
end

function love.draw()
   love.graphics.print('hai~', 400, 300)
   player:draw(time)
end

