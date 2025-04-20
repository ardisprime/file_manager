
local vector = {}

vector[1] = 1
vector[2] = 1

vector.get = function(self, index)
  -- check if getting at index is allowed
  if index ~= 1 and index ~= 2 then return end

  return self[index]
end

vector.set = function(self, index, value)
  -- check if setting at index is allowed
  if index ~= 1 and index ~= 2 then return end
  self[index] = value
end

vector.new = function()
  local _ = {}
  setmetatable(_, {__index = vector} )
  return _
end

return vector

