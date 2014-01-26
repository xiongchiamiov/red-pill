local img = {
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

-- image to pick, in 22nds
local imgToPick = {
   img[1], img[1], img[1], img[1], img[1],
   img[2], img[2], img[2],
   img[3], img[3], img[3],
   img[4], img[4],
   img[5], img[5],
   img[6],
   img[7],
   img[8],
   img[9],
   img[10],
   img[11], img[11]
}

local Monster = Class{
   __includes = {Civilian};
   typ = 'monster';
   init = function(self, x, y)
      Civilian.init(self, x, y)
      self.damage = 1
   end;

   update = function(self, dt)
      Civilian.update(self, dt)
      self.image = imgToPick[math.ceil(Player.player.sanity / 5)]
   end;

   moveToDestination = function(self, dt)
      local vecToPlayer = Player.player.position - self.position
      if vecToPlayer:len() <= Monster.VISION_DISTANCE then
         vecToPlayer = vecToPlayer:normalize_inplace() * Monster.MOVE_DISTANCE * dt
         self:move(vecToPlayer.x, vecToPlayer.y)
      else
         Civilian.moveToDestination(self, dt)
      end
   end;
}

return Monster

