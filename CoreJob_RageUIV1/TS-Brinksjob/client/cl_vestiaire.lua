ESX = exports["es_extended"]:getSharedObject()
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


local pos = vector3(-299.3459777832,6127.0048828125,31.825439453125)
Citizen.CreateThread(function()
    local blip = AddBlipForCoord(pos)

    SetBlipSprite (blip, 103)
    SetBlipScale  (blip, 1.2)
    SetBlipColour (blip, 0)
    SetBlipAsShortRange(blip, true)

    BeginTextCommandSetBlipName('STRING')
    AddTextComponentSubstringPlayerName('~g~Entreprise~s~ | Brinks - France')
    EndTextCommandSetBlipName(blip)
end)


---------------------------
function VBrinks()
    local VBrinks = RageUI.CreateMenu("", "Brinks - France")
        RageUI.Visible(VBrinks, not RageUI.Visible(VBrinks))
            while VBrinks do
            Citizen.Wait(0)
            RageUI.IsVisible(VBrinks, function()
                local plyCoords3 = GetEntityCoords(GetPlayerPed(-1), false)
                local dist3 = Vdist(plyCoords3.x, plyCoords3.y, plyCoords3.z, vBrinks.pos.Vestiaire.position.x, vBrinks.pos.Vestiaire.position.y, vBrinks.pos.Vestiaire.position.z)
                if dist3 >= 1.5 then
            RageUI.CloseAll()
                else

                RageUI.ButtonWithStyle("[~r~Reprendre ses vêtements~s~]",nil, {RightBadge = RageUI.BadgeStyle.Clothes}, true, function(Hovered, Active, Selected)
                    if Selected then
                        ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
                            startAnim('clothingtie', 'try_tie_positive_a')
                            Citizen.Wait(5000)
                            ClearPedTasksImmediately(GetPlayerPed(-1))
                        TriggerEvent('skinchanger:loadSkin', skin)
                        RageUI.CloseAll()
                        end)
                    end
                end)
    
                RageUI.ButtonWithStyle("~b~→~s~ Tenue Brinks (Manche Courte)",nil, {RightBadge = RageUI.BadgeStyle.Clothes}, true, function(Hovered, Active, Selected)
                    if Selected then
                        startAnim('clothingtie', 'try_tie_positive_a')
                        Citizen.Wait(5000)
                        TreeSpacebr()
                        RageUI.CloseAll()
                    end
                end)

                RageUI.ButtonWithStyle("~b~→~s~ Tenue Brinks (Manche Longue)",nil, {RightBadge = RageUI.BadgeStyle.Clothes}, true, function(Hovered, Active, Selected)
                    if Selected then
                        startAnim('clothingtie', 'try_tie_positive_a')
                        Citizen.Wait(5000)
                        TreeSpacebr2()
                        RageUI.CloseAll()
                    end
                end)
            
        end
            end, function()
            end)

            if not RageUI.Visible(VBrinks) then
            VBrinks = RMenu:DeleteType("VBrinks", true)
        end
    end
end


    function startAnim(lib, anim)
        ESX.Streaming.RequestAnimDict(lib, function()
            TaskPlayAnim(PlayerPedId(), lib, anim, 8.0, -8.0, -1, 0, 0.0, false, false, false)
        end)
    end

Citizen.CreateThread(function()
    while true do
        local Timer = 500
        if ESX.PlayerData.job and ESX.PlayerData.job.name == 'brinks' then
        local plyCoords3 = GetEntityCoords(GetPlayerPed(-1), false)
        local dist3 = Vdist(plyCoords3.x, plyCoords3.y, plyCoords3.z, vBrinks.pos.Vestiaire.position.x, vBrinks.pos.Vestiaire.position.y, vBrinks.pos.Vestiaire.position.z)
        if dist3 <= 1.2 and vBrinks.genre then
            Timer = 0
            DrawMarker(25, 1328.6137695312,3633.0900878906,36.002136230469,  0.0, 0.0, 0.0, 0.0,0.0,0.0, 0.3, 0.3, 0.3, 69, 112, 246 , 255, false, true, p19, true)
            end
            if dist3 <= 1.2 then
                Timer = 0   
                    RageUI.Text({  message = "Appuyez sur [~b~E~w~] pour ouvrir votre vestiaire", time_display = 1 })
                        if IsControlJustPressed(1,51) then
                            VBrinks()    
                end
                end
            end 
        Citizen.Wait(Timer)
    end
end)



function TreeSpacebr()
    local model = GetEntityModel(GetPlayerPed(-1))
    TriggerEvent('skinchanger:getSkin', function(skin)
        if model == GetHashKey("mp_m_freemode_01") then
            clothesSkin = {
                ['tshirt_1'] = 15, ['tshirt_2'] = 0,
                ['torso_1'] = 611, ['torso_2'] = 0,
                ['arms'] = 0,
                ['pants_1'] = 321, ['pants_2'] = 1,
                ['shoes_1'] = 228, ['shoes_2'] = 0,
                ['chain_1'] = 0, ['chain_2'] = 0,
                ['bproof_1'] = 78, ['bproof_2'] = 0,

            }
        else
            clothesSkin = {
                ['tshirt_1'] = 34, ['tshirt_2'] = 0,
                ['torso_1'] = 0, ['torso_2'] = 1,
                ['arms'] = 33,
                ['pants_1'] = 5, ['pants_2'] = 0,
                ['shoes_1'] = 25, ['shoes_2'] = 0,
            }
        end
        TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
    end)
end

function TreeSpacebr2()
    local model = GetEntityModel(GetPlayerPed(-1))
    TriggerEvent('skinchanger:getSkin', function(skin)
        if model == GetHashKey("mp_m_freemode_01") then
            clothesSkin = {
                ['tshirt_1'] = 15, ['tshirt_2'] = 0,
                ['torso_1'] = 612, ['torso_2'] = 0,
                ['arms'] = 0,
                ['pants_1'] = 321, ['pants_2'] = 1,
                ['shoes_1'] = 228, ['shoes_2'] = 0,
                ['chain_1'] = 0, ['chain_2'] = 0,
                ['bproof_1'] = 78, ['bproof_2'] = 0,

            }
        else
            clothesSkin = {
                ['tshirt_1'] = 34, ['tshirt_2'] = 0,
                ['torso_1'] = 0, ['torso_2'] = 1,
                ['arms'] = 33,
                ['pants_1'] = 5, ['pants_2'] = 0,
                ['shoes_1'] = 25, ['shoes_2'] = 0,
            }
        end
        TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
    end)
end
