local filenameMapping = {
   a = { file = 'double-yellow', rot = 0 },
   A = { file = 'double-yellow', rot = math.pi / 2 },
   b = { file = 'double-yellow', rot = math.pi },
   B = { file = 'double-yellow', rot = math.pi * 3 / 2 },

   c = { file = 'asphalt', rot = 0 },
   C = { file = 'asphalt', rot = math.pi / 3 },
   d = { file = 'asphalt', rot = math.pi },
   D = { file = 'asphalt', rot = math.pi * 3 / 2 },

   e = { file = 'greybrix', rot = 0, passable = false },
   E = { file = 'greybrix', rot = math.pi / 2, passable = false },
   f = { file = 'greybrix', rot = math.pi, passable = false },
   F = { file = 'greybrix', rot = math.pi * 3 / 2, passable = false },

   g = { file = 'sidewalk', rot = 0 },
   G = { file = 'sidewalk', rot = math.pi / 2 },
   h = { file = 'sidewalk', rot = math.pi },
   H = { file = 'sidewalk', rot = math.pi * 3 / 2 },
}

local Tile = Class{
   SIZE = 30;

   init = function(self, key, x, y)
      self.position = Vector(x + self.SIZE / 2, y + self.SIZE / 2)
      
      tileMap = filenameMapping[key]

      if tileMap == nil or tileMap.passable == false then
         self.boundingBox = Collider:addRectangle(
            self.position.x - Tile.SIZE / 2,
            self.position.y - Tile.SIZE / 2,
            Tile.SIZE,
            Tile.SIZE)
         self.boundingBox.parent = self
      end
      
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
         if DEBUG and self.boundingBox ~= nil then
            self.boundingBox:draw('fill')
         end
      end
   end;
}

return Tile

