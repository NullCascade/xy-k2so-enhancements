if mods['apia'] then
    -- Non-optional settings
    data.raw['ammo']['artillery-shell-with-phosphorus'].icon = '__xy-k2so-enhancements__/icons/phosphorus-artillery-shell.png' -- Standardised icon
    data.raw['assembling-machine']['kr-greenhouse'].surface_conditions = { { property = "pressure", min = 1000, max = 2500, } } -- Allows greenhouse to be built on Apia, like Gleba
    data.raw['combat-robot']['flamethrower'].time_to_live = 120 * 60 --Flamethrower Drone - Increasing lifetime to standardise

    -- Phosphorus Artillery Shell - Update damage, stack size, weight, & recipe to standardise (balances to be between nuclear and antimatter)
    if settings.startup['xy-apia-artillery-rebalance'].value then    
        data.raw['artillery-projectile']['artillery-projectile-with-phosphorus'].action.action_delivery.target_effects = {
            {
                type = "nested-result",
                action = {
                    type = "area",
                    radius = 10.0,
                    action_delivery = {
                        type = "instant",
                        target_effects = {
                            { type = "damage", damage = { amount = 2500 , type = "physical" } },
                            { type = "damage", damage = { amount = 2500 , type = "explosion" } },
                        }
                    }
                }
            },
            {
                type = "create-trivial-smoke",
                smoke_name = "artillery-smoke",
                initial_height = 0,
                speed_from_center = 0.05,
                speed_from_center_deviation = 0.005,
                offset_deviation = {{-4, -4}, {4, 4}},
                max_radius = 3.5,
                repeat_count = 4 * 4 * 15
            },
            {
                type = "create-smoke",
                entity_name = "phosphorus-cloud",
                repeat_count = 8,
                random_offset = true,
                offset_deviation = {{-8, -8}, {8, 8}}
            },
            {
                type = "create-entity",
                entity_name = "big-artillery-explosion"
            },
            {
                type = "show-explosion-on-chart",
                scale = 8/32
            }
        }
        data.raw['ammo']['artillery-shell-with-phosphorus'].stack_size = 25
        data.raw['ammo']['artillery-shell-with-phosphorus'].weight = 1000*kg
        data.raw['recipe']['artillery-shell-with-phosphorus'].ingredients = {
            { type = "item", name = "steel-plate", amount = 10 },
            { type = "item", name = "processing-unit", amount = 10 },
            { type = "item", name = "phosphorus", amount = 15 },
            { type = "item", name = "artillery-shell", amount = 1 },
        }
    end

    -- Bio Solar Panel:
    --     More solar power (but not too much to outshadow the Advanced Solar Panel per square)
    --     Drastically nerfing pollution absorbtion to not make it completely broken & outshine air purifiers
    --      (it absorbs pollution at the same strength of 2000 trees...)
    -- Also weight & stack size standardisation
    if settings.startup['xy-apia-biosolar-rebalance'].value then
        data.raw['solar-panel']['bio-solar-panel'].emissions_per_second = { pollution = -0.2 }
        data.raw['solar-panel']['bio-solar-panel'].production = '120kW'
        data.raw['item']['bio-solar-panel'].weight = 40000
        data.raw['item']['bio-solar-panel'].stack_size = 50
    end
end