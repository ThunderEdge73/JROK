SMODS.Joker({
	key = "7_ball",
	atlas = "stolen",
	pos = { x = 4, y = 7 },
	rarity = 2,
	cost = 7,
	config = { extra = 7 },
	pools = { Meme = true },
	loc_vars = function(self, info_queue, card)
		local n, d = SMODS.get_probability_vars(card, 1, card.ability.extra, "hpr_7_ball")
		return { vars = { n, d } }
	end,
	calculate = function(self, card, context)
		if
			(context.individual and context.cardarea == G.play or context.forcetrigger)
			and #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit
		then
			if
				context.forcetrigger
				or context.other_card:get_id() == 7
					and SMODS.pseudorandom_probability(card, "hpr_7_ball", 1, card.ability.extra)
			then
				G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
				return {
					extra = {
						message = localize("k_plus_spectral"),
						colour = G.C.SECONDARY_SET.Spectral,
						message_card = card,
						func = function()
							G.E_MANAGER:add_event(Event({
								func = function()
									SMODS.add_card({
										set = "Spectral",
										key_append = "hpr_7_ball",
									})
									G.GAME.consumeable_buffer = 0
									return true
								end,
							}))
						end,
					},
				}
			end
		end
	end,
    stolen_from = "Hypernova",
    in_pool = function (self, args)
        return false
    end,
	forcetrigger_compat = true,
})

SMODS.Joker { -- solar flare, levels up not most played hands and destroys some cards
    key = "solar",
    atlas = "stolen",
    pos = { x = 3, y = 7 },
    in_pool = function (self, args)
        return false
    end,
    config = { extra = { destroyed = 2 } },
    loc_vars = function (self, info_queue, card)
        return { vars = { card.ability.extra.destroyed } }
    end,
    stolen_from = "Hypernova",
    rarity = 3,
    cost = 10,
    calculate = function(self, card, context)
        if context.before and G.GAME.current_round.hands_played == 0 then
            local _handname, _played = 'High Card', -1
            for hand_key, hand in pairs(G.GAME.hands) do
                if hand.played > _played then
                    _played = hand.played
                    _handname = hand_key
                end
            end
            if context.scoring_name ~= _handname then
                local options = {}
                for _, c in ipairs(G.play.cards) do
                    if not SMODS.is_eternal(c) then options[#options+1] = c end
                end
                for _ = 1, math.min(card.ability.extra.destroyed, #options) do
                    local roll, pos = pseudorandom_element(options, "hpr_solar")
                    roll.hpr_solar_destroy = true
                    table.remove(options, pos)
                end
                return {
                    level_up = 1,
                    message = localize("k_upgrade_ex"),
                    colour = G.C.GREEN
                }
            end
        end
        if context.destroy_card and not context.blueprint and G.GAME.current_round.hands_played == 0 then
            local _handname, _played = 'High Card', -1
            for hand_key, hand in pairs(G.GAME.hands) do
                if hand.played > _played then
                    _played = hand.played
                    _handname = hand_key
                end
            end
            if context.scoring_name ~= _handname and context.destroy_card.hpr_solar_destroy then
                return { remove = true }
            end
        end
    end,
    hpr_ascension_key = "j_hpr_observatorium"
}