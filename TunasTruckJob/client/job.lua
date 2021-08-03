hasPowerJob = true -- Poweer Grid compatibility enabled by default, Can be found here --> https://forum.cfx.re/t/tunas-power-job-esx-working-power-grid-free-release/3820220
gridAdd = 200 -- amount you want added to power grid for completing a "Power Grid Delivery" job
debug = true -- test spawn coordinates of peds; Youll need to change job site coords in multiple places, so proceed with caution if you do
-- for payout, see /server/payment.lua
--[[
___________                ___________                        
\__    ___/_ __  ____ _____\__    ___/________________  ______
  |    | |  |  \/    \\__  \ |    |_/ __ \_  __ \____ \/  ___/
  |    | |  |  /   |  \/ __ \|    |\  ___/|  | \/  |_> >___ \ 
  |____| |____/|___|  (____  /____| \___  >__|  |   __/____  >
                    \/     \/           \/      |__|       \/

 - TunasTruckJob - created with <3 by Tuna Terps; If you enjoyed, go ahead and check out some of my other work ! 
https://github.com/Tuna-Terps
https://www.youtube.com/channel/UCqoEtIuzJc3PGk9YX6kslNw
]]--
-- ======================================= variables ===============================================
onJob = false
npcJob = false
ccJob = false
ccJob2 = false
bcJob = false
luxJob = false
luxReturn = false
pAnim = nil
pCoords = nil
xlJob = false
lsB = false
jobMenu = nil
sC3 = nil

bcJob3 = false
j1 = false;j2 = false;j3 = false;j4 = false;j5 = false;j6 = false;j8 = false;j10 = false;

-- ------------------------------------- thread/loops ----------------------------------------
Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent("esx:getSharedObject", function(obj) ESX = obj end)
		Citizen.Wait(0)
    end
end)

Citizen.CreateThread(function()
    while true do
        player = PlayerPedId()
        coords = GetEntityCoords(player)
        Citizen.Wait(500)
    end
end)


 -- menu
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(5)
        local s = true
        local dist = GetDistanceBetweenCoords(coords.x, coords.y, coords.z, -176.74, -2581.24, 5.1, false)
        local dist2 = GetDistanceBetweenCoords(coords.x, coords.y, coords.z, 120.39, 6625.51, 31.69, false)
        if jobMenu ~= nil then
            while jobMenu ~= nil and dist > 1.5 do jobMenu = nil Citizen.Wait(1) end
            if jobMenu == nil then ESX.UI.Menu.CloseAll() end
        else
            if dist < 18 then
                s = false
                if dist < 13 then
                    DynaMarker(27,-176.74, -2581.24, 5.0, 0.0, 0.0, 600, 100, true)
                    if dist < 1.5 then
                        DrawText3Ds(-176.74, -2581.24, 6.1, "~r~[~g~E~r~]".." ~w~Open Job Menu")
                        if IsControlJustPressed(0, 38) then
                            lsB = true
                            OpenJobMenu()
                        end                          
                    end
                end
            elseif dist2 < 18 then
                s = false
                if dist2 < 13 then
                    DynaMarker(27, 120.39, 6625.51, 30.97, 0.0, 0.0, 600, 100, true)
                    if dist2 < 1.5 then
                        DrawText3Ds(120.39, 6625.51, 31.95, "~r~[~g~E~r~]".." ~w~Open Job Menu")
                        if IsControlJustPressed(0, 38) then
                            OpenJobMenu()
                        end                          
                    end
                end
            end
        end
        if s then Citizen.Wait(1000) end
    end    
end)

-- ======================================= main functions ===============================================
function OpenJobMenu()
    if lsB then 
        elements = {
            {label = 'Yacht Delivery', value = 'option_0'},
            {label = 'Power Grid Delivery', value = 'option_1'},
            {label = 'Luxury Auto Delivery', value = 'option_5'},
            {label = 'Cross-County Delivery', value = 'option_2'},
            {label = 'Exit Menu', value = 'exit'},
        }
    else
        elements = {
            {label = 'Lumber Yard Delivery', value = 'option_7'},
            {label = 'Power Grid Delivery', value = 'option_3'},
            {label = 'Army Depot Delivery', value = 'option_6'},
            {label = 'Cross-County Delivery', value = 'option_4'},
            {label = 'Exit Menu', value = 'exit'},
        }
    end
	ESX.UI.Menu.CloseAll()
	ESX.UI.Menu.Open('default', 'TunasTruckJob', 'tunas_truck_job', {
        css = 'vestiaire',
        title = 'LS TRUCKING',
        align = 'top-right',
        elements = elements
        }, function(data, menu)
        if data.current.value == 'option_0' then
            menu.close()
            ChangeClothes()
            if onJob == false then
                onJob = true
                lsB = false
                startJob1()
            else
                print('already on the clock ..')
            end
        elseif data.current.value == 'option_1' then
            menu.close()
            ChangeClothes()
            if onJob == false then
                onJob = true
                lsB = false
                startJob2()
            	return
            else
                print('already on the clock ..')
		        return
            end
        elseif data.current.value == 'option_2' then
            menu.close()
            ChangeClothes()
            if onJob == false then
                onJob = true
                lsB = false
                startJob3()
            else
		        print('~r~error: ~w~already on the clock ....')
                return
            end
        elseif data.current.value == 'option_3' then
            menu.close()
            ChangeClothes()
            if onJob == false then
                onJob = true
                startJob4()
            else
		        print('~r~error: ~w~already on the clock ....')
                return
            end
        elseif data.current.value == 'option_4' then
            menu.close()
            ChangeClothes()
            if onJob == false then
                onJob = true
                startJob5()
            else
		        print('~r~error: ~w~already on the clock ....')
                return
            end
        elseif data.current.value == 'option_5' then
            menu.close()
            ChangeClothes()
            if onJob == false then
                onJob = true
                startJob6()
            else
		        print('~r~error: ~w~already on the clock ....')
                return
            end
        elseif data.current.value == 'option_6' then
            menu.close()
            ChangeClothes()
            if onJob == false then
                onJob = true
                startJob8()
            else
		        print('~r~error: ~w~already on the clock ....')
                return
            end
        elseif data.current.value == 'option_7' then
            menu.close()
            ChangeClothes()
            if onJob == false then
                onJob = true
                startJob10()
            else
		        print('~r~error: ~w~already on the clock ....')
                return
            end
        elseif data.current.value == 'exit' then
            menu.close()     
        end
	end)
end


RegisterNetEvent('TunasTruckJob:ped')
AddEventHandler('TunasTruckJob:ped', function(pCoords, isP, pAnim, cBool)
    if cBool then
        hash = 's_m_y_armymech_01'
    else
        hash = 's_m_y_construct_02'
    end
    nCoords = pCoords - vector3(5,9,0) -- this is the offset of the ped from center of delivery site; If this coord cant be found ped will not delete
    Citizen.CreateThread(function()
        if debug then
            print('spawning ' .. hash .. ' at ' .. nCoords)
        end
        RequestModel(hash)
        while not HasModelLoaded(hash)
            do RequestModel(hash)
            Citizen.Wait(0)
        end
        if isP then
            if debug then
                print('ped detected, opting for either emote, or standby ...')
            end
            local ped = ESX.Game.GetClosestPed(nCoords)
            if isP and pAnim then
                if debug then
                    print('beginning ped anim ..')
                end
                Citizen.Wait(1)
                TaskStartScenarioInPlace(ped, "WORLD_HUMAN_CLIPBOARD", 0, true)
                Citizen.Wait(10000)
                SetEntityAsNoLongerNeeded(ped)
                DeletePed(ped)
                return
            else
                print('else')
            end

        else
            if debug then
                print('creating ped ....')
            end
            CreatePed(1,hash,nCoords, true, false)
            return 
        end
        return
    end)
end)


function DeliveryAnim()
    local pIndex = PlayerPedId()
     Citizen.CreateThread(function()
        Wait(1000)
        TaskStartScenarioInPlace(pIndex, "WORLD_HUMAN_CLIPBOARD", 0, true)
        FreezeEntityPosition(pIndex, true)
        exports['progressBars']:startUI(10000, 'Signing off on the order ..')
        Wait(10000)
        FreezeEntityPosition(pIndex, false)
        if onJob then
            ClearPedTasksImmediately(PlayerPedId())
            TriggerServerEvent("TunasTruckJob:pay")
            TriggerEvent('esx:showNotification','Job Complete')
            --onJob = false
            if npcJob then
                local c = vector3(-757.09, -1487.09, 5.14)-vector3(5,9,0)
                npcJob = false
                TriggerEvent('TunasTruckJob:ped',c, true, true, false)
                FinishJob()
                return
            end
            if xlJob or bcJob then
                if hasPowerJob then
                    local c = vector3(2838.13,1525.58,24.58)-vector3(5,9,0)
                    TriggerServerEvent("grid:add", gridAdd)
                    TriggerServerEvent("TunasTruckJob:pay")
                    xlJob = false
                    TriggerEvent('TunasTruckJob:ped',c,true, true, false)
                    FinishJob()
                    return
                else
                    local c = vector3(2838.13,1525.58,24.58)-vector3(5,9,0)
                    TriggerServerEvent("TunasTruckJob:pay")
                    xlJob = false
                    TriggerEvent('TunasTruckJob:ped',c,true, true, false)
                    FinishJob()
                    return
                end
            end
            if ccJob then
                local c = vector3(152.56,6623.85,31.81)-vector3(5,9,0)
                ccJob = false
                TriggerEvent('TunasTruckJob:ped',c, true, true, false)
                TriggerServerEvent("TunasTruckJob:pay")
                return
            end
            if ccJob2 then
                local c = vector3(-150.98, -2567.15, 6.0)-vector3(5,9,0)
                ccJob2 = false
                TriggerEvent('TunasTruckJob:ped',c, true, true, false)
                TriggerServerEvent("TunasTruckJob:pay")
                return
            end
            if luxJob then
                print('luxjob')
                local c = vector3(529.6,-3022.47,6.03)-vector3(5,9,0)
                luxJob = false
                TriggerEvent('TunasTruckJob:ped',c, true, true, false)
                Citizen.Wait(1000)
                Job7()
            --    TriggerServerEvent("TunasTruckJob:pay")
                return
            end
            if luxReturn then
                local c = vector3(-17.83,-1105.28,26.67)-vector3(5,9,0)
                luxReturn = false
                TriggerEvent('TunasTruckJob:ped',c, true, true, false)
                Citizen.Wait(1000)
                FinishJob()
                TriggerServerEvent("TunasTruckJob:pay")
                return
            end
            if armyJob then
                local c = vector3(-322.58,6095.0,31.47)-vector3(5,9,0)
                armyJob = false
                TriggerEvent('TunasTruckJob:ped',c, true, true, false)
                Citizen.Wait(1000)
                Job9()
                TriggerServerEvent("TunasTruckJob:pay")
                return
            end
            if armyReturn then
                local c = vector3(-2333.76,3405.91,30.21)-vector3(5,9,0)
                armyReturn = false
                bcJob = true
                TriggerEvent('TunasTruckJob:ped',c, true, true, true)
                Citizen.Wait(1000)
                FinishJob()
                TriggerServerEvent("TunasTruckJob:pay")
                return
            end
            if bcJob3 then
                local c = vector3(-570.6,5265.1,70.44)-vector3(5,9,0)
                bcJob3 = false
                bcJob = true
                TriggerEvent('TunasTruckJob:ped',c, true, true, true)
                Citizen.Wait(1000)
                FinishJob()
                return
            end
            return
		else 
			print('youre already on the clock foh ...')
        end
    end)
end


function FinishJob()
    if bcJob then
        sC3 = vector3(152.56,6623.85,31.81)
        bcJob = false
    else
        sC3 = vector3(-150.98, -2567.15, 6.0)
    end
    print('beginning finish job ...')
    local n1 = false
    local mB3 = AddBlipForCoord(sC3)
    SetBlipRoute(mB3, true)
    SetBlipRouteColour(mB3, 57)
    SetBlipColour(mB3, 57)
    Citizen.CreateThread(function()
        local wait = 100
        ESX.ShowHelpNotification("Return the vehicle to recieve an additional payment !", true, true, 5000)
        while not n1 do
            Citizen.Wait(wait)
            local tDist = GetDistanceBetweenCoords(coords.x, coords.y, coords.z, sC3, false)
            if tDist < 40 and tDist > 10 then
                wait = 5
                local p = PlayerPedId()
                local v = GetVehiclePedIsIn(p)
                DynaMarker(1, sC3.x, sC3.y, sC3.z-1.0,250, 0, 0, 200, false)    
           end
           if tDist <= 10 then
                onJob = false
                wait = 5
                DynaMarker(1, sC3.x, sC3.y, sC3.z-1.0,0, 600, 0, 200, false)    
                local p = PlayerPedId()
                local v = GetVehiclePedIsIn(p)
                Citizen.Wait(1000)
                SetBlipRoute(mB3, false)
                RemoveBlip(mB3)
                Citizen.Wait(6500)
                ESX.Game.DeleteVehicle(v)
                TriggerServerEvent('TunasTruckJob:pay')
                Citizen.Wait(1000)
                n1 = true
                return
            end   
        end
    end)
end
-- ====================================== cancel job ===============================================
-- Credits to Soubisan on the cfx forums <3 -- this will clear routes + some blips/ will not despawn peds 
RegisterNetEvent('TunasTruckJob_gw:stoptruck')
AddEventHandler('TunasTruckJob_gw:stoptruck', function()
	local p = PlayerPedId()
    local v = GetVehiclePedIsIn(p)
	if onJob then 
        onjob = false;
        ClearAllBlipRoutes()
        RemoveBlip(mB)
        RemoveBlip(mB3)
        ESX.Game.DeleteVehicle(v)
        sC3 = nil;
        onJob = false;
        ccJob = false;ccJob2 = false;
        npcJob = false;bcJob = false;luxJob=false;luxReturn=false;xlJob = false;
        pAnim = nil;pCoords = nil;lsB=false;
        armyJob = false; armyReturn = false; bcJob = false; bcJob2 = false; bcJob3 = false;
        j1 = false;j2 = false;j3 = false;j4 = false;j5 = false;j6 = false;j8 = false;j10 = false;
        jobMenu = nil;
    else
        TriggerEvent('esx:showNotification','You`re not on the job !')
  end 
end)
-- Credits to Soubisan on the cfx forums <3 -- this will clear routes + some blips/ will not despawn peds 
-- ====================================== cancel job ===============================================


-- ======================================= job 1 (s) ===============================================


function startJob1()
    local p = PlayerPedId()
    local vC1 = vector3(-156.41,-2561.54,6.02) -- truck
    local vC2 = vector3(-165.6,-2560.4,5.82) -- trailer
    local h = 86.65
    local sC = vector3(-757.09, -1487.09, 5.14)
    local n2 = false
    ESX.Game.SpawnVehicle("packer", vC1, h , function(veh)
	    Citizen.Wait(1000)
        SetVehicleLivery(veh, 4)
        SetPedIntoVehicle(p, veh, -1)
        print(veh)
        mB = AddBlipForCoord(sC)
        SetBlipRoute(mB, true)
        SetBlipRouteColour(mB, 57)
        SetBlipColour(mB, 57)
        ESX.Game.SpawnVehicle("tr3", vC2, h , function(veh2)
            AttachVehicleToTrailer(veh, veh2, 1.1)
            Citizen.CreateThread(function()
                local wait = 100
                while not n2 do
                    Citizen.Wait(wait)
                    local tDist = GetDistanceBetweenCoords(coords.x, coords.y, coords.z, sC, false)
                    local tr = GetEntityCoords(veh2)
                    local trDist = GetDistanceBetweenCoords(tr, sC, false)
                    if tDist < 60  and trDist > 6 then
                        wait = 5
                        r = 250 ;  g = 0;  b = 0; a = 200;
                       DynaMarker(1, sC.x, sC.y, sC.z-1.0, 250, 0, 0, 200, false)    
                    end
                    if trDist < 6 then
                        wait = 5
                        DynaMarker(1, sC.x, sC.y, sC.z-1.0, 0, 600, 0, 100, false)
                        if trDist < 2 then
                            print('ok ...')
                            SetBlipRoute(mB, false)
                            RemoveBlip(mB)
                            Job1()
                            n2 = true
                            npcJob = true
                            Citizen.Wait(10000)
                            ESX.Game.DeleteVehicle(veh2)
                            return
                        end
                    end   
                end
            end)
        end)
    end)
end

function Job1()
    local jC = vector3(-757.09, -1487.09, 5.14)
    local nC = jC + vector3(0,0,1.5) - vector3(5,9,0)
    TriggerEvent('TunasTruckJob:ped', jC, false, false, false)
    j1 = true
    while j1 do
        Citizen.Wait(5)
        local uDist = GetDistanceBetweenCoords(coords.x, coords.y, coords.z, jC.x-5,jC.y-9, jC.z, false)
        if uDist < 20 then
            ESX.ShowHelpNotification("Sign off on the order !", true, true, 5000)
            DrawMarker(29, nC, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 2.0, 2.0, 1.0, 0, 120, 0, 200, false, true, 2, false, false, false, false)
            if uDist < 3 then
                ESX.ShowHelpNotification("Press ~INPUT_CONTEXT~ to speak with the foreman", true, true, 5000)
                if IsControlJustPressed(0,38) then
                    DeliveryAnim()
                    j1 = false
                    return
                end
            end
        end
    end  
end

-- ======================================= job 1 (m) ===============================================


function startJob2()
    local p = PlayerPedId()    
    local vC1 = vector3(-203.2,-2573.06,6.02) -- truck
    local vC2 = vector3(-197.01,-2571.96,6.02) -- trailer
    local h = 178.31
    local sC1 = vector3(2838.13,1525.58,24.58)
    local n2 = false
    ESX.Game.SpawnVehicle("phantom", vC1, h , function(veh)        
	    Citizen.Wait(1000)
        SetVehicleLivery(veh, 4)
        SetPedIntoVehicle(p, veh, -1)
        print(veh)
        mB = AddBlipForCoord(sC1)
        SetBlipRoute(mB, true)
        SetBlipRouteColour(mB, 57)
        SetBlipColour(mB, 57)
        ESX.Game.SpawnVehicle("tanker2", vC2, h , function(veh2)
            AttachVehicleToTrailer(veh, veh2, 1.1)
            Citizen.CreateThread(function()
                local wait = 100
                while not n2 do
                    Citizen.Wait(wait)
                    local tDist = GetDistanceBetweenCoords(coords.x, coords.y, coords.z, sC1, false)
                    local tr = GetEntityCoords(veh2)
                    local trDist = GetDistanceBetweenCoords(tr, sC1, false)
                    if tDist < 60  and trDist > 5 then
                        wait = 5
                        r = 250 ;  g = 0;  b = 0; a = 200;
                       DynaMarker(1, sC1.x, sC1.y, sC1.z-1.0, 250, 0, 0, 200, false)    
                    end
                    if trDist < 5 then
                        wait = 5
                        DynaMarker(1, sC1.x, sC1.y, sC1.z-1.0, 0, 600, 0, 100, false)
                        if trDist < 2 then
                            print('ok ...')
                            SetBlipRoute(mB, false)
                            RemoveBlip(mB)
                            Job2()
                            Citizen.Wait(10000)
                            ESX.Game.DeleteVehicle(veh2)
                            return
                        end
                    end   
                end
            end)
        end)
    end)
end

function Job2()
    local jC2 = vector3(2838.13,1525.58,24.58)
    local nC = jC2 + vector3(0,0,1.5) - vector3(5,9,0)
    TriggerEvent('TunasTruckJob:ped', jC2, false, false, false)
    j2 = true
    while j2 do
        Citizen.Wait(5)
        local uDist = GetDistanceBetweenCoords(coords.x, coords.y, coords.z, jC2.x-5,jC2.y-9, jC2.z, false)
        if uDist < 20 then
            ESX.ShowHelpNotification("Sign off on the order !", true, true, 5000)
            DrawMarker(29, nC, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 2.0, 2.0, 1.0, 0, 120, 0, 200, false, true, 2, false, false, false, false)
            if uDist < 3 then
                ESX.ShowHelpNotification("Press ~INPUT_CONTEXT~ to speak with the foreman", true, true, 5000)
                if IsControlJustPressed(0,38) then
                    xlJob = true
                    DeliveryAnim()
                    j2 = false
                    return
                end
            end
        end
    end  
end

-- ======================================= job 3 (CC LS -> BC) ===============================================
function startJob3()
    local p = PlayerPedId()
    local vC1 = vector3(-156.41,-2561.54,6.02) -- truck
    local vC2 = vector3(-165.6,-2560.4,5.82) -- trailer
    local h = 86.65
    local sC2 = vector3(152.56,6623.85,31.81)
    local n2 = false
    ESX.Game.SpawnVehicle("phantom", vC1, h , function(veh)        
	    Citizen.Wait(1000)
        SetVehicleLivery(veh, 4)
        SetPedIntoVehicle(p, veh, -1)
        print(veh)
        mB = AddBlipForCoord(sC2)
        SetBlipRoute(mB, true)
        SetBlipRouteColour(mB, 57)
        SetBlipColour(mB, 57)
        ESX.Game.SpawnVehicle("trailers2", vC2, h , function(veh2)
            AttachVehicleToTrailer(veh, veh2, 1.1)
            Citizen.CreateThread(function()
                local wait = 100
                while not n2 do
                    Citizen.Wait(wait)
                    local tDist = GetDistanceBetweenCoords(coords.x, coords.y, coords.z, sC2, false)
                    local tr = GetEntityCoords(veh2)
                    local trDist = GetDistanceBetweenCoords(tr, sC2, false)
                    if tDist < 60  and trDist > 5 then
                        wait = 5
                        r = 250 ;  g = 0;  b = 0; a = 200;
                       DynaMarker(1, sC2.x, sC2.y, sC2.z-1.0, 250, 0, 0, 200, false)    
                    end
                    if trDist < 5 then
                        wait = 5
                        DynaMarker(1, sC2.x, sC2.y, sC2.z-1.0, 0, 600, 0, 100, false)
                        if trDist < 2 then
                            print('ok ...')
                            SetBlipRoute(mB, false)
                            RemoveBlip(mB)
                            Job3()
                            Citizen.Wait(10000)
                            ESX.Game.DeleteVehicle(veh)
                            ESX.Game.DeleteVehicle(veh2)
                            return
                        end
                    end   
                end
            end)
        end)
    end)
end

function Job3()
    local jC2 = vector3(152.56,6623.85,31.81)
    local nC = jC2 + vector3(0,0,1.5) - vector3(5,9,0)
    TriggerEvent('TunasTruckJob:ped', jC2, false, false, false)
    j3 = true
    while j3 do
        Citizen.Wait(5)
        local uDist = GetDistanceBetweenCoords(coords.x, coords.y, coords.z, jC2.x-5,jC2.y-9, jC2.z, false)
        if uDist < 20 then
            ESX.ShowHelpNotification("Sign off on the order !", true, true, 5000)
            DrawMarker(29, nC, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 2.0, 2.0, 1.0, 0, 120, 0, 200, false, true, 2, false, false, false, false)
            if uDist < 3 then
                ESX.ShowHelpNotification("Press ~INPUT_CONTEXT~ to speak with the foreman", true, true, 5000)
                if IsControlJustPressed(0,38) then
                    ccJob = true
                    DeliveryAnim()
                    j3 = false
                    return
                end
            end
        end
    end  
end

-- ===================================================== BC 1 =============================================

function startJob4()
    local p = PlayerPedId()
    local vC1 = vector3(135.39,6620.55,31.76) -- truck
    local vC2 = vector3(144.59,6621.6,31.56) -- trailer
    local h = 128.13
    local sC2 = vector3(2838.13,1525.58,24.58)
    local n2 = false
    ESX.Game.SpawnVehicle("phantom", vC1, h , function(veh)        
	    Citizen.Wait(1000)
        SetVehicleLivery(veh, 4)
        SetPedIntoVehicle(p, veh, -1)
        print(veh)
        mB = AddBlipForCoord(sC2)
        SetBlipRoute(mB, true)
        SetBlipRouteColour(mB, 57)
        SetBlipColour(mB, 57)
        ESX.Game.SpawnVehicle("tanker2", vC2, h , function(veh2)
            AttachVehicleToTrailer(veh, veh2, 1.1)
            Citizen.CreateThread(function()
                local wait = 100
                while not n2 do
                    Citizen.Wait(wait)
                    local tDist = GetDistanceBetweenCoords(coords.x, coords.y, coords.z, sC2, false)
                    local tr = GetEntityCoords(veh2)
                    local trDist = GetDistanceBetweenCoords(tr, sC2, false)
                    if tDist < 60  and trDist > 5 then
                        wait = 5
                        r = 250 ;  g = 0;  b = 0; a = 200;
                       DynaMarker(1, sC2.x, sC2.y, sC2.z-1.0, 250, 0, 0, 200, false)    
                    end
                    if trDist < 5 then
                        wait = 5
                        DynaMarker(1, sC2.x, sC2.y, sC2.z-1.0, 0, 600, 0, 100, false)
                        if trDist < 2 then
                            print('ok ...')
                            SetBlipRoute(mB, false)
                            RemoveBlip(mB)
                            Job4()
                            Citizen.Wait(10000)
                            ESX.Game.DeleteVehicle(veh2)
                            return
                        end
                    end   
                end
            end)
        end)
    end)
end

function Job4()
    local jC2 = vector3(2838.13,1525.58,24.58)
    local nC = jC2 + vector3(0,0,1.5) - vector3(5,9,0)
    TriggerEvent('TunasTruckJob:ped', jC2, false, false, false)
    j4 = true
    while j4 do
        Citizen.Wait(5)
        local uDist = GetDistanceBetweenCoords(coords.x, coords.y, coords.z, jC2.x-5,jC2.y-9, jC2.z, false)
        if uDist < 20 then
            ESX.ShowHelpNotification("Sign off on the order !", true, true, 5000)
            DrawMarker(29, nC, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 2.0, 2.0, 1.0, 0, 120, 0, 200, false, true, 2, false, false, false, false)
            if uDist < 3 then
                ESX.ShowHelpNotification("Press ~INPUT_CONTEXT~ to speak with the foreman", true, true, 5000)
                if IsControlJustPressed(0,38) then
                    bcJob = true
                    DeliveryAnim()
                    j4 = false
                    return
                end
            end
        end
    end  
end

-- =========================================== cc -> bc -> ls =======================================================

-- ===================================================== BC 1 =============================================

function startJob5()
    local p = PlayerPedId()
    local vC1 = vector3(135.39,6620.55,31.76) -- truck
    local vC2 = vector3(144.59,6621.6,31.56) -- trailer
    local h = 128.13
    local sC2 = vector3(-150.98, -2567.15, 6.0)
    local n2 = false
    ESX.Game.SpawnVehicle("packer", vC1, h , function(veh)        
	    Citizen.Wait(1000)
        SetVehicleLivery(veh, 4)
        SetPedIntoVehicle(p, veh, -1)
        print(veh)
        mB = AddBlipForCoord(sC2)
        SetBlipRoute(mB, true)
        SetBlipRouteColour(mB, 57)
        SetBlipColour(mB, 57)
        ESX.Game.SpawnVehicle("trailers3", vC2, h , function(veh2)
            AttachVehicleToTrailer(veh, veh2, 1.1)
            Citizen.CreateThread(function()
                local wait = 100
                while not n2 do
                    Citizen.Wait(wait)
                    local tDist = GetDistanceBetweenCoords(coords.x, coords.y, coords.z, sC2, false)
                    local tr = GetEntityCoords(veh2)
                    local trDist = GetDistanceBetweenCoords(tr, sC2, false)
                    if tDist < 60  and trDist > 5 then
                        wait = 5
                        r = 250 ;  g = 0;  b = 0; a = 200;
                        DynaMarker(1, sC2.x, sC2.y, sC2.z-1.0, 250, 0, 0, 200, false)    
                    end
                    if trDist < 5 then
                        wait = 5
                        DynaMarker(1, sC2.x, sC2.y, sC2.z-1.0, 0, 600, 0, 100, false)   
                        if trDist < 2 then
                            print('ok ...')
                            SetBlipRoute(mB, false)
                            RemoveBlip(mB)
                            Job5()
                            Citizen.Wait(10000)
                            ESX.Game.DeleteVehicle(veh)
                            ESX.Game.DeleteVehicle(veh2)
                            return
                        end
                    end   
                end
            end)
        end)
    end)
end

function Job5()
    local jC2 = vector3(-150.98, -2567.15, 6.0)
    local nC = jC2 + vector3(0,0,1.5) - vector3(5,9,0)
    TriggerEvent('TunasTruckJob:ped', jC2, false, false, false)
    j5 = true
    while j5 do
        Citizen.Wait(5)
        local uDist = GetDistanceBetweenCoords(coords.x, coords.y, coords.z, jC2.x-5,jC2.y-9, jC2.z, false)
        if uDist < 20 then
            ESX.ShowHelpNotification("Sign off on the order !", true, true, 5000)
            DrawMarker(29, nC, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 2.0, 2.0, 1.0, 0, 120, 0, 200, false, true, 2, false, false, false, false)
            if uDist < 3 then
                ESX.ShowHelpNotification("Press ~INPUT_CONTEXT~ to speak with the foreman", true, true, 5000)
                if IsControlJustPressed(0,38) then
                    ccJob2 = true
                    DeliveryAnim()
                    j5 = false
                    return
                end
            end
        end
    end  
end

-- ===================================================== luxury auto delivery =================================

function startJob6()
    local p = PlayerPedId()
    local vC1 = vector3(-156.41,-2561.54,6.02) -- truck
    local vC2 = vector3(-165.6,-2560.4,5.82) -- trailer
    local h = 86.65
    local sC = vector3(529.6,-3022.47,6.03)
    local n2 = false
    ESX.Game.SpawnVehicle("phantom", vC1, h , function(veh)        
	    Citizen.Wait(1000)
        SetVehicleLivery(veh, 4)
        SetPedIntoVehicle(p, veh, -1)
        print(veh)
        mB = AddBlipForCoord(sC)
        SetBlipRoute(mB, true)
        SetBlipRouteColour(mB, 57)
        SetBlipColour(mB, 57)
        ESX.Game.SpawnVehicle("tr2", vC2, h , function(veh2)
            AttachVehicleToTrailer(veh, veh2, 1.1)
            Citizen.CreateThread(function()
                local wait = 100
                while not n2 do
                    Citizen.Wait(wait)
                    local tDist = GetDistanceBetweenCoords(coords.x, coords.y, coords.z, sC, false)
                    if tDist < 50 then
                        local tr = GetEntityCoords(veh2)
                        local trDist = GetDistanceBetweenCoords(tr, sC, false)
                        wait = 5
                        r = 250 ;  g = 0;  b = 0; a = 200;
                        DrawMarker(1, sC.x, sC.y, sC.z-1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 10.0, 10.0, 5.0, r, g, b, a, false, true, 2, false, false, false, false)
                        if trDist < 15 then
                            r = 0; g = 120; b = 0; a = 0;   
                            if trDist < 5 then
                                print('ok ...')
                                Citizen.Wait(1000)
                                SetBlipRoute(mB, false)
                                RemoveBlip(mB)
                                luxJob = true
                                Job6()
                                n2 = true
                                Citizen.Wait(10000)
                                local nH = GetEntityHeading(tr)
                                ESX.Game.DeleteVehicle(veh2)
                                ESX.Game.SpawnVehicle("tr4", tr, nH , function(veh3)
                                    AttachVehicleToTrailer(veh, veh3, 1.1)
                                    function Job7()
                                        onJob = true
                                        local jC = vector3(-17.83,-1105.28,26.67)
                                        local nC = jC + vector3(0,0,1.5) - vector3(5,9,0)
                                        mB = AddBlipForCoord(jC)
                                        SetBlipRoute(mB, true)
                                        SetBlipRouteColour(mB, 57)
                                        SetBlipColour(mB, 57)
                                        TriggerEvent('TunasTruckJob:ped', jC, false, false, false)
                                        while true do
                                            Citizen.Wait(5)
                                            local uDist = GetDistanceBetweenCoords(coords.x, coords.y, coords.z, jC.x-5,jC.y-9, jC.z, false)
                                            r = 250 ;  g = 0;  b = 0; a = 200;
                                            DrawMarker(1, jC.x, jC.y, jC.z-1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 10.0, 10.0, 5.0, r, g, b, a, false, true, 2, false, false, false, false)
                                            if uDist < 20 then        
                                                ESX.ShowHelpNotification("Sign off on the order !", true, true, 5000)
                                                DrawMarker(29, nC, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 2.0, 2.0, 1.0, 0, 120, 0, 200, false, true, 2, false, false, false, false)
                                                if uDist < 3 then
                                                    ESX.ShowHelpNotification("Press ~INPUT_CONTEXT~ to speak with the foreman", true, true, 5000)
                                                    if IsControlJustPressed(0,38) then
                                                        luxReturn = true
                                                        DeliveryAnim()
                                                        SetBlipRoute(mB, false)
                                                        RemoveBlip(mB)
                                                        Citizen.Wait(10000)
                                                        local nH = GetEntityHeading(tr)
                                                        ESX.Game.DeleteVehicle(veh3)
                                                        Citizen.Wait(1000)
                                                        ESX.Game.SpawnVehicle("tr2", tr, nH , function(veh4)
                                                            AttachVehicleToTrailer(veh, veh4, 1.1)
                                                        end)
                                                        return
                                                    end
                                                end
                                            end
                                        end  
                                    end
                                end)
                            end
                        end    
                    end   
                end  
            end)
        end)
    end)
end

function Job6()
    local jC = vector3(529.6,-3022.47,6.03)
    local nC = jC + vector3(0,0,1.5) - vector3(5,9,0)
    TriggerEvent('TunasTruckJob:ped', jC, false, false, false)
    j6 = true
    while j6 do
        Citizen.Wait(5)
        local uDist = GetDistanceBetweenCoords(coords.x, coords.y, coords.z, jC.x-5,jC.y-9, jC.z, false)
        if uDist < 20 then
            ESX.ShowHelpNotification("Sign off on the order !", true, true, 5000)
            DrawMarker(29, nC, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 2.0, 2.0, 1.0, 0, 120, 0, 200, false, true, 2, false, false, false, false)
            if uDist < 3 then
                ESX.ShowHelpNotification("Press ~INPUT_CONTEXT~ to speak with the foreman", true, true, 5000)
                if IsControlJustPressed(0,38) then
                    DeliveryAnim()
                    luxJob = true
                    j6 = false
                    return
                end
            end
        end
    end  
end

-- =================================================== ARMY DEPOT JOB ===============================================

function startJob8()
    local p = PlayerPedId()
    local vC1 = vector3(140.82,6591.37,31.86) -- truck +9.21 , 1.1, 1.2
    local vC2 = vector3(150.01,6592.47,33.06) -- trailer
    local h = 219.82
    local sC = vector3(-322.58,6095.0,31.47)
    local n2 = false
    ESX.Game.SpawnVehicle("barracks2", vC1, h , function(veh)        
	    Citizen.Wait(1000)
        SetVehicleLivery(veh, 4)
        SetPedIntoVehicle(p, veh, -1)
        print(veh)
        mB = AddBlipForCoord(sC)
        SetBlipRoute(mB, true)
        SetBlipRouteColour(mB, 57)
        SetBlipColour(mB, 57)
        ESX.Game.SpawnVehicle("armytrailer", vC2, h , function(veh2)
            AttachVehicleToTrailer(veh, veh2, 1.1)
            Citizen.CreateThread(function()
                local wait = 100
                while not n2 do
                    Citizen.Wait(wait)
                    local tDist = GetDistanceBetweenCoords(coords.x, coords.y, coords.z, sC, false)
                    if tDist < 50 then
                        local tr = GetEntityCoords(veh2)
                        local trDist = GetDistanceBetweenCoords(tr, sC, false)
                        wait = 5
                        r = 250 ;  g = 0;  b = 0; a = 200;
                        DrawMarker(1, sC.x, sC.y, sC.z-1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 10.0, 10.0, 5.0, r, g, b, a, false, true, 2, false, false, false, false)
                        if trDist < 15 then
                            r = 0; g = 120; b = 0; a = 0;   
                            if trDist < 5 then
                                print('ok ...')
                                Citizen.Wait(1000)
                                SetBlipRoute(mB, false)
                                RemoveBlip(mB)
                                Job8()
                                n2 = true
                                Citizen.Wait(10000)
                                local nH = GetEntityHeading(tr)
                                ESX.Game.DeleteVehicle(veh2)
                                ESX.Game.SpawnVehicle("armytrailer2", tr, nH , function(veh3)
                                    AttachVehicleToTrailer(veh, veh3, 1.1)
                                -- ARMY DEPOT RETURN
                                    function Job9()
                                        onJob = true
                                        local jC = vector3(-2333.76,3405.91,30.21)
                                        local nC = jC + vector3(0,0,3) - vector3(5,9,0)
                                        mB = AddBlipForCoord(jC)
                                        SetBlipRoute(mB, true)
                                        SetBlipRouteColour(mB, 57)
                                        SetBlipColour(mB, 57)
                                        TriggerEvent('TunasTruckJob:ped', jC, false, false, true)
                                        while true do
                                            Citizen.Wait(5)
                                            local uDist = GetDistanceBetweenCoords(coords.x, coords.y, coords.z, nC.x,nC.y, nC.z, false)
                                            r = 250 ;  g = 0;  b = 0; a = 200;
                                            DrawMarker(1, jC.x, jC.y, jC.z-1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 10.0, 10.0, 5.0, r, g, b, a, false, true, 2, false, false, false, false)
                                            if uDist < 20 then        
                                                ESX.ShowHelpNotification("Sign off on the order !", true, true, 5000)
                                                DrawMarker(29, nC, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 2.0, 2.0, 1.0, 0, 120, 0, 200, false, true, 2, false, false, false, false)
                                                if uDist < 3 then
                                                    ESX.ShowHelpNotification("Press ~INPUT_CONTEXT~ to speak with the commander", true, true, 5000)
                                                    if IsControlJustPressed(0,38) then
                                                        armyReturn = true
                                                        DeliveryAnim()
                                                        SetBlipRoute(mB, false)
                                                        RemoveBlip(mB)
                                                        Citizen.Wait(10000)
                                                        local nH = GetEntityHeading(tr)
                                                        ESX.Game.DeleteVehicle(veh3)
                                                        Citizen.Wait(1000)
                                                        ESX.Game.SpawnVehicle("armytrailer", tr, nH , function(veh4)
                                                            AttachVehicleToTrailer(veh, veh4, 1.1)
                                                        end)
                                                        return
                                                    end
                                                end
                                            end
                                        end
                                        return  
                                    end
                                end)
                            end
                        end    
                    end   
                end  
            end)
        end)
    end)
end

function Job8()
    local jC = vector3(-320.23,6099.54,31.47)
    local nC = jC + vector3(0,0,1.5) - vector3(5,9,0)
    TriggerEvent('TunasTruckJob:ped', jC, false, false, false)
    j8 = true
    while j8 do
        Citizen.Wait(5)
        local uDist = GetDistanceBetweenCoords(coords.x, coords.y, coords.z, nC, false)
        if uDist < 20 then
            ESX.ShowHelpNotification("Sign off on the order !", true, true, 5000)
            DrawMarker(29, nC, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 2.0, 2.0, 1.0, 0, 120, 0, 200, false, true, 2, false, false, false, false)
            if uDist < 3 then
                ESX.ShowHelpNotification("Press ~INPUT_CONTEXT~ to speak with the foreman", true, true, 5000)
                if IsControlJustPressed(0,38) then
                    DeliveryAnim()
                    armyJob = true
                    j8 = false
                    return
                end
            end
        end
    end  
end

-- ========================================= logging ======================================


function startJob10()
    local p = PlayerPedId()
    local vC1 = vector3(135.39,6620.55,31.76) -- truck
    local vC2 = vector3(144.59,6621.6,31.56) -- trailer
    local h = 128.13
    local sC2 = vector3(-570.6,5265.1,70.44)
    local n2 = false
    ESX.Game.SpawnVehicle("phantom", vC1, h , function(veh)        
	    Citizen.Wait(1000)
        SetVehicleLivery(veh, 4)
        SetPedIntoVehicle(p, veh, -1)
        print(veh)
        mB = AddBlipForCoord(sC2)
        SetBlipRoute(mB, true)
        SetBlipRouteColour(mB, 57)
        SetBlipColour(mB, 57)
        ESX.Game.SpawnVehicle("trailerlogs", vC2, h , function(veh2)
            AttachVehicleToTrailer(veh, veh2, 1.1)
            Citizen.CreateThread(function()
                local wait = 100
                while not n2 do
                    Citizen.Wait(wait)
                    local tDist = GetDistanceBetweenCoords(coords.x, coords.y, coords.z, sC2, false)
                    local tr = GetEntityCoords(veh2)
                    local trDist = GetDistanceBetweenCoords(tr, sC2, false)
                    if tDist < 60  and trDist > 5 then
                        wait = 5
                        r = 250 ;  g = 0;  b = 0; a = 200;
                        DynaMarker(1, sC2.x, sC2.y, sC2.z-1.0, 250, 0, 0, 200, false)    
                    end
                    if trDist < 5 then
                        local trH = GetEntityHeading(veh2)
                        wait = 5
                        DynaMarker(1, sC2.x, sC2.y, sC2.z-1.0, 0, 600, 0, 100, false)   
                        if trDist < 2 then
                            print('ok ...')
                            SetBlipRoute(mB, false)
                            RemoveBlip(mB)
                            Job10()
                            Citizen.Wait(10000)
                            ESX.Game.DeleteVehicle(veh2)
                            ESX.Game.SpawnVehicle("trflat", tr, trH , function(veh3)
                                AttachVehicleToTrailer(veh, veh3, 1.1)
                            end)
                            return
                        end
                    end   
                end
            end)
        end)
    end)
end

function Job10()
    j10 = true
    local jC2 = vector3(-570.6,5265.1,70.44)
    local nC = jC2 + vector3(0,0,1.5) - vector3(5,9,0)
    TriggerEvent('TunasTruckJob:ped', jC2, false, false, false)
    while j10 do
        Citizen.Wait(5)
        local uDist = GetDistanceBetweenCoords(coords.x, coords.y, coords.z, jC2.x-5,jC2.y-9, jC2.z, false)
        if uDist < 20 then
            ESX.ShowHelpNotification("Sign off on the order !", true, true, 5000)
            DrawMarker(29, nC, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 2.0, 2.0, 1.0, 0, 120, 0, 200, false, true, 2, false, false, false, false)
            if uDist < 3 then
                ESX.ShowHelpNotification("Press ~INPUT_CONTEXT~ to speak with the foreman", true, true, 5000)
                if IsControlJustPressed(0,38) then
                    bcJob3 = true
                    DeliveryAnim()
                    j10 = false
                    return
                end
            end
        end
    end  
end
