require("aliens")
require("ship")
require("bullets")
require("scorekeeper")

-- holder for our ship
local ship = nil
-- holder for the missles we file
local bullets = nil
-- holder for alien ships
local aliens = nil
-- holder for the score keeper
local score = nil

-- main load
function love.load()
  -- createthe score keeper
  score = ScoreKeeper.new()
  -- create our ship holder
  ship = Ship.new()
  -- create hold for our ammo
  bullets = Bullets.new(ship)
  -- create the alien ship holder
  aliens = Aliens.new(10)
end

-- draw the screen by calling each holder's
--  draw function in turn
function love.draw()
  ship:draw()
  aliens:draw()
  bullets:draw()
  score:draw()
end

-- snipit found on love2d site
-- Collision detection function;
-- Returns true if two boxes overlap, false if they don't;
-- x1,y1 are the top-left coords of the first box, while w1,h1 are its width and height;
-- x2,y2,w2 & h2 are the same, but for the second box.
function CheckCollision(x1,y1,w1,h1, x2,y2,w2,h2)
  return x1 < x2+w2 and
         x2 < x1+w1 and
         y1 < y2+h2 and
         y2 < y1+h1
end

-- main update loop
function love.update(dt)
  aliens:update()
  ship:update()
  bullets:update()
  
  -- check for impact and remove ship/bullets
  --  the are collide
  for i,s in ipairs(aliens.ships) do 
    -- if ship is destroyed then just wait for zero
    --  and then remove the ship
    if(s.isDestroyed) then
      if s.distroyedTimer <= 0 then
        table.remove(aliens.ships, i)
      end
    else
      -- if ship gets to the bottom of the screen
      --  we have a miss, update score
      if(s.y > love.graphics.getHeight()) then
          s.isDestroyed = true;
          score.addMiss()
      else
        -- if bullet hits a ship, we have a hit
        --  remove the ship, bullet, and update score
        for x,b in ipairs(bullets.rounds) do
          if CheckCollision(b.x, b.y, b.width, b.height, s.x, s.y, s.width, s.height) then
            s.isDestroyed = true
            table.remove(bullets.rounds, x)
            score:addHit()
            break
          end
        end
      end
    end
  end
end
