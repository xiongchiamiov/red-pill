local image = love.graphics.newImage('Assets/pill_color.png')

local Text = Class{
   init = function(self, x, y, text)
      self.position = Vector(
         x + Tile.SIZE / 2,
         y + Tile.SIZE / 2)
      self.text = text
      self.bgColor = {255, 255, 255, 100}
      self.textColor = {0, 0, 0, 255}
    end;

   draw = function(self, time)
      local r, g, b, a = love.graphics.getColor()
      
      love.graphics.setColor(self.bgColor)
      love.graphics.rectangle('fill', self.position.x, self.position.y,
         self.TEXT_WIDTH, self.TEXT_HEIGHT)
      love.graphics.setColor(self.textColor)
      love.graphics.printf(
         self.text,
         self.position.x + self.PADDING,
         self.position.y + self.PADDING,
         self.TEXT_WIDTH - self.PADDING * 2)
      
      love.graphics.setColor(r, g, b, a)
   end;
   TEXT_WIDTH = 5 * Tile.SIZE;
   TEXT_HEIGHT = 2 * Tile.SIZE;
   PADDING = 8;
}

return Text

