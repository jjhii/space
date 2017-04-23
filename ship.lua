-- hold the ship class
Ship = {}

-- create a new ship class
Ship.new = function()
  local self = self or {}
  self.x = love.graphics.getWidth() / 2
  self.y = love.graphics.getHeight() - 20
  self.width = 40
  self.height = 10
  -- speed of ship
  self.speed = 10
  -- load our lovely ship image
  self.image = love.graphics.newImage("resources/ship.png")
  
  -- draw the ship, this is call externally
  self.draw = function()
    love.graphics.draw(self.image, self.x, self.y)
  end

  -- update the ship location on key hit
  self.update = function()
    if(love.keyboard.isDown("right")) then 
      if(self.x <= love.graphics.getWidth() - self.width) then
        self.x = self.x + self.speed
      end
    end
    if(love.keyboard.isDown("left")) then 
      if(self.x >= 1) then
        self.x = self.x - self.speed
      end
    end
  end
  
  -- get our ship's location and return it
  self.getPosition = function()
    return self.x + self.width / 2, self.y
  end
    
  -- return self
  return self
end