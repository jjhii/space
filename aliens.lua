-- hold the aliens enemy class
Aliens = {}

-- create a new aliens class
Aliens.new = function(x)
  local self = self or {}
  self.x = x
  self.y = 0
  self.width = 50
  self.height = 50
  self.ships = {}
  self.timer = 50
  self.timerDuration = 50
  self.timer2 = 1000
  self.timer2Duration = 1000
  self.missed = 0
  self.hits = 0
  self.speed = 1
  self.aliens = {}
  -- load aliens image into memory
  self.image = love.graphics.newImage("resources/aliens.png")
  -- load distroyed ship image
  self.destroyedImage = love.graphics.newImage("resources/destroyed.png")
  -- ship count
  self.shipCount = 0
  -- load the alien ships.
  --  there is one lare image divided into 4 by 4 grid
  --  note, only using top to rows now
  for y=0,2 do
    for x=0,4 do
      self.shipCount = self.shipCount + 1
      self.aliens[self.shipCount] = love.graphics.newQuad(x*self.width, y*self.height, self.width, self.height, self.image:getWidth(), self.image:getHeight())
    end
  end
  
  -- draw all alien ships, this is call externally
  self.draw = function()
    for _,s in pairs(self.ships) do
      if(s.isDestroyed) then
        love.graphics.draw(self.destroyedImage, s.x+25, s.y+25, math.rad(math.random(1, 360)), 1, 1, 25, 25)
      else
        love.graphics.draw(self.image, self.aliens[s.quadIdx], s.x, s.y)
      end
    end
  end
  
  -- return the number of times we missed
  self.getMissed = function()
    return self.missed
  end

  -- update aliens' placement
  self.update = function()    
    self.x = self.x + 1
    for i,s in ipairs(self.ships) do
      if(s.isDestroyed) then
        s.distroyedTimer = s.distroyedTimer - 1
      else
        s.y = s.y + self.speed
      end
    end
    -- decerment the ship creation timer
    self.timer = self.timer - 1
    -- when ship creation timer reach zero
    --  create another alien ship
    if(self.timer <= 0) then
      -- ship holder
      s = {}
      -- set destroyed flag to false
      s.isDestroyed = false
      s.distroyedTimer = self.timerDuration
      -- set width and height of ship
      s.width = self.width
      s.height = self.height
      -- set x location based on a random value less
      --  then the width of the screen and an alien ship width
      s.x = love.math.random(1, love.graphics.getWidth() - self.width)
      -- just put it at the time
      s.y = 0
      -- randomly pick a ship to draw from our collection of ships
      s.quadIdx = love.math.random(1, self.shipCount)
      -- add ship to table
      table.insert(self.ships, s)
      self.timer = self.timerDuration
    end
    -- timer 2 is the speed timer
    --  each time we reach 0, make it go faster
    self.timer2 = self.timer2 - 1
    if(self.timer2 <= 0) then
      self.timer2 = self.timer2Duration
      self.speed = self.speed + 0.5
    end
  end
  
  -- return self
  return self
end