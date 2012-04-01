-- Represents a tacklezone

Zone = {}
Zone.__index = Zone

function Zone.create()
  local instance = {}
  setmetatable(instance, Zone)
  return instance
end

function Zone:draw(square, player)
  local x,y,size = self:dimensions(square)
  local r,g,b,a = love.graphics.getColor()
  love.graphics.setColor(player:getZoneColor())
  love.graphics.rectangle(
    "fill",
    x,
    y,
    size,
    size
  )
  love.graphics.setColor(r,g,b,a)
end

function Zone:dimensions(square)
  local x = square:getX() - square.size
  local y = square:getY() - square.size
  return x, y, square.size * 3
end

function Zone:xIndex()
  return math.max(self.square.xIndex - 1, 1)
end

function Zone:yIndex()
  return math.max(self.square.yIndex - 1, 1)
end