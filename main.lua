-- kissy face

local VIRTUAL_WIDTH = 3200
local VIRTUAL_HEIGHT = 1600

local sx = VIRTUAL_WIDTH / love.graphics.getWidth()
local sy = VIRTUAL_HEIGHT / love.graphics.getHeight()

local entities = {}
local spriteBatch, protagonist, radish

local x, y = 0, 0


function love.load()
  love.graphics.setDefaultFilter("nearest", "nearest")
  love.graphics.setBackgroundColor(0.38, 0.60, 1.0)
  image = love.graphics.newImage("graphics/images.png")
  spriteBatch = love.graphics.newSpriteBatch(image)
  
  local quadPlayer = love.graphics.newQuad(0, 0, 20, 20, image:getDimensions())
  local quadChicken = love.graphics.newQuad(0, 20, 20, 20, image:getDimensions())
  local quadChick = love.graphics.newQuad(20, 20, 20, 20, image:getDimensions())
  local quadGround = love.graphics.newQuad(20, 40, 20, 20, image:getDimensions())
  local quadFence = love.graphics.newQuad(0, 40, 20, 20, image:getDimensions())
  local quadTree = love.graphics.newQuad(40, 40, 20, 20, image:getDimensions())
  local quadSun = love.graphics.newQuad(60, 40, 20, 20, image:getDimensions())
  local quadGrass = love.graphics.newQuad(20, 0, 20, 20, image:getDimensions())
  local quadRadish = love.graphics.newQuad(20, 60, 20, 20, image:getDimensions())
  
  local windowWidth, windowHeight = love.graphics.getDimensions()
  

  for baseX = 0, 180, 20 do
    table.insert(entities, {
      quad = quadGround,
      x = baseX,
      y = 80,
      serial = #entities,
      name = "ground",
      direction=true
    })
  end

  for baseX = 20, 160, 20 do
    table.insert(entities, {
      quad = quadGrass,
      x = baseX,
      y = 60,
      serial = #entities,
      name = "grass",
      direction=true
    })
  end

  table.insert(entities, {
    quad = quadTree,
    x = 0,
    y = 60,
    serial = #entities,
    name = "tree",
    direction=true
  })
  
  table.insert(entities, {
    quad = quadTree,
    x = 180,
    y = 60,
    serial = #entities,
    name = "tree",
    direction=true
  })

  table.insert(entities, {
    quad = quadSun,
    x = 160,
    y = 10,
    serial = #entities,
    name = "sun",
    direction=true
  })

  radish = {quad = quadRadish, 
    x = math.random(1, 8) * 20, 
    y = 60, 
    serial = #entities, 
    name = "radish",
    direction=true
  }
  
  table.insert(entities, radish)
  
  chicken = {quad = quadChicken, 
    x = 20, 
    y = 60, 
    serial = #entities, 
    name = "Chicken",
    direction=true
  }
  
  table.insert(entities, chicken)
  
  chick = {quad = quadChick, 
    x = 40, 
    y = 60, 
    serial = #entities, 
    name = "Chick",
    direction=true
  }
  
  table.insert(entities, chick)


  protagonist = {quad=quadPlayer, x=60, y=60, serial=#entities, name="Pedrez", direction=true}
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
  if protagonist.x < 20 then
    dx = 1
  end
  if protagonist.x > 160  then
    dx = -1
  end

  protagonist.x = protagonist.x + dx * 20
  if dx == 1 then
    protagonist.direction = true
  else
    protagonist.direction = false
  end
  
  if radish.x == protagonist.x and radish.y == protagonist.y then
    radish.x = radish.x + dx * 20
  end
  
end

timer = 0

function love.update(dt)
  timer = timer + dt
  
  if timer >= 3 then    
   
    for i, entity in ipairs(entities) do
      if entity.name == "radish" then
        
      end
    end
    
    timer = 0
  end
end

function love.draw()
  love.graphics.push()
  love.graphics.scale(sx, sy)

  spriteBatch:clear()
  
  for _, entity in ipairs(entities) do
    if entity.direction then
      spriteBatch:add(entity.quad, math.floor(entity.x), math.floor(entity.y), 0, 1, 1)
    else
      spriteBatch:add(entity.quad, math.floor(entity.x + 20), math.floor(entity.y), 0, -1, 1)
    end
  end
  
  love.graphics.draw(spriteBatch)
  
  love.graphics.print("Hello World", 100, 100)
  
  love.graphics.pop()
end

