local utils = {}

local t = data.raw.technology

local function add_preqs(tech, preqs)
    if t[tech] then
        for _,v in pairs(preqs) do
            table.insert(t[tech].prerequisites, v)
        end
    end
end
utils.tech_add_preqs = add_preqs

local function remove_preqs(tech, preqs_to_remove) -- Should be used before add_preqs() if both are needed
    if t[tech] then
        for _,to_remove in pairs(preqs_to_remove) do
            for i,existing_preq in pairs(t[tech].prerequisites) do
                if existing_preq == to_remove then
                    table.remove(t[tech].prerequisites, i)
                end
            end
        end
    end
end
utils.tech_remove_preqs = remove_preqs

local function remove_cards(tech, cards_to_remove) -- Should be used before add_preqs() if both are needed
    if t[tech] then
        for _,to_remove in pairs(cards_to_remove) do
            for i,existing_card in pairs(t[tech].unit.ingredients) do
                if existing_card[1] == to_remove then
                    table.remove(t[tech].unit.ingredients, i)
                end
            end
        end
    end
end
utils.tech_remove_cards = remove_cards

local function add_card(tech, card_to_add)
    local tech_prototype = t[tech]
    if (not tech_prototype) then
        log(tech..' - Tech does not exist!')
        return
    end

    for _, ingredient in ipairs(tech_prototype.unit.ingredients) do
        if (ingredient[1] == card_to_add) then
            return
        end
    end

    table.insert(tech_prototype.unit.ingredients, {card_to_add, 1})
end
utils.tech_add_card = add_card

local function order_from_index(list, prototype, lead)
    local lead = lead or 'z'
    for index,item in pairs(list) do
        local v = data.raw[prototype][item]
        if v then 
            local extra = ''
            if index < 10 then extra = '0' end
            v.order = lead..extra..tostring(index)
        end
    end
end
utils.order_from_index = order_from_index

local function replace_ingredient_name(recipe, old, new) -- Just for item names, good for swapping equiv. items
    local r = data.raw.recipe[recipe]
    if r then
        for _,v in pairs(r.ingredients) do
            if v.name == old then
                v.name = new
            end
        end
    end
end
utils.replace_ingred_name = replace_ingredient_name

--- @param entity_type string
--- @param entity_id string
--- @param planet_id string
function utils.relax_conditions_for_planet(entity_type, entity_id, planet_id)
	local surface = data.raw["planet"][planet_id]
	if (surface == nil) then
		return
	end

	local prototype = data.raw[entity_type][entity_id]
	if (prototype == nil) then
		return nil
	end

	local surface_properties = surface.surface_properties or {}
	for _, condition in ipairs(prototype.surface_conditions or {}) do
		local surface_condition = surface_properties[condition.property]
		if (surface_condition) then
			if (condition.min > surface_condition) then
				condition.min = surface_condition
			end
			if (condition.max < surface_condition) then
				condition.max = surface_condition
			end
		end
	end
end

return utils
