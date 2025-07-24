ESX = exports["es_extended"]:getSharedObject()
local PlayerData = {}

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
     PlayerData = xPlayer
end)

Citizen.CreateThread(function()
	while ESX == nil do
		ESX = exports["es_extended"]:getSharedObject()
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
	ESX.PlayerData = xPlayer
end)

local pos = vector3(-555.37951660156, -599.91339111328, 34.682399749756)

Citizen.CreateThread(function()
    local blip = AddBlipForCoord(pos)

    SetBlipSprite (blip, 419)
    SetBlipScale  (blip, 1.5)
    SetBlipColour (blip, 4)
    SetBlipAsShortRange(blip, true)

    BeginTextCommandSetBlipName('STRING')
    AddTextComponentSubstringPlayerName('Mairie de Paris')
    EndTextCommandSetBlipName(blip)
end)


RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	ESX.PlayerData.job = job
end)


function GarageMairie()
    local GarageMairieKaito = RageUI.CreateMenu("", "Menu Intéraction..")
        RageUI.Visible(GarageMairieKaito, not RageUI.Visible(GarageMairieKaito))
            while GarageMairieKaito do
            Citizen.Wait(0)
            RageUI.IsVisible(GarageMairieKaito, function()

                RageUI.ButtonWithStyle("Renault Espace",nil, {RightLabel = "→"},true, function(Hovered, Active, Selected)
                    if (Selected) then  
                    local model = GetHashKey("espace2banapn")
                    RequestModel(model)
                    while not HasModelLoaded(model) do Citizen.Wait(10) end
                    local pos = GetEntityCoords(PlayerPedId())
                    local vehicle = CreateVehicle(model, -505.7502746582,-615.33801269531,29.887052536011, 359.9498291015625, true, true)
                    local plate = GetVehicleNumberPlateText(vehicle)
                    local name = GetDisplayNameFromVehicleModel(model)
                    local ped = PlayerPedId()
                    TriggerServerEvent('sy_carkeys:CreateKey', plate, name)
                    end
                end)    
    
            end, function()
            end, 1)

            if not RageUI.Visible(GarageMairieKaito) then
                GarageMairieKaito = RMenu:DeleteType("GarageMairieKaito", true)
        end
    end
end

local position = {
    {x = -512.62420654297, y = -628.97399902344, z = 30.443027496338}
}

Citizen.CreateThread(function()
    while true do

      local wait = 750

        for k in pairs(position) do
        if ESX.PlayerData.job and ESX.PlayerData.job.name == 'mairie' then 
            local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
            local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, position[k].x, position[k].y, position[k].z)

            if dist <= 5.0 then
            wait = 0

        
            if dist <= 2.0 then
               wait = 0
			   RageUI.Text({

				message = "Appuyez sur [~o~E~w~] pour ouvrir le garage",
	
				time_display = 1
	
			})
                if IsControlJustPressed(1,51) then
                    GarageMairie()
            end
        end
    end
    end
    Citizen.Wait(wait)
    end
end
end)



local npc2 = {
	{hash="a_m_y_beachvesp_01", x = -512.62420654297, y = -628.97399902344, z = 30.443027496338, a=4.7398042678833}
    
}

Citizen.CreateThread(function()
	for _, item2 in pairs(npc2) do
		local hash = GetHashKey(item2.hash)
		while not HasModelLoaded(hash) do
		RequestModel(hash)
		Wait(20)
		end
		ped2 = CreatePed("PED_TYPE_CIVFEMALE", item2.hash, item2.x, item2.y, item2.z-0.92, item2.a, false, true)
		SetBlockingOfNonTemporaryEvents(ped2, true)
		FreezeEntityPosition(ped2, true)
		SetEntityInvincible(ped2, true)
	end
end)

------------- RANGER VOITURE ----------------


local ouaiso = {
    {x = -516.43438720703, y = -612.51843261719, z = 29.870885848999}
}


function okBallo(vehicle)
    local props = ESX.Game.GetVehicleProperties(vehicle)
    local current = GetPlayersLastVehicle(GetPlayerPed(-1), true)
    local engineHealth = GetVehicleEngineHealth(current)

    local ped = PlayerPedId()
    local vehicle = GetVehiclePedIsUsing(ped)

    local plate = GetVehicleNumberPlateText(vehicle)
    local model = GetEntityModel(vehicle)
    local name = GetDisplayNameFromVehicleModel(model)

    TriggerServerEvent('sy_carkeys:DeleteKey', 1, plate, name) 
    if IsPedInAnyVehicle(GetPlayerPed(-1), true) then 
        if engineHealth < 890 then
            ESX.ShowNotification("Votre véhicule est trop endommagé, vous ne pouvez pas le ranger.")
        else
          --  ESX.Game.DeleteVehicle(vehicle)
            ESX.ShowNotification("~g~Le Véhicule a été rangé dans le garage.")
        end
    end
end

Citizen.CreateThread(function()
    while true do

      local wait = 750

        for k in pairs(ouaiso) do
        if ESX.PlayerData.job and ESX.PlayerData.job.name == 'mairie' then 
            local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
            local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, ouaiso[k].x, ouaiso[k].y, ouaiso[k].z)

            if dist <= 5.0 then
            wait = 0
        
            if dist <= 5.0 then
               wait = 0
               if IsPedInAnyVehicle(GetPlayerPed(-1), false) then
                DrawMarker(22, -516.43438720703, -612.51843261719, 29.870885848999, 0.0, 0.0, 0.0, 0.0,0.0,0.0, 0.3, 0.3, 0.3, 255, 0, 0 , 255, true, true, p19, true)
			   RageUI.Text({

				message = "Appuyez sur [~r~E~w~] pour ranger ton véhicule",
	
				time_display = 1
	
			})
                if IsControlJustPressed(1,51) then
                    DoScreenFadeOut(3000)
                    Citizen.Wait(3000)
                    DoScreenFadeIn(3000)
					okBallo()
            end
        end
    end
    end
    end
    Citizen.Wait(wait)
    end
end
end)

