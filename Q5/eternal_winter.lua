-- Table to store the areas we want thunders to appear in
-- 0 = no effect, 1 = effect, 
-- 2 = center of the effect (sprite unused), 3 = center of the effect (sprite used)
local configurations = {        
    {
        {0, 0, 0, 0, 0, 0, 0},
        {0, 0, 0, 0, 0, 0, 0},
        {0, 0, 0, 1, 0, 0, 0},
        {0, 0, 0, 3, 0, 0, 0},
        {0, 0, 0, 0, 0, 0, 0},
        {0, 0, 0, 0, 0, 0, 0},
        {0, 0, 0, 0, 0, 0, 0}
    },
    {
        {0, 0, 0, 0, 0, 0, 0},
        {0, 0, 0, 1, 0, 0, 0},
        {0, 0, 0, 0, 1, 0, 0},
        {0, 0, 1, 3, 1, 1, 0},
        {0, 0, 1, 0, 0, 0, 0},
        {0, 0, 0, 1, 0, 0, 0},
        {0, 0, 0, 0, 0, 0, 0}
    },
    {
        {0, 0, 0, 0, 0, 0, 0},
        {0, 0, 1, 1, 1, 0, 0},
        {0, 0, 1, 0, 0, 0, 0},
        {1, 0, 1, 3, 0, 1, 0},
        {0, 1, 0, 0, 1, 0, 0},
        {0, 0, 1, 1, 0, 0, 0},
        {0, 0, 0, 0, 0, 0, 0}
    },
    {
        {0, 0, 0, 1, 0, 0, 0},
        {0, 0, 1, 0, 1, 0, 0},
        {0, 1, 0, 0, 0, 1, 0},
        {1, 0, 0, 3, 0, 0, 1},
        {0, 1, 0, 0, 0, 1, 0},
        {0, 0, 1, 0, 1, 0, 0},
        {0, 0, 0, 1, 0, 0, 0}
    },

    {
        {0, 0, 0, 0, 0, 0, 0},
        {0, 0, 0, 0, 1, 0, 0},
        {0, 1, 0, 1, 0, 0, 0},
        {0, 0, 0, 3, 1, 1, 0},
        {0, 1, 0, 0, 0, 1, 0},
        {0, 0, 1, 0, 1, 0, 0},
        {0, 0, 0, 1, 0, 0, 0}
    },
    {
        {0, 0, 0, 0, 0, 0, 0},
        {0, 0, 0, 1, 0, 1, 0},
        {0, 1, 1, 1, 0, 0, 0},
        {1, 0, 1, 3, 0, 1, 0},
        {0, 1, 0, 0, 1, 0, 0},
        {0, 0, 0, 1, 0, 1, 0},
        {0, 0, 0, 1, 0, 0, 0}
    },
    {
        {0, 0, 0, 1, 0, 0, 0},
        {0, 0, 0, 0, 1, 0, 0},
        {0, 1, 1, 0, 0, 0, 1},
        {0, 0, 0, 3, 0, 0, 1},
        {1, 0, 1, 0, 0, 0, 0},
        {0, 0, 1, 0, 1, 0, 0},
        {0, 0, 0, 1, 0, 0, 0}
    },
    {
        {0, 0, 0, 1, 0, 0, 0},
        {0, 0, 1, 0, 1, 0, 0},
        {0, 1, 1, 1, 1, 0, 0},
        {0, 0, 0, 2, 0, 1, 1},
        {0, 1, 1, 0, 0, 0, 0},
        {0, 0, 1, 0, 0, 1, 0},
        {0, 0, 0, 0, 0, 0, 0}
    },
    
    {
        {0, 0, 0, 1, 0, 0, 0},
        {0, 0, 0, 0, 1, 0, 0},
        {0, 1, 0, 0, 0, 0, 0},
        {1, 0, 0, 2, 1, 0, 1},
        {0, 0, 1, 0, 0, 1, 0},
        {0, 0, 1, 0, 0, 0, 0},
        {0, 0, 0, 0, 1, 0, 0}
    },
    {
        {0, 0, 0, 0, 0, 0, 0},
        {0, 0, 1, 0, 1, 0, 0},
        {0, 1, 0, 1, 0, 0, 0},
        {0, 0, 0, 2, 1, 0, 1},
        {0, 1, 0, 1, 1, 0, 0},
        {0, 0, 1, 0, 0, 0, 0},
        {0, 0, 0, 0, 0, 0, 0}
    },
    {
        {0, 0, 0, 0, 0, 0, 0},
        {0, 0, 1, 0, 1, 0, 0},
        {0, 1, 0, 0, 0, 1, 0},
        {0, 0, 0, 2, 0, 0, 1},
        {0, 0, 1, 0, 0, 0, 0},
        {0, 0, 1, 0, 0, 0, 0},
        {0, 0, 0, 0, 0, 0, 0}
    }
}


--returns another table of combat object with proper parameters from the configurations table and effect used
local function createAndStoreCombats(areas)
    local combats = {}
    for i, area in ipairs(areas) do 
        local combat = Combat()
        combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_ICETORNADO)
        combat:setArea(createCombatArea(area))
        table.insert(combats, combat)
    end
    return combats
end

local combats = createAndStoreCombats(configurations)

function onCastSpell(creature, variant)
    for i, combat in ipairs(combats) do
        addEvent(function()
            combat:execute(creature, variant)
        end, 300 * i)  -- adding delay to iterate between combat area configs
    end
end


