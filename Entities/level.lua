Tile = require 'Entities.tile'

local Level = Class{
   MAP_NAMES = {
      "demo.map"
   };
   init = function(self, mapName)
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
