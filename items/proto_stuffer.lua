SMODS.Joker({
	key = "slop_moist",
	stolen_from = "Stocking Stuffer",
	atlas = "stolen",
	pos = { x = 7, y = 4 },
	rarity = 2,
	cost = 10,
	discovered = true,
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = G.P_CENTERS.e_foil
	end,
	in_pool = function(self, args)
		return false
	end,
	calculate = function(self, card, context)
		if context.selling_self then
			-- do stuff here
			local cards = {}
			for i = 1, #G.jokers.cards do
				if G.jokers.cards[i].ability.perishable or G.jokers.cards[i].debuff then
					table.insert(cards, i)
				end
			end
			if #cards >= 1 then
				local thing = pseudorandom_element(cards, "remove debuffs")
				G.jokers.cards[thing].ability.perishable = false
				G.jokers.cards[thing].ability.debuff = false
			else
				local smelly = pseudorandom_element(G.jokers.cards, "make it scented")
				local scent = pseudorandom_element({ "e_foil", "e_polychrome", "e_negative" }, "scent to apply")
				smelly:set_edition(scent)
			end
		end
	end,
})

SMODS.Joker({
	key = "slop_vulpix",
	stolen_from = "Stocking Stuffer",
	atlas = "stolen",
	pos = { x = 8, y = 4 },
	cost = 8,
	rarity = 2,
	discovered = true,
	config = {
		extra = {
			numer1 = 1,
			denom1 = 4,
			numer2 = 2,
			denom2 = 11,
			handQ = 0,
		},
	},
	loc_vars = function(self, info_queue, card)
		local numer1, denom1 =
			SMODS.get_probability_vars(card, card.ability.extra.numer1, card.ability.extra.denom1, "planet sold")
		local numer2, denom2 =
			SMODS.get_probability_vars(card, card.ability.extra.numer2, card.ability.extra.denom2, "lost discard")
		return { vars = { numer1, denom1, numer2, denom2 } }
	end,
	in_pool = function(self, args)
		return false
	end,
	calculate = function(self, card, context)
		local ret = {}
		if context.selling_card and context.card.ability.set == "Planet" then
			if
				G.STATE ~= G.STATES.SELECTING_HAND
				and SMODS.pseudorandom_probability(
					card,
					"shoutouts to aroace vulpienbies",
					card.ability.extra.numer1,
					card.ability.extra.denom1,
					"planet sold"
				)
			then
				G.GAME.proot_psold = true
				card.ability.extra.handQ = card.ability.extra.handQ + 1
				if card.ability.extra.handQ >= 3 then
					ret.sound = "chips" .. (card.ability.extra.handQ % 2) + 1
				end
				ret.message = localize("proot_yep")
				ret.colour = G.C.GREEN
				ret.extra = {}
				ret.extra.message = "+" .. card.ability.extra.handQ
				return ret
			else
				ret.message = localize("k_nope_ex")
				ret.colour = G.C.SECONDARY_SET.Tarot
				return ret
			end
			if G.STATE == G.STATES.SELECTING_HAND then
				G.GAME.proot_psold = true
				if
					SMODS.pseudorandom_probability(
						card,
						"shoutouts to aroace vulpienbies",
						card.ability.extra.numer1,
						card.ability.extra.denom1,
						"planet sold"
					)
				then
					G.GAME.current_round.hands_left = G.GAME.current_round.hands_left + 1
					ret.message = localize({ type = "variable", key = "a_hands", vars = { 1 } })
					return ret
				else
					ret.message = localize("k_nope_ex")
					ret.colour = G.C.SECONDARY_SET.Tarot
					return ret
				end
			end
		end

		if context.setting_blind then
			if G.GAME.proot_psold then
				G.GAME.current_round.hands_left = G.GAME.current_round.hands_left + card.ability.extra.handQ
				ret.message = localize({ type = "variable", key = "a_hands", vars = { card.ability.extra.handQ } })
				card.ability.extra.handQ = 0
				return ret
			end
		end

		if context.joker_main and G.GAME.proot_psold then
			if
				SMODS.pseudorandom_probability(
					card,
					"*paws at you- paws at you- paws at y-*",
					card.ability.extra.numer2,
					card.ability.extra.denom2,
					"lost discard"
				)
			then
				ease_discard(-1, nil, nil)
				card:juice_up()
			end
		end

		if context.end_of_round then
			G.GAME.proot_psold = nil
		end
	end,
})
