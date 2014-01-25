local Monster = Class{
   __includes = {Character};
   init = function(self, x, y)
      self.position = Vector(x, y)
      self.image = love.graphics.newImage('Assets/monster11.png')
      self.boundingBox = Collider:addRectangle(
         self.position.x - Tile.SIZE / 2,
         self.position.y - Tile.SIZE / 2,
         Tile.SIZE,
         Tile.SIZE)
   end;
   
   update = function(self, dt)
      self.position.x = self.position.x + (math.random(-1, 1) * Player.MOVE_DISTANCE)
      self.position.y = self.position.y + (math.random(-1, 1) * Player.MOVE_DISTANCE)
      self.boundingBox:moveTo(self.position.x, self.position.y)
   end;
}

return Monster

