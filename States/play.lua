Missile = require 'Entities.missile'
Monster = require 'Entities.monster'
Player = require 'Entities.player'
Level = require 'Entities.level'

local play = {}

function play:init()
   time = 0

   player = Player()
   world = Vector(500, 500)
   camera = Camera(player.position.x, player.position.y)
   level = Level("demo")
   love.graphics.setBackgroundColor(255, 255, 255)
   npcs = {}
   missiles = {}

   for i = 1, 20 do
      table.insert(npcs, Monster(i*80, i*35))
   end

   camera:zoom(2)
end

function play:update(dt)
   time = time + dt
   
   for i, npc in ipairs(npcs) do
      npc:update(dt)
   end
   for i, missile in ipairs(missiles) do
      missile:update(dt)
   end
   
   player:update(dt)
end

function play:draw()
   local dx, dy = player.position.x - camera.x, player.position.y - camera.y

   camera:attach()
   camera:move(dx / 2, dy / 2)

   level:draw()
   for i, npc in ipairs(npcs) do
      npc:draw()
   end
   for i, missile in ipairs(missiles) do
      missile:draw()
   end

   player:draw(time)

   camera:detach()
end

function play:keypressed(key)
   if key == 'w' then
      player.direction.y = -Player.MOVE_DISTANCE
   elseif key == 's' then
      player.direction.y = Player.MOVE_DISTANCE
   elseif key == 'd' then
      player.direction.x = Player.MOVE_DISTANCE
   elseif key == 'a' then
      player.direction.x = -Player.MOVE_DISTANCE
   elseif key == 'q' then
       love.event.push('quit')
   end
end

function play:keyreleased(key)
   if key == 'w' then
      player.direction.y = 0
   elseif key == 's' then
      player.direction.y = 0
   elseif key == 'd' then
      player.direction.x = 0
   elseif key == 'a' then
      player.direction.x = 0
   end
end

-- x: Mouse x position.
-- y: Mouse y position.
-- button: http://www.love2d.org/wiki/MouseConstant
function play:mousepressed(x, y, button)
   -- The camera screws things up, so let's ignore where Love thinks we're
   -- clicking.
   x, y = camera:mousepos()
   
   if button == "l" then
      table.insert(missiles, player:fire(x, y))
   end
end

return play

