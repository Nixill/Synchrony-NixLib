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

function module.splitToList(str)
  if not str then return {} end

  local out = {}

  for token in str:gmatch("[^%s]+") do
    table.insert(out, token)
  end

  return out
end

function module.splitToSet(str)
  if not str then return {} end

  local out = {}

  for token in str:gmatch("[^%s]+") do
    out[token] = true
  end

  return out
end

return module