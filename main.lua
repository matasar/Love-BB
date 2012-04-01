require('lua/zone.lua')
require('lua/player.lua')
require('lua/square.lua')
require("lua/board.lua")

function love.load()
  board = Board.create("media/field_good.jpg")
end

function love.draw()
  board:draw()
end

function love.update(dt)
  board:update(dt)
end

function love.mousepressed(x, y, button)
  board:mousepressed(x,y,button)
end

function love.mousereleased(x,y, button)
  board:mousereleased(x,y,button)
end