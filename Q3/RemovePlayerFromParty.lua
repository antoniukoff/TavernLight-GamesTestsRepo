function removeMemberFromPlayerParty(playerId, membername)
    local player = Player(playerId)
    local playerToRemove = Player(membername)
    if not player or not playerToRemove -- check to see if both are valid
        return 
    end 

    local party = player:getParty()
    if party then -- check if player is in the party 
        -- better to use ipairs if players are stored in a sequntial container like an array or a vector
        -- also break if hits nil
        for _, member in ipairs(party:getMembers()) do -- loops through partie's members
            if member == playerToRemove then 
                party:removeMember(member) -- removes the member and breaks the loop 
                break
            end
        end
    end
end