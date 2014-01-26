HardonCollider = require 'HardonCollider'

Tile = require 'Entities.tile'
Character = require 'Entities.character'
Missile = require 'Entities.Weapons.missile'
Civilian = require 'Entities.civilian'
Monster = require 'Entities.monster'
Pill = require 'Entities.pill'
Exit = require 'Entities.exit'
Player = require 'Entities.player'
Level = require 'Entities.level'
Text = require 'Entities.text'

drawSanityMeter = require 'UI.sanityMeter'

local play = {}
sanityEnabled = false -- start out in level 1 without draining sanity

-- Doesn't contain all button states, just the ones we need (like LMB)
local buttonPressing = {
   lmb = false,
   w = false,
   a = false,
   s = false,
   d = false
}

DEBUG = false
MAX_PILL_EFFECTIVENESS = 11

function play:enter(self, levelNumber)
   time = 0
   currentLevel = levelNumber

   -- Loading...
   Collider = HardonCollider(100, collision_start, collision_stop)
   world = Vector(500, 500)
   -- Set player to nil just in case we're loading back in. Level constructor
   -- will make Player.player again
   local oldPlayer
   if Player.player ~= nil then
      oldPlayer = Player.player
      Player.player = nil
   end
   level = Level(currentLevel)
   if oldPlayer then
      local p = Player.player
      local o = oldPlayer
      p.sanity = o.sanity
      p.health = o.health
      p.abilities.fireball.level = o.abilities.fireball.level
   end
   player = Player.player
   player.sanity = oldSanity or player.sanity
   characters = level.characters
   texts = level.texts
   missiles = {}

   -- Ready!
   camera = Camera(player.position.x, player.position.y)
   love.graphics.setBackgroundColor(0, 0, 0)

   camera:zoom(2)
end

function play:update(dt)
   time = time + dt

   player.direction = Vector(0, 0)
   if buttonPressing.w and not buttonPressing.s then
      player.direction.y = -Player.MOVE_DISTANCE
   elseif buttonPressing.s and not buttonPressing.w then
      player.direction.y = Player.MOVE_DISTANCE
   end

   if buttonPressing.d and not buttonPressing.a then
      player.direction.x = Player.MOVE_DISTANCE
   elseif buttonPressing.a and not buttonPressing.d then
      player.direction.x = -Player.MOVE_DISTANCE
   end

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

   for i, character in ipairs(characters) do
      character:update(dt)
      if character.health <= 0 then
         table.remove(characters, i)
         if character == player then
            Gamestate.switch(gameover, 'lose')
         elseif character.typ == 'monster' then
            Player.player.abilities.current.level = math.min(Player.player.abilities.current.level + 1, 3)
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
   if sanityEnabled then
      drawSanityMeter()
   end
end

function play:keypressed(key)
   if key == 'w' then
      buttonPressing.w = true
   elseif key == 's' then
      buttonPressing.s = true
   elseif key == 'd' then
      buttonPressing.d = true
   elseif key == 'a' then
      buttonPressing.a = true
   elseif key == 'q' then
       love.event.push('quit')
   end
end

function play:keyreleased(key)
   if key == 'w' then
      buttonPressing.w = false
   elseif key == 's' then
      buttonPressing.s = false
   elseif key == 'd' then
      buttonPressing.d = false
   elseif key == 'a' then
      buttonPressing.a = false
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

