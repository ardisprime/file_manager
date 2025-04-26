
generate_id_string = function()
  math.randomseed(os.time() )
  local id_string = ""
  for i=1,5 do
    id_string = id_string .. math.random(0, 9)
  end
  return id_string
end

