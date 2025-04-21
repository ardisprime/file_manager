
-- file manager:
-- # o window:
-- #   o position -> vector
-- #   o size -> vector
-- #   o buffer
-- #   o clear buffer
--   o files:
-- #   o ls
-- #   o cd
-- #   o all toggle
--     o make file/dir
--     o del
--     o mv
--     o rename
--   o overlay
--     o matching terminal size 
--       o dynamic?
--     o colors <- make symlink to dirs have slash, but symlink color

local paths = require "paths"
local window = require(paths.window)
local files = require(paths.files)
require(paths.control_sequence)

local w1 = window.new( {1, 1}, {20, 20} )
local f1 = files.new()
local selection_char = "*"

-- set terminal in raw mode without echo
os.execute("stty raw -echo")

-- main loop
local input = ""
local file_list = {}
local buf = 0
local selection = 1
local list_flags = ""
clear_screen()
w1:print_at( {1, selection}, selection_char)
repeat
    
  -- graphics
  w1:clear_buffer()
  file_list = f1:list(list_flags)
  for i=1,w1.size:get(2) do
    if file_list[i] ~= nil then 
      w1:print_at( {2, i}, file_list[i] )
    end
  end
  if selection <= 0 then selection = 1 
  elseif selection > # file_list then selection = # file_list end
  w1:print_at( {1, selection}, selection_char)
  w1:refresh()

  -- input handling
  input = io.read(1)
  buf = 0
  if input == "l" then 
    f1:change_directory(f1:list(list_flags .. " -L")[selection] )
  elseif input == "h" then 
    f1:change_directory("../")
  elseif input == "j" then buf = 1 
  elseif input == "k" then buf = -1 
  elseif input == "a" then 
    -- toggle list all flag
    if string.find(list_flags, " %-A") == nil then 
      list_flags = list_flags .. " -A"
    else 
      local start, stop = string.find(list_flags, " %-A")
      list_flags = string.sub(list_flags, 1, start-1) .. string.sub(list_flags, stop+1)
    end
  end
  if (buf == 1) or (buf == -1) then
    selection = selection + buf 
  end 

until input == "q"
  
-- set terminal back in cooked mode with echo
os.execute("stty cooked echo")

