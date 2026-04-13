local function reformat(original_name, short_name, import_location, tech_name, ignore_tech, basic_card)
    -- The actual name of the science pack, the "relevant" part of the science pack name, import location
    -- Ex: 'cryogenic-science-pack', 'cryogenic', 'aquilo', nil
    -- The first arg exists cause some mods will start their items with "kr-" for example
    -- tech_name is for (bad) mods where the tech name to unlock the tech card is not the same as the actual item itself
    -- ignore_tech is for when the unlock tech should not be altered (by changing its icon/name); mainly if it unlocks other things
    -- basic_card is for when a card is an early-game card that does not need research data
    local research_data_name = short_name..'-research-data'
    
    -- Create research data item
    if not basic_card then
        data.extend({ 
            {
                type = 'item',
                name = 'xy-'..research_data_name,
                icon = '__xy-k2so-enhancements__/icons/'..research_data_name..'.png',
                subgroup = 'science-pack',
                order = 'zzz', -- This should be overridden by patches.category
                stack_size = 200,
                weight = 1 * kg,
                default_import_location = import_location,
                localised_name = {'item-name.xy-'..research_data_name},
            },
        })
    end

    local r = data.raw.recipe[original_name]
    local research_data_recipe = table.deepcopy(r)

    -- Replace the science pack recipe with a tech card recipe
    -- If it is an advanced card, change the recipe to use research data
    -- If it is a basic card, simply add 5 blank tech cards as an ingredient
    r.energy_required = 20
    r.additional_categories = nil
    r.surface_conditions = {}
    r.results = {{type = 'item', name = original_name, amount = 5},}
    r.always_show_products = true
    r.show_amount_in_title = false
    r.localised_name = {'item-name.xy-'..short_name..'-tech-card'}
    r.icon = '__xy-k2so-enhancements__/icons/'..short_name..'-tech-card.png'
    if basic_card then
        r.category = 'crafting'
        for _, ingredients in pairs(r.ingredients) do
			if ingredients.type == 'fluid' then
				r.category = 'crafting-with-fluid'
				break
			end
		end
        table.insert(r.ingredients, {type = 'item', name = 'kr-blank-tech-card', amount = 5})
    else
        r.category = 'kr-tech-cards'
        r.ingredients = {
            {type = 'item', name = 'kr-blank-tech-card', amount = 5},
            {type = 'item', name = 'xy-'..research_data_name, amount = 5},
        }
    end

    -- Clone the original science pack recipe and make it yield research datas
    if not basic_card then
        research_data_recipe.name = 'xy-'..research_data_name
        data:extend({research_data_recipe})
        for _,result in pairs(research_data_recipe.results) do
            if result.name == original_name then
                result.name = 'xy-'..research_data_name
            end
        end
        research_data_recipe.main_product = research_data_recipe.name
        research_data_recipe.icon = '__xy-k2so-enhancements__/icons/'..research_data_name..'.png'
    end

    -- Change research data icon and loc
    local i = data.raw.tool[original_name]
    i.icon = '__xy-k2so-enhancements__/icons/'..short_name..'-tech-card.png'
    i.localised_name = {'item-name.xy-'..short_name..'-tech-card'}

    -- Finally, change the technology to give research data recipe + change its icons and loc
    local tech_name = tech_name or original_name
    local t = data.raw.technology[tech_name]
    if not basic_card then
        table.insert(t.effects, {
            type = 'unlock-recipe', recipe = research_data_recipe.name
        })
    end
    if not ignore_tech then
        t.icons = nil
        t.icon = '__xy-k2so-enhancements__/icons/'..short_name..'-tech-card-research.png'
        t.localised_name = {'item-name.xy-'..short_name..'-tech-card'}
    end
end

---

for _,card_data in pairs(require('fixes.tech_cards_list')) do
    if mods[card_data.mod] and card_data.setting then
        reformat(card_data['original_name'], card_data['short_name'], card_data['import_location'], card_data['tech_name'], card_data['ignore_tech'], card_data['basic_card'])
    end
end

--- Specific card patches
if mods['pelagos'] then
    data.raw.item['xy-decomposition-research-data'].spoil_ticks = 81000
    data.raw.item['xy-decomposition-research-data'].spoil_result = 'spoilage'
    data.raw.tool['pelagos-science-pack'].spoil_result = 'kr-blank-tech-card'
end

if mods['apia'] then
    data.raw.item['xy-apicultural-research-data'].spoil_ticks = 54000
    data.raw.item['xy-apicultural-research-data'].spoil_result = 'spoilage'
    data.raw.tool['apicultural-science-pack'].spoil_result = 'kr-blank-tech-card'
end