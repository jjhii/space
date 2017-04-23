-- hold the bullets class
Bullets = {}

-- create a new bullets class
Bullets.new = function(ship)
  local self = self or {}
  self.x = 0
  self.y = 0
  self.radius = 3
  self.timer = 10
  self.rounds = {}
  self.ship = ship
  -- load bullet image into memory
  self.image = love.graphics.newImage("resources/bullet.png")
  
  -- draw all bullets, this is call externally
  self.draw = function()
    for _,r in pairs(self.rounds) do
      -- love.graphics.circle("fill", r.x, r.y, self.radius)
      love.graphics.draw(self.image, r.x, r.y)
    end
  end

  -- update bullet location and remove if off screen5
  self.update = function()
    for i,r in ipairs(self.rounds) do
      r.y = r.y - 3
      if(r.y <= 0) then 
        table.remove(self.rounds, i) 
      end
    end
    self.timer = self.timer - 1
    if(love.keyboard.isDown("space") and self.timer <= 0) then
      self.timer = 10
      r = {}
      x,y = ship:getPosition()
      r.x = x + 4
      r.y = y + 10
      r.width = self.radius
      r.height = self.radius
      table.insert(self.rounds, r)
    end
  end
  
  -- return self
  return self
end