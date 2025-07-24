ESX = exports["es_extended"]:getSharedObject()
local PlayerData = {}
local ox_inventory              = exports.ox_inventory
local ox_target                 = exports.ox_target


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


RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	ESX.PlayerData.job = job
end)



function CoffreMairie()
	TriggerServerEvent('ox:loadStashes')
	ox_inventory:openInventory('stash', {id="mairie", groups="mairie"})
end
  
exports("CoffreMairie",CoffreMairie)

local position = {
  {x = -557.00988769531, y = -599.72650146484, z = 34.682403564453}
}

Citizen.CreateThread(function()
    while true do

      local wait = 750

        for k in pairs(position) do
        if ESX.PlayerData.job and ESX.PlayerData.job.name == 'mairie' then 
            local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
            local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, position[k].x, position[k].y, position[k].z)
            DrawMarker(22, -556.96325683594,-599.82269287109,34.682411193848, 0.0, 0.0, 0.0, 0.0,0.0,0.0, 0.3, 0.3, 0.3, 255, 0, 0 , 255, true, true, p19, true)

            if dist <= 5.0 then
            wait = 0
        
            if dist <= 1.0 then
               wait = 0
			   RageUI.Text({

				message = "Appuyez sur [~r~E~w~] pour ouvrir le coffre",
	
				time_display = 1
	
			})
                if IsControlJustPressed(1,51) then
					CoffreMairie()
            end
        end
    end
    end
    Citizen.Wait(wait)
    end
end
end)

