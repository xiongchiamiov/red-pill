local imgs = {
   love.graphics.newImage('Assets/monster1.png'),
   love.graphics.newImage('Assets/monster2.png'),
   love.graphics.newImage('Assets/monster3.png'),
   love.graphics.newImage('Assets/monster4.png'),
   love.graphics.newImage('Assets/monster5.png'),
   love.graphics.newImage('Assets/monster6.png'),
   love.graphics.newImage('Assets/monster7.png'),
   love.graphics.newImage('Assets/monster8.png'),
   love.graphics.newImage('Assets/monster9.png'),
   love.graphics.newImage('Assets/monster10.png'),
   love.graphics.newImage('Assets/monster11.png')
}

local Monster = Class{
   __includes = {Civilian};
   init = function(self, x, y)
		Civilian.init(self, x, y)
      self.damage = 1
   end;
   
   update = function(self, dt)
		Civilian.update(self, dt)
      
      self.image = imgs[math.ceil(redPillEffectiveness)]

      local vecToPlayer = Player.player.position - self.position
      if vecToPlayer:len() <= Monster.VISION_DISTANCE then
         vecToPlayer = vecToPlayer:normalize_inplace() * Monster.MOVE_DISTANCE * dt
         self:move(vecToPlayer.x, vecToPlayer.y)
      end
   end;
}

return Monster

