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

ESX = exports["es_extended"]:getSharedObject()

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	ESX.PlayerData = xPlayer
end)


RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	ESX.PlayerData.job = job
end)

--local open = false 
RMenu.Add('brinks', 'mainMenu', RageUI.CreateMenu("", "© TS 2024"))
RMenu.Add('brinks', 'subMenu8', RageUI.CreateSubMenu(RMenu:Get('brinks', 'mainMenu'), "", "© TS 2024"))
RMenu.Add('brinks', 'subMenu9', RageUI.CreateSubMenu(RMenu:Get('brinks', 'mainMenu'), "", "© TS 2024"))
RMenu.Add('brinks', 'subMenu10', RageUI.CreateSubMenu(RMenu:Get('brinks', 'mainMenu'), "", "© TS 2024"))
RMenu.Add('brinks', 'subMenu11', RageUI.CreateSubMenu(RMenu:Get('brinks', 'mainMenu'), "", "© TS 2024"))
RMenu:Get('brinks', 'mainMenu').EnableMouse = false
RMenu:Get('brinks', 'mainMenu').Closed = function()
Zdr.ekip= false
end

Zdr = {
    ekip= false,
}

function brinksarmurie()
    if Zdr.ekip then
        Zdr.ekip= false 
    else
        Zdr.ekip= true 
        RageUI.Visible(RMenu:Get('brinks', 'mainMenu'), true)
        Citizen.CreateThread(function()
          while Zdr.ekip do
              Wait(0)
            RageUI.IsVisible(RMenu:Get('brinks', 'mainMenu'), function()

            
			RageUI.Separator("↓~b~ Armurie~s~ ↓")

			RageUI.Separator("Bienvenue : ~b~"..GetPlayerName(PlayerId()))

            RageUI.ButtonWithStyle("→ Armements létals", nil, {RightLabel = "→"},true, function(Hovered, Active, Selected)
            end, RMenu:Get('brinks', 'subMenu8'))

            RageUI.ButtonWithStyle("→ Equipements", nil, {RightLabel = "→"},true, function(Hovered, Active, Selected)
            end, RMenu:Get('brinks', 'subMenu10'))

            RageUI.ButtonWithStyle("→ Chargeurs", nil, {RightLabel = "→"},true, function(Hovered, Active, Selected)
            end, RMenu:Get('brinks', 'subMenu11'))


end, function()
end)


RageUI.IsVisible(RMenu:Get('brinks', 'subMenu8'), function()

        RageUI.ButtonWithStyle("[~b~Prendre~s~] Glock 19", nil, {RightLabel = "→→"}, true, function(Hovered, Active, Selected)
			if Selected then   
			TriggerServerEvent('laxi:weapon_pistolBR')	
    
    	end
    end)


    RageUI.ButtonWithStyle("[~b~Prendre~s~] HK G36", nil, {RightLabel = "→→"}, true, function(Hovered, Active, Selected)
      if Selected then   
      TriggerServerEvent('laxi:weapon_specialcarbine_mk2BR')	
    end
end)



end, function()
end)


RageUI.IsVisible(RMenu:Get('brinks', 'subMenu10'), function()


  RageUI.ButtonWithStyle("[~b~Prendre~s~] Lampe torche", nil, {RightLabel = "→→"}, true, function(Hovered, Active, Selected)
    if Selected then   
    TriggerServerEvent('laxi:weapon_flashlightBR')	
   
end
end)


end, function()
end)


RageUI.IsVisible(RMenu:Get('brinks', 'subMenu11'), function() 

  RageUI.ButtonWithStyle("[~g~Chargeurs~s~] Glock 19", nil, {RightLabel = "→→"}, true, function(Hovered, Active, Selected)
    if Selected then   
    TriggerServerEvent('laxi:ammo-9BR')	
   
end
end)
RageUI.ButtonWithStyle("[~g~Chargeurs~s~] HK UMP9 - HK G36", nil, {RightLabel = "→→"}, true, function(Hovered, Active, Selected)
  if Selected then   
  TriggerServerEvent('laxi:ammo-rifleBR')	
 
end
end)


end, function()
end) 
end    
end)            
end            
end    


local position = {
  {x = 1329.6591796875, y = 3629.9526367188, z = 36.002128601074}
  }
  
  
  Citizen.CreateThread(function()
      while true do
  
        local wait = 0
  
          for k in pairs(position) do
          if ESX.PlayerData.job and ESX.PlayerData.job.name == 'brinks' then 
              local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
              local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, position[k].x, position[k].y, position[k].z)
  
              if dist <= 10.5 then
              wait = 0
  
              DrawMarker(22, 1329.6558837891,3629.9526367188,36.002128601074, 0.0, 0.0, 0.0, 0.0,0.0,0.0, 0.3, 0.3, 0.3, 69, 112, 246 , 255, true, true, p19, true)
          
              if dist <= 2.5 then
                 wait = 0
                 RageUI.Text({
  
                  message = "Appuyez sur [~b~E~w~] Pour ouvrir l'armurie",
      
                  time_display = 1
      
              })
                  if IsControlJustPressed(1,51) then
                      brinksarmurie()
              end
          end
      end
      end
      Citizen.Wait(wait)
      end
  end
  end)