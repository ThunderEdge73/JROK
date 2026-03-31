SMODS.Joker({
	key = "jimbot",
	-- Extra is empty, because it only happens once. If you wanted to copy multiple cards, you'd need to restructure the code and add a for loop or something.
	config = { extra = { punk = 0 } },
	rarity = 2,
	atlas = "stolen",
	pos = { x = 4, y = 8 },
    stolen_from = "Garbshit",
    in_pool = function (self, args)
        return false
    end,
	unlocked = true,
	discovered = false, --whether or not it starts discovered
	blueprint_compat = true, --can it be blueprinted/brainstormed/other
	eternal_compat = true, --can it be eternal
	perishable_compat = true, --can it be perishable
	cost = 5,
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = G.P_CENTERS.m_steel
		info_queue[#info_queue + 1] = G.P_CENTERS.m_gold
	end,
	calculate = function(self, card, context)
		if context.before and #G.play.cards == 1 then
			G.play.cards[1]:set_ability(
				G.P_CENTERS[pseudorandom_element({ "m_steel", "m_gold" }, pseudoseed("BROBOT"))]
			)
			G.play.cards[1]:juice_up()
			card.ability.extra.punk = card.ability.extra.punk + 1
			if card.ability.extra.punk > 4 then
				card.ability.extra.punk = 1
			end
			local daft = { "HARDER!", "BETTER!", "FASTER!", "STRONGER!" }

			return {
				message = daft[card.ability.extra.punk],
			}
		end
	end,
})

SMODS.Joker({
	key = "hhgregg",
	config = { extra = { discount = 2 } },
	rarity = 2,
	atlas = "stolen",
	pos = { x = 5, y = 8 },
	cost = 7,
    stolen_from = "Garbshit",
    in_pool = function (self, args)
        return false
    end,
	unlocked = true,
	discovered = false, --whether or not it starts discovered
	blueprint_compat = false, --can it be blueprinted/brainstormed/other
	eternal_compat = true, --can it be eternal
	perishable_compat = true, --can it be perishable

	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.discount } }
	end,

	add_to_deck = function(self, card, from_debuff)
		if G.STATE == G.STATES.SHOP then
			for k, v in pairs(G.shop_jokers.cards) do
				G.E_MANAGER:add_event(Event({
					trigger = "after",
					delay = 0.5,
					func = function()
						if v.cost - card.ability.extra.discount >= 0 then
							v.cost = v.cost - card.ability.extra.discount
							card:juice_up()
							v:juice_up()
							play_sound("coin1", 1.2)
						elseif v.cost > 0 then
							v.cost = 0
							card:juice_up()
							v:juice_up()
							play_sound("coin1", 1.2)
						end
						return true
					end,
				}))
			end
		end
	end,

	calculate = function(self, card, context)
		if context.starting_shop or context.reroll_shop and not context.blueprint then
			for k, v in pairs(G.shop_jokers.cards) do
				G.E_MANAGER:add_event(Event({
					trigger = "after",
					delay = 0.5,
					func = function()
						if v.cost - card.ability.extra.discount >= 0 then
							v.cost = v.cost - card.ability.extra.discount
							if context.blueprint_card then
								context.blueprint_card:juice_up()
							else
								card:juice_up()
							end
							v:juice_up()
							play_sound("coin1", 1.2)
						elseif v.cost > 0 then
							v.cost = 0
							if context.blueprint_card then
								context.blueprint_card:juice_up()
							else
								card:juice_up()
							end
							v:juice_up()
							play_sound("coin1", 1.2)
						end
						return true
					end,
				}))
			end
		end
	end,
})
