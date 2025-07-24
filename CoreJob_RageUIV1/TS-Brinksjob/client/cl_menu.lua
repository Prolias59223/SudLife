ESX = exports["es_extended"]:getSharedObject()

local PlayerData = {}

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(10)
    end
    while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
    end
    if ESX.IsPlayerLoaded() then

		ESX.PlayerData = ESX.GetPlayerData()

    end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
     PlayerData = xPlayer
     ESX.PlayerData.job = jo
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)  
	PlayerData.job = job  
	Citizen.Wait(5000) 
end)


function F6Brinks()
    local Brinks = RageUI.CreateMenu("", "Brinks - France")
    local subMenu8 = RageUI.CreateSubMenu(Brinks, "", "Brinks - France")
    RageUI.Visible(Brinks, not RageUI.Visible(Brinks))
    while Brinks do
        Citizen.Wait(0)
            RageUI.IsVisible(Brinks, function()

                    RageUI.Separator("~b~↓~s~ Annonce ~b~↓")

                    RageUI.ButtonWithStyle("Annonces Ouverture",nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                        if Selected then       
                            TriggerServerEvent('OuvertvBrinks')
                        end
                    end)
            
                    RageUI.ButtonWithStyle("Annonces Fermeture",nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                        if Selected then      
                            TriggerServerEvent('FermervBrinks')
                        end
                    end)
    
                    RageUI.ButtonWithStyle("Annonces Recrutement",nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                        if Selected then      
                            TriggerServerEvent('RecruvBrinks')
                        end
                    end)
                    RageUI.ButtonWithStyle("Annonce Personnalisé",nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                        if Selected then
                            local te = KeyboardInput("Message", "", 100)
                            ExecuteCommand("br " ..te)
                        end
                    end)

                    RageUI.Separator("~b~↓~s~ Intéraction ~b~↓")

                    RageUI.ButtonWithStyle("Facture",nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                        if Selected then
                            ExecuteCommand'facture'
                            RageUI.CloseAll()
                        end
                    end)
                    if IsPedInAnyVehicle(PlayerPedId(), false) then
                        RageUI.ButtonWithStyle("~h~→ Placer le GPS à la Banque (Récolte)",nil, {}, true, function(Hovered, Active, Selected)
                        if Selected then       
                            SetNewWaypoint(-2941.36, 477.97, 15.24)
                        end
                    end)
                end

            if IsPedInAnyVehicle(PlayerPedId(), false) then
                RageUI.ButtonWithStyle("~h~→ Placer le GPS à la Banque Nord (Traitement)",nil, {}, true, function(Hovered, Active, Selected)
                if Selected then       
                    SetNewWaypoint(-127.68,  6445.82,  31.54)
                end
            end)
        end

        if IsPedInAnyVehicle(PlayerPedId(), false) then
            RageUI.ButtonWithStyle("~h~→ Placer le GPS à la Banque Centrale (Ventes)",nil, {}, true, function(Hovered, Active, Selected)
            if Selected then       
                SetNewWaypoint(262.79, 220.49, 100.68)
            end
        end)
    end
end, function() 
end)


RageUI.IsVisible(RMenu:Get('Brinks', 'subMenu8'), function()
    
		RageUI.ButtonWithStyle("→ Petite demande",nil, {RightLabel = nil}, true, function(Hovered, Active, Selected)
			if Selected then
				local raison = 'petite'
				local elements  = {}
				local playerPed = PlayerPedId()
				local coords  = GetEntityCoords(playerPed)
				local name = GetPlayerName(PlayerId())
			TriggerServerEvent('renfort', coords, raison)
		end
	end)

	RageUI.ButtonWithStyle("→ Moyenne demande",nil, {RightLabel = nil}, true, function(Hovered, Active, Selected)
		if Selected then
			local raison = 'moyen'
			local elements  = {}
			local playerPed = PlayerPedId()
			local coords  = GetEntityCoords(playerPed)
			local name = GetPlayerName(PlayerId())
		TriggerServerEvent('renfort', coords, raison)
	end
end)

RageUI.ButtonWithStyle("→ Grosse demande",nil, {RightLabel = nil}, true, function(Hovered, Active, Selected)
	if Selected then
		local raison = 'grosse'
		local elements  = {}
		local playerPed = PlayerPedId()
		local coords  = GetEntityCoords(playerPed)
		local name = GetPlayerName(PlayerId())
	TriggerServerEvent('renfort', coords, raison, name)
end
end)

                end, function() 
                end)

                if not RageUI.Visible(AmmuFarm) then
                    AmmuFarm = RMenu:DeleteType("AmmuFarm", true)
        end
    end
end


Keys.Register('F6', 'Brinks', 'Ouvrir le Menu Brinks', function()
	if ESX.PlayerData.job and ESX.PlayerData.job.name == 'brinks' then
    	F6Brinks()
	end
end)