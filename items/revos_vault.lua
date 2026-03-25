SMODS.Joker({
	key = "spin",
	atlas = "Jokers2",
	rarity = 1,
	cost = 5,
	unlocked = true,
	discovered = false,
	blueprint_compat = false,
	always_buyable = true,
	pos = {
		x = 3,
		y = 9,
	},
	config = {
		extra = {},
	},
	loc_vars = function(self, info_queue, card)
		return {
			vars = {},
		}
	end,
	add_to_deck = function(self, card, from_debuff)
		G.jokers.config.card_limit = G.jokers.config.card_limit + 1
	end,
	remove_from_deck = function(self, card, from_debuff)
		G.jokers.config.card_limit = G.jokers.config.card_limit - 1
	end,

	calculate = function(self, card, context)
		if context.individual and context.cardarea == G.play then
			if context.other_card then
				context.other_card:flip()
				context.other_card:flip()
			end
		end
	end,
	in_pool = function(self, args)
		return false
	end,
})
