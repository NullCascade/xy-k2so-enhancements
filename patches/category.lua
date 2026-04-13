local util = require('util.util')
local function apply_item_subgroup(subgroup, items, prototype)
    for _, item in pairs(items) do
        local v = data.raw[prototype][item]
        if v then
            v.subgroup = subgroup
        end
    end
end

if mods['science-tab'] then
    -- reset the orders as the index of this list; so order matters!
    data:extend({
        {
            type = 'item-subgroup',
            group = 'science',
            name = 'xy-special-science',
            order = 'x1',
        },
        {
            type = 'item-subgroup',
            group = 'science',
            name = 'xy-tech-card-1',
            order = 'd1',
        },
        {
            type = 'item-subgroup',
            group = 'science',
            name = 'xy-tech-card-2',
            order = 'd2',
        },
        {
            type = 'item-subgroup',
            group = 'science',
            name = 'xy-tech-card-3',
            order = 'd3',
        },
    })
    -- These arrays are used to order and regroup all the research datas. They are ordered by index; so just the order they are written in
    local order_research_data = {
        'kr-blank-tech-card',
        'kr-biter-research-data',
        'xy-nuclear-research-data',
        'kr-space-research-data',
        'kr-metallurgic-research-data',
        'kr-agricultural-research-data',
        'kr-electromagnetic-research-data',
        'xy-decomposition-research-data',
        'xy-compression-research-data',
        'xy-apicultural-research-data',
        'xy-battlefield-research-data',
        'xy-biorecycling-research-data',
        'kr-cerysian-research-data',
        'xy-electrochemical-research-data',
        'xy-sun-research-data',
        'hydraulic-research-data',
        'kr-cryogenic-research-data',
        'kr-matter-research-data',
        'xy-particle-physics-research-data',        
        'xy-gas-manipulation-research-data',
        'kr-promethium-research-data',
    }
    local order_tech_card_1 = { -- "Basic" tech cards; pre-space
        'automation-science-pack',
        'logistic-science-pack',
        'workshop-science-pack',
        'military-science-pack',
        'chemical-science-pack',
        'production-science-pack',
        'utility-science-pack',
        'nuclear-science-pack'
    }
    local order_tech_card_2 = { -- Muluna until planets w/ big asteroids
        'space-science-pack',
        'kr-advanced-tech-card',
        'metallurgic-science-pack',
        'agricultural-science-pack',
        'electromagnetic-science-pack',
        'apicultural-science-pack',
        'battlefield-science-pack',
        'biorecycling-science-pack',
        'cerysian-science-pack',
        'electrochemical-science-pack',
        'slp-sun-science-pack',
        'pelagos-science-pack',
        'planetaris-compression-science-pack',
        'interstellar-science-pack',
    }
    local order_tech_card_3 = { -- Big/huge asteroids
        'hydraulic-science-pack',
        'outer-rim-thermodynamic-science-pack',
        'cryogenic-science-pack',
        'kr-matter-tech-card',
        'kr-singularity-tech-card',
        'particle-physics-pack',
        'gas-manipulation-science-pack',
        'promethium-science-pack', -- Always last (unless something adds post-promethium)
    }
    -- the outer rim brings its own compat for this.
    if not mods["outer-rim"] then
        table.insert(order_tech_card_3, 5, 'galvanization-science-pack')
        table.insert(order_tech_card_3, 7, 'golden-science-pack')
        table.insert(order_research_data,16,'xy-galvanization-research-data')
        table.insert(order_research_data,18,'xy-golden-research-data')
    end
    local order_special_science = {
        'kr-space-research-data-advanced',
        'cerys-space-science-pack-from-methane-ice',
        'space-science-pack-muluna',
        'rubia-biofusion-promethium-science-pack',
    }

    -- the science tab mod contains this by default.

    apply_item_subgroup('krastorio-research-data', order_research_data, 'item')

    apply_item_subgroup('xy-tech-card-1', order_tech_card_1, 'tool')
    apply_item_subgroup('xy-tech-card-2', order_tech_card_2, 'tool')
    apply_item_subgroup('xy-tech-card-3', order_tech_card_3, 'tool')
    apply_item_subgroup('xy-special-science', order_special_science, 'recipe')
    util.order_from_index(order_research_data, 'item')
    util.order_from_index(order_tech_card_1, 'tool')
    util.order_from_index(order_tech_card_2, 'tool')
    util.order_from_index(order_tech_card_3, 'tool')
end
