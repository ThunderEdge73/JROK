SMODS.Joker({
	key = "uniku",
	stolen_from = "UNIK's Mod",
	atlas = "stolen",
	pos = { x = 0, y = 5 },
	rarity = 2,
	config = { extra = { repetitions = 2 } },
	cost = 5,
    in_pool = function (self, args)
        return false
    end,
	blueprint_compat = true,
	perishable_compat = true,
	eternal_compat = true,
	loc_vars = function(self, info_queue, center)
		return { vars = { center.ability.extra.repetitions } }
	end,
	calculate = function(self, card, context)
		if context.cardarea == G.play and context.repetition and not context.repetition_only then
			if context.other_card:get_id() == 7 then
				return {
					message = localize("k_again_ex"),
					repetitions = card.ability.extra.repetitions,
					colour = G.C.UNIK_UNIK,
					card = card,
				}
			end
		end
	end,
})

SMODS.Joker({
	key = "ghost_joker",
	atlas = "stolen",
    stolen_from = "UNIK's Mod",
    in_pool = function (self, args)
        return false
    end,
	pos = { x = 1, y = 5 },
	rarity = 3,
	cost = 9,
	blueprint_compat = true,
	perishable_compat = true,
	eternal_compat = true,
	demicoloncompat = true,
	calculate = function(self, card, context)
		if (context.setting_blind or context.forcetrigger) and not (context.blueprint_card or self).getting_sliced then
			if #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
				G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
				G.E_MANAGER:add_event(Event({
					trigger = "before",
					delay = 0.0,
					func = function()
						local n_card =
							create_card("Spectral", G.consumeables, nil, nil, nil, nil, nil, "unik_ghost_joker")
						n_card:add_to_deck()
						G.consumeables:emplace(n_card)
						G.GAME.consumeable_buffer = 0
						return true
					end,
				}))
				card_eval_status_text(card, "extra", nil, nil, nil, {
					message = localize("k_plus_spectral"),
					colour = G.C.SECONDARY_SET.Spectral,
					card = card,
				})
			end
			return {}
		end
	end,
	draw = function(self, card, layer)
		local notilt = nil
		if card.area and card.area.config.type == "deck" then
			notilt = true
		end
		card.children.center:draw_shader("negative_shine", nil, card.ARGS.send_to_shader, notilt, card.children.center)
	end,
})
