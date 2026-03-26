SMODS.Joker({
	key = "subterfuge",
	rarity = 3,
	pos = { x = 8, y = 3 },
	pools = {
		Music = true,
	},
	atlas = "stolen",
	cost = 8,
	discovered = false,
	blueprint_compat = false,
	eternal_compat = true,
	perishable_compat = true,
	calculate = function(self, card, context)
		if
			not context.blueprint
			and context.destroy_card
			and (context.cardarea == G.play or context.cardarea == "unscored")
		then
			-- Destroy all cards in first hand
			if G.GAME.current_round.hands_played == 0 then
				if context.destroy_card == context.full_hand[#context.full_hand] then
					return {
						remove = true,
						message = localize("jrok_destroyed_ex"),
						colour = G.C.RED,
					}
				else
					return {
						remove = true,
					}
				end
			end
		end
	end,
    in_pool = function (self, args)
        return false
    end,
    stolen_from = "Paperback",
})

SMODS.Joker({
	key = "deadringer",
	config = {
		extra = {
			["Ace"] = 1,
			["7"] = 1,
			["9"] = 2,
		},
	},
	rarity = 3,
	pos = { x = 0, y = 4 },
	atlas = "stolen",
	cost = 7,
	unlocked = true,
	discovered = false,
	blueprint_compat = true,
	eternal_compat = true,
    in_pool = function (self, args)
        return false
    end,
    stolen_from = "Paperback",
	loc_vars = function(self, info_queue, card)
		return {
			vars = {
				localize("Ace", "ranks"),
				localize("7", "ranks"),
				localize("9", "ranks"),
			},
		}
	end,

	calculate = function(self, card, context)
		if context.cardarea == G.play and context.repetition and not SMODS.has_no_rank(context.other_card) then
			return {
				repetitions = card.ability.extra[context.other_card.base.value],
			}
		end
	end,
})
