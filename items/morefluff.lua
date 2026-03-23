SMODS.Joker({
	key = "philosophical",
	config = {
		card_limit = 1,
	},
	atlas = "stolen",
	pos = { x = 2, y = 1 },
	rarity = 1,
	cost = 1,
	unlocked = true,
	discovered = true,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = false,
	loc_vars = function(self, info_queue, center)
		return {
			vars = { center.ability.card_limit },
		}
	end,
})

SMODS.Joker({
	key = "basepaul",
	config = {
		extra = { x_mult = 1.25 },
	},
	atlas = "stolen",
	pos = { x = 3, y = 1 },
	rarity = 1,
	cost = 5,
	unlocked = true,
	discovered = true,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	demicoloncompat = true,
	loc_vars = function(self, info_queue, center)
		return {
			vars = { center.ability.extra.x_mult, center.ability.extra.x_mult * 10 },
		}
	end,
	calculate = function(self, card, context)
		if context.forcetrigger or context.joker_main then
			if string.find(string.lower(G.PROFILES[G.SETTINGS.profile].name), "paul") then
				return {
					message = localize({
						type = "variable",
						key = "a_xmult",
						vars = {
							card.ability.extra.x_mult * 10,
						},
					}),
					Xmult_mod = card.ability.extra.x_mult * 10,
				}
			else
				return {
					message = localize({
						type = "variable",
						key = "a_xmult",
						vars = {
							card.ability.extra.x_mult,
						},
					}),
					Xmult_mod = card.ability.extra.x_mult,
				}
			end
		end
	end,
})
