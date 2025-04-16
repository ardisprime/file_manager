
-- window has:
--  o position x,y
--  o size w,h
--  o buffer containing content

local size_ = require "src/size"
local pos_ = require "src/position"
  
-- TEST FUNCTION --
local test_print_ = function(input)
  print(input)
end

return {
  test_print = test_print_,
  get_size = size_.get,
  set_size = size_.set,
  get_pos = get_pos_,
  set_pos = set_pos_
}

