local filenameMapping = {
   a = { file = 'double-yellow', rot = 0 },
   A = { file = 'double-yellow', rot = math.pi }, -- different because vertical (temp?)
   b = { file = 'asphalt', rot = 0 },
   B = { file = 'asphalt', rot = math.pi / 2 },
   c = { file = 'greybrix', rot = 0 },
   C = { file = 'greybrix', rot = math.pi / 2 },
   d = { file = 'sidewalk', rot = 0 },
   D = { file = 'sidewalk', rot = math.pi },
}

local Tile = Class{
   SIZE = 30;

   init = function(self, key, x, y)
      self.position = Vector(x + self.SIZE / 2, y + self.SIZE / 2)

      tileMap = filenameMapping[key]

      if tileMap == nil then
         if key ~= ' ' then
            print("WARN: no tile for key: " .. key)
         end
         return
      end

      local filename = filenameMapping[key].file
      self.image = love.graphics.newImage('Assets/' .. filename .. '.png')
      self.rot = filenameMapping[key].rot
   end;

   draw = function(self, time)
      if self.image then
         love.graphics.draw(self.image, self.position.x, self.position.y, self.rot, 1, 1, self.SIZE / 2, self.SIZE / 2)
      end
   end;
}

return Tile

