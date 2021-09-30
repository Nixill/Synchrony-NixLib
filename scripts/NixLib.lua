local module = {}

function module.checkFlags(value, test, all)
  if all then return bit.band(value, test) == test
  else return bit.band(value, test) ~= 0 end
end

function module.median(a, b, c)
  if (a >= b and b >= c) then return b
  elseif (a <= b and b <= c) then return b
  elseif (b <= a and a <= c) then return a
  elseif (b >= a and a >= c) then return a
  elseif (a >= c and c >= b) then return c
  elseif (a <= c and c <= b) then return b
  end
end

function module.splitToList(str, sep)
  if not str then return {} end
  sep = sep or "%s"
  
  local out = {}
  
  for token in str:gmatch("[^" .. sep .. "]+") do
    table.insert(out, token)
  end
  
  return out
end

function module.splitToSet(str, sep, del, def)
  if not str then return {} end
  sep = sep or "%s"
  del = del or ":"
  def = def or true

  local out = {}

  for token in str:gmatch("[^" .. sep .. "]+") do
    local k, v = string.match(token, "^([^" .. del .. "]+)" .. del .. "(.+)$")
    if k then out[k] = v
    else out[token] = true end
  end

  return out
end

return module