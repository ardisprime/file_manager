
-- window chunk test
  
paths = require "paths"
window = require(paths.window)
vector = require(paths.vector)

position = {1, 5}
size = {7, 15}
str = "hello"
w1 = window.new(position, size)

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

print("window test PASSED")
  
