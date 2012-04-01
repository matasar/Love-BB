Player = {}
Player.__index = Player

function Player.create(square)
  local x,y = square:getPosition()
  local instance = {
    image = love.graphics.newImage("media/epcatcher1b.gif"),
    zone = Zone.create(square),
    rotation = 0,
    velocity = math.random() * 0.2,
    alpha = 255,
    dragging = false,
    x = x,
    y = y,
    diffX = 0,
    diffY = 0
  }
  if math.random(2) == 1 then
    instance.velocity = instance.velocity * -1
  end
  setmetatable(instance, Player)
  square.player = instance
  return instance
end

function Player:draw(square)
  local offset = square.size / 2
  local r,g,b,a = love.graphics.getColor()
  love.graphics.setColor(r,g,b,self.alpha)
  local x,y = self:getPosition(square)
  love.graphics.draw(
    self.image,
    x + offset,
    y + offset,
    self.rotation,
    1,
    1,
    offset,
    offset
  )
  love.graphics.setColor(r,g,b,a)
  if self:shouldDrawZone() then
    self.zone:draw(square, self)
  end
end

function Player:getZoneColor()
  if love.keyboard.isDown("lshift") then
    return 255,0,0,85
  else
    return 0,0,255,85
  end
end

function Player:shouldDrawZone()
  local shift = love.keyboard.isDown("rshift") or love.keyboard.isDown("lshift")
  return shift and not self.dragging
end

function Player:dropped(board)
  self.alpha = 255
  local offset = board.squareSize / 2
  local square = board:squareAt(self.x + offset,self.y + offset)
  board:each_square(function (ea)
    if ea.player == self then
      ea.player = nil
    end
  end)
  if not square.player then
    square.player = self
  end
  self.dragging = false
  self.x = square:getX()
  self.y = square:getY()
end

function Player:getPosition(square)
  if self.dragging then
    return self.x, self.y
  else
    return square:getX(), square:getY()
  end
end

function Player:mousepressed(x,y,button)
  self.alpha = 122
  self.diffX = x - self.x
  self.diffY = y - self.y
end

function Player:update(dt)
  if self.dragging then
    self.x = love.mouse.getX() - self.diffX
    self.y = love.mouse.getY() - self.diffY
  end
  self.rotation = self.rotation + self.velocity -- SPIN THE MAN
end
