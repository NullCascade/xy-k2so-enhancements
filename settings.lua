data:extend({
    --- Fixes!
    {
        type = 'bool-setting',
        name = 'xy-paracelsin-tech-card',
        setting_type = 'startup',
        default_value = true,

        order = '1-parac',
        hidden = true,

        localised_name = {'mod-setting-name.xy-paracelsin-tech-card'},
    },
    {
        type = 'bool-setting',
        name = 'xy-secretas-tech-card',
        setting_type = 'startup',
        default_value = true,

        order = '1-secre',
        hidden = true,

        localised_name = {'mod-setting-name.xy-secretas-tech-card'},
    },
    {
        type = 'bool-setting',
        name = 'xy-corrundum-tech-card',
        setting_type = 'startup',
        default_value = true,
        hidden = true,

        order = '1-corru',

        localised_name = {'mod-setting-name.xy-corrundum-tech-card'},
    },
    --- Maraxsis
    {
        type = 'bool-setting',
        name = 'xy-hydro-plant-runs-fuel-ref-recipes',
        setting_type = 'startup',
        default_value = true,

        order = 'marax-a',

        localised_name = {'mod-setting-name.xy-hydro-plant-runs-fuel-ref-recipes'},
    },
    {
        type = 'bool-setting',
        name = 'xy-maraxsis-moshine-connection',
        setting_type = 'startup',
        default_value = false,

        order = 'marax-b',

        localised_name = {'mod-setting-name.xy-maraxsis-moshine-connection'},
        localised_description = {'mod-setting-description.xy-maraxsis-moshine-connection'},
    },
    --- Moshine
    {
        type = 'bool-setting',
        name = 'xy-moshine-connection-length',
        setting_type = 'startup',
        default_value = true,

        order = 'mosh-a',

        localised_name = {'mod-setting-name.xy-moshine-connection-length'},
        localised_description = {'mod-setting-description.xy-moshine-connection-length'},
    },
    --- Muluna
    --- Paracelsin
    {
        type = 'bool-setting',
        name = 'xy-paracelsin-tech-card-endgame',
        setting_type = 'startup',
        default_value = true,

        order = 'parac-a',

        localised_name = {'mod-setting-name.xy-paracelsin-tech-card-endgame'},
        localised_description = {'mod-setting-description.xy-paracelsin-tech-card-endgame'},
    },
    {
        type = 'bool-setting',
        name = 'xy-adv-chem-plant-rebalance',
        setting_type = 'startup',
        default_value = true,

        order = 'parac-b',

        localised_name = {'mod-setting-name.xy-adv-chem-plant-rebalance'},
        localised_description = {'mod-setting-description.xy-adv-chem-plant-rebalance'},
    },
    {
        type = 'bool-setting',
        name = 'xy-mechanical-plant-more-recipes',
        setting_type = 'startup',
        default_value = true,

        order = 'parac-c',

        localised_name = {'mod-setting-name.xy-mechanical-plant-more-recipes'},
    },
    --- Planetaris: Arig
    {
        type = 'bool-setting',
        name = 'xy-arig-belts',
        setting_type = 'startup',
        default_value = true,

        order = 'taris-arig-a',

        localised_name = {'mod-setting-name.xy-arig-belts'},
        localised_description = {'mod-setting-description.xy-arig-belts'},
    },
    --- Secretas
    {
        type = 'bool-setting',
        name = 'xy-secretas-polish',
        setting_type = 'startup',
        default_value = true,

        order = 'secre-a',

        localised_name = {'mod-setting-name.xy-secretas-polish'},
        localised_description = {'mod-setting-description.xy-secretas-polish'},
    },
    --- General - Technology ---
    {
        type = 'bool-setting',
        name = 'xy-tech-inflation',
        setting_type = 'startup',
        default_value = false,

        order = 'x-a-tech-0',

        localised_name = {'mod-setting-name.xy-tech-inflation'},
        localised_description = {'mod-setting-description.xy-tech-inflation'},
    },
    {
        type = 'string-setting',
        name = 'xy-tech-inflation-scale',
        setting_type = 'startup',
        default_value = '100%',
        allowed_values = {'25%','50%','75%','100%','150%','200%'},

        order = 'x-a-tech-1',

        localised_name = {'mod-setting-name.xy-tech-inflation-scale'},
        localised_description = {'mod-setting-description.xy-tech-inflation-scale'},
    },
    {
        type = 'bool-setting',
        name = 'xy-advanced-tank-expensive-research',
        setting_type = 'startup',
        default_value = false,

        order = 'x-a-tech-a',

        localised_name = {'mod-setting-name.xy-advanced-tank-expensive-research'},
        localised_description = {'mod-setting-description.xy-advanced-tank-expensive-research'},
    },
    --- General - Recipes
    {
        type = 'bool-setting',
        name = 'xy-lab-recipe-changes',
        setting_type = 'startup',
        default_value = true,

        order = 'x-b-recipes-a',

        localised_name = {'mod-setting-name.xy-lab-recipe-changes'},
        localised_description = {'mod-setting-description.xy-lab-recipe-changes'},
    },
    {
        type = 'bool-setting',
        name = 'xy-processing-unit-alt',
        setting_type = 'startup',
        default_value = true,

        order = 'x-b-recipes-b',

        localised_name = {'mod-setting-name.xy-processing-unit-alt'},
        localised_description = {'mod-setting-description.xy-processing-unit-alt'},
    },
    {
        type = 'bool-setting',
        name = 'xy-spidertron-fish',
        setting_type = 'startup',
        default_value = false,

        order = 'x-b-recipes-z',

        localised_name = {'mod-setting-name.xy-spidertron-fish'},
    },
    --- General - Misc.
    {
        type = 'bool-setting',
        name = 'xy-item-weight',
        setting_type = 'startup',
        default_value = true,

        order = 'x-x-misc-a',

        localised_name = {'mod-setting-name.xy-item-weight'},
        localised_description = {'mod-setting-description.xy-item-weight'},
    },
    {
        type = 'bool-setting',
        name = 'xy-move-lab-category',
        setting_type = 'startup',
        default_value = true,

        order = 'x-x-misc-b',

        localised_name = {'mod-setting-name.xy-move-lab-category'},
        localised_description = {'mod-setting-description.xy-move-lab-category'},
    },
    {
        type = 'bool-setting',
        name = 'xy-advanced-centrifuge-rebalance',
        setting_type = 'startup',
        default_value = true,

        order = 'x-x-misc-c',

        localised_name = {'mod-setting-name.xy-advanced-centrifuge-rebalance'},
        localised_description = {'mod-setting-description.xy-advanced-centrifuge-rebalance'},
    },
})