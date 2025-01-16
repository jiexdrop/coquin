-- kissy face

local VIRTUAL_WIDTH = 4096
local VIRTUAL_HEIGHT = 2640

local sx = VIRTUAL_WIDTH / love.graphics.getWidth()
local sy = VIRTUAL_HEIGHT / love.graphics.getHeight()

local entities = {}
local spriteBatch, protagonist

local x, y = 0, 0


function love.load()
  love.graphics.setDefaultFilter("nearest", "nearest")
  love.graphics.setBackgroundColor(0.05, 0.15, 0.05)
  image = love.graphics.newImage("graphics/images.png")
  spriteBatch = love.graphics.newSpriteBatch(image)
  
  local quadPlayer = love.graphics.newQuad(0, 0, 20, 20, image:getDimensions())
  local quadGrass = love.graphics.newQuad(20, 40, 20, 20, image:getDimensions())
  local quadFence = love.graphics.newQuad(0, 40, 20, 20, image:getDimensions())
  local quadTree = love.graphics.newQuad(40, 40, 20, 20, image:getDimensions())
  
  local windowWidth, windowHeight = love.graphics.getDimensions()
  
  for baseY = 0, windowHeight, 40 do
    for baseX = 0, windowWidth, 40 do
      local quad = (
        love.math.random() < .10 and quadTree or
        love.math.random() < .03 and quadFence or
        quadGrass
      )
      table.insert(entities, {
        quad = quad,
        x = baseX + math.random(-12, 12),
        y = baseY + math.random(-8, 8),
        serial = #entities
      })
    end
  end
  
  protagonist = {quad=quadPlayer, x=0, y=0, serial=#entities}
  table.insert(entities, protagonist)
end

function love.keypressed( key, scancode, isrepeat )
   local dx, dy = 0, 0
   if scancode == "d" then -- move right
      dx = 1
   elseif scancode == "a" then -- move left
      dx = -1
   elseif scancode == "s" then -- move down
      dy = 1
   elseif scancode == "w" then -- move up
      dy = -1
   end
   move (dx, dy) 
end

function move(dx, dy)
  protagonist.x = protagonist.x + dx * 20
  protagonist.y = protagonist.y + dy * 20
end

function love.draw()
  love.graphics.push()
  love.graphics.scale(sx, sy)

  spriteBatch:clear()
  
  for _, entity in ipairs(entities) do
    spriteBatch:add(entity.quad, math.floor(entity.x), math.floor(entity.y))
  end
  
  love.graphics.draw(spriteBatch)
  
  love.graphics.print("Hello World", 100, 100)
  
  love.graphics.pop()
end

