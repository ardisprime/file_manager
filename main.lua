
-- windows
--  o window
--   o position -> vector
--   o size -> vector
--   o buffer

local paths = require "paths"
local window = require(paths.window)
require(paths.control_sequence)

local w1 = window.new( {0, 0}, {0, 1} )

-- set terminal in raw mode without echo
os.execute("stty raw -echo")
  
-- main loop
clear_screen()
move_cursor_to( {1, 1} )
local input = ""
repeat

  input = io.read(1)
until input == "q"
input = nil

-- set terminal back in cooked mode with echo
os.execute("stty cooked echo")

