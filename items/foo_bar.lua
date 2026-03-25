SMODS.Joker({
	key = "baguette",
	atlas = "stolen",
    stolen_from = "FooBar",
	pos = { x = 4, y = 3 },
	config = {
		extra = {
			money = 1,
		},
		immutable = {
			rounds = 4,
		},
	},
    in_pool = function (self, args)
        return false
    end,
	cost = 4,
	eternal_compat = false,
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.money, card.ability.immutable.rounds } }
	end,
	calculate = function(self, card, context)
		if context.individual and context.cardarea == G.play then
			if context.other_card:is_face() then
				return {
					dollars = card.ability.extra.money,
				}
			end
		end
		if context.end_of_round and context.game_over == false and context.main_eval and not context.blueprint then
			card.ability.immutable.rounds = card.ability.immutable.rounds - 1
			if card.ability.immutable.rounds == 0 then
				SMODS.destroy_cards(card, nil, nil, nil)
				return {
					message = localize("k_eaten_ex"),
					colour = G.C.RED,
				}
			else
				return {
					message = "nom!",
					colour = G.C.YELLOW,
					func = function(...)
						G.E_MANAGER:add_event(Event({
							func = function()
								self:set_sprites(card, card.config.center)
								return true
							end,
						}))
					end,
				}
			end
		end
	end,
	set_sprites = function(self, card, front)
		if card.ability and card.ability.immutable and card.ability.immutable.rounds > 0 then
			card.children.center:set_sprite_pos({ x = 4 + 4 - card.ability.immutable.rounds, y = 3 })
		end
	end,
})
