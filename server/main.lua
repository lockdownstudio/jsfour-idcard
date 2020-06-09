local ESX = nil
-- ESX
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

-- Open ID card
RegisterServerEvent('jsfour-idcard:open')
AddEventHandler('jsfour-idcard:open', function(ID, targetID, type)
	local identifier = ESX.GetPlayerFromId(ID).identifier
	local _source 	 = ESX.GetPlayerFromId(targetID).source
	local show       = false

	MySQL.Async.fetchAll('SELECT firstname, lastname, dateofbirth, sex, height FROM users WHERE identifier = @identifier', {['@identifier'] = identifier},
	function (user)
		if (user[1] ~= nil) then
			MySQL.Async.fetchAll('SELECT type FROM user_licenses WHERE owner = @identifier', {['@identifier'] = identifier},
			function (licenses)
				local hash = {}
				local res = {}

				if type ~= nil then
					for i=1, #licenses, 1 do
						if type == 'driver' then
							if licenses[i].type == 'drive' or licenses[i].type == 'drive_bike' or licenses[i].type == 'drive_truck' then
								show = true
							end
						elseif type =='weapon' then
							if licenses[i].type == 'weapon' then
								show = true
							end
						elseif type =='weed' then
							if licenses[i].type == 'weed_processing' then
								show = true
							end
						elseif type =='aircraft' then
							if licenses[i].type == 'aircraft' then
								show = true
							end
						elseif type =='boat' then
							if licenses[i].type == 'boat' then
								show = true
							end														
						end
					end
				else
					show = true
				end

				if show then
					-- Remove multiple licenses
					for _,v in ipairs(licenses) do
						if (not hash[v]) then
							res[#res+1] = v -- you could print here instead of saving to result table if you wanted
							hash[v] = true
						end
					end

					local array = {
						user = user,
						licenses = res
					}
					TriggerClientEvent('jsfour-idcard:open', _source, array, type)
				else
					TriggerClientEvent('esx:showNotification', _source, "You don't have that type of license..")
				end
			end)
		end
	end)
end)
