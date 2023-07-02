local Event = require "necro.event.Event"

Event.objectFacing.add("updateFacing",
  { order = "sprite", sequence = 1, filter = { "NixLib_partialDirectionalSpriteChange", "sprite" }
  },
  function(ev)
    local pdsc = ev.entity.NixLib_partialDirectionalSpriteChange
    if ev.visualDirection and not pdsc.ignored[ev.visualDirection] then
      pdsc.lastFacing = ev.visualDirection
    end
  end
)
