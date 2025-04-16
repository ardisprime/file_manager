
local size_ = {w = 0, h = 0}

local set_ = function(which, value)
  -- check if input is in correct format
  if tonumber(value) == nil then
    return
  end 

  if which == "w" then
    size_.w = value
  elseif which == "h" then
    size_.h = value
  end 

end

local get_ = function(which)
  if which == "w" then
    return size_.w
  elseif which == "h" then
    return size_.h
  end 
  return nil
end

return {
  get = get_,
  set = set_
}

