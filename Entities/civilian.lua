image = love.graphics.newImage('Assets/monster1.png')

local Civilian = Class{
   __includes = {Monster};
   init = function(self, x, y)
		Monster.init(self, x, y)
      self.damage = 0
   end;
   
   update = function(self, dt)
		Monster.update(self, dt)
		self.image = image
   end;
}

return Civilian

