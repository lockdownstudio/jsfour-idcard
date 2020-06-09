ESX              = nil
local PlayerData = {}

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
  PlayerData = xPlayer   
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
  PlayerData.job = job
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)

        local ped = PlayerPedId()

        if not IsPedDeadOrDying(ped, 1) then
            if IsControlJustPressed(1, 244) and GetLastInputMethod(2) then -- change keybinding
                IdMenu()
            end
        else
            Citizen.Wait(500)
        end
    end
end)

function IdMenu()

    ESX.UI.Menu.CloseAll()

    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'id_card_menu', {
        title = _U('id_menu'),
        align = 'top-left',
        elements = {
            {label = _U('check_id'), value = 'check_id'},
            {label = _U('show_id'), value = 'show_id'},
            {label = _U('show_licenses'), value = 'show_licenses'}
        }
    }, 
    function(data, menu)
        if data.current.value == 'check_id' then
        ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'check_id', {
                title = _U('id_check_menu'),
                align = 'top-left',
                elements = {
                    {label = _U('id_check'), value = 'id_check'},
                    {label = _U('aircraft_check'), value = 'aircraft_check'},
                    {label = _U('boat_check'), value = 'boat_check'},
                    {label = _U('driver_check'), value = 'driver_check'},
                    {label = _U('weed_check'), value = 'weed_check'}
                }
            },
                function(data, menu)

                --[[    if data.current.value == 'id_check' then
                        TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(PlayerId()))
                        ESX.UI.Menu.CloseAll()
                    elseif data.current.value == 'aircraft_check' then
                        TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(PlayerId()), 'aircraft')
                        ESX.UI.Menu.CloseAll()
                    elseif data.current.value == 'boat_check' then
                        TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(PlayerId()), 'boat')
                        ESX.UI.Menu.CloseAll()
                    elseif data.current.value == 'driver_check' then
                        TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(PlayerId()), 'driver')
                        ESX.UI.Menu.CloseAll()
                    elseif data.current.value == 'weed_check' then
                        TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(PlayerId()), 'weed')
                        ESX.UI.Menu.CloseAll()
                    end ]]--

                end, 
                function(data, menu)
                    menu.close() 
                end
            end)
        elseif data.current.value == 'show_id' then

           local player, distance = ESX.Game.GetClosestPlayer()
           
           if distance ~= -1 and distance <= 3.0 then
            TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(player))
            ESX.UI.Menu.CloseAll()
           else
            ESX.ShowNotification(_U('nobody_near'))
            ESX.UI.Menu.CloseAll()
           end

        elseif data.current.value == 'show_licenses' then
          ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'show_licenses', {
                title = _U('license_menu'),
                align = 'top-left',
                elements = {
                    {label = _U('aircraft_show'), value = 'aircraft_show'},
                    {label = _U('boat_show'), value = 'boat_show'},
                    {label = _U('driver_show'), value = 'driver_show'},
                    {label = _U('weed_show'), value = 'weed_show'}
                }                
            }, 
            
            function(data, menu)
                if data.current.value == 'aircraft_show' then
                    local player, distance = ESX.Game.GetClosestPlayer()
                    if distance ~= -1 and distance <= 3.0 then
                        TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(player), 'aircraft')
                        ESX.UI.Menu.CloseAll()                                                
                    else
                        ESX.ShowNotification(_U('nobody_near'))
                        ESX.UI.Menu.CloseAll()                        
                    end
                elseif data.current.value == 'boat_show' then
                    local player, distance = ESX.Game.GetClosestPlayer()
                    if distance ~= -1 and distance <= 3.0 then
                        TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(player), 'boat')                        
                        ESX.UI.Menu.CloseAll()                                                
                    else
                        ESX.ShowNotification(_U('nobody_near'))
                        ESX.UI.Menu.CloseAll()                        
                    end
                elseif data.current.value == 'driver_show' then
                    local player, distance = ESX.Game.GetClosestPlayer()
                    if distance ~= -1 and distance <= 3.0 then
                        TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(player), 'driver')                        
                        ESX.UI.Menu.CloseAll()                                                
                    else
                        ESX.ShowNotification(_U('nobody_near'))
                        ESX.UI.Menu.CloseAll()                        
                    end
                elseif data.current.value == 'weed_show' then
                    local player, distance = ESX.Game.GetClosestPlayer()
                    if distance ~= -1 and distance <= 3.0 then
                        TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(player), 'weed')                        
                        ESX.UI.Menu.CloseAll()                                                
                    else
                        ESX.ShowNotification(_U('nobody_near'))
                        ESX.UI.Menu.CloseAll()                        
                    end
                end

            end,
            function(data, menu)
                    menu.close()
                end
            end)
        end
    end,
        function(data, menu)
            menu.close()
        end
    end)
end