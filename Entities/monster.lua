local Monster = Class{
   init = function(self, x, y)
      self.position = Vector(x, y)
      self.image = love.graphics.newImage('Assets/monster11.png')
   end;
   
   update = function(self, dt)
      self.position.x = self.position.x + (math.random(-1, 1) * Player.MOVE_DISTANCE)
      self.position.y = self.position.y + (math.random(-1, 1) * Player.MOVE_DISTANCE)
   end;

   draw = function(self, time)
      love.graphics.draw(self.image, self.position.x - Tile.SIZE / 2, self.position.y - Tile.SIZE, 0, 1, 1, Tile.SIZE / 2, Tile.SIZE)
   end;
}

return Monster

