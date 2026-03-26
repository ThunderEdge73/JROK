SMODS.Joker({
	key = "butterfly",
	stolen_from = "Balatro Waves",
	rarity = 3,
	blueprint_compat = true,
	cost = 10,
	pos = { x = 4, y = 6 },
	atlas = "stolen",
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = {
			key = "e_negative_consumable",
			set = "Edition",
			config = { extra = 1 },
		}
	end,
    in_pool = function (self, args)
        return false
    end,
    pixel_size = { w = 69, h = 95 },
	calculate = function(self, card, context)
		if context.setting_blind and context.blind and context.blind.boss then
			G.E_MANAGER:add_event(Event({
				func = function()
					SMODS.add_card({
						set = "Spectral",
						edition = { negative = true },
					})
					return true
				end,
			}))
		end
	end,
})

SMODS.Joker({
	key = "pero",
	rarity = 2,
    pixel_size = { w = 69, h = 95 },
	blueprint_compat = true,
    in_pool = function (self, args)
        return false
    end,
    stolen_from = "Balatro Waves",
	cost = 7,
	atlas = "stolen",
	pos = { x = 3, y = 6 },

	config = { extra = { Xmult = 2 } },

	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.Xmult } }
	end,

	calculate = function(self, card, context)
		if context.joker_main then
			local max_slots = G.jokers.config.card_limit or 0
			local filled = #G.jokers.cards

			if filled >= max_slots and max_slots > 0 then
				return { Xmult = card.ability.extra.Xmult }
			end
		end
	end,
})
