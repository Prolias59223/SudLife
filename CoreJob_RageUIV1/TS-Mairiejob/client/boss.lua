ESX = exports["es_extended"]:getSharedObject()
local PlayerData = {}
local Itbossm = nil

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
     PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)  
	PlayerData.job = job  
	Citizen.Wait(5000) 
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


function Itbossym()
    local mairie = RageUI.CreateMenu("", "Menu Intéraction..")
      RageUI.Visible(mairie, not RageUI.Visible(mairie))
  
              while mairie do
                  Citizen.Wait(0)
                      RageUI.IsVisible(mairie, function()
  
            if Itbossm ~= nil then
                RageUI.ButtonWithStyle("Argent société :", nil, {RightLabel = "€" .. Itbossm}, true, function()
                end)
            end

            RageUI.ButtonWithStyle("Retirer argent de société",nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
                if Selected then
                    local amount = KeyboardInput("Montant", "", 10)
                    amount = tonumber(amount)
                    if amount == nil then
                        RageUI.Popup({message = "Montant invalide"})
                    else
                        TriggerServerEvent('esx_society:withdrawMoney', 'mairie', amount)
                        RefreshItbossm()
                    end
                end
            end)

            RageUI.ButtonWithStyle("Déposer argent de société",nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
                if Selected then
                    local amount = KeyboardInput("Montant", "", 10)
                    amount = tonumber(amount)
                    if amount == nil then
                        RageUI.Popup({message = "Montant invalide"})
                    else
                        TriggerServerEvent('esx_society:depositMoney', 'mairie', amount)
                        RefreshItbossm()
                    end
                end
            end) 




        end, function()
        end)
        if not RageUI.Visible(mairie) then
            mairie = RMenu:DeleteType("mairie", true)
    end
end
end


local position = {

    {x = -527.33734130859, y = -590.02587890625, z = 34.681980133057}

}

Citizen.CreateThread(function()
    while true do

      local wait = 750

        for k in pairs(position) do
            if ESX.PlayerData.job and ESX.PlayerData.job.name == 'mairie' and ESX.PlayerData.job.grade_name == 'boss' then 
            local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
            local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, position[k].x, position[k].y, position[k].z)
            DrawMarker(22, -527.33734130859,-590.02587890625,34.681980133057, 0.0, 0.0, 0.0, 0.0,0.0,0.0, 0.3, 0.3, 0.3, 255, 0, 0 , 255, true, true, p19, true)

            if dist <= 5.0 then
            wait = 0
        
            if dist <= 1.0 then
               wait = 0
			   RageUI.Text({

				message = "Appuyez sur [~r~E~w~] pour accéder au panel administratif",
	
				time_display = 1
	
			})
                if IsControlJustPressed(1,51) then
                    RefreshItbossm()           
                    Itbossym()
            end
        end
    end
    end
    Citizen.Wait(wait)
    end
end
end)

function RefreshItbossm()
    if ESX.PlayerData.job ~= nil and ESX.PlayerData.job.grade_name == 'boss' then
        ESX.TriggerServerCallback('esx_society:getSocietyMoney', function(money)
            UpdateItbossm(money)
        end, ESX.PlayerData.job.name)
    end
end

function UpdateItbossm(money)
    Itbossm = ESX.Math.GroupDigits(money)
end

function aboss()
    TriggerEvent('esx_society:openBossMenu', 'mairie', function(data, menu)
        menu.close()
    end, {wash = false})
end

function KeyboardInput(TextEntry, ExampleText, MaxStringLenght)
    AddTextEntry('FMMC_KEY_TIP1', TextEntry)
    blockinput = true
    DisplayOnscreenKeyboard(1, "FMMC_KEY_TIP1", "", ExampleText, "", "", "", MaxStringLenght)
    while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do 
        Wait(0)
    end 
        
    if UpdateOnscreenKeyboard() ~= 2 then
        local result = GetOnscreenKeyboardResult()
        Wait(500)
        blockinput = false
        return result
    else
        Wait(500)
        blockinput = false
        return nil
    end
end

