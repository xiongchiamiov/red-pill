local Missile = Class{
   init = function(self, x, y, direction, radius)
      self.position = Vector(x, y)
      self.direction = direction:normalized()
      self.boundingBox = Collider:addCircle(x, y, radius)
   end;
   
   update = function(self, dt)
      self.position = self.position + (self.direction * self.speed * dt)
      self.boundingBox:moveTo(self.position.x, self.position.y)
   end;
}

return Missile

