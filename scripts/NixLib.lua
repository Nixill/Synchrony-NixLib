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

-- function module.extendTable(tbl, key)
--   local index = 1
--   for k, v in pairs(tbl) do
--     index = index + 1
--   end
--   tbl[key] = index
--   return index
-- end

function module.getComponent(name)
  return NLEvent.getComponentTable()[name]
end

function module.getComponents()
  return NLEvent.getComponentTable()
end

--@deprecated
function module.getModVersion(modName)
  local a, b, c = module.isModLoaded(modName)

  if a then
    return modName, c
  else
    return a
  end
end

function module.isModLoaded(modName)
  local mods = Resources.getData(Netplay.Resource.MOD_LIST)

  if mods == nil then return nil end

  for i, v in ipairs(mods) do
    if v.name == modName then
      return true, v.version, v.package
    end
  end

  return false
end

function module.join(tbl, sep)
  sep = sep or ""
  local str = ""

  for i, v in ipairs(tbl) do
    if i ~= 1 then str = str .. sep end
    str = str .. v
  end

  return str
end

function module.median(a, b, c)
  if (a >= b and b >= c) then return b
  elseif (a <= b and b <= c) then return b
  elseif (b <= a and a <= c) then return a
  elseif (b >= a and a >= c) then return a
  elseif (a >= c and c >= b) then return c
  elseif (a <= c and c <= b) then return c
  end
end

function module.sjoin(l, r, sep, force)
  sep = sep or ""
  if l and r then return l .. sep .. r
  elseif l then
    if force then return l .. sep
    else return l end
  elseif r then
    if force then return sep .. r
    else return r end
  else
    if force then return sep
    else return nil end
  end
end

local function getKey(item, key)
  if type(key) == "function" then
    return key(item)
  else
    return item[key]
  end
end

function module.sortBy(tbl, key, cmp)
  cmp = cmp or function(l, r) return l < r end

  table.sort(tbl, function(left, right)
    local lKey = getKey(left, key)
    local rKey = getKey(right, key)
    return cmp(lKey, rKey)
  end)
end

function module.sortByMany(tbl, cmp, ...)
  local keys = { ... }
  cmp = cmp or function(l, r)
    if l == r then
      return false, true
    elseif l < r then
      return true, false
    else
      return false, false
    end
  end

  table.sort(tbl, function(left, right)
    for i, v in ipairs(keys) do
      local lKey = getKey(left, v)
      local rKey = getKey(right, v)
      local compLT, compEQ = cmp(lKey, rKey)

      if type(compLT) == "number" then
        if compLT < 0 then
          return true
        elseif compLT > 0 then
          return false
        end
      elseif type(compLT) == "boolean" and type(compEQ) == "boolean" then
        if compLT then
          return true
        elseif not compEQ then
          return false
        end
      end
    end

    return false
  end)
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

function module.versionCompare(left, right)
  if left == right then return false, true end

  local lVer = {}

  for i, v in ipairs(module.splitToList(left, ".")) do
    local num = tonumber(v)
    if not num then error("Mod version strings must have numeric components.") end
    table.insert(lVer, num)
  end

  local rVer = {}

  for i, v in ipairs(module.splitToList(right, ".")) do
    local num = tonumber(v)
    if not num then error("Mod version strings must have numeric components.") end
    table.insert(rVer, num)
  end

  for i = 1, math.min(#lVer, #rVer) do
    if lVer[i] ~= rVer[i] then
      return lVer[i] < rVer[i], false
    end
  end

  return #lVer < #rVer, #lVer == #rVer
end

return module
