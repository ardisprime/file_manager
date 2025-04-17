
-- vector chunk test

paths = require "paths"
vector = require(paths.vector)

v1 = vector.new()

-- start values and get function
assert(v1:get(1) == 0)
assert(v1:get(2) == 0)

-- changing values
new_values = {5, 10}
v1:set(1, new_values[1])
v1:set(2, new_values[2])
assert(v1:get(1) == new_values[1] )
assert(v1:get(2) == new_values[2] )
  
-- 2 vectors working independently
v2 = vector.new()
v2:set(1, new_values[2])
v2:set(2, new_values[1])
assert(v1:get(1) == v2:get(2) )
assert(v1:get(2) == v2:get(1) )

