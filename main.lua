
-- file manager:
-- # o window:
-- #   o position -> vector
-- #   o size -> vector
-- #   o buffer
--   o files:
-- #   o ls
--     o cd
--     o make file/dir
--     o del
--     o mv
--     o rename

local paths = require "paths"
local window = require(paths.window)
local files = require(paths.files)
require(paths.control_sequence)

local w1 = window.new( {1, 1}, {20, 20} )
local f1 = files.new()

-- set terminal in raw mode without echo
os.execute("stty raw -echo")

-- main loop
local input = ""
local buf = ""
clear_screen()
repeat
  -- print the file list in current path
  buf = f1:list()
  for i=1,w1.size:get(2) do
    if buf[i] ~= nil then 
      w1:print_at( {2, i}, buf[i] )
    end
  end
  w1:refresh()

  -- get input
  input = io.read(1)
until input == "q"
  
-- set terminal back in cooked mode with echo
os.execute("stty cooked echo")

