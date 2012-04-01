Board = {}
Board.__index = Board

function Board.create(imagePath)
  local instance = {
    width = 30,
    height = 15,
    offset = 0
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
      self.squares[i][j] = Square.create(i,j, self)
    end
  end
end

function Board:each_square(fn)
  for x,row in ipairs(self.squares) do
    for y,square in ipairs(row) do
      fn(square,x,y)
    end
  end
end

function Board:draw()
  love.graphics.draw(self.image)
  self:each_square(function(ea)
    ea:draw()
  end)
end

function Board:update(dt)
  self:each_square(function (ea)
    ea:update(dt)
  end)
  if love.mouse.isDown("l") and self.player then
    local x,y = love.mouse.getPosition()
    self.player:draggedTo(x,y)
  end
end

function Board:mousepressed(x, y, button)
  local square = self:squareAt(x,y)
  square:mousepressed(button)
  if square.player and love.mouse.isDown("l") then
    self.player = square.player
    self.player.dragging = true
  elseif not self.player and love.mouse.isDown("r") then
    Player.create(square)
  end
end

function Board:mousereleased(x,y,button)
  if self.player then
    self.player:dropped(self)
    self.player = nil
  end
end

function Board:squareAt(x,y)
  xIndex = math.floor(math.abs(x - self.offset) / 30) + 1
  yIndex = math.floor(math.abs(y - self.offset) / 30) + 1
  return self.squares[xIndex][yIndex]
end