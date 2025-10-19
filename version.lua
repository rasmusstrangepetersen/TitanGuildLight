--- Check if for client version
addOn = {}
--- Addon is running on Retail client
--- WOW_PROJECT_MAINLINE = 1;
--- @type boolean
addOn.isRetail = (WOW_PROJECT_ID == WOW_PROJECT_MAINLINE)

--- Addon is running on Classic "Vanilla" client: Means Classic Era and its seasons like SoM
--- WOW_PROJECT_CLASSIC = 2;
---@type boolean
addOn.isVanilla = (WOW_PROJECT_ID == WOW_PROJECT_CLASSIC)

--- Addon is running on MoP Classic client
--- WOW_PROJECT_MISTS_CLASSIC = 19;
---@type boolean
addOn.isClassic = (WOW_PROJECT_ID == WOW_PROJECT_MISTS_CLASSIC)

--- Addon is running on unsupported/untested client
--- WOW_PROJECT_BURNING_CRUSADE_CLASSIC = 5;
--- WOW_PROJECT_WRATH_CLASSIC = 11;
--- WOW_PROJECT_CATACLYSM_CLASSIC = 14;
---@type boolean
addOn.isOther = (
        WOW_PROJECT_ID == WOW_PROJECT_BURNING_CRUSADE_CLASSIC or
        WOW_PROJECT_ID == WOW_PROJECT_WRATH_CLASSIC or
        WOW_PROJECT_ID == WOW_PROJECT_CATACLYSM_CLASSIC or
        WOW_PROJECT_ID > 19
        )
