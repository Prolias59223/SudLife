ESX = exports["es_extended"]:getSharedObject()


local stash = {
    id = "mairie",
    label = "Mairie de Paris",
    slots = 25,
    weight = 75000,
    groups = "mairie"
}

AddEventHandler('onServerResourceStart', function(resourceName)
    if resourceName == 'ox_inventory' or resourceName ==
        GetCurrentResourceName() then
        exports.ox_inventory:RegisterStash(stash.id, stash.label, stash.slots,
                                           stash.weight, stash.groups)
    end
end)

TriggerEvent('esx_society:registerSociety', 'mairie', 'mairie', 'society_mairie', 'society_mairie', 'society_mairie', {type = 'private'})


ESX.RegisterServerCallback('Mairie:getStockItems', function(source, cb)
	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_mairie', function(inventory)
		cb(inventory.items)
	end)
end)

RegisterNetEvent('Mairie:getStockItem')
AddEventHandler('Mairie:getStockItem', function(itemName, count)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_mairie', function(inventory)
		local inventoryItem = inventory.getItem(itemName)

		-- is there enough in the society?
		if count > 0 and inventoryItem.count >= count then
				inventory.removeItem(itemName, count)
				xPlayer.addInventoryItem(itemName, count)
				TriggerClientEvent('esx:showNotification', _source, 'Objet retiré', count, inventoryItem.label)
		else
			TriggerClientEvent('esx:showNotification', _source, "Quantité invalide")
		end
	end)
end)

ESX.RegisterServerCallback('Mairie:getPlayerInventory', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)
	local items   = xPlayer.inventory

	cb({items = items})
end)

RegisterNetEvent('Mairie:putStockItems')
AddEventHandler('Mairie:putStockItems', function(itemName, count)
	local xPlayer = ESX.GetPlayerFromId(source)
	local sourceItem = xPlayer.getInventoryItem(itemName)

	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_mairie', function(inventory)
		local inventoryItem = inventory.getItem(itemName)

		-- does the player have enough of the item?
		if sourceItem.count >= count and count > 0 then
			xPlayer.removeInventoryItem(itemName, count)
			inventory.addItem(itemName, count)
		else
			TriggerClientEvent('esx:showNotification', _source, "Quantité invalide")
		end
	end)
end)

AddEventHandler('playerDropped', function()
	-- Save the source in case we lose it (which happens a lot)
	local _source = source

	-- Did the player ever join?
	if _source ~= nil then
		local xPlayer = ESX.GetPlayerFromId(_source)

		-- Is it worth telling all clients to refresh?
		if xPlayer ~= nil and xPlayer.job ~= nil and xPlayer.job.name == 'mairie' then
			Citizen.Wait(5000)
			TriggerClientEvent('Mairie:updateBlip', -1)
		end
	end
end)

RegisterServerEvent('Mairie:spawned')
AddEventHandler('Mairie:spawned', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

	if xPlayer ~= nil and xPlayer.job ~= nil and xPlayer.job.name == 'mairie' then
		Citizen.Wait(5000)
		TriggerClientEvent('Mairie:updateBlip', -1)
	end
end)

AddEventHandler('onResourceStart', function(resource)
	if resource == GetCurrentResourceName() then
		Citizen.Wait(5000)
		TriggerClientEvent('Mairie:updateBlip', -1)
	end
end)

AddEventHandler('onResourceStop', function(resource)
	if resource == GetCurrentResourceName() then
		TriggerEvent('esx_phone:removeNumber', 'mairie')
	end
end)


RegisterServerEvent('Mairie:message')
AddEventHandler('Mairie:message', function(target, msg)
	TriggerClientEvent('esx:showNotification', target, msg)
end)


RegisterServerEvent('OuvertMairie')
AddEventHandler('OuvertMairie', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local xPlayers	= ESX.GetPlayers()
	for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], 'Mairie de Paris', '📌 ~b~Nouvelle~s~ annonce 📢', 'La Mairie est ~g~Ouvert~s~ !', 'CHAR_MAIRIE', 8)
	end
end)

RegisterServerEvent('FermerMairie')
AddEventHandler('FermerMairie', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local xPlayers	= ESX.GetPlayers()
	for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], 'Mairie de Paris', '📌 ~b~Nouvelle~s~ annonce 📢', 'La Mairie est ~r~Fermer~s~ !', 'CHAR_MAIRIE', 8)
	end
end)


RegisterServerEvent('mairie:mairiejob')
AddEventHandler('mairie:mairiejob', function(PriseOuFin, message)
    local _source = source
    local _raison = PriseOuFin
    local xPlayer = ESX.GetPlayerFromId(_source)
    local xPlayers = ESX.GetPlayers()
    local name = xPlayer.getName(_source)


    for i = 1, #xPlayers, 1 do
        local thePlayer = ESX.GetPlayerFromId(xPlayers[i])
        if thePlayer.job.name == 'mairie' then
            TriggerClientEvent('mairie:mairiejob', xPlayers[i], _raison, name, message)
        end
    end
end)

RegisterServerEvent('RecruMairie')
AddEventHandler('RecruMairie', function (target)

    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local xPlayers = ESX.GetPlayers()
    for i=1, #xPlayers, 1 do
    local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
    TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], 'Mairie de Paris', '📌 ~b~Nouvelle~s~ annonce 📢', '~y~Recrutement en cours, rendez-vous à la Mairie!', 'CHAR_MAIRIE', 8)

    end
end)



RegisterCommand('mairie', function(source, args, rawCommand)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    if xPlayer.job.name == "mairie" then
        local src = source
        local msg = rawCommand:sub(5)
        local args = msg
        if player ~= false then
            local name = GetPlayerName(source)
            local xPlayers	= ESX.GetPlayers()
        for i=1, #xPlayers, 1 do
            local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
            TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], 'Mairie de Marseille', '📌 ~b~Nouvelle~s~ annonce 📢', ''..msg..'', 'CHAR_MAIRIE', 0)
        end
    else
        TriggerClientEvent('esx:showAdvancedNotification', _source, 'Avertisement', '~r~Erreur' , '~y~Tu n\'es pas membre de cette entreprise pour faire cette commande', 'CHAR_MAIRIE', 0)
    end
else
    TriggerClientEvent('esx:showAdvancedNotification', _source, 'Avertisement', '~r~Erreur' , '~y~Tu n\'es pas membre de cette entreprise pour faire cette commande', 'CHAR_MAIRIE', 0)
end
end, false)
