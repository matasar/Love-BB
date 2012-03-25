Board = {}
Board.__index = Board

function Board.create(imagePath)
  local instance = {}
  setmetatable(instance, Board)
  instance:setImage(imagePath)
  return instance
end

function Board:setImage(imagePath)
  self.image = love.graphics.newImage(imagePath)
end

function Board:draw()
  love.graphics.draw(self.image)
end