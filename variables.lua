--- Tables and colors used in the code

--- Active versions
if addOn.isRetail then
    VERSION_WOWVERSION = VERSION_RETAIL
elseif addOn.isVanilla then
    VERSION_WOWVERSION = VERSION_VANILLA
elseif addOn.isClassic then
    VERSION_WOWVERSION = VERSION_CLASSIC
else
    VERSION_WOWVERSION = VERSION_UNSUPPORTED
end
VERSION = VERSION_WOWVERSION

--- used general colors
colorRed        = "ffff0000"; -- red DEBUG text color and guild rank
colorBlue       = "ff20d0ff"; -- Hint for left click and zone
colorWhite      = "ffffffff"; -- white
colorOrange     = "ffff8000"; -- orange used for level
colorYellow     = "ffffff00"; -- yellow used for status
colorGrey       = "ff9d9d9d"; -- grey used for note

--- standard class colour
GUILDLIGHT_CLASSES = {
    { class = DRUID,        color = "|cffff7d0a", vanilla = true, classic = true, variable = "FilterDruid"},
    { class = HUNTER,       color = "|cffabd473", vanilla = true, classic = true, variable = "FilterHunter"},
    { class = MAGE,         color = "|cff69ccf0", vanilla = true, classic = true, variable = "FilterMage"},
    { class = PALADIN,      color = "|cfff58cba", vanilla = true, classic = true, variable = "FilterPaladin"},
    { class = PRIEST,       color = "|cffffffff", vanilla = true, classic = true, variable = "FilterPriest"},
    { class = ROGUE,        color = "|cfffff569", vanilla = true, classic = true, variable = "FilterRogue"},
    { class = SHAMAN,       color = "|cff2459ff", vanilla = true, classic = true, variable = "FilterShaman"},
    { class = WARLOCK,      color = "|cff9482ca", vanilla = true, classic = true, variable = "FilterWarlock"},
    { class = WARRIOR,      color = "|cffc79c6e", vanilla = true, classic = true, variable = "FilterWarrior"},
    { class = DEATH_KNIGHT, color = "|cffc41f3b", vanilla = false, classic = true, variable = "FilterDeathKnight"},
    { class = MONK,         color = "|cff00ff96", vanilla = false, classic = true, variable = "FilterMonk"},
    { class = DEMON_HUNTER, color = "|cffa330c9", vanilla = false, classic = false, variable = "FilterDemonHunter"},
    { class = EVOKER,       color = "|cff33937F", vanilla = false, classic = false, variable = "FilterEvoker"}
}

