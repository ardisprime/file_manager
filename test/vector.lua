
-- vector chunk test

local paths = require "paths"
local vector = require(paths.vector)

local v1 = vector.new()

-- start values and get function
assert(vector.get(v1, 1) == 1)
assert(vector.get(v1, 2) == 1)

-- changing values
local new_values = {5, 10}
vector.set(v1, 1, new_values[1])
vector.set(v1, 2, new_values[2])
assert(vector.get(v1, 1) == new_values[1] )
assert(vector.get(v1, 2) == new_values[2] )

-- 2 vectors working independently
local v2 = vector.new()
vector.set(v2, 1, new_values[2])
vector.set(v2, 2, new_values[1])
assert(vector.get(v1, 1) == vector.get(v2, 2) )
assert(vector.get(v1, 2) == vector.get(v2, 1) )

print("== PASSED: vector test ==")

