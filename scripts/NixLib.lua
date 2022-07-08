local Netplay   = require "necro.network.Netplay"
local Resources = require "necro.client.Resources"

local NLEvent = require "NixLib.NixLibEvents"

local module = {}

function module.bitSplit(value, log)
  local out = {}

  for i = 31, 0, -1 do
    local twoI = bit.lshift(1, i)
    if bit.band(value, twoI) == twoI then
      if log then
        table.insert(out, i)
      else
        table.insert(out, twoI)
      end
    end
  end

  return out
end

function module.checkFlags(value, test, all)
  if all then return bit.band(value, test) == test
  else return bit.band(value, test) ~= 0 end
end

function module.extendTable(table, key)
  local index = 1
  for k, v in pairs(table) do
    index = index + 1
  end
  table[key] = index
  return index
end

function module.getComponent(name)
  return NLEvent.getComponentTable()[name]
end

function module.getComponents()
  return NLEvent.getComponentTable()
end

function module.getModVersion(modName)
  local mods = Resources.getData(Netplay.Resource.MOD_LIST)

  if mods == nil then return nil end

  for i, v in ipairs(mods) do
    if v.name == modName then
      return v.name, v.package
    end
  end

  return false
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

function module.ternary(cond, iftrue, iffalse)
  if cond then
    return iftrue
  else
    return iffalse
  end
end

return module
