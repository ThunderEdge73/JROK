SMODS.Joker({ -- Button
	key = "button",
	blueprint_compat = true,
	eternal_compat = true,
	unlocked = true,
	discovered = false,
	atlas = "stolen",
	rarity = 1,
	cost = 3,
	in_pool = function(self, args)
		return false
	end,
	stolen_from = "Incognito",
	pos = { x = 9, y = 8 },
	config = { extra = { xmult = 0.5, xmult_gain = 0.05, odds = 100 } },

	loc_vars = function(self, info_queue, card)
		local new_numerator, new_denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds)
		return { vars = { new_numerator, new_denominator, card.ability.extra.xmult, card.ability.extra.xmult_gain } }
	end,

	calculate = function(self, card, context)
		if context.jrok_key_press_space then
			if SMODS.pseudorandom_probability(card, "j_nic_button", 1, card.ability.extra.odds) then
				card:start_dissolve({ G.C.RED })
				card:juice_up(10, 10)
				return { play_sound("nic_explosion"), message = "BOOM!", colour = G.C.RED }
			else
				card.ability.extra.xmult = card.ability.extra.xmult + card.ability.extra.xmult_gain
				card:juice_up()
				return { play_sound("nic_click") }
			end
		end
		if context.joker_main then
			return {
				xmult = card.ability.extra.xmult,
			}
		end
	end,
})

local jrokmodpress = love.keypressed
function love.keypressed(key)
	if key == "space" then
		if G and G.jokers and G.jokers.cards and not G.SETTINGS.paused then
			SMODS.calculate_context({ jrok_key_press_space = true })
		end
	end
	return jrokmodpress(key)
end

SMODS.Joker({ -- Incognito
	key = "incognito",
	blueprint_compat = true,
	eternal_compat = true,
	unlocked = true,
	discovered = false,
	atlas = "stolen",
	rarity = 4,
	cost = 20,
	pos = { x = 7, y = 8 },
	soul_pos = { x = 8, y = 8 },
    stolen_from = "Incognito",
    in_pool = function (self, args)
        return false
    end,
	config = { extra = { xmult = 1, xmult_gain = 1, odds = 7 } },

	loc_vars = function(self, info_queue, card)
		--info_queue[#info_queue + 1] = { key = "nic_spades_no_debuff", set = "Other" }
		local new_numerator, new_denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds)
		return { vars = { new_numerator, new_denominator, card.ability.extra.xmult_gain, card.ability.extra.xmult } }
	end,

	add_to_deck = function(self, card, from_debuff)
		love.audio.stop()
	end,

	--[[update = function(self, card)
        if card.edition and card.edition.key == "e_negative" then
            card.children.center:set_sprite_pos({x = 1, y = 3})
            card.children.floating_sprite:set_sprite_pos({x = 2, y = 3})
        else
            card.children.center:set_sprite_pos({x = 4, y = 1})
            card.children.floating_sprite:set_sprite_pos({x = 5, y = 1})
        end
    end,]]

	calculate = function(self, card, context)
		if context.destroy_card and context.destroy_card.should_destroy and not context.blueprint then
			return { remove = true, colour = G.C.SUITS.Spades }
		end

		if context.remove_playing_cards and not context.blueprint then
			local spades_cards = 0
			for _, removed_card in ipairs(context.removed) do
				if not (removed_card.base.suit == "Spades") then
					spades_cards = spades_cards + 1
				end
			end
			if spades_cards > 0 then
				card.ability.extra.xmult = card.ability.extra.xmult + (spades_cards * card.ability.extra.xmult_gain)
				return {
					message = "+X" .. spades_cards .. " MULT!",
					colour = G.C.SUITS.Spades,
				}
			end
		end

		if context.individual and context.cardarea == G.hand and not context.end_of_round and not context.blueprint then
			if not (context.other_card.base.suit == "Spades") then
				if SMODS.pseudorandom_probability(card, "j_nic_incognito", 1, card.ability.extra.odds) then
					context.other_card.should_destroy = true
					G.E_MANAGER:add_event(Event({
						func = function()
							return true
						end,
					}))
					return { message = "SWOON!", colour = G.C.SUITS.Spades }
				else
					return { message = "NOPE!", colour = G.C.SUITS.Spades }
				end
			end
		end

		if context.individual and context.cardarea == G.hand and not context.end_of_round then
			if context.other_card:is_suit("Spades") then
				return {
					xmult = card.ability.extra.xmult,
				}
			end
		end
	end,
})
