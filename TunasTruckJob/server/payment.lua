ESX = nil
payMin = 200 
payMax = 500

TriggerEvent("esx:getSharedObject", function(obj) ESX = obj end)

RegisterNetEvent('TunasTruckJob:pay')
AddEventHandler('TunasTruckJob:pay', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
        if xPlayer ~= nil then
            local randomMoney = math.random(payMin,payMax)
            xPlayer.addMoney(randomMoney)
            local cash = xPlayer.getMoney()
		if randomMoney > 501 then
			print(source .. " may be cheating ....")
			return
        	end
            TriggerClientEvent('banking:updateCash', _source, cash)
            TriggerClientEvent('esx:showNotification', _source,'You were paid $ '.. randomMoney)
        end
end)
