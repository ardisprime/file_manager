
local vector_ = {0, 0, a = 0}

local set_ = function(value)
  vector_[which] = value
end

local get_ = function(self, which)
  return self[which]
end

return {
  get = get_,
  set = set_
}

