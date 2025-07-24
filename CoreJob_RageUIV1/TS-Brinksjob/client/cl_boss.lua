ESX = exports["es_extended"]:getSharedObject()

local PlayerData = {}
local brinksboss = nil

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
	ESX.PlayerData = xPlayer
end)


RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	ESX.PlayerData.job = job
end)


function brinksboss()
    local PatronBoss = RageUI.CreateMenu("", "Brinks - France")
      RageUI.Visible(PatronBoss, not RageUI.Visible(PatronBoss))
  
              while PatronBoss do
                  Citizen.Wait(0)
                      RageUI.IsVisible(PatronBoss, function()
  
                        local plyCoords3 = GetEntityCoords(GetPlayerPed(-1), false)
                        local dist3 = Vdist(plyCoords3.x, plyCoords3.y, plyCoords3.z, vBrinks.pos.Boss.position.x, vBrinks.pos.Boss.position.y, vBrinks.pos.Boss.position.z)
                        if dist3 >= 1.5 then
                    RageUI.CloseAll()
                        else

            RageUI.ButtonWithStyle("→ Retirer argent de société",nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
                if Selected then
                    local amount = KeyboardInput("Montant", "", 10)
                    amount = tonumber(amount)
                    if amount == nil then
                        RageUI.Popup({message = "Montant invalide"})
                    else
                        TriggerServerEvent('esx_society:withdrawMoney', 'brinks', amount)
                    end
                end
            end)

            RageUI.ButtonWithStyle("→ Déposer argent de société",nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
                if Selected then
                    local amount = KeyboardInput("Montant", "", 10)
                    amount = tonumber(amount)
                    if amount == nil then
                        RageUI.Popup({message = "Montant invalide"})
                    else
                        TriggerServerEvent('esx_society:depositMoney', 'brinks', amount)
                    end
                end
            end) 

          RageUI.ButtonWithStyle("→ Accéder aux actions de Management",nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
                if Selected then
                    aboss()
                    RageUI.CloseAll()
                end
            end)
        end

        end, function()
        end)
        if not RageUI.Visible(PatronBoss) then
        PatronBoss = RMenu:DeleteType("PatronBoss", true)
    end
end
end

Citizen.CreateThread(function()
    while true do
        local Timer = 500
        if ESX.PlayerData.job and ESX.PlayerData.job.name == 'brinks' then 
        local plyCoords3 = GetEntityCoords(GetPlayerPed(-1), false)
        local dist3 = Vdist(plyCoords3.x, plyCoords3.y, plyCoords3.z, vBrinks.pos.Boss.position.x, vBrinks.pos.Boss.position.y, vBrinks.pos.Boss.position.z)
        if dist3 <= 1.2 and vBrinks.genre then
            Timer = 0
            end
            if dist3 <= 1.2 then
                DrawMarker(25, vBrinks.pos.Boss.position.x, vBrinks.pos.Boss.position.y, vBrinks.pos.Boss.position.z,   0.0, 0.0, 0.0, 0.0,0.0,0.0, 0.3, 0.3, 0.3, 69, 112, 246 , 255, false, true, p19, true)
                Timer = 0   
                    RageUI.Text({  message = "Appuyez sur [~b~E~s~] pour ouvrir votre panel", time_display = 1 })
                        if IsControlJustPressed(1,51) then
                            brinksboss()  
                end
                end
            end 
        Citizen.Wait(Timer)
    end
end)


function Updatebrinksboss(money)
    brinksboss = ESX.Math.GroupDigits(money)
end

function aboss()
    TriggerEvent('esx_society:openBossMenu', 'brinks', function(data, menu)
        menu.close()
    end, {wash = false})
end
