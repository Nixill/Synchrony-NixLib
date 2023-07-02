local Event    = require "necro.event.Event"
local Entities = require "system.game.Entities"

Event.animateObjects.add("partialDirectionalSpriteChange",
  {
    order = "directionalSpriteChange",
    sequence = 1
  },
  function(ev)
    for entity in Entities.entitiesWithComponents {
      "NixLib_partialDirectionalSpriteChange",
      "spriteSheet"
    } do
      local pdsc = entity.NixLib_partialDirectionalSpriteChange
      local offset = pdsc.frameX[pdsc.lastFacing]

      if offset then
        entity.spriteSheet.frameX = entity.spriteSheet.frameX + offset
      end
    end
  end
)
