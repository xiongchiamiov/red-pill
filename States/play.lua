Monster = require 'Entities.monster'
Player = require 'Entities.player'
Tile = require 'Entities.tile'

local play = {}

function play:init()
   time = 0

   player = Player()
   world = Vector(500, 500)
   camera = Camera(player.position.x, player.position.y)
   tiles = {}
   love.graphics.setBackgroundColor(255, 255, 255)
   npcs = {}
   
   for i = 1, 20 do
      table.insert(npcs, Monster(i*80, i*35))
   end
end

function play:update(dt)
   time = time + dt
   
   for i, npc in ipairs(npcs) do
      npc:update(dt)
   end
   
   player:update(dt)
end

function play:draw()
   for i, tile in ipairs(tiles) do
      tile:draw()
   end
   for i, npc in ipairs(npcs) do
      npc:draw()
   end
   
   player:draw(time)
   
   local dx, dy = player.position.x - camera.x, player.position.y - camera.y
   camera:move(dx / 2, dy / 2)
end

function play:keypressed(key)
   if key == 'w' then
      player.direction = Vector(0, -Player.MOVE_DISTANCE)
   elseif key == 's' then
      player.direction = Vector(0, Player.MOVE_DISTANCE)
   elseif key == 'd' then
      player.direction = Vector(Player.MOVE_DISTANCE, 0)
   elseif key == 'a' then
      player.direction = Vector(-Player.MOVE_DISTANCE, 0)
   end
end

return play

