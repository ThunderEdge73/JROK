SMODS.Joker({
	key = "posh",
    stolen_from = "Valk:Redux",
	atlas = "stolen",
	pos = { x = 7, y = 5 },
	config = { extra = { chips = 30 } },
	rarity = 1,
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.chips } }
	end,
	calculate = function(self, card, context)
		if context.individual and context.cardarea == G.hand and next(SMODS.get_enhancements(context.other_card)) then
			return { chips = card.ability.extra.chips }
		end
	end,
	in_pool = function(self, args)
		return false
	end,
	cost = 4,
})

SMODS.Joker({
	key = "stellar_yogurt",
    stolen_from = "Valk:Redux",
	atlas = "stolen",
	pos = { x = 6, y = 5 },
	config = { extra = {} },
	rarity = 2,
	in_pool = function(self, args)
		return false
	end,
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = G.P_CENTERS.c_fool
		info_queue[#info_queue + 1] = G.P_TAGS.tag_meteor
		return { vars = {} }
	end,
	calculate = function(self, card, context)
		-- code here
		if context.selling_self then
			if G.consumeables.config.card_limits.total_slots - G.consumeables.config.card_count > 0 then
				SMODS.add_card({ key = "c_fool" })
			end
			add_tag(Tag("tag_meteor"))
		end
	end,
	cost = 6,
	valk_artist = "pangaea",
})
