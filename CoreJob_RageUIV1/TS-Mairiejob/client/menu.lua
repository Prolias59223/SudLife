ESX = exports["es_extended"]:getSharedObject()

local PlayerData = {}


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


function MenuMairie()
    local F6Mairie = RageUI.CreateMenu("", "Menu Intéraction...")
    RageUI.Visible(F6Mairie, not RageUI.Visible(F6Mairie))
    while F6Mairie do
        Citizen.Wait(0)
            RageUI.IsVisible(F6Mairie, function()

                RageUI.Checkbox("Prendre son service",nil, service,{},function(Hovered,Ative,Selected,Checked)
                    if Selected then
    
                        service = Checked
    
    
                        if Checked then
                            onservice = true
                            RageUI.Popup({
                                message = "Vous avez pris votre service !"})
    
                            
                        else
                            onservice = false
                            RageUI.Popup({
                                message = "Vous n'etes plus en service !"})
    
                        end
                    end
                end)
    
                if onservice then

                RageUI.Separator("↓ ~r~     Annonce    ~s~↓")

                RageUI.ButtonWithStyle("Annonces Ouverture",nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                    if Selected then       
                        TriggerServerEvent('OuvertMairie')
                    end
                end)
        
                RageUI.ButtonWithStyle("Annonces Fermeture",nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                    if Selected then      
                        TriggerServerEvent('FermerMairie')
                    end
                end)

                RageUI.ButtonWithStyle("Annonces Recrutement",nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                    if Selected then      
                        TriggerServerEvent('RecruMairie')
                    end
                end)

                RageUI.Separator("↓ ~b~     Facture    ~s~↓")

                RageUI.ButtonWithStyle("Intéraction Facture",nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                    if Selected then      
                        ExecuteCommand'facture'
                        RageUI.CloseAll()
                    end
                end)

                        
                RageUI.Separator("↓ ~b~     Message    ~s~↓")
        
                RageUI.ButtonWithStyle("Message aux Employés", "Pour écrire un message aux Employés", {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                    if (Selected) then   
                    local info = 'patron'
                    local message = KeyboardInput('Veuillez mettre le messsage à envoyer', '', 40)
                    TriggerServerEvent('mairie:mairiejob', info, message)
                end
                end)

            
            end
            
                end, function() 
                end)

                if not RageUI.Visible(AmmuFarm) then
                    AmmuFarm = RMenu:DeleteType("AmmuFarm", true)
        end
    end
end


Keys.Register('F6', 'Mairie', 'Ouvrir le Menu Mairie', function()
	if ESX.PlayerData.job and ESX.PlayerData.job.name == 'mairie' then
    	MenuMairie()
	end
end)


RegisterNetEvent('mairie:mairiejob')
AddEventHandler('mairie:mairiejob', function(service, nom, message)
	if service == 'patron' then
		PlaySoundFrontend(-1, "Start_Squelch", "CB_RADIO_SFX", 1)
		ESX.ShowAdvancedNotification('INFO Mairie', '~b~A lire', 'Maire: ~b~'..nom..'\n~w~Message: ~g~'..message..'', 'CHAR_MAIRIE', 8)
		Wait(1000)
		PlaySoundFrontend(-1, "End_Squelch", "CB_RADIO_SFX", 1)	
	end
end)