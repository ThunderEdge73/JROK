-- PlasmaPhrase

SMODS.Joker({
	key = "hatchet",
	stolen_from = "Hatchet",
	config = {
		extra = {
			xmult = 2.5,
		},
	},
	pos = { x = 0, y = 1 },
	cost = 9,
	rarity = 3,
	blueprint_compat = false,
	eternal_compat = true,
	perishable_compat = true,
	unlocked = true,
	discovered = true,
	atlas = "stolen",
	loc_vars = function(self, info_queue, card)
		return {
			vars = {
				card.ability.extra.xmult,
			},
		}
	end,
	calculate = function(self, card, context)
		if context.joker_main and G.GAME.current_round.hands_played == 0 then
			return {
				xmult = card.ability.extra.xmult,
			}
		end
		if context.destroy_card and G.GAME.current_round.hands_played == 0 then
			return {
				remove = true,
			}
		end
		if context.after and G.GAME.current_round.hands_played == 0 then
			return {
				message = localize("k_felled_ex"),
				colour = G.C.RED,
			}
		end
	end,
})

SMODS.Joker({
	key = "dakimakura",
	stolen_from = "Hatchet",
	config = {
		extra = {},
	},
	pos = { x = 1, y = 1 },
	cost = 5,
	rarity = 1,
	blueprint_compat = false,
	eternal_compat = true,
	perishable_compat = true,
	unlocked = true,
	atlas = "stolen",
	calculate = function(self, card, context)
		if context.joker_main and next(context.poker_hands["Flush"]) then
			for i = 1, #context.full_hand do
				local percent = 1.15 - (i - 0.999) / (#G.hand.cards - 0.998) * 0.3
				local target = context.full_hand[i]
				G.E_MANAGER:add_event(Event({
					trigger = "after",
					delay = 0.15,
					func = function()
						target:flip()
						play_sound("card1", percent)
						target:juice_up(0.3, 0.3)
						return true
					end,
				}))
			end
			for i = 1, #context.full_hand do
				local target = context.full_hand[i]
				G.E_MANAGER:add_event(Event({
					func = function()
						assert(SMODS.change_base(target, pseudorandom_element(SMODS.Suits, "edit_card_suit").key, nil))
						return true
					end,
				}))
			end
			for i = 1, #context.full_hand do
				local percent = 1.15 - (i - 0.999) / (#G.hand.cards - 0.998) * 0.3
				local target = context.full_hand[i]
				G.E_MANAGER:add_event(Event({
					trigger = "after",
					delay = 0.15,
					func = function()
						target:flip()
						play_sound("card1", percent)
						target:juice_up(0.3, 0.3)
						return true
					end,
				}))
			end
		end
	end,
})
