SMODS.Joker({
	key = "sora",
	loc_vars = function(self, info_queue, card)
		return {
			vars = {
				card.ability.extra.x_mult, --1
				card.ability.extra.Xmult_gain, --2
			},
		}
	end,
	stolen_from = "Final Mix",
	rarity = 3,
	atlas = "stolen",
	pos = { x = 9, y = 0 },
	cost = 7,
	discovered = true,
	blueprint_compat = true,
	config = {
		extra = {
			x_mult = 1,
			Xmult_gain = 0.2,
		},
	},
	calculate = function(self, card, context)
		if context.individual and context.cardarea == G.play and not context.blueprint then
			if context.other_card:is_suit("Hearts") then
				SMODS.scale_card(card, {
					ref_table = card.ability.extra,
					ref_value = "x_mult",
					scalar_value = "Xmult_gain",
					operation = "+",
				})
			end
		end
		if context.joker_main and card.ability.extra.x_mult > 1 then
			return {
				x_mult = card.ability.extra.x_mult,
			}
		end
		if context.end_of_round and context.game_over == false and context.main_eval and not context.blueprint then
			if context.beat_boss then
				card.ability.extra.x_mult = 1
				return {
					message = localize("k_reset"),
					colour = G.C.RED,
				}
			end
		end
	end,
})

SMODS.Joker({
	key = "paopufruit",
	loc_vars = function(self, info_queue, card)
		return {
			vars = {
				card.ability.extra.hands_left, -- 1
			},
		}
	end,
	stolen_from = "Final Mix",
	rarity = 2,
	atlas = "stolen",
	pos = { x = 9, y = 1 },
	cost = 6,
	discovered = true,
	blueprint_compat = true,
	config = {
		extra = {
			hands_left = 5,
		},
	},
	calculate = function(self, card, context)
		if context.before and not context.blueprint then
			local first_card = context.scoring_hand[1]
			local edition = poll_edition("kh_paopufruit", nil, true, true, { "e_polychrome", "e_holo", "e_foil" })
			local random_seal = SMODS.poll_seal({ key = "kh_seed", guaranteed = true })
			local enhancement = SMODS.poll_enhancement({ key = "kh_seed", guaranteed = true })
			first_card:set_edition(edition, true)
			first_card:set_seal(random_seal, true)
			first_card:set_ability(enhancement, true)
		end

		if context.after and not context.blueprint then
			if card.ability.extra.hands_left - 1 <= 0 then
				SMODS.destroy_cards(card, nil, nil, true)
				SMODS.calculate_effect({ message = localize("kh_riku_no"), colour = G.C.FILTER }, card)
			else
				card.ability.extra.hands_left = card.ability.extra.hands_left - 1
				return {
					message = card.ability.extra.hands_left .. "",
					colour = G.C.FILTER,
				}
			end
		end
	end,
})
