
-- important control sequences:
--  o cursor:
--    o up: nA
--    o down: nB
--    o right: nC
--    o left: nD
--    o next line: nE
--    o prev line: nF
--    o horizontal abs: nG
--    o position: n;mH
--  o erase:
--    o in display: nJ 
--      o n=0: from cursor to end
--      o n=1: from cursor to beginning
--      o n=2: entire screen
--      o n=3: entire screen + scrollback buffer
--    o in line: nK 
--      o n=0: from cursor to end
--      o n=1: from cursor to beginning
--      o n=2: entire line
--  o graphics: nm (see doc)

send_ctrl_seq = function(sequence)
  io.write("\27[" .. sequence)
end

move_cursor_to = function(position)
  send_ctrl_seq(position[1] .. ";" .. position[2] .. "H")
end

clear_screen = function()
  send_ctrl_seq("2J")
end

