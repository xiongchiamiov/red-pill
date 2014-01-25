Camera = require 'hump.camera'
Class = require 'hump.class'
Gamestate = require 'hump.gamestate'
Vector = require 'hump.vector'

play = require 'States.play'

function love.load()
   Gamestate.registerEvents()
   Gamestate.switch(play)
end

