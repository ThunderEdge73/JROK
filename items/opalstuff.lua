-- Opal

SMODS.Joker({
	key = "shiny_rock",
	config = { extra = { odds = 20 } },
	rarity = 2,
	atlas = "stolen",
	pos = { x = 5, y = 0 },
	cost = 7,
	blueprint_compat = true,
	loc_vars = function(self, info_queue, card)
		local numerator, denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, "opal_sr1")
		return { vars = { numerator, denominator } }
	end,
	calculate = function(self, card, context)
		if context.individual and context.cardarea == G.play then
			local chosencard = context.other_card
			if
				chosencard
				and not chosencard.edition
				and not chosencard.being_opaled
				and SMODS.pseudorandom_probability(card, "opal_sr2", 1, card.ability.extra.odds)
			then
				chosencard.being_opaled = true
				G.E_MANAGER:add_event(Event({
					func = function()
						local edition = poll_edition("opal", nil, true, true)
						chosencard:set_edition(edition, true)
						return true
					end,
				}))
				card_eval_status_text(card, "extra", nil, nil, nil, { message = "Edition!", colour = G.C.TAROT })
			end
		end
	end,
})

SMODS.Joker({
	key = "cultist",
	rarity = 1,
	atlas = "stolen",
	pos = { x = 6, y = 0 },
	cost = 5,
	blueprint_compat = true,
	calculate = function(self, card, context)
		if context.open_booster and context.card.ability.name:find("Arcana") then
			G.E_MANAGER:add_event(Event({
				trigger = "after",
				func = function()
					extra_card = create_card("Spectral", G.pack_cards, nil, nil, true, true, nil, "cultist")
					extra_card:start_materialize()
					G.pack_cards:emplace(extra_card)
					return true
				end,
			}))
		end
	end,
})
