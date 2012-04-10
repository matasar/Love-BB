require('lua/zone')
require('lua/player')
require('lua/square')
require("lua/board")

function love.load()
  board = Board.create("media/field_good.jpg")
end

function love.draw()
  board:draw()
end

function love.update(dt)
  board:update(dt)
end

function love.keypressed(k)
  if k == "escape" then
    love.event.push("q")
  end
end

function love.mousepressed(x, y, button)
  board:mousepressed(x,y,button)
end

function love.mousereleased(x,y, button)
  board:mousereleased(x,y,button)
end