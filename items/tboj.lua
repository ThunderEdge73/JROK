SMODS.Joker({
	key = "spoon_bender",
	pos = { x = 0, y = 0 },
	config = { extra = { Xmult_multi = 2 } },
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.Xmult_multi } }
	end,
	rarity = 3,
	cost = 8,
	atlas = "jokers",
	perishable_compat = true,
	eternal_compat = true,
	blueprint_compat = true,
	calculate = function(self, card, context)
		if context.cardarea == "unscored" and context.individual then
			return {
				colour = G.C.MULT,
				Xmult = card.ability.extra.Xmult_multi,
			}
		end
	end,
	in_pool = function(self, args)
		return false
	end,
})

SMODS.Joker({
	key = "charm_of_the_vampire",
	pos = { x = 1, y = 0 },
	config = { extra = { mult = 0, mult_mod = 3 } },
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.mult_mod, card.ability.extra.mult } }
	end,
	rarity = 1,
	cost = 5,
	atlas = "jokers",
	perishable_compat = false,
	eternal_compat = true,
	blueprint_compat = true,
	calculate = function(self, card, context)
		if context.joker_main then
			return {
				mult = card.ability.extra.mult,
			}
		end
		if context.end_of_round and context.game_over == false and context.main_eval and not context.blueprint then
			SMODS.scale_card(card, {
				ref_value = "mult",
				scalar_value = "mult_mod",
			})
		end
	end,
	in_pool = function(self, args)
		return false
	end,
})
