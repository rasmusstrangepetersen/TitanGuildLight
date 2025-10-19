--- Titan command and registry variables
REVISION = "1.0.0";
GUILDLIGHT_ID = "GuildLight"; -- don't change this, without changing all TitanPanel function names also
GUILDLIGHT_CATEGORY = "Information";
-- general command variables
LEFT_BUTTON = "LeftButton";
PLAYER = "player";
-- Titan control variables
CONTROL_VARIABLE_SHOW_LABEL_TEXT = "ShowLabelText";
CONTROL_VARIABLE_SHOW_REGULAR_TEXT = "ShowRegularText";
CONTROL_VARIABLE_SHOW_COLORED_TEXT = "ShowColoredText";
-- Addon save variables
ADDON_VARIABLE_SHOW_OFFLINE_MEMBERS = "ShowOfflineMembers";
ADDON_VARIABLE_SHOW_LEVEL = "ShowTooltipLevel";
ADDON_VARIABLE_SHOW_STATUS = "ShowTooltipStatus";
ADDON_VARIABLE_SHOW_NOTE = "ShowTooltipNote";
ADDON_VARIABLE_SHOW_ZONE = "ShowTooltipZone";
ADDON_VARIABLE_SHOW_CLASS = "ShowTooltipClass";
ADDON_VARIABLE_SHOW_RANK = "ShowTooltipRank";

--- titan guild global variables
local showDebug = 0; -- 1 = show debugs in general chat, 0 turns off debug

-- **************************************************************************
-- DESC : Debug function to print message to chat frame
-- VARS : Message = message to print to chat frame
-- **************************************************************************
function debugMessage(Message, override)
    if ((showDebug == 1 or override == 1) and Message ~= lastDebug) then
        DEFAULT_CHAT_FRAME:AddMessage("|c" .. colorRed .. "GL: " .. Message);
        lastDebug = Message;
    end
end
-- **************************************************************************
-- DESC : Registers the plugin upon it loading
-- **************************************************************************
function TitanPanelGuildLightButton_OnLoad(self)
    debugMessage("Entering: TitanPanelGuildLightButton_OnLoad", 0);
    self.registry = {
        id = GUILDLIGHT_ID,
        category = GUILDLIGHT_CATEGORY,
        version = REVISION,
        menuText = GUILDLIGHT_MENU_TEXT,
        menuTextFunction = TitanPanelRightClickMenu_PrepareGuildMenu,
        buttonTextFunction = TitanPanelGuildLightButton_GetButtonText,
        tooltipTitle = GUILDLIGHT_TOOLTIP,
        tooltipTextFunction = TitanPanelGuildLightButton_GetTooltipText,
        icon = "Interface\\PetitionFrame\\GuildCharter-Icon.blp",
        iconWidth = 16,
        controlVariables = {
            ShowIcon = true,
            ShowLabelText = true,
            ShowRegularText = true,
            ShowColoredText = true,
            DisplayOnRightSide = true,
        },
        savedVariables = {
            ShowIcon = true,
            ShowLabelText = true,
            ShowRegularText = true,
            ShowColoredText = true,
            DisplayOnRightSide = false,
            ShowOfflineMembers = true,
            ShowTooltipLevel = true,
            ShowTooltipStatus = true,
            ShowTooltipNote = true,
            ShowTooltipZone = true,
            ShowTooltipClass = true,
            ShowTooltipRank = true,
            FilterDruid = true,
            FilterHunter = true,
            FilterMage = true,
            FilterPaladin = true,
            FilterPriest = true,
            FilterRogue = true,
            FilterShaman = true,
            FilterWarlock = true,
            FilterWarrior = true,
            FilterDeathKnight = true,
            FilterMonk = true,
            FilterDemonHunter = true,
            FilterEvoker = true
        }
    };
    self:RegisterEvent("GUILD_ROSTER_UPDATE");
end

-- **************************************************************************
-- DESC : Update on hovering, if enabled
-- **************************************************************************
function TitanPanelGuildLightButton_OnEnter(self)
    debugMessage("Entering: TitanPanelGuildLightButton_OnEnter", 0);
    -- mouse over update
    TitanPanelButton_UpdateButton(GUILDLIGHT_ID);
    TitanPanelButton_UpdateTooltip(self);
end

-- **************************************************************************
-- DESC : Open the Guild pane on a left click
-- **************************************************************************
function TitanPanelGuildLightButton_OnClick(self, button)
    debugMessage("Entering: TitanPanelGuildLightButton_OnClick", 0);

    if (button == LEFT_BUTTON and not IsControlKeyDown()) then
        ToggleGuildFrame();
    end
end

-- **************************************************************************
-- DESC : Handle game events
-- **************************************************************************
function TitanPanelGuildLightButton_OnEvent(self, event)
    debugMessage("Entering: TitanPanelGuildLightButton_OnEvent", 0);

    if (event == "GUILD_ROSTER_UPDATE") then
        TitanPanelButton_UpdateButton(GUILDLIGHT_ID);
        TitanPanelButton_UpdateTooltip(self);
    end
end

-- **************************************************************************
-- DESC : Setup right click menu
-- **************************************************************************
function TitanPanelRightClickMenu_PrepareGuildMenu()
    debugMessage("Entering: TitanPanelRightClickMenu_PrepareGuildMenu", 0);

    local dropdownLevel = TitanPanelRightClickMenu_GetDropdownLevel();
    if dropdownLevel == 1 then
        SetupCustomMenuTier1()
    else
        SetupCustomMenuTier2();
    end
end

-- **************************************************************************
-- DESC : Create and return button text <Guildname>: online/offline, adjusted for filters
-- **************************************************************************
function TitanPanelGuildLightButton_GetButtonText(id)
    debugMessage("Entering: TitanPanelGuildLightButton_GetButtonText", 0);
    local label = GUILDLIGHT_MENU_TEXT .. ": ";
    local out = GUILDLIGHT_NOT_IN_GUILD;

    if (IsInGuild()) then
        C_GuildInfo.GuildRoster();
        -- show label text
        if (TitanGetVar(GUILDLIGHT_ID, CONTROL_VARIABLE_SHOW_LABEL_TEXT)) then
            label = GetGuildInfo(PLAYER) .. ": ";
        else
            label = "";
        end
        out = "";

        if (TitanGetVar(GUILDLIGHT_ID, CONTROL_VARIABLE_SHOW_REGULAR_TEXT)) then
            out = GetMenuText(id)
        end
    end

    return label .. out
end

-- **************************************************************************
-- DESC : Create and return the main functionality - a list of guild members
-- **************************************************************************
function GetMenuText(id)
    debugMessage("Entering: GetMenuText", 0);

    -- no guild check is needed, we are only called, if player is in a guild
    local menuText = ""
    C_GuildInfo.GuildRoster();

    if (TitanGetVar(id, CONTROL_VARIABLE_SHOW_REGULAR_TEXT)) then
        local numTotalMembers, numOnlineMaxLevelMembers, numOnlineMembers = GetNumGuildMembers();
        local numOnlineTotalMembers = 0;
        if (numOnlineMaxLevelMembers) then
            numOnlineTotalMembers = numOnlineMaxLevelMembers;
        end
        if (numOnlineMembers) then
            numOnlineTotalMembers = numOnlineTotalMembers + numOnlineMembers;
        end

        if (TitanGetVar(id, CONTROL_VARIABLE_SHOW_COLORED_TEXT)) then
            menuText = "|c" .. colorGreen .. numOnlineTotalMembers .. "|c" .. colorWhite .. "/" .. numTotalMembers
        else
            menuText = TitanUtils_GetNormalText(numOnlineTotalMembers .. "/" .. numTotalMembers);
        end
    end

    return menuText
end

-- **************************************************************************
-- DESC : Create and return the main functionality - a list of guild members
-- **************************************************************************
function TitanPanelGuildLightButton_GetTooltipText()
    debugMessage("Entering: TitanPanelGuildLightButton_GetTooltipText", 0);

    local out = TitanUtils_GetNormalText(GUILDLIGHT_NOT_IN_GUILD)

    if (IsInGuild()) then
        -- add guildname as headline
        out = TitanUtils_GetNormalText(GetGuildInfo("player"));
        -- add hint on same line
        out = out .. "\t" .. TitanUtils_GetGreenText(GUILDLIGHT_TOOLTIP_HINT_TEXT);
        out = out .. GetTooltipText();
    end

    return out;
end

-- **************************************************************************
-- DESC : Create and return the table with members
-- **************************************************************************
function GetTooltipText()
    local numTotalMembers, numOnlineMaxLevelMembers, numOnlineMembers = GetNumGuildMembers();--
    local showOfflineMembers = TitanGetVar(GUILDLIGHT_ID, ADDON_VARIABLE_SHOW_OFFLINE_MEMBERS);
    local tooltipTextOnline = "";
    local tooltipTextOffline = "";

    for guildIndex = 1, numTotalMembers do
        local name, rankName, rankIndex, level, classDisplayName, zone, publicNote, officerNote,
        isOnline, status, class, achievementPoints, achievementRank, isMobile, canSoR, repStanding,
        guid = GetGuildRosterInfo(guildIndex)

        -- only add member, if class is turn on (no 'continue' lua command for skipping ahead i the loop)
        if (isClassShown(classDisplayName)) then
            -- set status text
            local statustext = "";
            if status == 1 then
                statustext = "<" .. AFK .. ">"
            elseif status == 2 then
                statustext = "<" .. DND .. ">"
            elseif not isOnline then
                statustext = "<" .. OFFLINE .. ">"
            end

            -- fix zone if empty
            if not zone then
                zone = UNKNOWN_ZONE
            end

            local tooltipText = ""
            -- new line
            tooltipText = tooltipText .. TitanUtils_GetNormalText("\n");
            -- show level if turn on
            if TitanGetVar(GUILDLIGHT_ID, ADDON_VARIABLE_SHOW_LEVEL) then
                tooltipText = tooltipText .. " (|c" .. colorOrange .. level .. TitanUtils_GetNormalText(") ");
            end
            -- show status if turn on
            if TitanGetVar(GUILDLIGHT_ID, ADDON_VARIABLE_SHOW_STATUS) then
                tooltipText = tooltipText .. "|c" .. colorYellow .. statustext .. " ";
            end
            -- always show player names
            tooltipText = tooltipText .. GetColorPlayerName(classDisplayName, name) .. " ";
            -- show note if turn on
            if (TitanGetVar(GUILDLIGHT_ID, ADDON_VARIABLE_SHOW_NOTE) and publicNote ~= "") then
                tooltipText = tooltipText .. "|c" .. colorGrey .. "(" .. publicNote .. ")";
            end
            -- show zone if turn on
            if (TitanGetVar(GUILDLIGHT_ID, ADDON_VARIABLE_SHOW_ZONE)) then
                tooltipText = tooltipText .. "\t|c" .. colorBlue .. zone .. " ";
            end
            -- show class if turn on
            if (TitanGetVar(GUILDLIGHT_ID, ADDON_VARIABLE_SHOW_CLASS)) then
                tooltipText = tooltipText .. GetColorClassName(classDisplayName) .. " ";
            end
            -- show rank if turn on
            if (TitanGetVar(GUILDLIGHT_ID, ADDON_VARIABLE_SHOW_RANK)) then
                tooltipText = tooltipText .. "|c" .. colorRed .. rankName;
            end

            if (isOnline) then
                tooltipTextOnline = tooltipTextOnline .. tooltipText
            else
                tooltipTextOffline = tooltipTextOffline .. tooltipText
            end
        end
    end

    if (showOfflineMembers) then
        return tooltipTextOnline .. tooltipTextOffline
    end

    return tooltipTextOnline
end

-- *********************************************************************
-- DESC : get filter variable for showing the class
-- *********************************************************************
function isClassShown(className)
    for index in ipairs(GUILDLIGHT_CLASSES) do
        if (GUILDLIGHT_CLASSES[index].class == className) then
            TitanGetVar(GUILDLIGHT_ID, GUILDLIGHT_CLASSES[index].variable);
        end
    end
end

-- *********************************************************************
-- DESC : colors the class name based on the standard colors
-- *********************************************************************
function GetColorClassName(className)
    for index in ipairs(GUILDLIGHT_CLASSES) do
        if (GUILDLIGHT_CLASSES[index].class == className) then
            return GUILDLIGHT_CLASSES[index].color .. className;
        end
    end
    return className;
end

-- *********************************************************************
-- DESC : colors the player name based on the standard colors
-- *********************************************************************
function GetColorPlayerName(className, playerName)
    for index in ipairs(GUILDLIGHT_CLASSES) do
        if (GUILDLIGHT_CLASSES[index].class == className) then
            return GUILDLIGHT_CLASSES[index].color .. playerName;
        end
    end
    return playerName;
end

-- **************************************************************************
-- DESC : Setup Custom right click menu, tier 1
-- **************************************************************************
function SetupCustomMenuTier1()

    -- title
    TitanPanelRightClickMenu_AddTitle(TitanPlugins[GUILDLIGHT_ID].menuText);

    -- show offline
    addMenuItem(MENU_TEXT_SHOW_OFFLINE_MEMBERS, ADDON_VARIABLE_SHOW_OFFLINE_MEMBERS, 1, 0);
    TitanPanelRightClickMenu_AddSpacer();

    -- sub menu choose what to see on tooltip
    addSubMenu(MENU_TEXT_SUBMENU_SHOW);
    -- sub menu choose to see specific classes
    addSubMenu(MENU_TEXT_SUBMENU_FILTER_CLASS);
    TitanPanelRightClickMenu_AddSpacer();

    -- add control variables
    TitanPanelRightClickMenu_AddControlVars(GUILDLIGHT_ID)
end

-- **************************************************************************
-- DESC : Setup Custom right click menu, tier 2
-- **************************************************************************
function SetupCustomMenuTier2()
    local submenuName = TitanPanelRightClickMenu_GetDropdMenuValue()

    if (submenuName == MENU_TEXT_SUBMENU_SHOW) then
        -- level 2 items in the menu
        addMenuItem(MENU_TEXT_SUBMENU_SHOW_MENUITEM_LEVEL, ADDON_VARIABLE_SHOW_LEVEL, 2, 1);
        addMenuItem(MENU_TEXT_SUBMENU_SHOW_MENUITEM_STATUS, ADDON_VARIABLE_SHOW_STATUS, 2, 1);
        addMenuItem(MENU_TEXT_SUBMENU_SHOW_MENUITEM_NOTE, ADDON_VARIABLE_SHOW_NOTE, 2, 1);
        addMenuItem(MENU_TEXT_SUBMENU_SHOW_MENUITEM_ZONE, ADDON_VARIABLE_SHOW_ZONE, 2, 1);
        addMenuItem(MENU_TEXT_SUBMENU_SHOW_MENUITEM_CLASS, ADDON_VARIABLE_SHOW_CLASS, 2, 1);
        addMenuItem(MENU_TEXT_SUBMENU_SHOW_MENUITEM_RANK, ADDON_VARIABLE_SHOW_RANK, 2, 1);
    end
    if (submenuName == MENU_TEXT_SUBMENU_FILTER_CLASS) then
        -- level 2 items in the menu
        for index in ipairs(GUILDLIGHT_CLASSES) do
            if (addOn.isRetail or
                    (addOn.isClassic and GUILDLIGHT_CLASSES[index].classic) or
                    (addOn.isVanilla and GUILDLIGHT_CLASSES[index].vanilla)) then
                addMenuItem(GUILDLIGHT_CLASSES[index].color .. GUILDLIGHT_CLASSES[index].class,
                        GUILDLIGHT_CLASSES[index].variable, 2, 0);
            end
        end
    end
end

-- **************************************************************************
-- DESC : Helper function for submenus
-- **************************************************************************
function addSubMenu(submenuName)
    local info = {};
    info.text = submenuName;
    info.hasArrow = 1;
    TitanPanelRightClickMenu_AddButton(info);
end

-- **************************************************************************
-- DESC : Helper function for menuitems
-- **************************************************************************
function addMenuItem(menuItemText, menuItemVariable, menuLevel, keepShownOnClick)
    local info = {};
    info.text = menuItemText;
    info.checked = TitanGetVar(GUILDLIGHT_ID, menuItemVariable);
    info.func = function()
        ToggleMenuItem(menuItemVariable);
    end;
    info.keepShownOnClick = keepShownOnClick;
    TitanPanelRightClickMenu_AddButton(info, menuLevel);
end

-- **************************************************************************
-- DESC : Helper function for toggling variables
-- **************************************************************************
function ToggleMenuItem(menuItemVariable)
    TitanToggleVar(GUILDLIGHT_ID, menuItemVariable);
    TitanPanelButton_UpdateButton(GUILDLIGHT_ID);
end;