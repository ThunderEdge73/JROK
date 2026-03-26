---@diagnostic disable: undefined-global

JROK.init_joy_table = function(params)
	return not params.is_field_spell
			and {
				is_main_deck = params.is_main_deck
					or not params.summon_type
					or params.summon_type == "NORMAL"
					or params.summon_type == "RITUAL",
				summon_type = params.summon_type or "NORMAL",
				is_effect = (params.is_effect == nil and not params.token_name) and true or params.is_effect,
				is_tuner = params.is_tuner or false,
				is_pendulum = params.is_pendulum or false,
				is_trap = params.is_trap or false,
				is_flip = params.is_flip or false,
				attribute = params.attribute or "FIRE",
				monster_type = params.monster_type or "Dragon",
				monster_archetypes = params.monster_archetypes or {},
				is_all_attributes = params.is_all_attributes or false,
				is_all_types = params.is_all_types or false,
				is_all_materials = params.is_all_materials or {},
				summon_conditions = params.summon_conditions or {},
				summon_consumeable_conditions = params.summon_consumeable_conditions or nil,
				summoned = false,
				summon_materials = {},
				material_effects = {},
				xyz_materials = 0,
				revived = false,
				perma_debuffed = false,
				is_free = false,
				cannot_revive = params.cannot_revive or false,
				flip_active = false,
				cannot_flip = false,
				detached_count = 0,
				detached_count_round = 0,
			}
		or {
			is_field_spell = true,
			monster_archetypes = params.monster_archetypes or {},
			perma_debuffed = false,
			is_free = false,
		}
end

SMODS.Joker({
	key = "stormshooter",
	atlas = "stolen",
	pos = { x = 9, y = 6 },
	rarity = 2,
	in_pool = function(self, args)
        return false
    end,
	stolen_from = "JoyousSpring",
	discovered = true,
	blueprint_compat = false,
	eternal_compat = true,
	cost = 8,
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.column, JROK.get_joker_column(card) } }
	end,
	config = {
		extra = {
			joyous_spring = JROK.init_joy_table({
				attribute = "WIND",
				monster_type = "WingedBeast",
			}),
			column = 2,
		},
	},
	calculate = function(self, card, context)
		if JROK.can_use_abilities(card) then
			if
				context.after
				and JROK.get_joker_column(card) == card.ability.extra.column
				and #context.full_hand >= card.ability.extra.column
				and not SMODS.in_scoring(context.full_hand[card.ability.extra.column], context.scoring_hand)
				and #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit
			then
				local planet = JROK.get_played_planet(context.scoring_name)
				if planet then
					local amount = G.consumeables.config.card_limit - #G.consumeables.cards
					for i = 1, amount do
						SMODS.add_card({
							key = planet,
						})
					end
				end
			end
			if context.end_of_round and context.game_over == false and context.main_eval then
				card.ability.extra.column = pseudorandom("j_joy_stormshooter", 2, 5)
			end
		end
	end,
	add_to_deck = function(self, card, from_debuff)
		card.ability.extra.column = pseudorandom("j_joy_stormshooter", 2, 5)
	end,
})

JROK.get_joker_column = function(joker)
	return G.jokers and JROK.index_of(G.jokers.cards or {}, joker) or 0
end

JROK.index_of = function(array, value)
	for i, v in ipairs(array) do
		if v == value then
			return i
		end
	end
	return nil
end

JROK.get_played_planet = function(handname)
	local planet
	for _, center in pairs(G.P_CENTER_POOLS.Planet) do
		if center.config.hand_type == handname then
			planet = center.key
		end
		if center.config.joy_hand_types then
			for _, name in ipairs(center.config.joy_hand_types) do
				if name == handname then
					planet = center.key
					break
				end
			end
			if planet then
				break
			end
		end
	end
	return planet
end

JROK.can_use_abilities = function(card)
	if not card or card.debuff then
		return false
	end
	if card.facing == "front" then
		return true
	end
	for _, joker in ipairs(G.jokers.cards) do
		if
			not joker.debuff
			and joker.config.center.joy_allow_ability
			and joker.config.center.joy_allow_ability(joker, card)
		then
			return true
		end
	end
	if JoyousSpring then
		for _, joker in ipairs(JoyousSpring.field_spell_area.cards) do
			if
				not joker.debuff
				and joker.config.center.joy_allow_ability
				and joker.config.center.joy_allow_ability(joker, card)
			then
				return true
			end
		end
	end
	return false
end
