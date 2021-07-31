enableBlip = true
startBlips = {}
if enableBlip then
    Citizen.CreateThread(function()
        startBlips = {			
            [1] = {
                blip = nil, 
                name = "Truck Driving - LS",  -- #1
                coords = vector3(-176.74, -2581.24, 6.0), 
            },
            [2] = {
                blip = nil, 
                name = "Truck Driving - BC",  -- #2
                coords = vector3(120.39, 6620.51, 31.69), 
            },
        }
        for k, _ in pairs(startBlips) do
            local b = AddBlipForCoord(_.coords)
            SetBlipSprite(b,85)
            SetBlipColour(b, 57)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString(_.name)
            EndTextCommandSetBlipName(b)
            SetBlipAsShortRange(b,true)
            SetBlipAsMissionCreatorBlip(b,true)
            _.b = b
        end
    end)
end

function DynaMarker(type,posX,posY,posZ,r,g,b,a,multi)

    if multi == true then
        -- enter
        DrawMarker(type, posX,posY,posZ, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.0, 1.0, 1.0, r, g, b, a, false, true, 2, false, false, false, false)
       -- dollar sign
        DrawMarker(29, posX,posY,posZ+2.5, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.0, 1.0, 1.0, 0, 500, 0, 200, false, true, 2, false, false, false, false)
    else
        -- entering/exiting trailer zone
        DrawMarker(type, posX, posY,posZ, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 10.0, 10.0, 5.0, r, g, b, a, false, true, 2, false, false, false, false)
    end
end

function DrawMissionText(text)
    SetTextScale(0.5, 0.5)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextEdge(2, 0, 0, 0, 150)
    SetTextEntry("STRING")
    SetTextCentre(1)
    SetTextOutline()
    AddTextComponentString(text)
    DrawText(0.5,0.955)
end


function ChangeClothes()
    TriggerEvent('esx_skin:setLastSkin', function(skin)
        LastSkin = skin
        --print(LastSkin)
    end)

    TriggerEvent('skinchanger:getSkin', function(skin)
                        -- MALE
           if skin.sex == 0 then
            local clothesSkin = {
                ['tshirt_1'] = 112,  ['tshirt_2'] = 0,
                ['torso_1'] = 47,   ['torso_2'] = 0,
                ['decals_1'] = 0,   ['decals_2'] = 0,
                ['arms'] = 1,
                ['pants_1'] = 7,   ['pants_2'] = 0,
                ['shoes_1'] = 112,   ['shoes_2'] = 0,
                ['helmet_1'] = 113,  ['helmet_2'] = 3,
                ['chain_1'] = 0,    ['chain_2'] = 0,
                ['bproof_1'] = 0,     ['bproof_2'] = 0							
            }
            TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
        else
                        -- FEMALE
            local clothesSkin = {
                ['tshirt_1'] = 15,  ['tshirt_2'] = 0,
                ['torso_1'] = 95,   ['torso_2'] = 0,
                ['decals_1'] = 0,   ['decals_2'] = 0,
                ['arms'] = 11,
                ['pants_1'] = 11,   ['pants_2'] = 3,
                ['shoes_1'] = 60,   ['shoes_2'] = 4,
                --['helmet_1'] = 0,  ['helmet_2'] = 0,
                ['chain_1'] = 0,    ['chain_2'] = 0,
                ['bproof_1'] = 5,     ['bproof_2'] = 2
            }
            TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
        end
    end)
end


-- Function for 3D text:
function DrawText3Ds(x,y,z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    SetTextScale(0.32, 0.32)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 255)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
    local factor = (string.len(text)) / 500
    DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 0, 0, 0, 80)
end
-- ---------------------------------------- end of functions ----------------------------------------