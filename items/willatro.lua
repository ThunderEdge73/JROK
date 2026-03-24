-- Willow

SMODS.Joker({
	key = "jetfish",
	stolen_from = "Willatro",
	rarity = 2,
	atlas = "stolen",
	pos = { x = 3, y = 0 },
	cost = 6,
	blueprint_compat = true,
	perishable_compat = false,
	config = {
		extra = {
			mult_gain = 3,
			mult = 0,
		},
	},
	loc_vars = function(self, info_queue, card)
		return {
			vars = {
				card.ability.extra.mult_gain,
				card.ability.extra.mult,
			},
		}
	end,
	calculate = function(self, card, context)
		local unscoring = false
		if context.before and context.main_eval and not context.blueprint then
			if #context.full_hand ~= #context.scoring_hand then
				unscoring = true
			end

			if unscoring then
				local last_mult = card.ability.extra.mult
				card.ability.extra.mult = 0
				if last_mult > 0 then
					return {
						message = localize("k_reset"),
					}
				end
			else
				card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.mult_gain
			end
		end
		if context.joker_main then
			return {
				mult = card.ability.extra.mult,
			}
		end
	end,
})

SMODS.Joker({
	key = "cobbler",
	rarity = 1,
	atlas = "stolen",
	stolen_from = "Willatro",
	pos = { x = 4, y = 0 },
	cost = 6,
	blueprint_compat = true,
	eternal_compat = false,
	config = {
		extra = {
			mult_gain = 5,
			mult = 0,
			max_mult = 40,
		},
	},
	loc_vars = function(self, info_queue, card)
		return {
			vars = {
				card.ability.extra.mult_gain,
				card.ability.extra.mult,
				card.ability.extra.max_mult,
			},
		}
	end,
	calculate = function(self, card, context)
		if context.end_of_round and context.game_over == false and context.main_eval and not context.blueprint then
			card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.mult_gain

			if card.ability.extra.mult >= card.ability.extra.max_mult then
				G.E_MANAGER:add_event(Event({
					func = function()
						play_sound("tarot1")
						card.T.r = -0.2
						card:juice_up(0.3, 0.4)
						card.states.drag.is = true
						card.children.center.pinch.x = true
						G.E_MANAGER:add_event(Event({
							trigger = "after",
							delay = 0.3,
							blockable = false,
							func = function()
								card:remove()
								return true
							end,
						}))
						return true
					end,
				}))
				return {
					message = localize("k_eaten_ex"),
				}
			else
				return {
					message = localize({ type = "variable", key = "a_mult", vars = { card.ability.extra.mult_gain } }),
					colour = G.C.MULT,
				}
			end
		end
		if context.joker_main then
			return {
				mult = card.ability.extra.mult,
			}
		end
	end,
})
