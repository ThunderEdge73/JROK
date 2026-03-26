SMODS.Joker({
	key = "futuristic",
	atlas = "stolen",
	pos = { x = 1, y = 7 },
	rarity = 3,
	cost = 8,
	unlocked = true,
	discovered = false,
	blueprint_compat = true,
	eternal_compat = true,
    in_pool = function (self, args)
        return false
    end,
    stolen_from = "Ortalab",
	perishable_compat = true,
	config = { extra = { xmult = 1.25 } },
	loc_vars = function(self, info_queue, card)
		return {
			vars = {
				card.ability.extra.xmult,
				card.ability.extra.rank and localize(card.ability.extra.rank, "ranks") or localize("jrok_rank"),
				localize("Straight", "poker_hands"),
			},
		}
	end,
	set_ability = function(self, card)
		if G.playing_cards and #G.playing_cards > 0 then
			card.ability.extra.rank = JROK.rank_from_deck("ortalab_futuristic")
		end
	end,
	calculate = function(self, card, context)
		if context.before then
			card.ability.extra.ranks = {}
			for _, pcard in ipairs(context.scoring_hand) do
				if not SMODS.has_no_rank(card) then
					card.ability.extra.ranks[#card.ability.extra.ranks + 1] = pcard.base.value
				end
			end
		end
		if
			context.cardarea == G.play
			and context.individual
			and JROK.futuristic_check(
				SMODS.merge_lists({
					SMODS.Ranks[context.other_card.base.value].next,
					SMODS.Ranks[context.other_card.base.value].prev,
				}),
				card.ability.extra.ranks
			)
		then
			return {
				x_mult = card.ability.extra.xmult,
				message_card = context.other_card,
			}
		end
	end,
})

function JROK.rank_from_deck(seed)
	local ranks = {}
	local seed = seed or "ortalab_rank_from_deck"
	for _, card in pairs(G.playing_cards) do
		ranks[card.base.value] = card.base.value
	end
	return pseudorandom_element(ranks, pseudoseed(seed))
end

function JROK.futuristic_check(consecutive_ranks, ranks_in_hand)
	for _, rank in ipairs(consecutive_ranks) do
		if table.contains(ranks_in_hand, rank) then
			return true
		end
	end
	return false
end

SMODS.Joker({
	key = "gratification",
	atlas = "stolen",
	pos = { x = 2, y = 7 },
	rarity = 1,
    in_pool = function (self, args)
        return false
    end,
    stolen_from = "Ortalab",
	cost = 5,
	unlocked = true,
	discovered = false,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	config = { extra = 1 },
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra } }
	end,
	calculate = function(self, card, context) --Instant Gratification logic
		if context.discard and context.other_card == context.full_hand[#context.full_hand] then
			return {
				dollars = card.ability.extra,
				card = card,
			}
			-- G.E_MANAGER:add_event(Event({
			--     func = function()
			--         ease_dollars(card.ability.extra)
			--         card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = localize('$')..card.ability.extra,colour = G.C.MONEY, delay = 0.45})
			--         return true
			--     end}))
			-- return
		end
	end,
})
