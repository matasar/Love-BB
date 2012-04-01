Square = {}
Square.__index = Square

function Square.create(x,y, board)
  local instance = {
    size = board.squareSize,
    xIndex = x,
    yIndex = y,
    state = false,
    board = board
  }
  setmetatable(instance, Square)
  return instance
end

function Square:mousepressed(x,y,button)
  if self.player then
    self.player:mousepressed(x,y,button)
  end
end

function Square:getX()
  return ((self.xIndex - 1) * self.size) + board.offset
end

function Square:getY()
  return ((self.yIndex - 1) * self.size) + board.offset
end

function Square:getPosition()
  return self:getX(), self:getY()
end

function Square:update(dt)
  if self.player then
    self.player:update(dt)
  end
end

function Square:draw()
  if self.player then
    self.player:draw(self)
  end
end