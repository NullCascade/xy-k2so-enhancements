local function set_item_weight(item, weight_in_kg)
    local prototype = data.raw.item[item]
    if (not prototype) then
        return
    end

    prototype.weight = weight_in_kg * kg
end

-- Almost entirely for intermediates
if settings.startup['xy-item-weight'].value then
    -- Nerf weights
    set_item_weight('kr-imersite', 1) -- this was 10k/rocket which seems odd
    ---- Buff weight
    -- i like the idea of shipping in key intermediate products in buildings to assemble in-situ (other than imersite related)
    -- Some other key intermediates are slightly buffed as well, with electronic components significantly buffed
    -- fuel capacity is also doubled
    set_item_weight('kr-rare-metal-ore', 2) -- this was 70/rocket which is even more odd, moreso a consistency change. still useless because enriched ore is 1kg
    set_item_weight('sand', .5)
    set_item_weight('glass', 1)
    set_item_weight('kr-sand', .5)
    set_item_weight('kr-glass', 1)
    set_item_weight('steel-plate', 2)
    set_item_weight('kr-imersite-powder', .5)
    set_item_weight('kr-inserter-parts', .5)
    set_item_weight('kr-automation-core', 1.25)
    set_item_weight('kr-electronic-components', .5) -- key ingredient in red circuits
    set_item_weight('kr-iron-beam', 2)
    set_item_weight('kr-steel-beam', 2)
    set_item_weight('kr-fuel', 2)
    set_item_weight('kr-biofuel', 2)
    set_item_weight('kr-advanced-fuel', 2)

    if mods['Moshine'] then
        set_item_weight('silicon-cell', 2.5) -- i like the ideas of these being more efficient to ship than raw silicon
    end
end

