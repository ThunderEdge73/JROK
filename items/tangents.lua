SMODS.Joker({
	key = "pingas",
	rarity = 1,
	atlas = "stolen",
	in_pool = function(self, args)
		return false
	end,
	stolen_from = "Tangents",
	pos = { x = 0, y = 8 },
	cost = 3,
	unlocked = true,
	discovered = true,
	config = { extra = { mult = 4 } },
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.mult } }
	end,
	calculate = function(self, card, context)
		if
			context.individual
			and not context.repetition
			and not context.end_of_round
			and context.cardarea == G.play
		then
			local sound = "jrok_pingas"
			return {
				focus = context.other_card,
				mult_mod = card.ability.extra.mult,
				message = localize({ type = "variable", key = "a_mult", vars = { card.ability.extra.mult } }),
				sound = sound,
				colour = G.C.RED,
			}
		end
	end,
})

SMODS.Joker({
	key = "kendih",
	in_pool = function(self, args)
		return false
	end,
	stolen_from = "Tangents",
	rarity = 2,
	atlas = "stolen",
	pos = { x = 1, y = 8 },
	cost = 3,
	unlocked = true,
	discovered = true,
	config = { extra = {
		chance = 4,
		xmult = 1000,
		variance = 5000,
	} },
	loc_vars = function(self, info_queue, card)
		local n, d = SMODS.get_probability_vars(card, 1, card.ability.extra.chance, "mustard")
		return {
			vars = {
				n,
				d,
				card.ability.extra.xmult,
				card.ability.extra.xmult + card.ability.extra.variance,
			},
		}
	end,
	calculate = function(self, card, context)
		if context.joker_main then
			if SMODS.pseudorandom_probability(card, "mustard", 1, card.ability.extra.chance) then
				local multard = card.ability.extra.xmult + pseudorandom("mustard") * card.ability.extra.variance

				G.E_MANAGER:add_event(Event({
					trigger = "after",
					delay = 0.3,
					blockable = false,
					func = function()
						card:juice_up(2, 2)
						return true
					end,
				}))

				G.E_MANAGER:add_event(Event({
					trigger = "immediate",
					func = function()
						play_sound("jrok_mustard", 1, 1000)
						return true
					end,
				}))

				return {
					xmult = multard,
					card = card,
				}
			end
		end
	end,
})

SMODS.Font({
	key = "emoji",
	path = "NotoEmoji-Regular.ttf",
	render_scale = 95,
	TEXT_HEIGHT_SCALE = 1,
	TEXT_OFFSET = { x = 10, y = -17 },
	FONTSCALE = 0.15,
	squish = 1,
	DESCSCALE = 1,
})

SMODS.Sound({
	key = "jrok_mustard",
	path = "mustard.ogg",
})

SMODS.Sound({
	key = "jrok_pingas",
	path = "pingas.ogg",
})
