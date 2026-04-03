local t = data.raw.technology
local util = require('util.util')
local remove_preqs = util.tech_remove_preqs
local add_preqs = util.tech_add_preqs

local function remove_cards(tech, cards_to_remove) -- Should be used before add_preqs() if both are needed
    if t[tech] then
        for _,to_remove in pairs(cards_to_remove) do
            for i,existing_card in pairs(t[tech].unit.ingredients) do
                if existing_card[1] == to_remove then
                    table.remove(t[tech].unit.ingredients, i)
                end
            end
        end
    else
        log(tech..' - Tech does not exist!')
    end
end

--- Tech card replacements
if settings.startup['xy-paracelsin-tech-card'].value and mods['Paracelsin'] then
    if settings.startup['xy-paracelsin-tech-card-endgame'].value then
        util.tech_add_card('kr-singularity-lab', 'galvanization-science-pack')
        util.tech_add_card('kr-antimatter-ammo', 'galvanization-science-pack')
        util.tech_add_card('kr-antimatter-reactor', 'galvanization-science-pack')
        util.tech_add_card('kr-antimatter-reactor-equipment', 'galvanization-science-pack')
        util.tech_add_card('kr-intergalactic-transceiver', 'galvanization-science-pack')
    end

    if settings.startup['xy-lab-recipe-changes'].value and mods['planet-muluna'] then
        util.tech_add_card('cryolab', 'galvanization-science-pack')
    end
end
if settings.startup['xy-adv-chem-plant-rebalance'].value and mods['Paracelsin'] then
    add_preqs('planet-discovery-paracelsin', {'kr-advanced-chemical-plant'})
end

if settings.startup['xy-secretas-tech-card'].value and mods['secretas'] then
    -- Lock these behind auric tech card because you need those to unlock these.
    -- They are otherwise normally unlocked through the secretas research
    local requires_auric = {
        'worker-robots-storage-4',
        'gold-heat-pipe',
        'gold-plate-productivity',
        'gold-railgun-turret',
        'hyper-inserter',
        'pentapod-egg-unrestricted',
        'spaceship-scrap-recycling-productivity',
        'transport-belt-capacity-3-Secretas',
    }
    if mods['outer-rim'] then goto outer_rim_skip end
    if settings.startup['condense-level-4-modules-into-one-technology'].value then
        table.insert(requires_auric, 'module-finale')
    else
        table.insert(requires_auric, 'efficiency-module-4-S')
        table.insert(requires_auric, 'productivity-module-4-S')
        table.insert(requires_auric, 'quality-module-4-S')
        table.insert(requires_auric, 'speed-module-4-S')
    end
    for _,tech in pairs(requires_auric) do
        remove_preqs(tech, {'planet-discovery-secretas'})
        add_preqs(tech, {'golden-science-pack'})
    end

    remove_preqs('golden-science-pack', {'planet-discovery-secretas'})
    add_preqs('golden-science-pack', {'steam-recycler'})

    ::outer_rim_skip::
    --- Other secretas patches
    --- Logical progression
    
    t['science-pack-productivity'].hidden = true -- Remove this; bloat

    remove_cards('gold-heat-pipe', {'automation-science-pack', 'logistic-science-pack', 'chemical-science-pack'}) -- redundant cards at this point
    remove_preqs('planet-discovery-secretas', {'cryogenic-science-pack'})
    add_preqs('planet-discovery-secretas', {'railgun'})
    if settings.startup['condense-level-4-modules-into-one-technology'].value then
        add_preqs('efficiency-module-4-S',   {'efficiency-module-3'})
        add_preqs('productivity-module-4-S', {'productivity-module-3'})
        add_preqs('quality-module-4-S',      {'quality-module-3'})
        add_preqs('speed-module-4-S',        {'speed-module-3'})
    end
    
    if settings.startup['xy-paracelsin-tech-card'].value and mods['Paracelsin'] and not mods['outer-rim'] then
        util.tech_add_card('planet-discovery-secretas', 'galvanization-science-pack')
    end
end
--- Make K2's Adv. Tank more expensive to make you actually use the Spidertron for war purposes
if settings.startup['xy-advanced-tank-expensive-research'].value then
    t['kr-advanced-tank'].unit.count = 2500
    util.tech_add_card('kr-advanced-tank', 'metallurgic-science-pack')
    util.tech_add_card('kr-advanced-tank', 'agricultural-science-pack')
    util.tech_add_card('kr-advanced-tank', 'electromagnetic-science-pack')
    add_preqs('kr-advanced-tank', {'metallurgic-science-pack','agricultural-science-pack','electromagnetic-science-pack'})
end
--- Wipe out early tech cards in mid-late technologies
local strip_basic_tech_cards = {
    -- Corrundrum
    'calcium-sulfate', 'asphalt-and-concrete', 'calcium-sulfate-nutrients', 'calcium-sulfate-recovery', 'stone-production', 'blue-rocket', 'sulfonated-plastic', 'sulfur-poison-capsule', 'recrystalization',
    -- Rubia
    'braking-force-8', 'craptonite-productivity', 'craptonite-axe', 'craptonite-wall', 'rubia-efficiency-module4', 'rubia-long-bulk-inserter', 'rubia-long-stack-inserter', 'rubia-bio-utility-science-pack', 'rubia-bio-flying-robot-frame', 'rubia-biochamber-productivity-bonus',
}
for _,tech in pairs(strip_basic_tech_cards) do
    util.tech_remove_cards(tech, {'logistic-science-pack','military-science-pack','automation-science-pack','chemical-science-pack'})
end
--- Wipe out workshop tech card in mid-late technologies
if mods['workshop-science'] then
    for _,tech in pairs(t) do
        if not tech.unit then
            goto continueWorkshop
        end
        for _, val in pairs(tech.unit.ingredients) do
            if val[1] == 'automation-science-pack' then
                goto continueWorkshop
            end
            remove_cards(tech.name, {'workshop-science-pack'})
        end
        ::continueWorkshop::
    end
end
----- MLE Tech Scaling -----
if settings.startup['xy-tech-inflation'].value then
    -- increase the cost of all mid-late-endgame techs, starting after the first three vanilla planets
    -- does not affect Moshine as that is unrelated

    local hardcoded_multi = { -- overrides the sweeping changes
        ['planet-discovery-aquilo'] = 8,
        ['planet-discovery-maraxsis'] = 8,
        ['planet-discovery-paracelsin'] = 8,
        ['planet-discovery-moshine'] = 4,
        ['planet-discovery-secretas'] = 30,
        ['legendary-quality'] = 15,
        ['quantum-processor'] = 30,
        ['kr-intergalactic-transceiver'] = 50, -- vanilla megabase could still do this in 5 minutes lol
        ['kr-advanced-card'] = 2,
        ['biolab'] = 2,
    }
    local general_multi = { -- only applies the highest value, will make this a setting eventually but might be clutter? could organize into sections
        ['promethium-science-pack'] = 25,
        ['outer-rim-spacecraft-science-pack'] = 15,
        ['golden-science-pack'] = 15,
        ['kr-singularity-tech-card'] = 15,
        ['gas-manipulation-science-pack'] = 12,
        ['kr-matter-tech-card'] = 10,
        ['particle-physics-pack'] = 10,
        ['outer-rim-insulation-science-pack'] = 8,
        ['outer-rim-cryochemical-science-pack'] = 6,
        ['outer-rim-thermodynamic-science-pack'] = 6,
        ['cryogenic-science-pack'] = 6,
        ['galvanization-science-pack'] = 6,
        ['hydraulic-science-pack'] = 6,
        ['biorecycling-science-pack'] = 5,
        ['planetaris-compression-science-pack'] = 3,
        ['pelagos-science-pack'] = 3,
        ['kr-advanced-tech-card'] = 2,
        ['MAE-cards'] = 5,
    }
    local settings_post_multi = 1
    if settings.startup['xy-tech-inflation-scale'].value ~= '100%' then -- dumb but it works so whatever
        if     settings.startup['xy-tech-inflation-scale'].value == '25%'  then settings_post_multi = 0.25
        elseif settings.startup['xy-tech-inflation-scale'].value == '50%'  then settings_post_multi = 0.5
        elseif settings.startup['xy-tech-inflation-scale'].value == '75%'  then settings_post_multi = 0.75
        elseif settings.startup['xy-tech-inflation-scale'].value == '150%' then settings_post_multi = 1.5
        elseif settings.startup['xy-tech-inflation-scale'].value == '200%' then settings_post_multi = 2
        end
    end


    for _,tech in pairs(t) do
        if (tech.upgrade) or (not tech.unit) or (not tech.unit.count) then goto continue end

        if hardcoded_multi[tech.name] then
            tech.unit.count = math.ceil(tech.unit.count * hardcoded_multi[tech.name] * settings_post_multi)
        else
            -- general application
            local used_cards = {}
            local highest_multi = 1
            local MAE = 0 -- as in metallurgic, agricultural, and electromagnetic science. count up and if this is three then apply
            for _,card in pairs(tech.unit.ingredients) do
                table.insert(used_cards, card[1]) -- 1-indexed lists
            end
            for _,v in pairs(used_cards) do
                if v == 'agricultural-science-pack' or v == 'metallurgic-science-pack' or v == 'electromagnetic-science-pack' then
                    MAE = MAE + 1
                end
                local card_multi = general_multi[v] or -1
                if highest_multi < card_multi then
                    highest_multi = card_multi
                end
            end
            if highest_multi == 1 and MAE == 3 then
                highest_multi = general_multi['MAE-cards']
            end
            local final_multi = highest_multi * settings_post_multi
            if highest_multi ~= 1 and final_multi > 1 then
                tech.unit.count = math.ceil(tech.unit.count * final_multi)
            end
        end

        ::continue::
    end

end


