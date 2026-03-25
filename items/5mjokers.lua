SMODS.Joker({
	key = "twins",
	name = "The Twins",
	rarity = 3,
	pos = { x = 8, y = 2 },
	cost = 8,
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = G.P_TAGS.tag_double
	end,
	blueprint_compat = false,
	calculate = function(self, card, context)
		if context.mfxfj_pre_skip then
			add_tag(Tag("tag_double"))
			play_sound("generic1", 0.9 + math.random() * 0.1, 0.8)
			play_sound("holo1", 1.2 + math.random() * 0.1, 0.4)
		end
	end,
	atlas = "stolen",
	in_pool = function(self, args)
		return false
	end,
})

SMODS.Joker({
	key = "detour",
	blueprint_compat = false,
	perishable_compat = true,
	rarity = 2,
	cost = 7,
	pos = { x = 0, y = 3 },
	soul_pos = { x = 1, y = 3 },
	atlas = "stolen",
    in_pool = function(self, args)
		return false
	end,
})

SMODS.PokerHandPart:take_ownership("_straight", {
	func = function(hand)
		return get_straight(
			hand,
			next(SMODS.find_card("j_four_fingers")) and 4 or 5,
			not not next(SMODS.find_card("j_shortcut")),
			next(SMODS.find_card("j_jrok_detour"))
		)
	end,
})
