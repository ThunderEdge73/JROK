SMODS.Joker({
	key = "pissandshittium",
	atlas = "stolen",
	pos = {
		x = 7,
		y = 7,
	},
	rarity = 1,
	stolen_from = "Aikoyori's Shenanigans",
	cost = 2,
	config = {
		extras = {
			mult = 6,
			eeemult = 0.1,
		},
	},
	loc_vars = function(self, info_queue, card)
		return {
			vars = {
				card.ability.extras.mult,
				colours = {
					HEX("68211d"),
				},
			},
		}
	end,
	in_pool = function(self, args)
		return false
	end,
	calculate = function(self, card, context)
		if context.joker_main then
			return {
				message = localize("k_jrok_pissandshittium"),
				colour = HEX("68211d"),
				mult = card.ability.extras.mult,
			}
		end
	end,
	blueprint_compat = true,
})

SMODS.Joker({
	atlas = "stolen",
	key = "ash_joker",
	pos = {
		x = 8,
		y = 7,
	},
	rarity = 1,
	cost = 0,
	stolen_from = "Aikoyori's Shenanigans",
	in_pool = function(self, args)
		return false
	end,
	config = {
		extras = {
			chips = 35,
			chips_gain = 15,
			odds = 4,
		},
	},
	loc_vars = function(self, info_queue, card)
		local n, d = SMODS.get_probability_vars(card, 1, card.ability.extras.odds, "jrok_ash_joker")
		return {
			vars = {
				card.ability.extras.chips,
				n,
				d,
				card.ability.extras.chips_gain,
			},
		}
	end,
	calculate = function(self, card, context)
		if context.joker_main or context.forcetrigger then
			return { chips = card.ability.extras.chips }
		end
		if context.end_of_round and context.cardarea == G.jokers then
			if SMODS.pseudorandom_probability(card, "jrok_ash_joker", 1, card.ability.extras.odds) then
				SMODS.destroy_cards(card, nil, nil, true)
			else
				SMODS.scale_card(
					card,
					{ ref_table = card.ability.extras, ref_value = "chips", scalar_value = "chips_gain" }
				)
			end
		end
	end,
	demicoloncompat = true,
})
