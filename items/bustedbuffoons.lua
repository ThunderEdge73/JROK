SMODS.Joker({
	key = "murphy",
	atlas = "stolen",
	rarity = 3,
	cost = 8,
	discovered = true,
	unlocked = true,
	blueprint_compat = true,
	eternal_compat = true,
	pos = { x = 0, y = 9 },
	config = {
		extra = {
			perma = 9,
		},
	},
    stolen_from = "Busted Buffoons",
    in_pool = function (self, args)
        return false
    end,
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.perma } }
	end,
	calculate = function(self, card, context)
		if context.individual and context.cardarea == G.play then
			if context.other_card:get_id() == 9 then
				context.other_card.ability.perma_mult = (context.other_card.ability.perma_mult or 0)
					+ card.ability.extra.perma
				return {
					message = localize("k_upgrade_ex"),
					colour = G.C.MULT,
				}
			end
		end
	end,
})
