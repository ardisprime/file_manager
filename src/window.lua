
-- control sequences:
--  o \27[35m

paths = require "paths"
vector = require(paths.vector)

local window = {}

window.position = vector.new()
window.size = vector.new()
window.buffer = {}

window.print_at = function(position, string_)
  move_cursor_to(position)
  -- TODO implement buffer write
end

window.new = function(position, size)
  for i=1,2 do 
    if (size[i] <= 0) or (position[i] < 0) then return nil end
  end
  local _ = {}
  setmetatable(_, {__index = window} )
  for i=1,2 do
    _.position:set(i, position[i])
    _.size:set(i, size[i])
  end
  return _
end

return window

