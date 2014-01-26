local image = love.graphics.newImage('Assets/pill_color.png')

local PILL_INCREASE_SANITY = 60

local Pill = Class{
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
      love.graphics.draw(self.image, self.position.x - Tile.SIZE / 2, self.position.y - Tile.SIZE, 0, 1, 1)
   end;

    effect = function(self)
       if not sanityEnabled then
          sanityEnabled = true
       else
          Player.player.sanity = Player.player.sanity + PILL_INCREASE_SANITY
       end
       self.health = 0
       return 0
    end;
}

return Pill

