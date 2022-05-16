local Event = require "necro.event.Event"

local componentTable = {}

Event.entitySchemaGenerate.add("components", { order = "components", sequence = 1 }, function(ev)
  local comps = ev.components
  componentTable = {}

  for i, v in ipairs(comps) do
    componentTable[v.name] = v
  end
end)

return {
  getComponentTable = function() return componentTable end
}
