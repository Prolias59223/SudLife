ESX = exports["es_extended"]:getSharedObject()

local ox_inventory              = exports.ox_inventory
local ox_target                 = exports.ox_target
local PlayerData = {}

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
     PlayerData = xPlayer
     ESX.PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	ESX.PlayerData.job = job
end)

function CBrinks()
	TriggerServerEvent('ox:loadStashes')
	ox_inventory:openInventory('stash', {id="brinks", groups="brinks"})
end
  
exports("CBrinks",CBrinks)

Citizen.CreateThread(function()
    while true do
        local Timer = 500
        if ESX.PlayerData.job and ESX.PlayerData.job.name == 'brinks' then
        local plyCoords3 = GetEntityCoords(GetPlayerPed(-1), false)
        local dist3 = Vdist(plyCoords3.x, plyCoords3.y, plyCoords3.z, vBrinks.pos.Coffre.position.x, vBrinks.pos.Coffre.position.y, vBrinks.pos.Coffre.position.z)
        if dist3 <= 1.5 and vBrinks.genre then
            Timer = 0
            DrawMarker(25, vBrinks.pos.Coffre.position.x, vBrinks.pos.Coffre.position.y, vBrinks.pos.Coffre.position.z,  0.0, 0.0, 0.0, 0.0,0.0,0.0, 0.3, 0.3, 0.3, 69, 112, 246 , 255, false, true, p19, true)
            end
            if dist3 <= 1.5 then
                Timer = 0   
                    RageUI.Text({  message = "Appuyez sur [~b~E~s~] pour ouvrir le coffre", time_display = 1 })
                        if IsControlJustPressed(1,51) then
                            CBrinks()    
                end
                end
            end 
        Citizen.Wait(Timer)
    end
end)
