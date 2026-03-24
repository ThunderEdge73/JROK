-- Maelmc

SMODS.Joker({
	key = "spoon_bender",
	stolen_from = "TBOJ",
	pos = { x = 0, y = 0 },
	config = { extra = { Xmult_multi = 2 } },
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.Xmult_multi } }
	end,
	rarity = 3,
	cost = 8,
	atlas = "stolen",
	perishable_compat = true,
	eternal_compat = true,
	blueprint_compat = true,
	calculate = function(self, card, context)
		if context.cardarea == "unscored" and context.individual then
			return {
				colour = G.C.MULT,
				Xmult = card.ability.extra.Xmult_multi,
			}
		end
	end,
	in_pool = function(self, args)
		return false
	end,
})

SMODS.Joker({
	key = "dream_catcher",
	stolen_from = "TBOJ",
	pos = { x = 1, y = 0 },
	config = { extra = {} },
	loc_vars = function(self, info_queue, card)
		if not G.jokers then
			--print("not in game")
			return { vars = { localize("jrok_unknown") } }
		end
		if not table.contains(G.jokers.cards, card) then
			--print("not owned")
			return { vars = { localize("jrok_acquire_to_reveal") } }
		end
		local blind = JROK.predict_next_boss()
		if blind then
			return { vars = { localize({ type = "name_text", key = blind, set = "Blind" }) } }
		else
			--print("cant find blind")
			return { vars = { localize("jrok_unknown") } }
		end
	end,
	rarity = 1,
	cost = 4,
	atlas = "stolen",
	perishable_compat = true,
	eternal_compat = true,
	blueprint_compat = false,
	calculate = function(self, card, context) end,
	in_pool = function(self, args)
		return false
	end,
})

function JROK.predict_seed(key)
	local pkey = G.GAME.pseudorandom[key]
	if not G.GAME.pseudorandom[key] then
		pkey = pseudohash(key .. (G.GAME.pseudorandom.seed or ""))
	end

	pkey = math.abs(tonumber(string.format("%.13f", (2.134453429141 + pkey * 1.72431234) % 1)))
	return (pkey + (G.GAME.pseudorandom.hashed_seed or 0)) / 2
end

function JROK.predict_next_boss()
	local real_ante = G.GAME.round_resets.ante
	G.GAME.round_resets.ante = G.GAME.round_resets.ante + 1
	G.GAME.perscribed_bosses = G.GAME.perscribed_bosses or {}
	if G.GAME.perscribed_bosses and G.GAME.perscribed_bosses[G.GAME.round_resets.ante] then
		local ret_boss = G.GAME.perscribed_bosses[G.GAME.round_resets.ante]
		G.GAME.round_resets.ante = real_ante
		return ret_boss
	end
	if G.FORCE_BOSS then
		G.GAME.round_resets.ante = real_ante
		return G.FORCE_BOSS
	end

	local eligible_bosses = {}
	for k, v in pairs(G.P_BLINDS) do
		if G.GAME.round_resets.blind_choices.Boss ~= v.key then
			local res, options = SMODS.add_to_pool(v)
			options = options or {}
			if not v.boss then
			elseif options.ignore_showdown_check then
				eligible_bosses[k] = res and true or nil
			elseif v.in_pool and type(v.in_pool) == "function" then
				if
					(G.GAME.round_resets.ante % G.GAME.win_ante == 0 and G.GAME.round_resets.ante >= 2)
					== (v.boss.showdown or false)
				then
					eligible_bosses[k] = res and true or nil
				end
			elseif
				not v.boss.showdown
				and (
					v.boss.min <= math.max(1, G.GAME.round_resets.ante)
					and ((math.max(1, G.GAME.round_resets.ante)) % G.GAME.win_ante ~= 0 or G.GAME.round_resets.ante < 2)
				)
			then
				eligible_bosses[k] = res and true or nil
			elseif
				v.boss.showdown
				and G.GAME.round_resets.ante % G.GAME.win_ante == 0
				and G.GAME.round_resets.ante >= 2
			then
				eligible_bosses[k] = res and true or nil
			end
		end
	end
	for k, v in pairs(G.GAME.banned_keys) do
		if eligible_bosses[k] then
			eligible_bosses[k] = nil
		end
	end

	local min_use = 100
	for k, v in pairs(G.GAME.bosses_used) do
		if eligible_bosses[k] then
			if G.GAME.round_resets.blind_choices.Boss ~= k then
				eligible_bosses[k] = v
				if eligible_bosses[k] <= min_use then
					min_use = eligible_bosses[k]
				end
			end
		end
	end
	--local tot_elig = 0
	for k, v in pairs(eligible_bosses) do
		if eligible_bosses[k] then
			if eligible_bosses[k] > min_use then
				eligible_bosses[k] = nil
			elseif G.GAME.round_resets.blind_choices.Boss == eligible_bosses[k] then
				eligible_bosses[k] = nil
				--else
				--print(k)
				--tot_elig = tot_elig + 1
			end
		end
	end
	--print("eligible bosses: "..tot_elig)
	local _, boss = pseudorandom_element(eligible_bosses, JROK.predict_seed("boss"))
	G.GAME.round_resets.ante = real_ante

	local generated = JROK.generate_blind(JROK.predict_seed("jrok_prompt"))
	if generated then
		boss = generated
	end
	return boss
end
