-- Axyraandas

SMODS.Joker({
	key = "tony",
	stolen_from = "Berry's Legendaries",
	atlas = "stolen",
	rarity = 4,
	pos = { x = 6, y = 1 },
	soul_pos = { x = 7, y = 1 },
	cost = 20,
	blueprint_compat = true,
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = G.P_CENTERS.e_negative
		info_queue[#info_queue + 1] = G.P_CENTERS.e_foil
	end,
	calculate = function(self, card, context)
		if context.cardarea ~= G.jokers or not context.before then
			return
		end
		local hasAce = false
		local hasFoiled = false
		for i, v in pairs(context.full_hand) do
			if v:get_id() == 14 then
				hasAce = true
			end
			if v.edition and v.edition.key == "e_foil" then
				hasFoiled = true
			end
			if hasAce and hasFoiled then
				break
			end
		end
		if not hasAce or not hasFoiled then
			return
		end
		G.E_MANAGER:add_event(Event({
			trigger = "after",
			func = function()
				local card = SMODS.add_card({ set = "Spectral", edition = "e_negative", area = G.consumeables })
				return true
			end,
		}))
		return {
			message = localize("k_berry_ex"),
			colour = G.C.BLUE,
			card = card,
		}
	end,
	in_pool = function(self, args)
		return false
	end,
})

SMODS.Joker({
	key = "nyala",
	atlas = "stolen",
	stolen_from = "Berry's Legendaries",
	rarity = 4,
	config = { extra = {
		x_mult = 1,
		x_mult_gain = 0.5,
		ate_card = 0,
	} },
	pos = { x = 9, y = 2 },
	soul_pos = { x = 9, y = 3 },
	cost = 20,
	in_pool = function(self, args)
		return false
	end,
	blueprint_compat = true,
	loc_vars = function(self, info_queue, card)
		return { vars = {
			card.ability.extra.x_mult,
			card.ability.extra.x_mult_gain,
		} }
	end,
	calculate = function(self, card, context)
		if context.joker_main then
			local count = 0
			for _, v in ipairs(G.consumeables.cards) do
				-- Check if planet card is eaten already, or consumable is a planet card to be eaten
				local eat_card = self.config.extra.ate_card == 0 and v.ability.set == "Planet"
				-- Check if current scored hand matches target planet
				eat_card = eat_card
					and (
						next(SMODS.deepfind(v.ability, context.scoring_name, "value", false))
						or (v.label == "cry-sunplanet" and G.GAME.current_round.current_hand.cry_asc_num > 0)
					)
				if eat_card then
					G.E_MANAGER:add_event(Event({
						func = function()
							play_sound("tarot1")
							v.T.r = -0.2
							v:juice_up(0.3, 0.4)
							v.states.drag.is = true
							v.children.center.pinch.x = true
							G.E_MANAGER:add_event(Event({
								trigger = "after",
								delay = 0.3,
								blockable = false,
								func = function()
									G.consumeables:remove_card(v)
									v:remove()
									v = nil

									return true
								end,
							}))
							return true
						end,
					}))
					count = count + 1
				end
			end

			for _ = self.config.extra.ate_card + 1, count do
				G.E_MANAGER:add_event(Event({
					func = function()
						SMODS.add_card({ set = "Spectral", key = "c_black_hole" })
						return true
					end,
				}))
			end

			if count > self.config.extra.ate_card then
				SMODS.calculate_effect({ message = localize("jrok_nom"), colour = HEX("AD7B5C") }, card)
			end
			if self.config.extra.ate_card == 0 then
				self.config.extra.ate_card = count
			end

			return {
				xmult = card.ability.extra.x_mult,
			}
		end

		if context.using_consumeable and context.consumeable.label == "Black Hole" and not context.blueprint then
			card.ability.extra.x_mult = card.ability.extra.x_mult + card.ability.extra.x_mult_gain
			SMODS.calculate_effect({ message = localize("k_upgrade_ex"), colour = G.C.MULT }, card)
		end

		if context.after and self.config.extra.ate_card ~= 0 then
			self.config.extra.ate_card = 0
		end
	end,
})
