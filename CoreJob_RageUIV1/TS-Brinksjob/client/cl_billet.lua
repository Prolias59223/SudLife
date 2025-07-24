--ESX = nil

local spawnsacbillettreespace = 0
local spawnsacbillettreespaceoo = {}
local isPickingUp, isProcessing = false, false

ESX = exports["es_extended"]:getSharedObject()

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
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)  
	--PlayerData.job = job  
	Citizen.Wait(5000) 
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(10)
		local coords = GetEntityCoords(PlayerPedId())

		if GetDistanceBetweenCoords(coords, vBrinks.ZoneBillet.treespaceBillet.coords, true) < 50 then
			Spawnspawnsacbillettreespaceoo()
			Citizen.Wait(500)
		else
			Citizen.Wait(500)
		end
	end
end)

Citizen.CreateThread(function()
    while true do
        local Timer = 500
		local playerPed = PlayerPedId()
		local coords = GetEntityCoords(playerPed)
		local nearbyObject, nearbyID

		for i=1, #spawnsacbillettreespaceoo, 1 do
			if GetDistanceBetweenCoords(coords, GetEntityCoords(spawnsacbillettreespaceoo[i]), false) < 1 then
				nearbyObject, nearbyID = spawnsacbillettreespaceoo[i], i
			end
		end
        if ESX.PlayerData.job and ESX.PlayerData.job.name == 'brinks' and nearbyObject and IsPedOnFoot(playerPed) then
                Timer = 0   
                    RageUI.Text({  message = "Appuyez sur [~b~E~w~] pour récupérer le sac", time_display = 1 })
                        if IsControlJustPressed(1,51) then
							startAnim('random@domestic', 'pickup_low')   
							Citizen.Wait(2000)
							ESX.Game.DeleteObject(nearbyObject)			
							table.remove(spawnsacbillettreespaceoo, nearbyID)
							spawnsacbillettreespace = spawnsacbillettreespace - 1
							TriggerServerEvent('treespacesac')
						
                
                end
            end 
        Citizen.Wait(Timer)
    end
end)

AddEventHandler('onResourceStop', function(resource)
	if resource == GetCurrentResourceName() then
		for k, v in pairs(spawnsacbillettreespaceoo) do
			ESX.Game.DeleteObject(v)
		end
	end
end)

function Spawnspawnsacbillettreespaceoo()
	while spawnsacbillettreespace < 15 do
		Citizen.Wait(0)
		local weedCoords = GenertatetreespaceBilletCoords()

		ESX.Game.SpawnLocalObject('xs_prop_arena_bag_01', weedCoords, function(obj)
			PlaceObjectOnGroundProperly(obj)
			FreezeEntityPosition(obj, true)

			table.insert(spawnsacbillettreespaceoo, obj)
			spawnsacbillettreespace = spawnsacbillettreespace + 1
		end)
	end
end

function treespaceBilletCoords(plantCoord)
	if spawnsacbillettreespace > 0 then
		local validate = true

		for k, v in pairs(spawnsacbillettreespaceoo) do
			if GetDistanceBetweenCoords(plantCoord, GetEntityCoords(v), true) < 5 then
				validate = false
			end
		end

		if GetDistanceBetweenCoords(plantCoord, vBrinks.ZoneBillet.treespaceBillet.coords, false) > 6 then
			validate = false
		end

		return validate
	else
		return true
	end
end

function GenertatetreespaceBilletCoords()
	while true do
		Citizen.Wait(1)

		local weedCoordX, weedCoordY

		math.randomseed(GetGameTimer())
		local modX = math.random(-20, 20)

		Citizen.Wait(100)

		math.randomseed(GetGameTimer())
		local modY = math.random(-20, 20)

		weedCoordX = vBrinks.ZoneBillet.treespaceBillet.coords.x + modX
		weedCoordY = vBrinks.ZoneBillet.treespaceBillet.coords.y + modY

		local coordZ = GetCoordZWeed(weedCoordX, weedCoordY)
		local coord = vector3(weedCoordX, weedCoordY, coordZ)

		if treespaceBilletCoords(coord) then
			return coord
		end
	end
end

function GetCoordZWeed(x, y)
	local groundCheckHeights = { 50, 51.0, 52.0, 53.0, 54.0, 55.0, 56.0, 57.0, 58.0, 59.0, 60.0 }

	for i, height in ipairs(groundCheckHeights) do
		local foundGround, z = GetGroundZFor_3dCoord(x, y, height)

		if foundGround then
			return z
		end
	end

	return 53.85
end

function RemoveObj(id)
    Citizen.CreateThread(function()
        SetNetworkIdCanMigrate(id, true)
        local entity = NetworkGetEntityFromNetworkId(id)
        NetworkRequestControlOfEntity(entity)
        local test = 0
        while test > 100 and not NetworkHasControlOfEntity(entity) do
            NetworkRequestControlOfEntity(entity)
            DetachEntity(entity, 0, 0)
            Wait(1)
            test = test + 1
        end
        SetEntityAsNoLongerNeeded(entity)

        local test = 0
        while test < 100 and IsEntityAttached(entity) do 
            DetachEntity(entity, 0, 0)
            Wait(1)
            test = test + 1
        end

        local test = 0
        while test < 100 and DoesEntityExist(entity) do 
            DetachEntity(entity, 0, 0)
            SetEntityAsNoLongerNeeded(entity)
            DeleteEntity(entity)
            DeleteObject(entity)
            SetEntityCoords(entity, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0)
            Wait(1)
            test = test + 1
        end

    end)
end


local vehicle = nil

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(10)
            if DoesEntityExist(vehicle) == false then
                RequestModel(GetHashKey('stockade'))
                while not HasModelLoaded(GetHashKey('stockade')) do
                    Wait(1)
                end
                vehicle = CreateVehicle(GetHashKey('stockade'), -2938.3, 490.75, 13.87, 120.77, false, false)
                FreezeEntityPosition(vehicle, true)
                SetEntityInvincible(vehicle, true)
        end
    end
end)

-------------------- BANQUE CENTRAL ----------------------

Citizen.CreateThread(function()
    while true do
        local Timer = 500
        if ESX.PlayerData.job and ESX.PlayerData.job.name == 'brinks' then
        local plyCoords3 = GetEntityCoords(GetPlayerPed(-1), false)
        local dist3 = Vdist(plyCoords3.x, plyCoords3.y, plyCoords3.z, vBrinks.pos.Liasse.position.x, vBrinks.pos.Liasse.position.y, vBrinks.pos.Liasse.position.z)
        if dist3 <= 1.2 and vBrinks.genre then
            Timer = 0
            DrawMarker(25, vBrinks.pos.Liasse.position.x, vBrinks.pos.Liasse.position.y, vBrinks.pos.Liasse.position.z,  0.0, 0.0, 0.0, 0.0,0.0,0.0, 0.3, 0.3, 0.3, 69, 112, 246 , 255, false, true, p19, true)
            end
            if dist3 <= 1.2 then
                Timer = 0   
                    RageUI.Text({  message = "Appuyez sur [~g~E~w~] pour mettre en liasse", time_display = 1 })
                        if IsControlJustPressed(1,51) then
						liasse()
                end
                end
            end 
        Citizen.Wait(Timer)
    end
end)

local recoltepossible = false
Citizen.CreateThread(function()
        local playerPed = PlayerPedId()
        while true do
            local Timer = 500
            local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
            local playerCoords = GetEntityCoords(PlayerPedId())
            zoneDistance = GetDistanceBetweenCoords(playerCoords, vBrinks.pos.Liasse.position.x, vBrinks.pos.Liasse.position.y, vBrinks.pos.Liasse.position.z)
                if IsEntityAtCoord(PlayerPedId(), 0.0, -0.0, -0.0, 1.5, 1.5, 1.5, 0, 1, 0) then 
                    Timer = 0
            end
            if zoneDistance ~= nil then
                if zoneDistance > 1.5 then
                    recoltepossible = false
                end
            end
        Wait(Timer)
    end    
end)


function liasse()
    if not recoltepossible then
        recoltepossible = true
    while recoltepossible do
        Citizen.Wait(2000)
        TriggerServerEvent('liassetreespace')
    end
    else
        recoltepossible = false
    end
end

----------------- VENTE LIASSE ----------------------------------

Citizen.CreateThread(function()
    while true do
        local Timer = 500
        if ESX.PlayerData.job and ESX.PlayerData.job.name == 'brinks' then
        local plyCoords3 = GetEntityCoords(GetPlayerPed(-1), false)
        local dist3 = Vdist(plyCoords3.x, plyCoords3.y, plyCoords3.z, vBrinks.pos.Vente.position.x, vBrinks.pos.Vente.position.y, vBrinks.pos.Vente.position.z)
        if dist3 <= 1.2 and vBrinks.genre then
            Timer = 0
            DrawMarker(25, vBrinks.pos.Vente.position.x, vBrinks.pos.Vente.position.y, vBrinks.pos.Vente.position.z,  0.0, 0.0, 0.0, 0.0,0.0,0.0, 0.3, 0.3, 0.3, 69, 112, 246 , 255, false, true, p19, true)
            end
            if dist3 <= 1.2 then
                Timer = 0   
                    RageUI.Text({  message = "Appuyez sur [~g~E~w~] pour déposer vos liasses", time_display = 1 })
                        if IsControlJustPressed(1,51) then
						liassevente()
                end
                end
            end 
        Citizen.Wait(Timer)
    end
end)

local recoltepossible = false
Citizen.CreateThread(function()
        local playerPed = PlayerPedId()
        while true do
            local Timer = 500
            local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
            local playerCoords = GetEntityCoords(PlayerPedId())
            zoneDistance = GetDistanceBetweenCoords(playerCoords, vBrinks.pos.Vente.position.x, vBrinks.pos.Vente.position.y, vBrinks.pos.Vente.position.z)
                if IsEntityAtCoord(PlayerPedId(), 0.0, -0.0, -0.0, 1.5, 1.5, 1.5, 0, 1, 0) then 
                    Timer = 0
            end
            if zoneDistance ~= nil then
                if zoneDistance > 1.5 then
                    recoltepossible = false
                end
            end
        Wait(Timer)
    end    
end)


function liassevente()
    if not recoltepossible then
        recoltepossible = true
    while recoltepossible do
        Citizen.Wait(2000)
        TriggerServerEvent('liassevente')
    end
    else
        recoltepossible = false
    end
end
