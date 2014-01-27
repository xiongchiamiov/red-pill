Camera = require 'hump.camera'
Class = require 'hump.class'
Gamestate = require 'hump.gamestate'
Vector = require 'hump.vector'

play = require 'States.play'
gameover = require 'States.gameover'

function love.load()
   bgm = love.audio.newSource('Assets/GameJam6Final.ogg', 'static')
   bgm:setLooping(true)
   love.audio.play(bgm)
   Gamestate.registerEvents()
   Gamestate.switch(play, 1)
end

