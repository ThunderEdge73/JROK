SMODS.Joker({
	key = "eviloops",
	blueprint_compat = false,
	rarity = 2,
	cost = 5,
	atlas = "stolen",
	pos = { x = 5, y = 7 },
	calculate = function(self, card, context)
		if context.mod_probability and not context.blueprint then
			return {
				numerator = context.numerator / 2,
			}
		end
	end,
    stolen_from = "Typ0's Random Jokers",
    in_pool = function (self, args)
        return false
    end,
})

SMODS.Joker({
	key = "polychromeToTheRight",
    stolen_from = "Typ0's Random Jokers",
    in_pool = function (self, args)
        return false
    end,
	draw = function(self, card, layer)
		if card.config.center.discovered or card.bypass_discovery_center then
			card.children.center:draw_shader("polychrome", nil, card.ARGS.send_to_shader)
		end
	end,
    loc_vars = function (self, info_queue, card)
        return {
            vars = {
                card.ability.extra.x_mult,
            }
        }
    end,
	atlas = "stolen",
	pos = { x = 6, y = 7 },
	rarity = 2,
	cost = 6,
	blueprint_compat = true,
	config = {
		extra = {
			x_mult = 1.5,
		},
	},

	calculate = function(self, card, context)
		if context.joker_main then
			local jokers = G.jokers and G.jokers.cards
			if jokers and jokers[#jokers] == card then
				return {
					Xmult = 1.5,
				}
			end
		end
	end,

	add_to_deck = function(self, card, from_debuff)
		if not card.edition or card.edition.type ~= "polychrome" then
			card:set_edition({ type = "polychrome" }, true)
		end
	end,

	set_edition = function(self, card, edition)
		return { type = "polychrome" }
	end,
})
