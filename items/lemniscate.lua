--- Gets if the current blind is a Small Blind, or one of Ortalab's equivalents.
--- @return boolean
function JROK.is_small_blind()
	for _, blind in ipairs({
		"Small Blind", -- AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
		"bl_small", -- future proofing against localthunk gaining sanity
		"bl_ortalab_fold",
		"bl_ortalab_check",
		"bl_ortalab_bet",
		"bl_entr_small",
	}) do
		local is_small = SMODS.is_active_blind(blind, true)
		if is_small then
			return true
		end
	end

	return false
end

SMODS.Joker({
	key = "dead_ringer",
	atlas = "stolen",
	stolen_from = "Lemniscate",
	pos = { x = 1, y = 6 },
	pixel_size = { w = 70, h = 95 }, -- horror
	rarity = 3,
	cost = 8,
	blueprint_compat = true,
	demicoloncompat = true,
	config = {
		extra = {
			xmult = 3,
			active = false,
		},
	},
	in_pool = function(self, args)
		return false
	end,
	loc_vars = function(self, info_queue, card)
		-- clarify that Ortalab's parallel blinds are counted
		if (SMODS.Mods.ortalab or {}).can_load then
			info_queue[#info_queue + 1] = {
				key = "o_jrok_ortalab_dead_ringer",
				set = "Other",
			}
		end

		return {
			vars = {
				card.ability.extra.xmult,
				card.ability.extra.active and localize({
					type = "variable",
					key = "loyalty_active",
				}) or localize("k_jrok_inactive"),
			},
		}
	end,

	calculate = function(self, card, context)
		if context.end_of_round and context.main_eval and not context.blueprint then
			if context.game_over and JROK.is_small_blind() then
				card.ability.extra.active = true
				return {
					message = localize("k_saved_ex"),
					saved = "ph_jrok_dead_ringer_saved",
					colour = G.C.RED,
				}
			elseif context.beat_boss then
				card.ability.extra.active = false
				return {
					message = localize("k_reset"),
				}
			end
		end

		if context.joker_main and card.ability.extra.active then
			return {
				xmult = card.ability.extra.xmult,
			}
		end
	end,
})

SMODS.Joker({
	key = "fireball",
	atlas = "stolen",
	stolen_from = "Lemniscate",
	in_pool = function(self, args)
		return false
	end,
	spectralized_atlas = "lem_spells_spectralized", -- this involves a lovely patch
	pos = { x = 2, y = 6 },
	cost = 3,
	rarity = 1,

	config = {
		extra = {
			xmult = 3,
			triggered = false,
		},
	},

	loc_vars = function(self, info_queue, card)
		return {
			---@diagnostic disable-next-line: undefined-global
			key = (next(SMODS.Mods.Lemniscate or {}) and Lemniscate.show_infinite_spell_infoqueue(card))
					and self.key .. "_infinity"
				or nil,
			vars = {
				card.ability.extra.xmult,
			},
		}
	end,

	calculate = function(self, card, context)
		if context.joker_main then
			card.ability.extra.triggered = true
			return {
				xmult = card.ability.extra.xmult,
			}
		end
		if context.after and card.ability.extra.triggered then
			return {
				func = function()
					if not card.ability.lem_infinite_spell then
						SMODS.destroy_cards(card, true)
					end
				end,
			}
		end
	end,
	update = function(self, card, dt)
		-- spectralize spell cards
		if card.ability.lem_spectralized then
			card.children.center.atlas = SMODS.get_atlas(card.config.center.spectralized_atlas)
		end
	end,
	set_card_type_badge = function(self, card, badges)
		local strings = { localize("k_common"), localize("k_jrok_spell") }
		for _ = 1, 9 do
			strings[#strings + 1] = localize("k_common")
		end
		badges[#badges + 1] = {
			n = G.UIT.R,
			config = { align = "cm" },
			nodes = {
				{
					n = G.UIT.R,
					config = {
						align = "cm",
						colour = G.C.BLUE,
						r = 0.1,
						minw = 2,
						minh = 0.4 * 1.2,
						emboss = 0.05,
						padding = 0.03 * 1.2,
						func = "update_badge_lem",
					},
					nodes = {
						{ n = G.UIT.B, config = { h = 0.1, w = 0.03 } },
						{
							n = G.UIT.O,
							config = {
								object = DynaText({
									string = strings,
									colours = { G.C.WHITE },
									float = true,
									shadow = true,
									offset_y = -0.05,
									silent = true,
									spacing = 1,
									scale = 0.33 * 1.2,
									pop_in_rate = 9999999,
									random_element = true,
									pop_delay = 0.3,
									min_cycle_time = 0,
								}),
							},
						},
						{ n = G.UIT.B, config = { h = 0.1, w = 0.03 } },
					},
				},
			},
		}
	end,
})

function G.FUNCS.update_badge_lem(e)
	local target_uie = e.children[2]
	local target_dynatext = target_uie.config.object
	if target_dynatext.focused_string == 2 then
		e.config.colour = HEX("b386c4")
	else
		e.config.colour = G.C.BLUE
	end
end
