play = require 'States.play'

local gameover = {}

function gameover:init()
end

function gameover:enter(self, result)
   resultText = 'You ' .. result .. '!'
end

function gameover:update(dt)
end

function gameover:draw()
   love.graphics.print(resultText, 100, 300)
   love.graphics.rectangle('line', 75, 475, 200, 60)
   love.graphics.print('Play again? Click Here', 100, 500)
end

function gameover:keypressed(key)
   if key == 'q' then
      love.event.push('quit')
   elseif key == 'r' then
      Gamestate.switch(play, 1)
   end
end

function gameover:mousepressed(x, y, button)
   if button == "l" then
      if x > 75 and x < 275 and y > 475 and y < 535 then
         Gamestate.switch(play, 1)
      end
   end
end

return gameover

