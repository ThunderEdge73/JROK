SMODS.Joker({
	key = "stereom",
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.mult } }
	end,
	config = { extra = { mult = 2 } },
	stolen_from = "Balatro Dash",
	in_pool = function (self, args)
		return false
	end,
	rarity = 1,
	unlocked = true,
	blueprint_compat = true,
	mainlevel = true,
	firstrelease = true,
	atlas = "stolen",
	pos = { x = 2, y = 8 },
	cost = 4,
	calculate = function(self, card, context)
		if context.individual and context.cardarea == G.play then
			return {
				mult = card.ability.extra.mult,
			}
		end
	end,
})

SMODS.Joker({
	key = "dryout",
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.mult_mod, card.ability.extra.mult } }
	end,
	config = { extra = { mult = 0, mult_mod = 5 } },
	rarity = 2,
	unlocked = true,
	discovered = true,
	blueprint_compat = true,
	stolen_from = "Balatro Dash",
	in_pool = function (self, args)
		return false
	end,
	atlas = "stolen",
	pos = { x = 3, y = 8 },
	cost = 8,
	calculate = function(self, card, context)
		if context.setting_blind and not context.blueprint and not context.retrigger_joker then
			card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.mult_mod
		end
		if context.joker_main then
			return {
				mult = card.ability.extra.mult,
			}
		end
		if context.selling_card and context.cardarea == G.jokers then
			card.ability.extra.mult = 0
            return {
                message = localize("k_reset")
            }
		end
	end,
})
