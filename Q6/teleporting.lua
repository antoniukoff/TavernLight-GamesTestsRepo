local t = {
    squares = 5, --how many squares the player will move
    effects = {CONST_ME_POFF, CONST_ME_ENERGYAREA}
} 

function onCastSpell(cid, var)
    local pos, dir, tmp = getThingPos(cid), getPlayerLookDir(cid), {} --get player position and direction 
    table.insert(tmp, pos)
    
    -- 0 = north, 1 = east, 2 = south, 3 = west
    for i = 1, t.squares do
        local cur = {
            x = pos.x + (dir == 1 and i or dir == 3 and -i or 0),
            y = pos.y + (dir == 0 and -i or dir == 2 and i or 0),
            z = pos.z
        }
        print("tile ", cur.x, cur.y, cur.z)
        if not Tile(cur):isWalkable() then
            print("can't walk on tile")
            break
        end
		table.insert(tmp, cur) --insert the position into the table
    end

    --teleport the player to the next position with a delay of 50ms
    for i = 2, #tmp do
       addEvent(function()
            doTeleportThing(cid, tmp[i])
            for _, k in ipairs(t.effects) do
                doSendMagicEffect(tmp[i - 1], k) --send the effect to the previous position
            end
        end, i * 50)
    end

    return false
end
