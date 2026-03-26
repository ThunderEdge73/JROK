SMODS.Joker({
	key = "jokerton",
	atlas = "stolen",
	stolen_from = "WaffleMod",
	pos = { x = 8, y = 6 },
	config = {
		extra = {
			discard_requirement = 5,
			discards_remaining = 5,
			is_juicing = false,
			conv_enhancement = "m_steel",
		},
	},
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = G.P_CENTERS[card.ability.extra.conv_enhancement]
		return {
			vars = {
				card.ability.extra.discard_requirement,
				card.ability.extra.discards_remaining,
			},
		}
	end,
	blueprint_compat = false,
	rarity = 2,
	cost = 5,
	calculate = function(self, card, context)
		local extra = card.ability.extra
		if context.discard and context.other_card:is_suit("Hearts") then
			extra.discards_remaining = math.max(extra.discards_remaining - 1, 0)
			if extra.discards_remaining == 0 and not extra.is_juicing then
				G.E_MANAGER:add_event(Event({
					func = function()
						SMODS.calculate_effect({
							message = localize("k_active_ex"),
							colour = G.C.FILTER,
						}, card)
						local eval = function(card)
							return not extra.is_juicing
						end
						juice_card_until(card, eval, true)
						extra.is_juicing = true
						return true
					end,
				}))
			end
		end
		if extra.is_juicing and context.before then
			if context.scoring_hand and context.scoring_hand[1] then
				G.E_MANAGER:add_event(Event({
					func = function()
						local convCard = context.scoring_hand[1]
						convCard:set_ability(extra.conv_enhancement)
						convCard:juice_up()
						extra.is_juicing = false
						extra.discards_remaining = 10
						return true
					end,
				}))
				return {
					message = localize("k_jrok_steel"),
					colour = G.C.FILTER,
				}
			end
		end
	end,
	in_pool = function(self, args)
		return false
	end,
})

SMODS.Joker({
	key = "fountain",
	atlas = "stolen",
	pos = { x = 7, y = 6 },
	stolen_from = "WaffleMod",
	config = { extra = {
		dollars = 3,
	} },
	cost = 5,
	in_pool = function(self, args)
		return false
	end,
	loc_vars = function(self, info_queue, card)
		return {
			vars = {
				G.GAME.probabilities.normal or 1,
				card.ability.extra.dollars,
			},
		}
	end,
	calculate = function(self, card, context)
		if
			context.individual
			and context.cardarea == G.play
			and SMODS.has_no_rank(context.other_card) ~= true -- Stone cards have no rank and thus should not count for this
			and SMODS.pseudorandom_probability(card, "wafflemod_fountain_roll", 1, context.other_card.base.nominal)
		then
			G.GAME.dollar_buffer = (G.GAME.dollar_buffer or 0) + card.ability.extra.dollars
			return {
				dollars = card.ability.extra.dollars,
				func = function()
					G.E_MANAGER:add_event(Event({
						func = function()
							G.GAME.dollar_buffer = 0
							return true
						end,
					}))
				end,
			}
		end
	end,
})
