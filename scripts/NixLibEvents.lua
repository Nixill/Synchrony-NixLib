local Event = require "necro.event.Event"

local componentTable = nil

Event.entitySchemaGenerate.add("components", { order = "components", sequence = 1 }, function(ev)
  componentTable = ev.components
end)

return {
  getComponentTable = function() return componentTable end
}
