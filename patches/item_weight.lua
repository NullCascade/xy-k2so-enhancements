-- Almost entirely for intermediates
if settings.startup['xy-item-weight'].value then
    -- Nerf weights
    data.raw['item']['kr-imersite'].weight = 1 * kg -- this was 10k/rocket which seems odd
    ---- Buff weight
    -- i like the idea of shipping in key intermediate products in buildings to assemble in-situ (other than imersite related)
    -- Some other key intermediates are slightly buffed as well, with electronic components significantly buffed
    -- fuel capacity is also doubled
    data.raw['item']['kr-rare-metal-ore'].weight = 2 * kg -- this was 70/rocket which is even more odd, moreso a consistency change. still useless because enriched ore is 1kg
    data.raw['item']['sand'].weight = .5 * kg
    -- the name on this item is inconsistent
    if data.raw['item']['glass'] then
        data.raw['item']['glass'].weight = 1 * kg    
    end
    data.raw['item']['steel-plate'].weight = 2 * kg
    data.raw['item']['kr-imersite-powder'].weight = .5 * kg
    data.raw['item']['kr-inserter-parts'].weight = .5 * kg
    data.raw['item']['kr-automation-core'].weight = 1.25 * kg
    data.raw['item']['kr-electronic-components'].weight = .5 * kg -- key ingredient in red circuits
    data.raw['item']['kr-iron-beam'].weight = 2 * kg
    data.raw['item']['kr-steel-beam'].weight = 2 * kg
    data.raw['item']['kr-fuel'].weight = 2 * kg
    data.raw['item']['kr-biofuel'].weight = 2 * kg
    data.raw['item']['kr-advanced-fuel'].weight = 2 * kg

    if mods['Moshine'] then
        data.raw['item']['silicon-cell'].weight = 2.5 * kg -- i like the ideas of these being more efficient to ship than raw silicon
    end
end

