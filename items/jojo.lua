SMODS.Joker({
	key = "starPlatinum",
	config = {
		extra = {
			mult_added = 1,
			mult_mod = 0,
			chips = 0,
			mult = 0,
		},
	},
	stolen_from = "JoJo Mod",
	in_pool = function(self, args)
		return false
	end,
	atlas = "stolen",
	pos = { x = 5, y = 6 },

	loc_vars = function(self, info_queue, card)
		return {
			vars = {
				card.ability.extra.mult_added,
				card.ability.extra.mult_mod,
			},
		}
	end,

	rarity = 2,
	cost = 7,
	blueprint_compat = true,

	calculate = function(self, card, context)
		-- Basic scoring context
		if context.joker_main then
			local playhand = G.GAME.hands[context.scoring_name].played or 0
			local should_reset = false
			for k, v in pairs(G.GAME.hands) do
				if k ~= context.scoring_name and v.played > playhand and v.visible then
					should_reset = true
					break
				end
			end
			if not context.blueprint and not should_reset then
				SMODS.scale_card(card, {
					ref_table = card.ability.extra,
					ref_value = "mult_mod",
					scalar_value = "mult_added",
				})
			elseif should_reset then
				SMODS.calculate_effect({
					message = localize("k_reset"),
				})
				card.ability.extra.mult_mod = 0
			end

			return { mult = card.ability.extra.mult_mod }
		end
	end,
})

SMODS.Joker({
	key = "crazyDiamond",
	config = {},
	rarity = 3,
	cost = 10,
	blueprint_compat = true,
	stolen_from = "JoJo Mod",
	atlas = "stolen",
	pos = { x = 6, y = 6 },

	loc_vars = function(self, info_queue, card)
		return {}
	end,
	in_pool = function(self, args)
		return false
	end,
	calculate = function(self, card, context)
		if context.remove_playing_cards then
			for _, removed_card in ipairs(context.removed) do
				-- Duplicate the card
				G.playing_card = (G.playing_card and G.playing_card + 1) or 1
				local copy_card = copy_card(removed_card, nil, nil, G.playing_card)
				copy_card:add_to_deck()
				G.deck.config.card_limit = G.deck.config.card_limit + 1
				table.insert(G.playing_cards, copy_card)
				G.hand:emplace(copy_card)
				copy_card.states.visible = nil

				G.E_MANAGER:add_event(Event({
					func = function()
						copy_card:start_materialize()
						return true
					end,
				}))
			end
		end
	end,
})
