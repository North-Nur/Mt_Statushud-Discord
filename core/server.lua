ESX = nil

local botToken = 'MTMyOTgzODY3MDAwOTYwMjE1MQ.GPbkEZ.l1d6XDYkgb7vyQmA7zki_v8XP02-miL6DP2A-M'
local TOKEN = 'Bot '  .. botToken
local DEFAULT_ID = '1329463847433539644'

TriggerEvent('esx:getSharedObject', function(obj)ESX = obj end)


local function getDiscordId(playerId)
    local identifiers = GetPlayerIdentifiers(playerId)
    for i=1, #identifiers do
        if identifiers[i]:match('discord:') then
            return identifiers[i]:gsub('discord:', '')
        end
    end
    return DEFAULT_ID
end

local function getPlayerFromDiscord(discordId)
    if not discordId then
        return false
    end
    local p = promise.new()
    PerformHttpRequest(('https://discordapp.com/api/users/%s'):format(discordId), function(err, result, headers)
        p:resolve({data=result, code=err, headers = headers})
    end, 'GET', '', {['Content-Type'] = 'application/json', ['Authorization'] = TOKEN})

    local result = Citizen.Await(p)
    if result then
        if result.code ~= 200 then
            return print('Error: Something went wrong with error code - ' .. result.code)
        end
        local data = json.decode(result.data)
        if data and data.avatar then
            return ('https://cdn.discordapp.com/avatars/%s/%s'):format(discordId, data.avatar)
        end
    end
end

RegisterNetEvent('profile:setavadiscord', function()
    local playerIds = source
    local discordId = getDiscordId(playerIds)
    local avatar = getPlayerFromDiscord(discordId)
    TriggerClientEvent('profile:avadiscord', playerIds, avatar)
end)