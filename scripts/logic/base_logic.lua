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
    -- Gather required setting
    local episode_progression = Tracker:FindObjectForCode("episodeprogression")

    -- Return true immediately if open world, as all episodes available in open world
    if not episode_progression or episode_progression.CurrentStage == 1 then
        return true
    end

    -- Determine access based on completed episodes
    local completed_episode_count = 0
    for _, episode in ipairs(EPISODE_COMPLETED_CODES) do
        local episode_completion = Tracker:FindObjectForCode(episode)
        if episode_completion and episode_completion.Active then
            completed_episode_count = completed_episode_count + 1
        end
    end

    return completed_episode_count >= EPISODES_NEEDED_BY_EPISODE[tonumber(episode)]
end

-- Access rule for specific floor of an episode
function can_reach_floor(episode, floor)
    -- Equipment check
    -- Need X Equipment to reach Y floor
    local overall_equipment = Tracker:FindObjectForCode("Episode" .. episode .. "Equipment")
    local has_equipment = overall_equipment 
        and overall_equipment.AcquiredCount >= EQUIPMENT_NEEDED_BY_FLOOR[tonumber(floor)]

    -- Progressive level check
    -- If levelsanity, then need X progressive levels to reach Y floor
    local levelsanity = Tracker:FindObjectForCode("levelsanity")
    local progressive_levels = Tracker:FindObjectForCode("episode" .. episode .. "progressivelevelup")
    local has_levels = not levelsanity 
        or not levelsanity.Active 
        or not progressive_levels 
        or progressive_levels.AcquiredCount >= LEVELS_NEEDED_BY_FLOOR[tonumber(floor)]

    -- Dice check
    -- if Split dice, then need X Dice Shards to reach Y floor
    local dice_shards_per_die = Tracker:FindObjectForCode("diceshardsperdie")
    local dice_shards = Tracker:FindObjectForCode("diceshard")
    local has_dice = not dice_shards_per_die
        or not (dice_shards_per_die.AcquiredCount > 0)
        or not dice_shards
        or dice_shards.AcquiredCount >= DICE_NEEDED_BY_FLOOR[tonumber(floor)] * dice_shards_per_die.AcquiredCount

    return has_equipment and has_levels and has_dice
end
                