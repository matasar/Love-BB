require('lua/player.lua')
require('lua/square.lua')
require("lua/board.lua")

function love.load()
  board = Board.create("media/field_good.jpg")
end

function love.draw()
  board:draw()
end

function love.mousepressed(x, y, button)
	board:mousepressed(x,y,button)
end
