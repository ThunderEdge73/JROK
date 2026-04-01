SMODS.Joker({
	key = "mcbedrock",
	name = "Minecraft Bedrock",
	object_type = "Joker",
    stolen_from = "neonflame",
    in_pool = function (self, args)
        return false
    end,
	atlas = "stolen",
	pos = { x = 3, y = 4 },
	pools = { minecraft = true },

	config = { extra = { chance = 4, chip = 5, mult = 1 } },
	rarity = 1,
	cost = 3,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = false,
	demicolon_compat = true,

	loc_vars = function(self, info_queue, card)
		local num, den = SMODS.get_probability_vars(card, 1, card.ability.extra.chance, "nflame_mcbedrock")
		return { vars = { num, den, card.ability.extra.chip, card.ability.extra.mult } }
	end,

	calculate = function(self, card, context)
		if
			context.initial_scoring_step
			and not context.blueprint
			and SMODS.pseudorandom_probability(card, "nflame_mcbedrock", 1, card.ability.extra.chance)
		then
			card.ability.extra.chip = card.ability.extra.chip + hand_chips
			card.ability.extra.mult = card.ability.extra.mult + mult

			return { mult_mod = -mult, chip_mod = -hand_chips, message = localize("k_upgrade_ex") }
		end

		if context.joker_main or context.forcetrigger then
			return { chips = card.ability.extra.chip, mult = card.ability.extra.mult }
		end
	end,
})
