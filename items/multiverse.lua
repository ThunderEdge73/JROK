SMODS.Joker({
	key = "thunderedge",
	atlas = "stolen",
    stolen_from = "Multiverse",
	pos = { x = 9, y = 4 },
	soul_pos = { x = 9, y = 5 },
	config = {
		extra = {
			xmult = 1,
            xmult_gain = 0.1,
            money_earned = 0,
            money_req = 10
		},
	},
	rarity = 4,
	cost = 20,
	blueprint_compat = true,
	loc_vars = function(self, info_queue, card)
		return {
            vars = {
                card.ability.extra.xmult_gain,
                card.ability.extra.money_req,
                card.ability.extra.money_req - card.ability.extra.money_earned,
                card.ability.extra.xmult,
            }
        }
	end,
    calculate = function(self, card, context)
        if context.money_altered and context.amount > 0 and not context.blueprint then
            card.ability.extra.money_earned = card.ability.extra.money_earned + context.amount
            if card.ability.extra.money_earned >= card.ability.extra.money_req then
                local ref = {}
                ref.amt = math.floor(card.ability.extra.money_earned / card.ability.extra.money_req) * card.ability.extra.xmult_gain
                SMODS.scale_card(card, {
                    ref_table = card.ability.extra,
                    ref_value = "xmult",
                    scalar_table = ref,
                    scalar_value = "amt",
                })
                card.ability.extra.money_earned = card.ability.extra.money_earned % card.ability.extra.money_req
            end
        end
        if context.joker_main then
            return {
                xmult = card.ability.extra.xmult
            }
        end
    end,
	in_pool = function(self, args)
        return false
    end
})