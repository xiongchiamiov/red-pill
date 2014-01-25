local gameover = {}

function gameover:init()
end

function gameover:update(dt)
end

function gameover:draw()
	love.graphics.print('Game Over', 100, 300)
end

return gameover

