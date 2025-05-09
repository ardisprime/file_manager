
-- file manager:
-- # o window:
-- #   o position -> vector
-- #   o size -> vector
-- #   o buffer
-- #   o clear buffer
-- # o files:
-- #   o ls
-- #   o cd
-- #   o all toggle
-- #   o make file/dir
-- #   o remove to /tmp
-- #   o copy
--     o paste (rename if file already exists, with floating window) 
--     o rename
--   o overlay
--     o base overlay
--     o get input string in floating window
--     o move n lines
--     o colors <- make symlink to dirs have slash, but symlink color
--     o visual feedback
--     o matching terminal size 
--       o dynamic?
--     o layers


local paths = require "paths"
local window = require(paths.window)
local files = require(paths.files)
local vector = require(paths.vector)
require(paths.control_sequence)
require(paths.utils)

id_string = generate_id_string()
local w1 = window.new( {1, 1}, {20, 20} )
local f1 = files.new()
local selection_char = "*"

-- set terminal in raw mode without echo
os.execute("stty raw -echo")
os.execute("setterm --cursor off")

-- main loop
local input = ""
local file_list = {}
local buf = 0
local selection = 1
local list_flags = ""
clear_screen()
window.print_at(w1, {1, selection}, selection_char)
repeat
  -- graphics
  window.clear_buffer(w1)
  file_list = files.list(f1, list_flags)
  for i=1,vector.get(w1.size, 2) do
    if file_list[i] ~= nil then 
      window.print_at(w1, {2, i}, file_list[i] )
    end
  end
  if selection <= 0 then selection = 1 
  elseif selection > # file_list then selection = # file_list end
  window.print_at(w1, {1, selection}, selection_char)
  window.refresh(w1)

  -- input handling
  input = io.read(1)
  buf = 0
  if input == "l" then 
    files.change_directory(f1, files.selected_file(f1, list_flags, selection) )
  elseif input == "h" then 
    files.change_directory(f1, "../")
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
  elseif input == "r" then 
    files.rename(f1, "tmp", "tmp2")
  elseif input == "p" then 
    files.paste(f1)
  elseif input == "y" then 
    -- copy selected file
    files.copy(f1, files.selected_file(f1, list_flags, selection) )
  elseif input == "d" then 
    -- delete selected file
    local float_win = window.new( {4, 2}, {20, 5} )
    local name = files.selected_file(f1, list_flags, selection)
    local finished = false
    repeat 
      window.print_at(float_win, {2, 2}, "DELETE " .. name .. " ?")
      window.print_at(float_win, {2, 4}, "[y]es/[n]o")
      window.refresh(float_win) 
      input = io.read(1)
      if input == "y" then
        files.remove(f1, name)
        finished = true
      elseif input == "n" then
        finished = true
      end
    until finished
    float_win = nil
  elseif input == "c" then 
    -- create file or folder
    -- backspace: 127
    -- enter: 13
    local finished = false
    local name = ""
    local float_win = window.new( {4, 2}, {20, 3} )
    repeat 
      if name == "" then name = "_" end
      window.clear_buffer(float_win)
      window.print_at(float_win, {2, 2}, name)
      window.refresh(float_win) 
      input = io.read(1)
      if name == "_" then name = "" end
      if input == "q" or string.byte(input) == 13 then
        finished = true
      elseif string.byte(input) == 127 then
        name = string.sub(name, 1, string.len(name)-1)
      else
        name = name .. input
      end
    until finished
    float_win = nil
    files.make(f1, name)
  end
  if (buf == 1) or (buf == -1) then
    selection = selection + buf 
  end 

until input == "q"

-- remove temporary file to keep a clean file system
files.clear_temporary_file(f1)
-- set terminal back in cooked mode with echo
os.execute("setterm --cursor on")
os.execute("stty cooked echo")

