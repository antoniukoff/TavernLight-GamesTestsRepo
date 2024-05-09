
function onLogout(playerID) -- change the player to be an id parameter 
    local player = Player(playerID) -- Player(data) - takes in id or guid or name or userdata looks up only by these parameters based on the source code

    if player ~= nil and player:getStorageValue(1000) ~= -1 then -- if player exists and has set storage value
        local function releaseStorage()
            player:setStorageValue(1000, -1) --resets the storage value at that id
        end

        addEvent(function() releaseStorage(playerId) end, 1000) -- releases storage after delay
        return true 
	end
	return false
end