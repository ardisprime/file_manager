
local files = {}

files.get_path = function(self)
  return self.path
end

files.remove = function(self, name)
  os.execute("rm " .. self.path .. name)  
end

files.make = function(self, name)
  local command = "touch "
  if string.sub(name, string.len(name) ) == "/" then
    command = "mkdir "
  end
  os.execute(command .. self.path .. name)
end

local go_back_a_directoy = function(path)
  -- find the last segment
  local finds = {string.find(path, "/") }
  while finds[# finds] ~= string.len(path) do
    finds[ (# finds)+1] = string.find(path, "/", finds[# finds]+1 )
  end 
  -- cut it off
  return string.sub(path, 1, finds[ (# finds)-1]-1) .. "/"
end

files.change_directory = function(self, delta_path)
  -- remove the last part if going back
  if delta_path == "../" then
    self.path = go_back_a_directoy(self.path)
    return
  elseif delta_path == "./" then
    return
  elseif delta_path == nil then return
  end
  if string.sub(delta_path, # delta_path) ~= "/" then return end
  -- add the delta path to the current path
  self.path = self.path .. string.sub(delta_path, 1, string.len(delta_path)-1 ) .. "/"
end

files.list = function(self, flags)

  flags = flags .. " -FQ --group-directories-first"

  local handler = io.popen("ls " .. flags .. " \"" .. files.get_path(self) .."\"")
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
  local handler = io.popen("echo $PWD")
  _.path = handler:read() .. "/"
  return _
end

return files

