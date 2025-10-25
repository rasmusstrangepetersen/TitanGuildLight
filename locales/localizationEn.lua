if GetLocale() ~= "enUS" then return end -- When adding a new language, remember to add the localization file to the .toc file

GUILDLIGHT_MENU_TEXT = "GuildLight"
GUILDLIGHT_TOOLTIP = "Guild Info"
GUILDLIGHT_NOT_IN_GUILD = "Not a guild member";
GUILDLIGHT_TOOLTIP_HINT_TEXT = "Hint: Left-click to toggle guild window";

-- *** Version information
VERSION_TEXT = "TitanPanel GuildLight version: "
VERSION_RETAIL = " - The War Within"
VERSION_VANILLA = " - Classic Vanilla/SoD"
VERSION_CLASSIC = " - Classic Mist of Pandaria"
VERSION_UNSUPPORTED = " - Unsupported/untested WOW client"

GUILDLIGHT_ADDON_NOT_LOADED = "Addon not loaded, mouseover for update"

-- Class names used in tooltip filtering
WARRIOR = "Warrior";
MAGE = "Mage";
ROGUE = "Rogue";
DRUID = "Druid";
HUNTER = "Hunter";
SHAMAN = "Shaman";
PRIEST = "Priest";
WARLOCK = "Warlock";
PALADIN = "Paladin";
DEATH_KNIGHT = "Death Knight";
MONK = "Monk";
DEMON_HUNTER = "Demon Hunter";
EVOKER = "Evoker";

-- Addon menu texts
MENU_TEXT_SHOW_OFFLINE_MEMBERS = "Show offline members";
-- Sub-menu for showing info in tooltip
MENU_TEXT_SUBMENU_SHOW = "Show on tooltip"; -- sub-menu name
MENU_TEXT_SUBMENU_SHOW_MENUITEM_LEVEL = "Level";
MENU_TEXT_SUBMENU_SHOW_MENUITEM_STATUS = "Status";
MENU_TEXT_SUBMENU_SHOW_MENUITEM_NOTE = "Note";
MENU_TEXT_SUBMENU_SHOW_MENUITEM_ZONE = "Zone";
MENU_TEXT_SUBMENU_SHOW_MENUITEM_CLASS = "Class";
MENU_TEXT_SUBMENU_SHOW_MENUITEM_RANK = "Rank";
-- Sub-menu for filtering classes
MENU_TEXT_SUBMENU_FILTER_CLASS = "Class filter"; -- sub-menu name, class names are taken from the above translations
-- Addon tooltip texts
AFK = "AFK";
DND = "DND";
OFFLINE = "OFF";
UNKNOWN_ZONE = "Unknown zone";
