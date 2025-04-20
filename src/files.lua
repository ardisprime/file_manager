
local files = {}

files.path = "$HOME"

files.get_path = function(self)
  return self.path
end

files.list = function(self)
    
  local handler = io.popen("ls -FQ --group-directories-first " .. self:get_path() )
  -- read all file names out of handler output
  local file_list = {}
  local buffer = handler:read()
  while buffer ~= nil do
    file_list[ (# file_list)+1] = buffer
    buffer = handler:read()
  end

  -- clear " out of names
  local id_ch = ""
  for i,v in ipairs(file_list) do
    id_ch = string.sub(file_list[i], string.len(file_list[i] ) )
    if id_ch == "\"" then
      id_ch = ""
    end
    file_list[i] = string.sub(file_list[i], 2, string.find(file_list[i], "\"", 2)-1 ) .. id_ch
  end
  
  return file_list
end

files.new = function()
  local _ = {}
  setmetatable(_, {__index = files} )
  return _
end

return files
  
