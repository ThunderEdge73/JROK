SMODS.Joker({
	key = "spin",
	atlas = "stolen",
	stolen_from = "Revo's Vault",
	rarity = 1,
	cost = 5,
	unlocked = true,
	discovered = false,
	blueprint_compat = false,
	pos = {
		x = 4,
		y = 5,
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

SMODS.Joker({
	key = "grosdish",
    stolen_from = "Revo's Vault",
	atlas = "stolen",
	no_pool_flag = "groex",
	rarity = 2,
	cost = 6,
	unlocked = true,
	discovered = false,
	blueprint_compat = true,
	perishable_compat = false,
	pos = {
		x = 5,
		y = 5,
	},
	config = {
		extra = {
			chips = 120,
			odds = 6,
		},
	},
	loc_vars = function(self, info_queue, card)
		local cae = card.ability.extra
		local num, den = SMODS.get_probability_vars(card, 1, cae.odds, "grosdish_seed")
		return {
			vars = { card.ability.extra.chips, num, den },
		}
	end,
	calculate = function(self, card, context)
		local crv = card.ability.extra
		if context.joker_main then
			return {
				chips = crv.chips,
			}
		end
		if
			context.end_of_round
			and not context.blueprint
			and context.main_eval
			and SMODS.pseudorandom_probability(card, "gros_seed", 1, crv.odds)
		then
			G.E_MANAGER:add_event(Event({
				func = function()
					play_sound("tarot1")
					card.T.r = -0.2
					card:juice_up(0.3, 0.4)
					card.states.drag.is = true
					card.children.center.pinch.x = true
					G.E_MANAGER:add_event(Event({
						trigger = "after",
						delay = 1.5,
						blockable = false,
						func = function()
							G.jokers:remove_card(card)
							card:remove()
							card = nil
							return true
						end,
					}))
					G.GAME.pool_flags.groex = true
					return true
				end,
			}))
			return {
				message = localize("k_extinct_ex"),
				delay(0.6),
			}
		end
	end,
	in_pool = function(self, args)
		return false
	end,
})
