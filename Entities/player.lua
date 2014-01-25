local Player = Class{
   init = function(self)
      self.position = Vector(400, 400)
      self.image = love.graphics.newImage('Assets/player.png')
   end
}

function Player:draw(time)
   love.graphics.draw(self.image, self.position.x, self.position.y)
end

return Player

