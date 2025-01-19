ESX = nil

local voiceMode = 2

local SoundSrc = Config["PlayernotEat"]
local SoundSrc2 = Config["PlayerStress"]


Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj)ESX = obj end)
        Citizen.Wait(0)
    end
    TriggerServerEvent('profile:setavadiscord')
    Wait(0)
end)

RegisterNetEvent('profile:avadiscord', function(avatar)
    SendNUIMessage({
        type = 'SetDiscord',
        avatar = avatar
    })
end)

AddEventHandler('playerSpawned', function()
	Wait(2000)
    TriggerServerEvent('profile:setavadiscord')
end)

Citizen.CreateThread(function()
    Citizen.Wait(0)
    while true do
        TriggerEvent("esx_status:getStatus", "hunger", function(status)
            hungerPercent = status.getPercent()
        end)
        TriggerEvent("esx_status:getStatus", "stress", function(status)
        	stressPercent = status.getPercent()
        end)
        Wait(100)
    end
end)

Citizen.CreateThread(function()
	while true do
		Wait(10000)

		local playerPed  = GetPlayerPed(-1)
		local prevHealth = GetEntityHealth(playerPed)
		local health     = prevHealth
        

		TriggerEvent('esx_status:getStatus', 'hunger', function(status)
			if status.val < 200000 then
                    SendNUIMessage({
                        action = 'sound',
                        sound = SoundSrc,
                    }) 
				elseif status.val > 200000 then
		
                    -- SendNUIMessage({
                    --     action = 'sound',
                    --     sound = SoundSrc,
                    -- }) 
                    -- Wait(5000)
			end
		end)

		TriggerEvent('esx_status:getStatus', 'thirst', function(status)			
				if status.val < 200000 then	
                    SendNUIMessage({
                        action = 'sound',
                        sound = SoundSrc,
                    }) 
 
				elseif status.val > 200000 then
			
                    -- SendNUIMessage({
                    --     action = 'sound',
                    --     sound = SoundSrc,
                    -- }) 
                    -- Wait(5000)
					
			end
		end)
	end
end)




Citizen.CreateThread(function()
    while true do
        Citizen.Wait(100)

        local playerId = PlayerId()
        local ped = GetPlayerPed(-1)

        SetPedMaxHealth(ped, 200)				-- Set max health peds
		SetPedMaxTimeUnderwater(ped, 10.00) 	-- Set the underwater time to all players
        SetPlayerHealthRechargeMultiplier(PlayerId(), 0.0)

        local playerHealth = GetEntityHealth(ped) - 100	
        local armor = GetPedArmour(ped)
        local IDA = GetPlayerServerId(PlayerId())
        local FirstName = GetPlayerName(playerId)
        
        local playerStamina = 100 - GetPlayerSprintStaminaRemaining(playerId)
        local playerDive = GetPlayerUnderwaterTimeRemaining(playerId) * 10.00	-- Value setpedmaxtimeunderwater multiply getplayerunderwatertimeremaining = 100
        
            SendNUIMessage({
                action = 'ui',
                hide = IsPauseMenuActive(),
                health = playerHealth,
                stamina = playerStamina,
                dive = playerDive,
                armor = armor,
                hungry = hungerPercent,
                thirst = thirstPercent,
                stress = stressPercent,
                fullname = FirstName,
                talk = NetworkIsPlayerTalking(PlayerId()),
                id = IDA
            })
    end
end)

AddEventHandler('onResourceStart', function()
    voiceDistance()
end)

AddEventHandler('pma-voice:setTalkingMode', function(mode)
    voiceMode = mode
    voiceDistance()
end)

function voiceDistance()
	local text = Cfg.voiceModes[voiceMode][2]
    SendNUIMessage({
		action = 'voice',
        voiceText = text,
		voiceCircle = voiceMode
    })
end
