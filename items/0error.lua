SMODS.Joker({
	key = "dazzles",
	pos = { x = 4, y = 1 },
	atlas = "stolen",
	rarity = 1,
	cost = 3,
	unlocked = true,
	discovered = true,
	blueprint_compat = true,
	demicoloncompat = false,
	config = {
		extra = { mult = 4, times = 3, count = 0 },
	},
	loc_vars = function(self, info_queue, card)
		return {
			vars = {
				card.ability.extra.mult,
				card.ability.extra.times,
				card.ability.extra.times == 1 and " is" or "s are",
			},
		}
	end,
	calculate = function(self, card, context)
		if (context.individual and context.cardarea == G.play) or context.forcetrigger then
			card.ability.extra.count = card.ability.extra.count + 1
			if card.ability.extra.count >= card.ability.extra.times then
				card.ability.extra.count = 0
				card.ability.extra.times = pseudorandom_element({ 1, 2, 3, 6 }, "dazzles")
				return {
					mult = card.ability.extra.mult,
				}
			end
		end
	end,
})

SMODS.Joker({
	key = "croque_madame",
	atlas = "stolen",
	pos = { x = 5, y = 1 },
	rarity = 1,
	blueprint_compat = false,
	eternal_compat = false,
	cost = 3,
	unlocked = true,
	discovered = true,
	calculate = function(self, card, context)
		if context.end_of_round and context.main_eval and not context.blueprint then
            local other_joker = nil
			for i = 1, #G.jokers.cards do
				if G.jokers.cards[i] == card then
					other_joker = G.jokers.cards[i + 1]
				end
			end
			if other_joker and other_joker.config.center.cost then
				SMODS.destroy_cards(card, nil, nil, true)
				return {
					dollars = (card.sell_cost + other_joker.sell_cost) * 2,
				}
			end
		end
	end,
	pronouns = "she_her",
})
