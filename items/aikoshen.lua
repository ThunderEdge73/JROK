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
                    HEX("68211d")
                }
			},
		}
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
