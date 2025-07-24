ESX = exports["es_extended"]:getSharedObject()
local stash = {
    id = "brinks",
    label = "Brinks",
    slots = 25,
    weight = 75000,
    groups = "brinks"
}

AddEventHandler('onServerResourceStart', function(resourceName)
    if resourceName == 'ox_inventory' or resourceName ==
        GetCurrentResourceName() then
        exports.ox_inventory:RegisterStash(stash.id, stash.label, stash.slots,
                                           stash.weight, stash.groups)
    end
end)


TriggerEvent('esx_society:registerSociety', 'brinks', 'brinks', 'society_brinks', 'society_brinks', 'society_brinks', {type = 'private'})

ESX.RegisterServerCallback('vBrinks:getStockItems', function(source, cb)
	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_brinks', function(inventory)
		cb(inventory.items)
	end)
end)

RegisterNetEvent('vBrinks:getStockItem')
AddEventHandler('vBrinks:getStockItem', function(itemName, count)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_brinks', function(inventory)
		local inventoryItem = inventory.getItem(itemName)

		if count > 0 and inventoryItem.count >= count then
				inventory.removeItem(itemName, count)
				xPlayer.addInventoryItem(itemName, count)
				TriggerClientEvent('esx:showNotification', _source, 'Un objet a été retiré', count, inventoryItem.label)
		else
			TriggerClientEvent('esx:showNotification', _source, "Quantité invalide")
		end
	end)
end)

ESX.RegisterServerCallback('vBrinks:getPlayerInventory', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)
	local items   = xPlayer.inventory

	cb({items = items})
end)

RegisterNetEvent('vBrinks:putStockItems')
AddEventHandler('vBrinks:putStockItems', function(itemName, count)
	local xPlayer = ESX.GetPlayerFromId(source)
	local sourceItem = xPlayer.getInventoryItem(itemName)

	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_brinks', function(inventory)
		local inventoryItem = inventory.getItem(itemName)

		if sourceItem.count >= count and count > 0 then
			xPlayer.removeInventoryItem(itemName, count)
			inventory.addItem(itemName, count)
		else
			TriggerClientEvent('esx:showNotification', _source, "Quantité invalide")
		end
	end)
end)

RegisterNetEvent('treespacesac')
AddEventHandler('treespacesac', function()
    local item = "sdb"
    local limiteitem = 50
    local xPlayer = ESX.GetPlayerFromId(source)
    local nbitemdansinventaire = xPlayer.getInventoryItem(item).count
    

    if nbitemdansinventaire >= limiteitem then
        TriggerClientEvent('esx:showNotification', source, "T\'as pas assez de place dans ton inventaire !")
    else
        xPlayer.addInventoryItem(item, 1)
    end
end)

RegisterNetEvent('liassetreespace')
AddEventHandler('liassetreespace', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

    local sdb = xPlayer.getInventoryItem('sdb').count
    local ldb = xPlayer.getInventoryItem('ldb').count

    if ldb > 50 then
        TriggerClientEvent('esx:showNotification', source, '~r~Il semble que tu ne puisses plus porter de liasse(s)...')
    elseif sdb < 5 then
        TriggerClientEvent('esx:showNotification', source, '~r~Pas assez de sac de billet pour traiter...')
    else
        xPlayer.removeInventoryItem('sdb', 5)
        xPlayer.addInventoryItem('ldb', 1)    
    end
end)

RegisterNetEvent('liassevente')
AddEventHandler('liassevente', function()

    local money = math.random(10,50)
	local playerMoney  = math.random(1,5)
    local xPlayer = ESX.GetPlayerFromId(source)
    local societyAccount = nil
    local ldb = 0

    if xPlayer.getInventoryItem('ldb').count <= 0 then
        ldb = 0
    else
        ldb = 1
    end

    if ldb == 0 then
        TriggerClientEvent('esx:showNotification', xPlayer.source, '~r~Pas assez de liasse pour vendre...')
        return
    elseif xPlayer.getInventoryItem('ldb').count <= 0 and argent == 0 then
        TriggerClientEvent('esx:showNotification', xPlayer.source, '~r~Pas assez de liasse pour vendre...')
        ldb = 0
        return
    elseif ldb == 1 then
            local money = math.random(10,50)
			local playerMoney  = math.random(1,5)
            xPlayer.removeInventoryItem('ldb', 1)
            local societyAccount = nil

            TriggerEvent('esx_addonaccount:getSharedAccount', 'society_brinks', function(account)
                societyAccount = account
            end)
            if societyAccount ~= nil then
                societyAccount.addMoney(money) -- L'ARGENT VA DANS LA SOCIETY 
			--	xPlayer.addMoney(playerMoney) -- L'ARGENT VA SUR LE JOUEUR
                TriggerClientEvent('esx:showNotification', source, "~g~Vendu avec sucess...")
            end
        end
        end) 

        
        RegisterServerEvent('OuvertvBrinks')
AddEventHandler('OuvertvBrinks', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local xPlayers	= ESX.GetPlayers()
	for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], 'Brinks - France', '📌 ~b~Nouvelle~s~ annonce 📢', 'Brinks est ~g~Ouvert~s~ !', 'CHAR_BRINKS', 8)
	end
end)

RegisterServerEvent('FermervBrinks')
AddEventHandler('FermervBrinks', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local xPlayers	= ESX.GetPlayers()
	for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], 'Brinks - France', '📌 ~b~Nouvelle~s~ annonce 📢', 'Brinks est ~r~Fermer~s~ !', 'CHAR_BRINKS', 8)
	end
end)

RegisterServerEvent('RecruvBrinks')
AddEventHandler('RecruvBrinks', function (target)

    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local xPlayers = ESX.GetPlayers()
    for i=1, #xPlayers, 1 do
    local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
    TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], 'Brinks - France', '📌 ~b~Nouvelle~s~ annonce 📢', '~y~Recrutement~s~ en cours, rendez-vous au Brinks!', 'CHAR_BRINKS', 8)

    end
end)

RegisterCommand('br', function(source, args, rawCommand)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    if xPlayer.job.name == "brinks" then
        local src = source
        local msg = rawCommand:sub(5)
        local args = msg
        if player ~= false then
            local name = GetPlayerName(source)
            local xPlayers	= ESX.GetPlayers()
        for i=1, #xPlayers, 1 do
            local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
             TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], 'Brinks - France', '📌 ~b~Nouvelle~s~ annonce 📢', ''..msg..'', 'CHAR_BRINKS', 8)
        end
    else
        TriggerClientEvent('esx:showAdvancedNotification', _source, 'Avertisement', '~r~Erreur' , '~r~Tu n\'es pas membre de cette entreprise pour faire cette commande', 'CHAR_BRINKS', 0)
    end
else
    TriggerClientEvent('esx:showAdvancedNotification', _source, 'Avertisement', '~r~Erreur' , '~r~Tu n\'es pas membre de cette entreprise pour faire cette commande', 'CHAR_BRINKS', 0)
end
end, false)

-- Armurie 

RegisterNetEvent('laxi:weapon_combatpistolBR')
AddEventHandler('laxi:weapon_combatpistolBR', function()

    local _source = source
    local xPlayer = ESX.GetPlayerFromId(source)  
    local price = 0
    local xMoney = xPlayer.getMoney()

    if xMoney >= price then

        xPlayer.removeMoney(price)
        xPlayer.addInventoryItem('weapon_pistol', 1)
        TriggerClientEvent('esx:showNotification', source, "~g~[Réussi]~w~ vous avez reçu votre équipement !")
    end
end)

RegisterNetEvent('laxi:weapon_carbinerifleBR')
AddEventHandler('laxi:weapon_carbinerifleBR', function()

    local _source = source
    local xPlayer = ESX.GetPlayerFromId(source)  
    local price = 0
    local xMoney = xPlayer.getMoney()

    if xMoney >= price then

        xPlayer.removeMoney(price)
        xPlayer.addInventoryItem('weapon_carbinerifle', 1)
        TriggerClientEvent('esx:showNotification', source, "~g~[Réussi]~w~ vous avez reçu votre équipement !")
    end
end)

RegisterNetEvent('laxi:weapon_specialcarbine_mk2BR')
AddEventHandler('laxi:weapon_specialcarbine_mk2BR', function()

    local _source = source
    local xPlayer = ESX.GetPlayerFromId(source)  
    local price = 0
    local xMoney = xPlayer.getMoney()

    if xMoney >= price then

        xPlayer.removeMoney(price)
        xPlayer.addInventoryItem('weapon_specialcarbine_mk2', 1)
        TriggerClientEvent('esx:showNotification', source, "~g~[Réussi]~w~ vous avez reçu votre équipement !")
    end
end)

RegisterNetEvent('laxi:weapon_pistolBR')
AddEventHandler('laxi:weapon_pistolBR', function()

    local _source = source
    local xPlayer = ESX.GetPlayerFromId(source)  
    local price = 0
    local xMoney = xPlayer.getMoney()

    if xMoney >= price then

        xPlayer.removeMoney(price)
        xPlayer.addInventoryItem('weapon_pistol', 1)
        TriggerClientEvent('esx:showNotification', source, "~g~[Réussi]~w~ vous avez reçu votre équipement !")
    end
end)

RegisterNetEvent('laxi:weapon_flashlightBR')
AddEventHandler('laxi:weapon_flashlightBR', function()

    local _source = source
    local xPlayer = ESX.GetPlayerFromId(source)  
    local price = 0
    local xMoney = xPlayer.getMoney()

    if xMoney >= price then

        xPlayer.removeMoney(price)
        xPlayer.addInventoryItem('weapon_flashlight', 1)
        TriggerClientEvent('esx:showNotification', source, "~g~[Réussi]~w~ vous avez reçu votre équipement !")
    end
end)

RegisterNetEvent('laxi:weapon_vintagepistolBR')
AddEventHandler('laxi:weapon_vintagepistolBR', function()

    local _source = source
    local xPlayer = ESX.GetPlayerFromId(source)  
    local price = 0
    local xMoney = xPlayer.getMoney()

    if xMoney >= price then

        xPlayer.removeMoney(price)
        xPlayer.addInventoryItem('weapon_vintagepistol', 1)
        TriggerClientEvent('esx:showNotification', source, "~g~[Réussi]~w~ vous avez reçu votre équipement !")
    end
end)

RegisterNetEvent('laxi:weapon_nightstickBR')
AddEventHandler('laxi:weapon_nightstickBR', function()

    local _source = source
    local xPlayer = ESX.GetPlayerFromId(source)  
    local price = 0
    local xMoney = xPlayer.getMoney()

    if xMoney >= price then

        xPlayer.removeMoney(price)
        xPlayer.addInventoryItem('weapon_nightstick', 1)
        TriggerClientEvent('esx:showNotification', source, "~g~[Réussi]~w~ vous avez reçu votre équipement !")
    end
end)
RegisterNetEvent('laxi:weapon_peppersprayBR')
AddEventHandler('laxi:weapon_peppersprayBR', function()

    local _source = source
    local xPlayer = ESX.GetPlayerFromId(source)  
    local price = 0
    local xMoney = xPlayer.getMoney()

    if xMoney >= price then

        xPlayer.removeMoney(price)
        xPlayer.addInventoryItem('weapon_pepperspray', 1)
        TriggerClientEvent('esx:showNotification', source, "~g~[Réussi]~w~ vous avez reçu votre équipement !")
    end
end)
RegisterNetEvent('laxi:weapon_stungunBR')
AddEventHandler('laxi:weapon_stungunBR', function()

    local _source = source
    local xPlayer = ESX.GetPlayerFromId(source)  
    local price = 0
    local xMoney = xPlayer.getMoney()

    if xMoney >= price then

        xPlayer.removeMoney(price)
        xPlayer.addInventoryItem('weapon_stungun', 1)
        TriggerClientEvent('esx:showNotification', source, "~g~[Réussi]~w~ vous avez reçu votre équipement !")
    end
end)
RegisterNetEvent('laxi:weapon_lgcougarBR')
AddEventHandler('laxi:weapon_lgcougarBR', function()

    local _source = source
    local xPlayer = ESX.GetPlayerFromId(source)  
    local price = 0
    local xMoney = xPlayer.getMoney()

    if xMoney >= price then

        xPlayer.removeMoney(price)
        xPlayer.addInventoryItem('weapon_lgcougar', 1)
        TriggerClientEvent('esx:showNotification', source, "~g~[Réussi]~w~ vous avez reçu votre équipement !")
    end
end)


RegisterNetEvent('laxi:weapon_bzgasBR')
AddEventHandler('laxi:weapon_bzgasBR', function()

    local _source = source
    local xPlayer = ESX.GetPlayerFromId(source)  
    local price = 0
    local xMoney = xPlayer.getMoney()

    if xMoney >= price then

        xPlayer.removeMoney(price)
        xPlayer.addInventoryItem('weapon_bzgas', 1)
        TriggerClientEvent('esx:showNotification', source, "~g~[Réussi]~w~ vous avez reçu votre équipement !")
    end
end)

RegisterNetEvent('laxi:weapon_antidoteBR')
AddEventHandler('laxi:weapon_antidoteBR', function()

    local _source = source
    local xPlayer = ESX.GetPlayerFromId(source)  
    local price = 0
    local xMoney = xPlayer.getMoney()

    if xMoney >= price then

        xPlayer.removeMoney(price)
        xPlayer.addInventoryItem('weapon_antidote', 1)
        TriggerClientEvent('esx:showNotification', source, "~g~[Réussi]~w~ vous avez reçu votre équipement !")
    end
end)

RegisterNetEvent('laxi:weapon_lbdBR')
AddEventHandler('laxi:weapon_lbdBR', function()

    local _source = source
    local xPlayer = ESX.GetPlayerFromId(source)  
    local price = 0
    local xMoney = xPlayer.getMoney()

    if xMoney >= price then

        xPlayer.removeMoney(price)
        xPlayer.addInventoryItem('weapon_lbd', 1)
        TriggerClientEvent('esx:showNotification', source, "~g~[Réussi]~w~ vous avez reçu votre équipement !")
    end
end)

RegisterNetEvent('laxi:ammo-9BR')
AddEventHandler('laxi:ammo-9BR', function()

    local _source = source
    local xPlayer = ESX.GetPlayerFromId(source)  
    local price = 0
    local xMoney = xPlayer.getMoney()

    if xMoney >= price then

        xPlayer.removeMoney(price)
        xPlayer.addInventoryItem('ammo-9', 30)
        TriggerClientEvent('esx:showNotification', source, "~g~[Réussi]~w~ vous avez reçu votre équipement !")
    end
end)

RegisterNetEvent('laxi:ammo-rifleBR')
AddEventHandler('laxi:ammo-rifleBR', function()

    local _source = source
    local xPlayer = ESX.GetPlayerFromId(source)  
    local price = 0
    local xMoney = xPlayer.getMoney()

    if xMoney >= price then

        xPlayer.removeMoney(price)
        xPlayer.addInventoryItem('ammo-rifle', 30)
        TriggerClientEvent('esx:showNotification', source, "~g~[Réussi]~w~ vous avez reçu votre équipement !")
    end
end)