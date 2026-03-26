function JROK.count_tarots()
	local tarot_counter = 0
	if G.consumeables then
		for _, card in pairs(G.consumeables.cards) do
			if card.ability.set == "Tarot" then
				tarot_counter = tarot_counter + 1
			end
		end
	end
	return tarot_counter
end

SMODS.Joker({
    key = "ghost",
    stolen_from = "Phanta",
	config = { extra = { xmult = 1 } },
	rarity = 3,
	atlas = "stolen",
	individual_quips = true,
	pos = { x = 3, y = 3 },
	draw = function(self, card, layer)
		if self.discovered or card.params.bypass_discovery_center then
			card.children.center:draw_shader("booster", nil, card.ARGS.send_to_shader)
		end
	end,
	cost = 8,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.xmult, 1 + (JROK.count_tarots() * card.ability.extra.xmult) } }
	end,
	calculate = function(self, card, context)
		if context.joker_main then
			local tarot_count = JROK.count_tarots()
			if tarot_count > 0 then
				return { xmult = 1 + (tarot_count * card.ability.extra.xmult) }
			end
		end
	end,
	pronouns = "she_her",
})

SMODS.Joker({
    key = "ghostinabucket",
	config = { extra = { odds = 4 } },
	rarity = 1,
    stolen_from = "Phanta",
	atlas = "stolen",
	pos = { x = 2, y = 3 },
	cost = 4,
	loc_vars = function(self, info_queue, card)
		local num, denom = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, "ghostinabucket")
		return { vars = { num, denom } }
	end,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,

	calculate = function(self, card, context)
		if
			context.individual
			and context.cardarea == G.hand
			and not context.end_of_round
			and context.other_card:get_id() == 14
			and SMODS.pseudorandom_probability(card, "ghostinabucket", 1, card.ability.extra.odds)
			and JROK.count_consumables() < G.consumeables.config.card_limit
		then
			G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
			local juice_card = context.other_card
			return {
				extra = {
					message = localize("k_plus_tarot"),
					message_card = juice_card,
					func = function()
						G.E_MANAGER:add_event(Event({
							func = function()
								juice_card:juice_up()
								SMODS.add_card({
									set = "Tarot",
									key_append = "ghostinabucket",
								})
								G.GAME.consumeable_buffer = 0
								return true
							end,
						}))
					end,
				},
			}
		end
	end,
	pronouns = "she_her",
})
