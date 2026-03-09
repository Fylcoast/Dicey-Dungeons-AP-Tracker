require("scripts/logic/access_variables")
require("scripts/logic/logic_helper")
require("scripts/logic/warrior_episodes")

--==========================================================================
--==                           VISIBILITY RULES                           ==
--==========================================================================

-- Visibility rules to show ANY chest. true leads to more restrictive show logic
function show_chests()
    local checks_per_chest = Tracker:FindObjectForCode("checksperchest")
    return checks_per_chest and checks_per_chest.AcquiredCount > 0
end

-- Visibility rule for a specific chest.
function show_chest(episode, floor, iter)
    local checks_per_chest = Tracker:FindObjectForCode("checksperchest")
    local num_chests = WARRIOR_EPISODES[tonumber(episode)][tonumber(floor)]['num_chests']
    return checks_per_chest 
        and checks_per_chest.AcquiredCount > 0 
        and tonumber(iter) <= num_chests * checks_per_chest.AcquiredCount
    
    -- local checks_per_chest = Tracker:FindObjectForCode("checksperchest")
    -- if checks_per_chest then
    --     checks_per_chest.AcquiredCount = 3
    -- end
    -- return true
end

-- Visibility rules to show ANY shop. true leads to more restrictive show logic
function show_shops()
    local checks_per_shop = Tracker:FindObjectForCode("checkspershop")
    return checks_per_shop and checks_per_shop.AcquiredCount > 0
end

-- Visibility rule for a specific shop.
function show_shop(episode, floor, iter)
    local checks_per_shop = Tracker:FindObjectForCode("checkspershop")
    local num_shops = WARRIOR_EPISODES[tonumber(episode)][tonumber(floor)]['num_shops']
    return checks_per_shop 
        and checks_per_shop.AcquiredCount > 0 
        and tonumber(iter) <= num_shops * checks_per_shop.AcquiredCount
end

-- Visibility rules to show ANY trade. true leads to more restrictive show logic
function show_trades()
    local checks_per_trade = Tracker:FindObjectForCode("checkspertrade")
    return checks_per_trade and checks_per_trade.AcquiredCount > 0
end

-- Visibility rule for a specific trade.
function show_trade(episode, floor, iter)
    local checks_per_trade = Tracker:FindObjectForCode("checkspertrade")
    local num_trades = WARRIOR_EPISODES[tonumber(episode)][tonumber(floor)]['num_trades']
    return checks_per_trade 
        and checks_per_trade.AcquiredCount > 0 
        and tonumber(iter) <= num_trades * checks_per_trade.AcquiredCount
end

-- Visibility rules to show ANY heal. true leads to more restrictive show logic
function show_heals()
    return false
end

-- Visibility rule for a specific heal.
function show_heal(episode, floor, iter)
    return false
end

-- Visibility rules to show ANY upgrade. true leads to more restrictive show logic
function show_upgrades()
    return false
end

-- Visibility rule for a specific upgrade.
function show_upgrade(episode, floor, iter)
    return false
end

-- Visibility rules for Levelsanity
function show_levels()
    local levelsanity = Tracker:FindObjectForCode("levelsanity")
    return levelsanity and levelsanity.Active
end



--==========================================================================
--==                             ACCESS RULES                             ==
--==========================================================================

-- Access rule for specific episode
function can_reach_episode(episode)
    return true
end

-- Access rule for specific floor of an episode
function can_reach_floor(episode, floor)
    return true
end
                