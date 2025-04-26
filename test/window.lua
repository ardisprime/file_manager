
-- window chunk test
  
local paths = require "paths"
local window = require(paths.window)
local vector = require(paths.vector)

local position = {1, 5}
local size = {7, 15}
local str = "hello"
local w1 = window.new(position, size)

-- get position
assert(vector.get(w1.position, 1) == position[1] )
assert(vector.get(w1.position, 2) == position[2] )
-- get size
assert(vector.get(w1.size, 1) == size[1] )
assert(vector.get(w1.size, 2) == size[2] )

-- ?
-- set position
-- set size

-- change buffer
window.print_at(w1, {2, 2}, str)
assert(window.get_buffer_line(w1, 2) == " hello")

print("== PASSED: window test ==")
  
