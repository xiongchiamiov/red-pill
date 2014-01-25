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
}

return Character

