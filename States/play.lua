HardonCollider = require 'HardonCollider'

Tile = require 'Entities.tile'
Character = require 'Entities.character'
Missile = require 'Entities.Weapons.missile'
Civilian = require 'Entities.civilian'
Monster = require 'Entities.monster'
Pill = require 'Entities.pill'
Player = require 'Entities.player'
Level = require 'Entities.level'
Text = require 'Entities.text'

drawSanityMeter = require 'UI.sanityMeter'

local play = {}

-- Doesn't contain all button states, just the ones we need (like LMB)
local buttonPressing = {
   lmb = false
}

DEBUG = false
MAX_PILL_EFFECTIVENESS = 11

function play:enter()
   time = 0

   -- Loading...
   Collider = HardonCollider(100, collision_start, collision_stop)
   world = Vector(500, 500)
   -- Set player to nil just in case we're loading back in. Level constructor
   -- will make Player.player again
   Player.player = nil
   level = Level("demo")
   player = Player.player
   characters = level.characters
   texts = level.texts
   missiles = {}
   redPillEffectiveness = MAX_PILL_EFFECTIVENESS

   -- Ready!
   camera = Camera(player.position.x, player.position.y)
   love.graphics.setBackgroundColor(0, 0, 0)

   camera:zoom(2)
end

function play:update(dt)
   time = time + dt

   -- Fire missiles if possible and LMB is being held
   if buttonPressing.lmb == true then
      -- The camera screws things up, so let's ignore where Love thinks we're
      -- clicking.
      local x, y = camera:mousepos()
      m = player:fire(x, y)
      if m ~= nil then
         table.insert(missiles, m)
      end
   end

   redPillEffectiveness = redPillEffectiveness - dt
   if redPillEffectiveness < 1 then
      redPillEffectiveness = 1
   end
   
   for i, character in ipairs(characters) do
      character:update(dt)
      if character.health <= 0 then
         table.remove(characters, i)
         if character == player then
            Gamestate.switch(gameover)
         end
      end
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
   for i, text in ipairs(texts) do
      text:draw()
   end
   
   for i, character in ipairs(characters) do
      character:draw()
   end

   for i, missile in ipairs(missiles) do
      missile:draw()
   end

   camera:detach()

   -- Draw UI elements here
   drawSanityMeter()
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
   if button == "l" then
      buttonPressing.lmb = true
   end
end

function play:mousereleased(x, y, button)
   if button == "l" then
      buttonPressing.lmb = false
   end
end

function collision_start(dt, shapeA, shapeB, mtv_x, mtv_y)
end

function collision_stop(dt, shapeA, shapeB)
end

return play

