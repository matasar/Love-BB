Board = {}
Board.__index = Board

function Board.create(imagePath)
  local instance = {
    width = 30,
    height = 15,
    offset = 1
  }
  setmetatable(instance, Board)
  instance:setImage(imagePath)
  instance:buildSquares()
  return instance
end

function Board:setImage(imagePath)
  self.image = love.graphics.newImage(imagePath)
end

function Board:buildSquares()
  self.squares = {}
  for i = 1,30 do
    self.squares[i] = {}
    for j = 1,15 do
      self.squares[i][j] = Square.create(i,j)
    end
  end
end

function Board:draw()
  love.graphics.draw(self.image)
  for x,row in ipairs(self.squares) do
    for y,square in ipairs(row) do
      square:draw()
    end
  end
end

function Board:mousepressed(x, y, button)
  xIndex, yIndex = self:squareAt(x,y)
  print(xIndex .. ',' .. yIndex)
  self.squares[xIndex][yIndex]:mousepressed(button)
end

function Board:squareAt(x,y)
  xIndex = math.floor(math.abs(x - self.offset) / 30) + 1
  yIndex = math.floor(math.abs(y - self.offset) / 30) + 1
  return xIndex, yIndex
end