local filenameMapping = {
   a = 'double-yellow.png'
}

local Tile = Class{
   init = function(self, key, x, y)
      self.position = Vector(x, y)
      local filename = filenameMapping[key]
      self.image = love.graphics.newImage('Assets/'+filename+'.png')
   end;

   draw = function(self, time)
      love.graphics.draw(self.image, self.position.x, self.position.y)
   end;
}

return Tile

