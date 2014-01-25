HardonCollider = require 'HardonCollider'
Missile = require 'Entities.missile'
Monster = require 'Entities.monster'
Player = require 'Entities.player'
Level = require 'Entities.level'

local play = {}

function play:init()
   time = 0

   Collider = HardonCollider(100, collision_start, collision_stop)
   player = Player()
   world = Vector(500, 500)
   camera = Camera(player.position.x, player.position.y)
   level = Level("demo")
   love.graphics.setBackgroundColor(255, 255, 255)
   characters = {player}
   missiles = {}

   for i = 1, 20 do
      table.insert(characters, Monster(i*80, i*35))
   end

   camera:zoom(2)
end

function play:update(dt)
   time = time + dt
   
   for i, character in ipairs(characters) do
      character:update(dt)
   end
   for i, missile in ipairs(missiles) do
      missile:update(dt)
   end
   
   table.sort(characters, function(alice, bob)
      return alice.position.y < bob.position.y
   end)
   
   Collider:update(dt)
end

function play:draw()
   local dx, dy = player.position.x - camera.x, player.position.y - camera.y

   camera:attach()
   camera:move(dx / 2, dy / 2)

   level:draw()
   for i, character in ipairs(characters) do
      character:draw()
   end

   for i, missile in ipairs(missiles) do
      missile:draw()
   end

   camera:detach()
end

function play:keypressed(key)
   if key == 'w' then
      player.direction.y = player.direction.y - Player.MOVE_DISTANCE
   elseif key == 's' then
      player.direction.y = player.direction.y + Player.MOVE_DISTANCE
   elseif key == 'd' then
      player.direction.x = player.direction.x + Player.MOVE_DISTANCE
   elseif key == 'a' then
      player.direction.x = player.direction.x - Player.MOVE_DISTANCE
   elseif key == 'q' then
       love.event.push('quit')
   end
end

function play:keyreleased(key)
   if key == 'w' then
      player.direction.y = player.direction.y + Player.MOVE_DISTANCE
   elseif key == 's' then
      player.direction.y = player.direction.y - Player.MOVE_DISTANCE
   elseif key == 'd' then
      player.direction.x = player.direction.x - Player.MOVE_DISTANCE
   elseif key == 'a' then
      player.direction.x = player.direction.x + Player.MOVE_DISTANCE
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

function collision_start(dt, shapeA, shapeB, mtv_x, mtv_y)
   print(string.format("Colliding: mtv = (%s, %s)", mtv_x, mtv_y))
end

function collision_stop(dt, shapeA, shapeB)
end

return play

