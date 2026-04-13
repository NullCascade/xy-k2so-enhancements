if not mods['planetaris-arig'] then return end
local util = require('util.util')
local loader_graphics = require('__Krastorio2-spaced-out__.prototypes.buildings.loader-graphics')

-- Patch so that turbo (green) -> hyper (white) -> superior (purple) belts
util.tech_remove_preqs('kr-logistic-5', {'turbo-transport-belt'})
util.tech_add_preqs('kr-logistic-5', {'planetaris-hyper-transport-belt'})
-- Hyper belt rep, the base recipe is fine so just alter superior belt to require it instead of turbo
-- done above
-- Hyper Underground belt rep, upgrade length and change its ingreds to fit k2
data.raw['underground-belt']['planetaris-hyper-underground-belt'].max_distance = 30 -- turbo is 20, sup is 40
data.raw.recipe['planetaris-hyper-underground-belt'].ingredients = {
    {type = 'item', name = 'planetaris-hyper-transport-belt', amount = 30},
    {type = 'item', name = 'turbo-underground-belt', amount = 2},
    {type = 'item', name = 'planetaris-raw-diamond', amount = 4},
    {type = 'item', name = 'planetaris-silica', amount = 5},
}
-- Hyper splitter rep
util.replace_ingred_name('kr-superior-splitter', 'turbo-splitter', 'planetaris-hyper-splitter')
--- Create hyper loader

-- replacements
util.replace_ingred_name('kr-superior-transport-belt', 'turbo-transport-belt', 'planetaris-hyper-transport-belt')
util.replace_ingred_name('kr-superior-underground-belt', 'turbo-underground-belt', 'planetaris-hyper-underground-belt')

--- finally, reorder all so that hyper appears before superior
data.raw.item['kr-superior-transport-belt'].order = 'a[transport-belt]-f[superior-transport-belt]'
data.raw.item['planetaris-hyper-transport-belt'].order = 'a[transport-belt]-e[hyper-transport-belt]'
data.raw.item['kr-superior-underground-belt'].order = 'b[underground-belt]-f[superior-underground-belt]'
data.raw.item['planetaris-hyper-underground-belt'].order = 'b[underground-belt]-e[hyper-underground-belt]'
data.raw.item['kr-superior-splitter'].order = 'c[splitter]-f[superior-splitter]'
data.raw.item['planetaris-hyper-splitter'].order = 'c[splitter]-e[hyper-splitter]'

--- Loader order + Adding Hyper Loader if needed
if settings.startup['kr-loaders'].value then
    local belt_anim = data.raw["transport-belt"]['planetaris-hyper-transport-belt'].belt_animation_set
    data:extend({
        {
            type = 'recipe',
            name = 'xy-hyper-loader',
            category = 'electromagnetics',
            energy_required = 2,
            enabled = false,
            ingredients = {
                {type = 'item', name = 'planetaris-hyper-transport-belt', amount = 1},
                {type = 'item', name = 'kr-advanced-loader', amount = 2},
                {type = 'item', name = 'planetaris-raw-diamond', amount = 3},
                {type = 'item', name = 'planetaris-silica', amount = 4},
            },
            results = {{type = 'item', name = 'xy-hyper-loader', amount = 1}}
        },
        {
            type = 'item',
            name = 'xy-hyper-loader',
            icon = '__xy-k2so-enhancements-nulls-fork__/icons/hyper-loader.png',
            subgroup = 'belt',
            order = 'd[loader]-a5[xy-hyper-loader]',
            place_result = 'xy-hyper-loader',
            stack_size = 50,
            weight = 40*kg,
        },
        {
            type = 'loader-1x1',
            name = 'xy-hyper-loader',
            icon = '__xy-k2so-enhancements-nulls-fork__/icons/hyper-loader.png',
            flags = {'placeable-neutral', 'player-creation'},
            minable = {mining_time = .25, result = 'xy-hyper-loader'},
            fast_replaceable_group = 'transport_belt',
            collision_box = { { -0.4, -0.45 }, { 0.4, 0.45 } },
            selection_box = { { -0.5, -0.5 }, { 0.5, 0.5 } },
            max_belt_stack_size = 4,
            adjustable_belt_stack_size = true,
            container_distance = 0.75,
            filter_count = 5,
            energy_source = {
                type = "electric",
                usage_priority = "secondary-input",
                drain = "1.25kW",
            },
            speed = 0.15625,
            energy_per_item = "9kJ",
            max_health = 300,
            heating_energy = "50kW",
            corpse = "small-remnants",
            resistances = { { type = "fire", percent = 90 } },
            open_sound = sounds.machine_open,
            close_sound = sounds.machine_close,
            belt_animation_set = belt_anim,
            animation_speed_coefficient = 32,
            icon_draw_specification = {scale = 0.7},
            structure = loader_graphics.structure({250,250,250}),
            structure_render_layer = loader_graphics.structure_render_layer,
            circuit_wire_max_distance = default_circuit_wire_max_distance,
        }
    })
    table.insert(data.raw.technology['planetaris-hyper-transport-belt'].effects, {type = 'unlock-recipe', recipe = 'xy-hyper-loader'})
    util.replace_ingred_name('kr-superior-loader', 'kr-advanced-loader', 'xy-hyper-loader')
    data.raw.item['kr-superior-loader'].order = 'd[loader]-a6[kr-superior-loader]'
end