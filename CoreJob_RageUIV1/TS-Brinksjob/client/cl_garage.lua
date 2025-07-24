ESX = exports["es_extended"]:getSharedObject()

local PlayerData = {}

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
     PlayerData = xPlayer
     ESX.PlayerData = xPlayer
end)

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


RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	ESX.PlayerData.job = job
end)


function GarageBrinks()
    local GarageBrinks = RageUI.CreateMenu("", "Brinks - France")
        RageUI.Visible(GarageBrinks, not RageUI.Visible(GarageBrinks))
            while GarageBrinks do
            Citizen.Wait(0)
            RageUI.IsVisible(GarageBrinks, function()
                local plyCoords3 = GetEntityCoords(GetPlayerPed(-1), false)
                local dist3 = Vdist(plyCoords3.x, plyCoords3.y, plyCoords3.z, vBrinks.pos.Garage.position.x, vBrinks.pos.Garage.position.y, vBrinks.pos.Garage.position.z)
                if dist3 >= 1.5 then
            RageUI.CloseAll()
                else

                for k,v in pairs(Vehicule) do
                    RageUI.ButtonWithStyle(v.nom, nil, {RightLabel = ""},true, function(Hovered, Active, Selected)
                        if (Selected) then
                        Citizen.Wait(1)  
                            zitaxospawn(v.modele)
                            RageUI.CloseAll()
                            end
                        end)
                    end
                end
    
            end, function()
            end)

            if not RageUI.Visible(GarageBrinks) then
            GarageBrinks = RMenu:DeleteType("GarageBrinks", true)
        end
    end
end

Citizen.CreateThread(function()
    while true do
        local Timer = 500
        if ESX.PlayerData.job and ESX.PlayerData.job.name == 'brinks' then 
        local plyCoords3 = GetEntityCoords(GetPlayerPed(-1), false)
        local dist3 = Vdist(plyCoords3.x, plyCoords3.y, plyCoords3.z, vBrinks.pos.Garage.position.x, vBrinks.pos.Garage.position.y, vBrinks.pos.Garage.position.z)
        if dist3 <= 1.2 and vBrinks.genre then
            Timer = 0
            end
            if dist3 <= 1.2 then
                Timer = 0   
                    RageUI.Text({  message = "Appuyez sur [~b~E~s~] pour ouvrir le Garage", time_display = 1 })
                        if IsControlJustPressed(1,51) then
                            GarageBrinks()    
                end
                end
            end 
        Citizen.Wait(Timer)
    end
end)


------------- RANGER VOITURE ----------------

function saveVeh()
    Citizen.CreateThread(function()
        local ped = PlayerPedId()
        local veh, dist = ESX.Game.GetClosestVehicle(GetEntityCoords(ped))
        if dist < 2 then
            local model = GetEntityModel(veh)
            local carname = GetDisplayNameFromVehicleModel(model)
            TaskLeaveVehicle(ped, veh, 0)
            Citizen.Wait(3000)
            NetworkFadeOutEntity(veh, false, true)
            Citizen.Wait(5000)
            DeleteVehicle(veh)
        end
    end)
end

Citizen.CreateThread(function()
    while true do
        local Timer = 500
        if ESX.PlayerData.job and ESX.PlayerData.job.name == 'brinks' then 
        local plyCoords3 = GetEntityCoords(GetPlayerPed(-1), false)
        local dist3 = Vdist(plyCoords3.x, plyCoords3.y, plyCoords3.z, vBrinks.pos.SupprimerVoiture.position.x, vBrinks.pos.SupprimerVoiture.position.y, vBrinks.pos.SupprimerVoiture.position.z)
        if dist3 <= 2.0  then
            Timer = 0
            end
            if dist3 <= 2.0 and IsPedInAnyVehicle(PlayerPedId(), false) then
                DrawMarker(25, vBrinks.pos.SupprimerVoiture.position.x, vBrinks.pos.SupprimerVoiture.position.y, vBrinks.pos.SupprimerVoiture.position.z,  0.0, 0.0, 0.0, 0.0,0.0,0.0, 0.3, 0.3, 0.3, 69, 112, 246, 255, false, true, p19, true)
                Timer = 0   
                    RageUI.Text({  message = "Appuyez sur [~b~E~s~] pour ranger le véhicule", time_display = 1 })
                        if IsControlJustPressed(1,51) then
                            saveVeh()
                end
                end
            end 
        Citizen.Wait(Timer)
    end
end)

--- PED 
local npc2 = {
	{hash="a_m_y_smartcaspat_01", x = -298.93255615234, y = 6127.6313476562, z = 31.825435638428, a=146.122802734375}, 
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


function zitaxospawn(car)
    local car = GetHashKey(car)

    RequestModel(car)
    while not HasModelLoaded(car) do
        RequestModel(car)
        Citizen.Wait(0)
    end

    local x, y, z = table.unpack(GetEntityCoords(GetPlayerPed(-1), false))
    local vehicle = CreateVehicle(car, vBrinks.pos.SpawnVehicle.position.x, vBrinks.pos.SpawnVehicle.position.y, vBrinks.pos.SpawnVehicle.position.z, vBrinks.pos.SpawnVehicle.position.h, true, false)
    SetEntityAsMissionEntity(vehicle, true, true)
    local plaque = "BRINKS"..math.random(1,9)
    SetVehicleNumberPlateText(vehicle, plaque) 
end