if Inv.core then
    function GetCoreInv(playerId, prefix)
        local identifier = GetIdentifier(playerId)

        if identifier then
            return Framework.esx and ('%s-%s'):format(prefix, identifier:gsub(':','')) or ('%s-%s'):format(prefix, identifier)
        end

        return false
    end
end

local exp = Framework.esx and exports['es_extended']:getSharedObject() or exports['qb-core']:GetCoreObject()

function AddItem(playerId, item, amount, metadata)
    if Inv.ox then
        Inv.exp:AddItem(playerId, item, amount, metadata)
    elseif Inv.qb then
        QBCore.Functions.GetPlayer(playerId)?.Functions.AddItem(item, amount, nil, metadata)
    elseif Inv.qs then
        Inv.exp:AddItem(playerId, item, amount, nil, metadata)
    elseif Inv.core then
        local inventory = GetCoreInv(playerId, 'content')
        Inv.exp:addItem(inventory, item, amount, metadata, 'content')
    elseif Inv.codem then
        exports['codem-inventory']:AddItem(playerId, item, amount, nil, metadata)
    end
end


function GetItemAmount(playerId, name)
    if Framework.esx then
        local xPlayer = exp.GetPlayerFromId(playerId)
        local item = xPlayer.getInventoryItem(name)

        if item then
            for k,v in pairs(item) do
                if k == 'amount' or k == 'count' then return v end
            end
        end
    elseif Framework.qb then
        local Player = exp.Functions.GetPlayer(playerId)
        local item = Player.Functions.GetItemByName(name)

        if item then
            for k,v in pairs(item) do
                if k == 'amount' then
                    return v
                end

                if k == 'count' then
                    return v
                end
            end
        end
    end

    return 0
end


function RemoveItem(playerId, item, amount)
    if Framework.esx then
        local xPlayer = exp.GetPlayerFromId(playerId)
        xPlayer.removeInventoryItem(item, amount)
    elseif Framework.qb then
        local Player = exp.Functions.GetPlayer(playerId)

        Player.Functions.RemoveItem(item, amount)
    end
end