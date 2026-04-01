function JROK.gather_values(card)
	local total = 0
	for i, v in pairs(card.ability) do
		if JROK.is_number(v) and to_big(v) > to_big(1) and i ~= "order" then
			total = total + v
		elseif type(v) == "table" then
			total = total + JROK.gather_values({ ability = v })
		end
	end
	return total
end

function JROK.is_number(x)
	---@diagnostic disable-next-line: undefined-global
	return type(x) == "number" or (type(x) == "table" and is_number(x)) or (is_big and is_big(x))
end

to_big = to_big or function(x)
	return x
end

SMODS.Joker({
	key = "lambda_calculus",
	rarity = 2,
	cost = 6,
	in_pool = function(self, args)
		return false
	end,
	eternal_compat = true,
	pos = { x = 1, y = 4 },
	atlas = "stolen",
	config = {
		chips = 0,
	},
	perishable_compat = true,
	loc_vars = function(self, q, card)
		return {
			vars = {
				card.ability.chips,
			},
		}
	end,
	calculate = function(self, card, context)
		if context.joker_main then
			local chips = card.ability.chips
			card.ability.chips = 0
			return {
				chips = chips,
			}
		end
		if context.post_trigger and context.other_card ~= card then
			local change = JROK.gather_values(context.other_card)
			if to_big(change) > to_big(0) then
				card.ability.chips = card.ability.chips + change
				card_eval_status_text(
					card,
					"extra",
					nil,
					nil,
					nil,
					{ message = number_format(card.ability.chips), colour = G.C.BLUE }
				)
			end
		end
	end,
	stolen_from = "Entropy",
})

SMODS.Joker({
	key = "d0",
	rarity = 1,
	cost = 6,
	in_pool = function(self, args)
		return false
	end,
	eternal_compat = true,
	pos = { x = 2, y = 4 },
	atlas = "stolen",
	demicoloncompat = true,
	calculate = function(self, card, context)
		if context.fix_probability and not context.blueprint and not context.repetition then
			return {
				numerator = 0,
			}
		end
	end,
	stolen_from = "Entropy",
})
