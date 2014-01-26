local Exit = Class{
   init = function(self, x, y)
      self.position = Vector(
         x + Tile.SIZE / 2,
         y + Tile.SIZE / 2)
      self.image = image
      self.boundingBox = Collider:addRectangle(x, y, Tile.SIZE, Tile.SIZE)
      self.boundingBox.parent = self
      self.health = 1
      self.consumable = true
   end;

   update = function()
   end;

   draw = function(self, time)
      if DEBUG then
         self.boundingBox:draw('fill')
      end
   end;

   effect = function(self)
      Gamestate.switch(play, currentLevel + 1)
      self.health = 0
      return 0
   end;
}

return Exit

