SMODS.Joker({
	key = "atmospheric",
	atlas = "stolen",
	stolen_from = "Hawaii Pt. II",
	rarity = 2,
	cost = 5,
	unlocked = true,
	discovered = true,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = false,
	pos = { x = 2, y = 5 },
	config = {
		extra = {
			retriggers = 2,
			three = 0,
		},
	},
	loc_vars = function(self, info_queue, card)
		return { vars = {} }
	end,
	calculate = function(self, card, context)
		if context.before then
			G.atmoScoredFives = 0
		end
		if context.cardarea == G.play and context.repetition and not context.repetition_only then
			if context.other_card:get_id() == 5 and G.atmoScoredFives < 3 then
				if not context.blueprint then
					G.atmoScoredFives = G.atmoScoredFives + 1
				end
				return {
					repetitions = card.ability.extra.retriggers,
				}
			end
		end
	end,
	in_pool = function(self, args)
		return false
	end,
})

SMODS.Joker({
	key = "precious",
	stolen_from = "Hawaii Pt. II",
	atlas = "stolen",
	rarity = 2,
	cost = 5,
	unlocked = true,
	discovered = true,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = false,
	pos = { x = 3, y = 5 },
	config = {
		extra = {
			Xmult = 1,
			Xmult_gain = 0.25,
		},
	},
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.Xmult_gain, card.ability.extra.Xmult } }
	end,

	calculate = function(self, card, context)
		if context.end_of_round and context.main_eval and card.ability.extra.Xmult > 1 and not context.game_over then
			card.ability.extra.Xmult = 1
			return {
				message = localize("k_reset"),
			}
		end

		if context.joker_main and card.ability.extra.Xmult > 1 then
			return {
				xmult = card.ability.extra.Xmult,
			}
		end

		if context.cardarea == G.play and context.individual and not context.blueprint then
			if context.other_card:get_id() == 5 then
				card.ability.extra.Xmult = card.ability.extra.Xmult + card.ability.extra.Xmult_gain
				return {
					message = localize("k_upgrade_ex"),
				}
			end
		end
	end,
	in_pool = function(self, args)
		return false
	end,
})
