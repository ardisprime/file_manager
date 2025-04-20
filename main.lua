
-- windows
--  o window
--   o position -> vector
--   o size -> vector
--   o buffer

local paths = require "paths"
local window = require(paths.window)
require(paths.control_sequence)

-- local w1 = window.new( {1, 1}, {10, 10} )
local w1 = window.new( {10, 10}, {10, 5} )

print(string.sub("hello", 2) )

-- set terminal in raw mode without echo
os.execute("stty raw -echo")
  
-- main loop
clear_screen()
move_cursor_to( {2, 2} )
local input = ""
repeat
  w1:print_at( {1, 1}, "hello")
  w1:refresh()

  input = io.read(1)
until input == "q"
input = nil

-- set terminal back in cooked mode with echo
os.execute("stty cooked echo")

