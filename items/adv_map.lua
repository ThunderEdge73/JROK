-- vissa

SMODS.Joker({
	key = "punch_card",
	stolen_from = "Adventure Map",
	config = { extra = { Xmult = 4, every = 4, remaining = 4 } },
	atlas = "stolen",
	pos = { x = 8, y = 1 },
	rarity = 2,
	cost = 4,
	blueprint_compat = false,
	eternal_compat = true,
	unlocked = true,
	discovered = true,
	calculate = function(self, card, context)
		if context.blueprint then
			return
		end
		if context.using_consumeable then
			card.ability.extra.remaining = card.ability.extra.remaining - 1

			if card.ability.extra.remaining == 1 then
				local eval = function(card)
					return card.ability.extra.remaining == 1 and not G.RESET_JIGGLES
				end
				juice_card_until(card, eval, true)
			end

			if card.ability.extra.remaining == 0 then
				card.ability.extra.remaining = card.ability.extra.every

				G.E_MANAGER:add_event(Event({
					func = function()
						SMODS.add_card({
							key = context.consumeable.config.center.key, -- Optional, useful for manipulating the random seed and checking the source of the creation in `in_pool`.
						})
						G.GAME.consumeable_buffer = 0
						return true
					end,
				}))
				return {
					card = card,
					colour = G.C.GREEN,
					message = localize("k_jrok_punch_duplicate"),
				}
			end
		end
	end,
	loc_vars = function(self, info_queue, card)
		return {
			vars = {
				card.ability.extra.every,
				localize({
					type = "variable",
					key = (card.ability.extra.remaining == 1 and "jrok_punch_card_will" or "jrok_punch_card_more"),
					vars = { card.ability.extra.remaining },
				}),
			},
		}
	end,
})
