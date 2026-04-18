if not mods['planetaris-arig'] then return end
local util = require('util.util')
local loader_graphics = require('__Krastorio2-spaced-out__.prototypes.buildings.loader-graphics')
local sounds = require("__base__.prototypes.entity.sounds")

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
