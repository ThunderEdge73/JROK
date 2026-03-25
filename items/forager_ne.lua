-- J8-Bit

SMODS.Joker({
	key = "kitsune_mask",
    stolen_from = "Forager Nonessentials",
	blueprint_compat = true,
	perishable_compat = true,
	eternal_compat = true,
	rarity = 2,
	cost = 7,
	atlas = "stolen",
	pos = { x = 4, y = 4 },
	discovered = false,
	unlocked = true,
	config = { extra = { odds = 7 } },
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = G.P_CENTERS.m_lucky
		local numerator, denominator =
			SMODS.get_probability_vars(card, 1, card.ability.extra.odds, "j8mod_kitsune_mask")
		return {
			vars = {
				numerator,
				denominator,
				localize("7", "ranks"),
				localize("k_spectral"),
				localize({ type = "name_text", set = "Enhanced", key = "m_lucky" }),
			},
		}
	end,
	calculate = function(self, card, context)
		if
			context.individual
			and context.cardarea == G.play
			and #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit
		then
			if
				(context.other_card:get_id() == 7)
				and (
					SMODS.pseudorandom_probability(
						card,
						"j8mod_kitsune_mask",
						SMODS.has_enhancement(context.other_card, "m_lucky") and 2 or 1,
						card.ability.extra.odds
					)
				)
			then
				G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
				return {
					extra = {
						message = localize("k_plus_spectral"),
						colour = G.C.SECONDARY_SET.Spectral,
						message_card = context.blueprint_card or card,
						func = function() -- This is for timing purposes, everything here runs after the message
							G.E_MANAGER:add_event(Event({
								func = function()
									SMODS.add_card({
										set = "Spectral",
										key_append = "k_plus_spectral", -- Optional, useful for manipulating the random seed and checking the source of the creation in `in_pool`.
									})
									G.GAME.consumeable_buffer = 0
									return true
								end,
							}))
						end,
					},
				}
			end
		end
	end,
	in_pool = function(self, args)
		return false
	end,
})

SMODS.Joker({
	key = "thrift_shop",
    stolen_from = "Forager Nonessentials",
	blueprint_compat = true,
	perishable_compat = true,
	eternal_compat = true,
	rarity = 2,
	cost = 7,
	atlas = "stolen",
	pos = { x = 3, y = 4 },
	discovered = false,
	unlocked = true,
	config = { extra = { odds = 6 } },
	loc_vars = function(self, info_queue, card)
		local numerator, denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, "j8mod_thrift_shop")
		return { vars = { numerator, denominator } }
	end,
	in_pool = function(self, args)
		return false
	end,
	calculate = function(self, card, context)
		if context.reroll_shop then
			if SMODS.pseudorandom_probability(card, "j8mod_thrift_shop", 1, card.ability.extra.odds) then
				return {
					message = localize("j8mod_tagged_ex"),
					colour = G.C.GREEN,
					func = function()
						G.E_MANAGER:add_event(Event({
							trigger = "immediate",
							func = function()
								--- Credits to Eremel
								local tag_pool = get_current_pool("Tag")
								local selected_tag = pseudorandom_element(tag_pool, "j8mod_thrift_shop")
								local it = 1
								while selected_tag == "UNAVAILABLE" do
									it = it + 1
									selected_tag = pseudorandom_element(tag_pool, "j8mod_thrift_shop_resample" .. it)
								end
								local tag = Tag(selected_tag)
								if tag.name == "Orbital Tag" then
									local _poker_hands = {}
									for k, v in pairs(G.GAME.hands) do
										if v.visible then
											_poker_hands[#_poker_hands + 1] = k
										end
									end
									tag.ability.orbital_hand =
										pseudorandom_element(_poker_hands, "j8mod_thrift_shop_orbital_tag")
								end
								tag:set_ability()
								add_tag(tag)
								return true
							end,
						}))
						return true
					end,
				}
			end
		end
	end,
})
