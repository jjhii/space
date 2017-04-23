-- hold the score keeper class
ScoreKeeper = {}

-- create a new score keeper class
ScoreKeeper.new = function()
  local self = self or {}
  self.width = 200
  self.height = 20
  self.x = (love.graphics.getWidth() / 2) - (self.width / 2)
  self.y = 0
  self.hit = 0
  self.miss = 0
  -- user message
  self.message = ''
  self.messageTimer = 0
  
  -- draw the score at the top of the screen, this is call externally
  self.draw = function()
      love.graphics.rectangle("line", self.x, self.y, self.width, self.height)
      -- todo: make this look nicer
      love.graphics.print("   hit " .. self.hit .. " missed " .. self.miss, self.x, self.y)
      if self.messageTimer > 0 then
        self.messageTimer = self.messageTimer - 1
        -- show message below score
        -- todo: center message, make it look nicer
        love.graphics.print(self.message, self.x, self.y + 20)
      end
  end
  
  -- incerment the number of hits
  self.addHit = function()
    self.hit = self.hit + 1
  end
  
  -- incerment the number of misses
  self.addMiss = function()
    self.miss = self.miss + 1
  end
  
  -- set user message
  self.setMessage = function(msg)
    self.message = msg
    -- set the duration of time for showing message
    self.messageTimer = 50
  end
  
  -- return self
  return self
end
