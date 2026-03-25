SMODS.Joker({
	key = "berry_shimmer",
	atlas = "stolen",
    stolen_from = "Shimmerberry",
	pos = { x = 8, y = 5 },
	unlocked = true,
	discovered = true,
	eternal_compat = false,
	perishable_compat = true,
	blueprint_compat = true,
	rarity = 3,
	cost = 6,
	config = {
		activated = false,
		extra = {
			percent = 0.05,
		},
	},
	loc_vars = function(self, info_queue, card)
		local card_one = G.GAME.current_round.SEMBY_berry_rank_one or { rank = "King" }
		local card_two = G.GAME.current_round.SEMBY_berry_rank_two or { rank = "Queen" }
		return {
			vars = {
				localize(card_one.rank, "ranks"),
				localize(card_two.rank, "ranks"),
				100 * card.ability.extra.percent,
			},
		}
	end,
	calculate = function(self, card, context)
		if context.setting_blind and not (self.getting_sliced or context.blueprint) then
			card.ability.activated = false
		end
		if context.individual and context.cardarea == G.play then
			if
				context.other_card:get_id() == G.GAME.current_round.SEMBY_berry_rank_one.id
				or context.other_card:get_id() == G.GAME.current_round.SEMBY_berry_rank_two.id
			then
				card.ability.activated = true
				return {
					func = function()
						JROK.reduce_blind_size(card.ability.extra.percent, context.other_card, true)
						return true
					end,
				}
			end
		end
		if context.end_of_round and context.cardarea == G.jokers and not context.blueprint then
			if not card.ability.activated then
				G.E_MANAGER:add_event(Event({
					func = function()
						card:juice_up()
						G.E_MANAGER:add_event(Event({
							trigger = "after",
							delay = 0.3,
							blockable = false,
							func = function()
								SMODS.destroy_cards(card, nil, nil, true)
								return true
							end,
						}))
						return true
					end,
				}))
				return { message = localize("k_eaten_ex") }
			else
				return { message = localize("k_safe_ex") }
			end
		end
	end,
})

SMODS.Joker({
	key = "berry_golden",
	atlas = "stolen",
    stolen_from = "Shimmerberry",
	pos = { x = 0, y = 6 },
	unlocked = true,
	discovered = false,
	eternal_compat = false,
	perishable_compat = true,
	blueprint_compat = true,
	rarity = 2,
	cost = 5,
	config = {
		activated = false,
		extra = {
			-- Description says "1 or 2" but
			-- it's actually "between 1 and 2"
			dollars_min = 1,
			dollars_max = 2,
		},
	},
	loc_vars = function(self, info_queue, card)
		local card_one = G.GAME.current_round.SEMBY_berry_rank_one or { rank = "King" }
		local card_two = G.GAME.current_round.SEMBY_berry_rank_two or { rank = "Queen" }
		return {
			vars = {
				localize(card_one.rank, "ranks"),
				localize(card_two.rank, "ranks"),
				card.ability.extra.dollars_min,
				card.ability.extra.dollars_max,
			},
		}
	end,
	calculate = function(self, card, context)
		if context.setting_blind and not (self.getting_sliced or context.blueprint) then
			card.ability.activated = false
		end
		if context.individual and context.cardarea == G.play then
			if
				context.other_card:get_id() == G.GAME.current_round.SEMBY_berry_rank_one.id
				or context.other_card:get_id() == G.GAME.current_round.SEMBY_berry_rank_two.id
			then
				card.ability.activated = true
				--> This is too slow: Card scores, and when the NEXT card scores you get the Money.
				return {
					dollars = math.floor(
						pseudorandom(
							"SEMBY_berry_golden_" .. card.sort_id,
							card.ability.extra.dollars_min,
							card.ability.extra.dollars_max
						)
					),
				}
				--[[--> Quick'n'Dirty Alternative:
				local gain = math.floor(pseudorandom('SEMBY_berry_golden_'..card.sort_id, card.ability.extra.dollars_min, card.ability.extra.dollars_max))
				return {
            		func = function()
						ease_dollars(gain)
						return true
					end,
					extra = {
						message = localize{ type = 'variable', key = 'SEMBY_money', vars = { gain } },
						colour = G.C.MONEY,
						sound = 'coin'..math.random(3, 5),
						size = 1.2
					}
				}
				--]]
				--> I'm not gonna use that.
			end
		end
		if context.end_of_round and context.cardarea == G.jokers and not context.blueprint then
			if not card.ability.activated then
				G.E_MANAGER:add_event(Event({
					func = function()
						card:juice_up()
						G.E_MANAGER:add_event(Event({
							trigger = "after",
							delay = 0.3,
							blockable = false,
							func = function()
								SMODS.destroy_cards(card, nil, nil, true)
								return true
							end,
						}))
						return true
					end,
				}))
				return { message = localize("k_eaten_ex") }
			else
				return { message = localize("k_safe_ex") }
			end
		end
	end,
})

function JROK.reduce_blind_size(percent, card, wiggle)
	if percent then
		if G.GAME.blind.chips ~= 0 then
			JROK.change_blind_size(1.0 - percent)
		end
		if wiggle then
			JROK.wiggle_blind()
		end
		if card then
			card_eval_status_text(card, "extra", nil, nil, nil, {
				message = localize({ type = "variable", key = "jrok_percentage_minus", vars = { 100 * percent } }),
				colour = G.C.PURPLE,
			})
		end
	end
end

function JROK.wiggle_blind()
	G.E_MANAGER:add_event(Event({
		trigger = "after",
		func = function()
			play_sound("tarot2", 1, 0.4)
			SMODS.juice_up_blind()
			return true
		end,
	}))
	G.E_MANAGER:add_event(Event({
		trigger = "after",
		delay = 0.06 * G.SETTINGS.GAMESPEED,
		func = function()
			play_sound("tarot2", 0.76, 0.4)
			return true
		end,
	}))
end

function JROK.change_blind_size(mult)
	G.E_MANAGER:add_event(Event({
		trigger = "after",
		func = function()
			G.GAME.blind.chips = math.max(0, math.floor(G.GAME.blind.chips * mult))
			G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
			return true
		end,
	}))
end

function JROK.reset_berry_ranks()
	-- Reset Variables
	G.GAME.current_round.SEMBY_berry_rank_one = { rank = 'King', id = 13 }
	G.GAME.current_round.SEMBY_berry_rank_two = { rank = 'Queen', id = 12 }
	
	-- Get All Valid Cards for Rank One
	local valid_berry_cards_one = {}
	for _, playing_card in ipairs(G.playing_cards) do
		if not SMODS.has_no_rank(playing_card) then
			valid_berry_cards_one[#valid_berry_cards_one + 1] = playing_card
		end
	end
	-- Determine Rank One
	local berry_rank_one = pseudorandom_element(valid_berry_cards_one, pseudoseed('SEMBY_berry_rank_one'))
	if berry_rank_one then
		G.GAME.current_round.SEMBY_berry_rank_one.rank = berry_rank_one.base.value
		G.GAME.current_round.SEMBY_berry_rank_one.id = berry_rank_one.base.id
	else
		return -- nothing valid found => abort!
	end
	
	-- Get All Valid Cards for Rank Two
	local valid_berry_cards_two = {}
	for _, playing_card in ipairs(G.playing_cards) do
		if not SMODS.has_no_rank(playing_card) then
		    if not (playing_card.base.id == berry_rank_one.base.id) then
				valid_berry_cards_two[#valid_berry_cards_two + 1] = playing_card
			end
		end
	end
	-- Determine Rank Two
	local berry_rank_two = pseudorandom_element(valid_berry_cards_two, pseudoseed('SEMBY_berry_rank_two'))
	if berry_rank_two then
		-- Rank Two has it's own Number
		G.GAME.current_round.SEMBY_berry_rank_two.rank = berry_rank_two.base.value
		G.GAME.current_round.SEMBY_berry_rank_two.id = berry_rank_two.base.id
	else
		-- Rank Two and One are the same
		G.GAME.current_round.SEMBY_berry_rank_two.rank = berry_rank_one.base.value
		G.GAME.current_round.SEMBY_berry_rank_two.id = berry_rank_one.base.id
	end
end