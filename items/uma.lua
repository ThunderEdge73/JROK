SMODS.Joker({ --Gold Ship
	key = "goldship",
	stolen_from = "UmaMusumod",
	config = {
		extra = {
			kicks = { -2, -1, 1, 2, 3, 4, 5 },
		},
	},
	pos = {
		x = 6,
		y = 4,
	},
	cost = 4,
	rarity = 1,
	blueprint_compat = true,
	eternal_compat = true,
	unlocked = true,
	discovered = true,
	atlas = "stolen",

	loc_vars = function(self, info_queue, card)
        local rank = "Ace"
        if G.GAME.current_round and G.GAME.current_round.ship_card then
            rank = G.GAME.current_round.ship_card.rank
        end
		return { vars = { rank } }
	end,

	calculate = function(self, card, context)
		if context.hand_drawn then
			for k, v in ipairs(context.hand_drawn) do
				if v:get_id() == G.GAME.current_round.ship_card.id then
					local amount = pseudorandom_element(card.ability.extra.kicks, pseudoseed("dropkick"))
					ease_dollars(amount)
					card_eval_status_text(v, "extra", nil, nil, nil, { message = "$" .. amount, colour = G.C.MONEY })
				end
			end
		end
	end,
	in_pool = function(self, args)
		return false
	end,
})

function JROK.reset_ship_card()
	G.GAME.current_round.ship_card = G.GAME.current_round.ship_card or {}
	G.GAME.current_round.ship_card.rank = "Ace"
	G.GAME.current_round.ship_card.id = 14
	local valid_ship_cards = {}
	for k, v in ipairs(G.playing_cards) do
		if not SMODS.has_no_rank(v) then
			valid_ship_cards[#valid_ship_cards + 1] = v
		end
	end
	if valid_ship_cards[1] then
		local ship_card = pseudorandom_element(valid_ship_cards, pseudoseed("dropkick" .. G.GAME.round_resets.ante))
		G.GAME.current_round.ship_card.rank = ship_card.base.value
		G.GAME.current_round.ship_card.id = ship_card.base.id
	end
end

SMODS.Joker({ --TM Opera O
	key = "tmoperao",
	stolen_from = "UmaMusumod",
	config = {
		extra = {
			Xmult = 1,
			Xmult_mod = 0.25,
		},
	},
	pos = {
		x = 5,
		y = 4,
	},
	cost = 9,
	rarity = 3,
	blueprint_compat = true,
	perishable_compat = false,
	eternal_compat = true,
	unlocked = true,
	discovered = true,
	atlas = "stolen",

	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.Xmult, card.ability.extra.Xmult_mod } }
	end,

	calculate = function(self, card, context)
		if context.before and not context.blueprint then
			local faces = false
			for i = 1, #context.scoring_hand do
				if context.scoring_hand[i]:is_face() then
					faces = true
					break
				end
			end
			if faces then
				card.ability.extra.Xmult = card.ability.extra.Xmult + card.ability.extra.Xmult_mod
				return {
					card = card,
					message = localize("k_upgrade_ex"),
					colour = G.C.RED,
				}
			else
				local last_mult = card.ability.extra.Xmult
				card.ability.extra.Xmult = 1
				if last_mult > 1 then
					return {
						card = card,
						message = localize("k_reset"),
						colour = G.C.RED,
					}
				end
			end
		elseif context.cardarea == G.jokers and context.joker_main and card.ability.extra.Xmult > 1 then
			return {
				message = localize({ type = "variable", key = "a_xmult", vars = { card.ability.extra.Xmult } }),
				Xmult_mod = card.ability.extra.Xmult,
			}
		end
	end,
	in_pool = function(self, args)
		return false
	end,
})
