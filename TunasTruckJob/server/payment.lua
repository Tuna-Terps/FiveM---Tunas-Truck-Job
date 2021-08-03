ESX = nil
payMin = 350 
payMax = 500

TriggerEvent("esx:getSharedObject", function(obj) ESX = obj end)

RegisterNetEvent('TunasTruckJob:pay')
AddEventHandler('TunasTruckJob:pay', function()
    print('paying ...')
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
        if xPlayer ~= nil then
            local randomMoney = math.random(payMin,payMax)
            xPlayer.addMoney(randomMoney)
            local cash = xPlayer.getMoney()
            TriggerClientEvent('banking:updateCash', _source, cash)
            TriggerClientEvent('esx:showNotification', _source,'You were paid $ '.. randomMoney)
        end
end)
-- stop trucking; thanks Soubisan <3
RegisterCommand("stoptruck", function(source, args) 
    TriggerClientEvent('TunasTruckJob_gw:stoptruck', source)
end)
