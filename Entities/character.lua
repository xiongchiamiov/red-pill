local Character = Class{
   setPositionFromTopLeft = function(self, x, y)
      self.position = Vector(
         x + Tile.SIZE / 2,
         y + Tile.SIZE / 2)
   end;

   addBoundingBox = function(self)
      self.boundingBox = Collider:addRectangle(
         self.position.x - self.WIDTH / 2,
         self.position.y - self.BOX_HEIGHT / 2,
         self.WIDTH,
         self.BOX_HEIGHT)
      self.boundingBox.parent = self
   end;

   draw = function(self, time)
      if DEBUG then
         self.boundingBox:draw('fill')
      end
      if self.image ~= nil then
         love.graphics.draw(self.image, self.position.x - Tile.SIZE / 2, self.position.y - Tile.SIZE, 0, 1, 1, Tile.SIZE / 2, Tile.SIZE)
      end
   end;
   
   anyCollisions = function(self)
      for i, character in ipairs(characters) do
         if self.boundingBox:collidesWith(character.boundingBox) and
            character.consumable ~= true then
            return true
         end
      end
      for x=1, #level.map do
         for y=1, #level.map[x] do
            local boundingBox = level.map[x][y].boundingBox
            if boundingBox ~= nil and self.boundingBox:collidesWith(boundingBox) then
               return true
            end
         end
      end
      
      return false
   end;
   
   move = function(self, x, y)
      local previousPosition = self.position:clone()
      
      self.position.x = self.position.x + x
      self.position.y = self.position.y + y
      self.boundingBox:moveTo(self.position.x, self.position.y)
      if self:anyCollisions() then
         self.position = previousPosition
         self.boundingBox:moveTo(previousPosition.x, previousPosition.y)
         return false
      end
      
      return true
   end;
   HEIGHT = 2 * Tile.SIZE;
   WIDTH = Tile.SIZE;
   BOX_HEIGHT = .4 * Tile.SIZE;
}

return Character

