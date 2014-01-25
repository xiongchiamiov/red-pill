local Character = Class{
   addBoundingBox = function(self)
      self.boundingBox = Collider:addRectangle(
         self.position.x - Tile.SIZE / 2,
         self.position.y - Tile.SIZE / 2,
         Tile.SIZE,
         Tile.SIZE)
      self.boundingBox.parent = self
   end;

   draw = function(self, time)
      love.graphics.draw(self.image, self.position.x - Tile.SIZE / 2, self.position.y - Tile.SIZE, 0, 1, 1, Tile.SIZE / 2, Tile.SIZE)
   end;
   
   anyCollisions = function(self)
      for i, character in ipairs(characters) do
         if self.boundingBox:collidesWith(character.boundingBox) then
            return true
         end
      end
      
      return false
   end;
   
   move = function(self, x, y)
      local previousPosition = player.position:clone()
      
      self.position.x = self.position.x + x
      self.position.y = self.position.y + y
      self.boundingBox:moveTo(self.position.x, self.position.y)
      if self:anyCollisions() then
         player.position = previousPosition
         self.boundingBox:moveTo(previousPosition.x, previousPosition.y)
      end
   end;
}

return Character

