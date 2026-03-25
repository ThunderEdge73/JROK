SMODS.Joker({
	discovered = true,
	key = "sunflower",
	stolen_from = "Sarcpot",
	config = {
		extra = {
			active = false,
		},
	},
	loc_vars = function(self, info_queue, card)
		local status = ""
		if card.ability.extra.active == true then
			status = localize("jrok_active")
		else
			status = localize("jrok_inactive")
		end
		return {
			vars = { status },
		}
	end,
	rarity = 3,
	atlas = "stolen",
	pos = {
		x = 6,
		y = 2,
	},
	cost = 5,
	blueprint_compat = true,
	in_pool = function(self, args)
		return false
	end,
	calculate = function(self, card, context)
		if context.skip_blind and not context.blueprint and card.ability.extra.active ~= true then
			card.ability.extra.active = true
			local eval = function(card)
				return card.ability.extra.active == true
			end
			juice_card_until(card, eval, true)
			return {
				message = localize("jrok_active"),
			}
		end
		if
			context.setting_blind
			and G.GAME.blind.boss
			and card.ability.extra.active == true
			and not G.GAME.blind.disabled
		then
			G.GAME.blind:disable()
			card.ability.extra.active = false
			return {
				message = localize("jrok_disabled"),
			}
		end
	end,
})

SMODS.Joker({
	discovered = true,
	key = "orchid",
	stolen_from = "Sarcpot",
	config = {
		extra = {
			mult_mod = 2,
			mult = 0,
		},
	},
	loc_vars = function(self, info_queue, card)
		return {
			vars = { card.ability.extra.mult_mod, card.ability.extra.mult },
		}
	end,
	rarity = 1,
	atlas = "stolen",
	pos = {
		x = 7,
		y = 2,
	},
	cost = 5,
	in_pool = function(self, args)
		return false
	end,
	calculate = function(self, card, context)
		if context.before and context.scoring_hand and not context.blueprint then
			local found = false
			for _, v in pairs(context.scoring_hand) do
				if v:get_id() == 11 then
					found = true
				end
			end
			if found then
				SMODS.scale_card(card, {
					ref_table = card.ability.extra,
					ref_value = "mult",
					scalar_value = "mult_mod",
				})
			end
		end
		if context.joker_main then
			return {
				mult = card.ability.extra.mult,
			}
		end
	end,
})
