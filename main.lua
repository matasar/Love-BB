require("lua/board.lua")

function love.load()
  board = Board.create("media/field_good.jpg")
end

function love.draw()
  board:draw()
end