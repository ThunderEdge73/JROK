SMODS.Joker({
	key = "the_halo",
	pos = { x = 0, y = 0 },
	config = { extra = { chips = 20, mult = 3, money = 1 } },
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.chips, card.ability.extra.mult, card.ability.extra.money } }
	end,
	rarity = 1,
	cost = 5,
	atlas = "jokers",
	perishable_compat = true,
	eternal_compat = true,
	blueprint_compat = true,
	calculate = function(self, card, context)
		if context.joker_main then
			return {
				chips = card.ability.extra.chips,
				mult = card.ability.extra.mult,
			}
		end
	end,
	calc_dollar_bonus = function(self, card)
		return card.ability.extra.money
	end,
	in_pool = function(self, args)
		return false
	end,
})

SMODS.Joker({
	key = "holy_water",
	pos = { x = 1, y = 0 },
	config = { extra = { chips = 4 } },
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.chips } }
	end,
	rarity = 2,
	cost = 5,
	atlas = "jokers",
	perishable_compat = true,
	eternal_compat = true,
	blueprint_compat = true,
	calculate = function(self, card, context)
		if context.individual and context.cardarea == G.hand and not context.end_of_round then
			context.other_card.ability.perma_bonus = (context.other_card.ability.perma_bonus or 0)
				+ card.ability.extra.chips
			return {
				message = localize("k_upgrade_ex"),
			}
		end
	end,
	in_pool = function(self, args)
		return false
	end,
})
