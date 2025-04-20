
-- window chunk test
  
paths = require "paths"
window = require(paths.window)

position = {1, 5}
size = {7, 15}
str = "hello"
w1 = window.new(position, size)

-- get position
assert(position[1] == w1.position:get(1) and position[2] == w1.position:get(2) )
-- get size
assert(size[1] == w1.size:get(1) and size[2] == w1.size:get(2) )

-- set position
-- set size

-- change buffer
w1:print_at( {2, position[2]-1}, str)
assert(w1:get_buffer_line(position[2]-1) == " hello")

print("window test PASSED")
  
