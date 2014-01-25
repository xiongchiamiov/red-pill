Tile = require 'Entities.tile'

local Level = Class{
   MAP_NAMES = {
      "demo"
   };
   init = function(self, mapName)
      -- Pull in the .map file info
      self.map = {}
      local lineNum = 0
      for line in io.lines("Levels/" .. mapName .. ".map") do
         lineNum = lineNum + 1
         self.map[lineNum] = {}
         for i = 1, #line do
            local c = line:sub(i,i)
            self.map[lineNum][i] = Tile(c, (i - 1) * 30, (lineNum - 1) * 30)
         end
      end

      -- Pull in the .characters file info
      self.characters = {}
      local lineNum = 0
      for line in io.lines("Levels/" .. mapName .. ".characters") do
         lineNum = lineNum + 1
         for i = 1, #line do
            local c = line:sub(i,i)
            if c ~= ' ' then
               local posX, posY = (i - 1) * 30, (lineNum - 1) * 30
               local char = {}
               if c == 'P' then
                  char = Player(posX, posY)
               elseif c == 'm' then
                  char = Monster(posX, posY)
               elseif c ~= ' ' then
                  print("WARN: unknown character tile " .. key)
               end
               if char ~= {} then
                  table.insert(self.characters, char)
               end
            end
         end
      end
   end;

   draw = function(self, time)
      for x=1, #self.map do
         for y=1, #self.map[x] do
            self.map[x][y]:draw(time)
         end
      end
   end;
}

return Level
