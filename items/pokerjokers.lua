SMODS.Joker({
	key = "trash_bin",
	config = { extra = { mult = 1 } },
	rarity = 1,
	atlas = "stolen",
	pos = { x = 0, y = 7 },
	cost = 5,
	blueprint_compat = true,
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.mult, card.ability.extra.mult * (G.discard and #G.discard.cards or 0) } }
	end,
	calculate = function(self, card, context)
		if context.joker_main then
			return {
				mult = card.ability.extra.mult * #G.discard.cards,
			}
		end
	end,
    stolen_from = "PokerJokers",
    in_pool = function(self, args)
        return false
    end,
})
