
-- control sequences:
--  o \27[35m

paths = require "paths"
vector = require(paths.vector)

local window = {}

window.position = vector.new()
window.size = vector.new()
window.buffer = {}

window.print_at = function(self, position, str)
  for i=1,2 do 
    if position[i] <= 0 then return nil end
  end
  if # str <= 0 then return nil end

  -- insert needed array strings
  for i=(# self.buffer)+1,position[2] do 
    table.insert(self.buffer, "")
  end
  -- insert needed characters in string
  for i=(# self.buffer[position[2] ] )+1,position[1]-1 do 
    self.buffer[position[2] ] = self.buffer[position[2] ] .. " "
  end
  -- insert string
  self.buffer[position[2] ] = string.sub(self.buffer[position[2] ], 1, position[1]-1) .. str .. string.sub(self.buffer[position[2] ], position[1]+(# str))
end

window.refresh = function(self)
  local char
  for y=1,self.size[2] do
    for x=1,self.size[1] do
      move_cursor_to( {x+self.position[1]-1, y+self.position[2]-1} )
      if (# self.buffer < y) or (# self.buffer[y] < x) then
        char = " "
      else
        char = string.sub(self.buffer[y], x, x) 
      end
      io.write(char)
    end
  end
end

window.new = function(position, size)
  for i=1,2 do 
    if (size[i] <= 0) or (position[i] <= 0) then return nil end
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

