
AddLocation({
    location = "forest",
    version = 2,
    overrides={
        start_location = "default",
        season_start = "default",
        world_size = "default",
        task_set = "default",
        layout_mode = "LinkNodesByKeys",
        wormhole_prefab = "wormhole",
        roads = "default",
    },
    required_prefabs = {
        "multiplayer_portal",
    },
})

AddLocation({
    location = "cave",
    version = 2,
    overrides={
        task_set = "cave_default",
        start_location = "caves",
        season_start = "default",
        world_size = "default",
        layout_mode = "RestrictNodesByKey",
        wormhole_prefab = "tentacle_pillar",
        roads = "never",
    },
    required_prefabs = {
        "multiplayer_portal",
    },
})

