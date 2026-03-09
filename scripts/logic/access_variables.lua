-- Equipment needed by floor, floor -> equipment needed count
EQUIPMENT_NEEDED_BY_FLOOR = {
    [1] = 0,
    [2] = 1,
    [3] = 2,
    [4] = 4,
    [5] = 5,
    [6] = 6
}

-- Levels needed by floor, floor -> progressive level count required
LEVELS_NEEDED_BY_FLOOR = {
    [1] = 0,
    [2] = 0,
    [3] = 1,
    [4] = 2,
    [5] = 3,
    [6] = 4
}

-- Dice needed by floor, floor -> additional dice required
-- NOTE: Additional dice = received Dice Shards count / Dice Shards per Die
DICE_NEEDED_BY_FLOOR = {
    [1] = 0,
    [2] = 0,
    [3] = 1,
    [4] = 1,
    [5] = 2,
    [6] = 2
}

-- Episodes needed by episode, episode -> Episode Completed count required
EPISODES_NEEDED_BY_EPISODE = {
    [1] = 0,
    [2] = 0,
    [3] = 0,
    [4] = 2,
    [5] = 3,
    [6] = 4
}