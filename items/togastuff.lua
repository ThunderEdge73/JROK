SMODS.Joker({
	key = "toiletrock",
    stolen_from = "TOGA's Stuff",
	unlocked = true,
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = G.P_CENTERS.m_stone
		return { vars = { localize("Flush", "poker_hands") } }
	end,
	rarity = 2,
	atlas = "stolen",
	pos = { x = 4, y = 2 },
	cost = 6,
	blueprint_compat = false,
})

local getflushref = get_flush
function get_flush(hand)
	local ret = getflushref(hand)
	if next(ret) then
		return ret
	end

	if not next(SMODS.find_card("j_toga_toiletrock")) then
		return {}
	end

	ret = {}
	local four_fingers = SMODS.four_fingers("flush")
	if #hand < four_fingers then
		return ret
	else
		local t = {}
		local stone_count = 0
		for i = 1, #hand do
			if SMODS.has_enhancement(hand[i], "m_stone") then
				stone_count = stone_count + 1
				t[#t + 1] = hand[i]
			end
		end
		if stone_count >= four_fingers then
			table.insert(ret, t)
			return ret
		end
		return {}
	end
end

SMODS.Joker({
	key = "wishingstones",
    stolen_from = "TOGA's Stuff",
	unlocked = true,
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = G.P_CENTERS.m_stone
		return { vars = { localize("Straight", "poker_hands") } }
	end,
	rarity = 2,
	atlas = "stolen",
	pos = { x = 5, y = 2 },
	cost = 6,
	blueprint_compat = false,
})

local getstraightref = get_straight
function get_straight(hand, min_length, skip, wrap)
	local ret = getstraightref(hand, min_length, skip, wrap)
	if next(ret) then
		return ret
	end

	if not next(SMODS.find_card("j_toga_wishingstones")) then
		return {}
	end

	min_length = min_length or 5
	if min_length < 2 then
		min_length = 2
	end
	if #hand < min_length then
		return {}
	end

	ret = {}
	local stone_count, t = 0, {}
	for i = 1, #hand do
		if SMODS.has_enhancement(hand[i], "m_stone") then
			stone_count = stone_count + 1
			t[#t + 1] = hand[i]
		end
	end
	if stone_count >= min_length then
		table.insert(ret, t)
		return ret
	end

	return {}
end
