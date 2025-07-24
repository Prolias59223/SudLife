ESX = exports["es_extended"]:getSharedObject()
local PlayerData = {}
local ox_inventory              = exports.ox_inventory
local ox_target                 = exports.ox_target

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

function CoffreGouvee()
	TriggerServerEvent('ox:loadStashes')
	ox_inventory:openInventory('stash', {id="prefet", groups="prefet"})
end
  
exports("CoffreGouvee",CoffreGouvee)

Citizen.CreateThread(function()
    while true do
        local Timer = 500
        if ESX.PlayerData.job and ESX.PlayerData.job.name == 'prefet' then
        local plyCoords3 = GetEntityCoords(GetPlayerPed(-1), false)
        local dist3 = Vdist(plyCoords3.x, plyCoords3.y, plyCoords3.z, Config.pos.Coffre.position.x, Config.pos.Coffre.position.y, Config.pos.Coffre.position.z)
        if dist3 <= 1.5 and Config.genre then
            Timer = 0
            DrawMarker(25, Config.pos.Coffre.position.x, Config.pos.Coffre.position.y, Config.pos.Coffre.position.z,  0.0, 0.0, 0.0, 0.0,0.0,0.0, 0.3, 0.3, 0.3, 0, 0, 0 , 255, false, true, p19, true)
            end
            if dist3 <= 1.5 then
                FreezeEntityPosition(PlayerPedId(), false)
                Timer = 0   
                    RageUI.Text({  message = "Appuyez sur [~b~E~w~] pour ouvrir le coffre", time_display = 1 })
                        if IsControlJustPressed(1,51) then
                            FreezeEntityPosition(PlayerPedId(), true)
                            CoffreGouvee()    
                end
                end
            end 
        Citizen.Wait(Timer)
    end
end)


