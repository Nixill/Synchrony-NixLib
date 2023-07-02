local Action     = require "necro.game.system.Action"
local Components = require "necro.game.data.Components"

local Direction = Action.Direction

Components.register {
  -- This component is available for modder use, not given to anything by
  -- default.
  --
  -- Adds to this entity's frameX depending on facing direction, allowing
  -- some directions to not change or reset.
  --
  -- const table frameX: Maps direction → frameX offset.
  -- const table ignored: Maps direction → true; facing directions
  --   specified here will use the last frameX offset specified in frameX.
  -- enum lastFacing: The last non-ignored direction this entity was
  --   facing; this should be given a default that matches one of the
  --   frameX directions and not changed by mods during gameplay.
  NixLib_partialDirectionalSpriteChange = {
    Components.constant.table("frameX", {}),
    Components.constant.table("ignored", {}),
    Components.field.enum("lastFacing", Direction, Direction.RIGHT)
  }
}
