SMODS.Atlas({
	key = "al_jokers",
	path = "al_jokers.png",
	px = 71,
	py = 95,
})

SMODS.Atlas({
	key = "modicon",
	path = "jrok.png",
	px = 34,
	py = 34,
})

for k, c in pairs(G.P_CENTERS) do
	if c.set == "Joker" and not c.original_mod then
		SMODS.Joker:take_ownership(string.sub(k, 3), { atlas = "al_jokers" }, true)
	end
end

local init_loc_hook = init_localization
function init_localization()
	for k, c in pairs(G.P_CENTERS) do
		if c.set == "Joker" and not c.original_mod then
			local text = G.localization.descriptions.Joker[k].text
			local new_text = {}
			for _, line in ipairs(text) do
				local res = line
				if string.find(line, "(({.*}).*)[aA][iI]") then
					res = string.gsub(line, "(({.*}).*)[aA][iI]", "%1{C:attention}AI%2")
				else
					res = string.gsub(line, "[aA][iI]", "{C:attention}AI{}")
				end
				new_text[#new_text + 1] = res
			end
			G.localization.descriptions.Joker[k].text = new_text
		end
	end
	init_loc_hook()
end

JROK = {}
JROK.prompt_text = ""
JROK.menu_prompt = ""

function G.FUNCS.jrok_start_run_prompt(e)
	JROK.prompt_text = ""
	G.SETTINGS.paused = true
	local uidef = {
		n = G.UIT.ROOT,
		config = {
			align = "cm",
			minw = G.ROOM.T.w * 5,
			minh = G.ROOM.T.h * 5,
			padding = 0.1,
			r = 0.1,
			colour = { G.C.GREY[1], G.C.GREY[2], G.C.GREY[3], 0.7 },
		},
		nodes = {
			{
				n = G.UIT.R,
				config = { r = 0.1, colour = G.C.JOKER_GREY, padding = 0.05, align = "cm" },
				nodes = {
					{
						n = G.UIT.C,
						config = { colour = G.C.L_BLACK, r = 0.1, padding = 0.2, align = "cm" },
						nodes = {
							{
								n = G.UIT.R,
								config = { align = "cm" },
								nodes = {
									{
										n = G.UIT.C,
										config = { align = "cm", minh = 4 },
										nodes = {
											{
												n = G.UIT.R,
												config = { align = "cm", padding = 0.1 },
												nodes = {
													{
														n = G.UIT.O,
														config = {
															object = SMODS.create_sprite(
																0,
																0,
																1,
																1,
																"jrok_modicon",
																{ x = 0, y = 0 }
															),
														},
													},
													{
														n = G.UIT.B,
														config = { w = 0.1, h = 0.1 },
													},
													{
														n = G.UIT.T,
														config = {
															text = localize("k_jrok"),
															scale = 0.8,
															colour = G.C.UI.TEXT_LIGHT,
														},
													},
												},
											},
											{
												n = G.UIT.R,
												config = { align = "cm", padding = 0.1 },
												nodes = {
													{
														n = G.UIT.T,
														config = {
															text = localize("k_jrok_prompt"),
															scale = 0.7,
															colour = G.C.UI.TEXT_LIGHT,
														},
													},
												},
											},
											{
												n = G.UIT.R,
												config = { minh = 0.2 },
											},
											{
												n = G.UIT.R,
												config = { padding = 0.1, align = "cm" },
												nodes = {
													create_text_input({
														prompt_text = localize("k_jrok_text_prompt"),
														ref_table = JROK,
														ref_value = "prompt_text",
														max_length = 500,
														w = 11,
														extended_corpus = true,
													}),
													{
														n = G.UIT.C,
														config = {
															button = "start_setup_run_from_jrok",
															ref_element = e,
															colour = G.C.BLUE,
															minh = 0.6,
															minw = 1.8,
															padding = 0.05,
															r = 0.1,
															hover = true,
															shadow = true,
															align = "cm",
															func = "can_start_jrok",
														},
														nodes = {
															{
																n = G.UIT.T,
																config = {
																	text = localize("k_jrok_start"),
																	scale = 0.4,
																	colour = G.C.UI.TEXT_LIGHT,
																},
															},
														},
													},
												},
											},
										},
									},
								},
							},
							{
								n = G.UIT.R,
								config = {
									id = "overlay_menu_back_button",
									align = "cm",
									minw = 2.5,
									padding = 0.1,
									r = 0.1,
									hover = true,
									colour = G.C.ORANGE,
									button = "exit_overlay_menu",
									shadow = true,
									focus_args = { nav = "wide", button = "b" },
								},
								nodes = {
									{
										n = G.UIT.R,
										config = { align = "cm", padding = 0, no_fill = true },
										nodes = {
											{
												n = G.UIT.T,
												config = {
													text = localize("b_back"),
													scale = 0.5,
													colour = G.C.UI.TEXT_LIGHT,
													shadow = true,
												},
											},
										},
									},
								},
							},
						},
					},
				},
			},
		},
	}
	G.FUNCS.overlay_menu({
		definition = uidef,
		config = {
			--no_esc = true,
		},
	})
end

function G.FUNCS.start_setup_run_from_jrok(e)
	G.FUNCS.start_setup_run(e.config.ref_element)
end

local can_start_run_hook = G.FUNCS.can_start_run
function G.FUNCS.can_start_run(e)
	can_start_run_hook(e)
	if G.GAME.viewed_back.effect.center.unlocked and G.SETTINGS.current_setup ~= "Continue" then
		e.config.colour = G.C.BLUE
		e.config.button = "jrok_start_run_prompt"
	end
end

function G.FUNCS.can_start_jrok(e)
	if JROK.prompt_text ~= "" then
		e.config.colour = G.C.BLUE
		e.config.button = "start_setup_run_from_jrok"
	else
		e.config.colour = G.C.UI.BACKGROUND_INACTIVE
		e.config.button = nil
	end
end

function G.FUNCS.jrok_menu_prompt(e)
	JROK.menu_prompt = ""
	G.SETTINGS.paused = true
	local icon = SMODS.create_sprite(0, 0, 1, 1, "jrok_modicon", { x = 0, y = 0 })
	local uidef = {
		n = G.UIT.ROOT,
		config = {
			align = "cm",
			minw = G.ROOM.T.w * 5,
			minh = G.ROOM.T.h * 5,
			padding = 0.1,
			r = 0.1,
			colour = { G.C.GREY[1], G.C.GREY[2], G.C.GREY[3], 0.7 },
		},
		nodes = {
			{
				n = G.UIT.R,
				config = { r = 0.1, colour = G.C.JOKER_GREY, padding = 0.05, align = "cm" },
				nodes = {
					{
						n = G.UIT.C,
						config = { colour = G.C.L_BLACK, r = 0.1, padding = 0.2, align = "cm" },
						nodes = {
							{
								n = G.UIT.R,
								config = { align = "cm" },
								nodes = {
									{
										n = G.UIT.C,
										config = { align = "cm", minh = 4 },
										nodes = {
											{
												n = G.UIT.R,
												config = { align = "cm", padding = 0.1 },
												nodes = {
													{
														n = G.UIT.O,
														config = {
															object = icon,
														},
													},
													{
														n = G.UIT.B,
														config = { w = 0.1, h = 0.1 },
													},
													{
														n = G.UIT.T,
														config = {
															text = localize("k_jrok"),
															scale = 0.8,
															colour = G.C.UI.TEXT_LIGHT,
														},
													},
												},
											},
											{
												n = G.UIT.R,
												config = { align = "cm", padding = 0.1 },
												nodes = {
													{
														n = G.UIT.T,
														config = {
															text = localize("k_jrok_prompt2"),
															scale = 0.7,
															colour = G.C.UI.TEXT_LIGHT,
														},
													},
												},
											},
											{
												n = G.UIT.R,
												config = { minh = 0.2 },
											},
											{
												n = G.UIT.R,
												config = { padding = 0.1, align = "cm" },
												nodes = {
													create_text_input({
														prompt_text = localize("k_jrok_text_prompt2"),
														ref_table = JROK,
														ref_value = "menu_prompt",
														max_length = 500,
														w = 12.2,
														extended_corpus = true,
													}),
													{
														n = G.UIT.C,
														config = {
															button = "process_jrok_prompt",
															ref_element = e,
															colour = G.C.BLUE,
															minh = 0.6,
															minw = 0.6,
															padding = 0.05,
															r = 0.1,
															hover = true,
															shadow = true,
															align = "cm",
															func = "can_submit_jrok_prompt",
														},
														nodes = {
															{
																n = G.UIT.T,
																config = {
																	text = localize("k_jrok_arrow"),
																	scale = 0.4,
																	colour = G.C.UI.TEXT_LIGHT,
																},
															},
														},
													},
												},
											},
										},
									},
								},
							},
							{
								n = G.UIT.R,
								config = {
									id = "overlay_menu_back_button",
									align = "cm",
									minw = 2.5,
									padding = 0.1,
									r = 0.1,
									hover = true,
									colour = G.C.ORANGE,
									button = "exit_overlay_menu",
									shadow = true,
									focus_args = { nav = "wide", button = "b" },
								},
								nodes = {
									{
										n = G.UIT.R,
										config = { align = "cm", padding = 0, no_fill = true },
										nodes = {
											{
												n = G.UIT.T,
												config = {
													text = localize("b_back"),
													scale = 0.5,
													colour = G.C.UI.TEXT_LIGHT,
													shadow = true,
												},
											},
										},
									},
								},
							},
						},
					},
				},
			},
		},
	}
	G.FUNCS.overlay_menu({
		definition = uidef,
		config = {
			--no_esc = true,
		},
	})
	G.E_MANAGER:add_event(Event({
		blocking = false,
		blockable = false,
		timer = "REAL",
		trigger = "immediate",
		func = function()
			G.OVERLAY_MENU:recalculate()
			return true
		end,
	}))
end

function G.FUNCS.can_submit_jrok_prompt(e)
	if JROK.menu_prompt ~= "" then
		e.config.colour = G.C.BLUE
		e.config.button = "process_jrok_prompt"
	else
		e.config.colour = G.C.UI.BACKGROUND_INACTIVE
		e.config.button = nil
	end
end

function G.FUNCS.process_jrok_prompt(e)
	JROK.from_jrok = true
	if JROK.menu_prompt:find("custom") or JROK.menu_prompt:find("skin") or JROK.menu_prompt:find("collab") then
		G.FUNCS.customize_deck(e)
	elseif JROK.menu_prompt:find("deck") or JROK.menu_prompt:find("card") then
		G.FUNCS.deck_info(e)
	elseif JROK.menu_prompt:find("restart") or JROK.menu_prompt:find("reset") then
		G.FUNCS.setup_run(e)
	elseif JROK.menu_prompt:find("seed") and G.GAME.seeded then
		G.FUNCS.copy_seed(e)
	elseif JROK.menu_prompt:find("run") or JROK.menu_prompt:find("planet") or JROK.menu_prompt:find("level") then
		G.FUNCS.run_info(e)
	elseif JROK.menu_prompt:find("mod") then
		G.FUNCS.mods_button(e)
	elseif
		JROK.menu_prompt:find("main")
		or JROK.menu_prompt:find("title")
		or JROK.menu_prompt:find("quit")
		or JROK.menu_prompt:find("exit")
	then
		G.FUNCS.go_to_menu(e)
	elseif JROK.menu_prompt:find("collection") then
		G.FUNCS.your_collection(e)
	elseif JROK.menu_prompt:find("setting") or JROK.menu_prompt:find("option") then
		G.FUNCS.settings(e)
	elseif JROK.menu_prompt:find("score") then
		G.FUNCS.high_scores(e)
	end
	JROK.from_jrok = nil
end

local options_hook = G.FUNCS.options
G.FUNCS.options = function(e)
	if G.STAGE == G.STAGES.RUN then
		G.FUNCS.jrok_menu_prompt(e)
	else
		options_hook(e)
	end
end

local deck_info_hook = G.FUNCS.deck_info
function G.FUNCS.deck_info(e)
	if not JROK.from_jrok then
		G.FUNCS.jrok_menu_prompt(e)
	else
		deck_info_hook(e)
	end
end

local run_info_hook = G.FUNCS.run_info
function G.FUNCS.run_info(e)
	if not JROK.from_jrok then
		G.FUNCS.jrok_menu_prompt(e)
	else
		run_info_hook(e)
	end
end

local update_hook = Game.update
function Game:update(dt)
	update_hook(self, dt)
	for _, card in ipairs(G.I.CARD) do
		if card.ability and card.ability.set == "Joker" then
			if G.GAME.jrok_prompt and JROK.yuri() then
				if card.config.center_key == "j_blueprint" or card.config.center_key == "j_brainstorm" then
					card:set_cost()
				end
			end
		end
	end
end

SMODS.current_mod.calculate = function(self, context)
	if context.create_shop_card then
		local item = JROK.generate_joker(true)
		if item then
			return {
				shop_create_flags = {
					key = item,
				},
			}
		end
	end
	if context.setting_blind and JROK.naneinf() and context.blind.key == "bl_final_vessel" then
		G.E_MANAGER:add_event(Event({
			func = function()
				G.GAME.blind.chips = 1e210 * 1e210
				G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
				SMODS.juice_up_blind()
				return true
			end,
		}))
	end
end

SMODS.Booster:take_ownership_by_kind("Buffoon", {
	create_card = function()
		local item = JROK.generate_joker()
		if item then
			return {
				area = G.pack_cards,
				skip_materialize = true,
				soulable = true,
				key_append = "buf",
				key = item,
			}
		end
		return {
			set = "Joker",
			area = G.pack_cards,
			skip_materialize = true,
			soulable = true,
			key_append = "buf",
		}
	end,
}, true)

SMODS.Booster:take_ownership_by_kind("Arcana", {
	create_card = function()
		local item = JROK.generate_tarot()
		if item then
			return {
				area = G.pack_cards,
				skip_materialize = true,
				soulable = true,
				key_append = "ar2",
				key = item,
			}
		end
		local _card
		if G.GAME.used_vouchers.v_omen_globe and pseudorandom("omen_globe") > 0.8 then
			_card = {
				set = "Spectral",
				area = G.pack_cards,
				skip_materialize = true,
				soulable = true,
				key_append = "ar2",
			}
		else
			_card = {
				set = "Tarot",
				area = G.pack_cards,
				skip_materialize = true,
				soulable = true,
				key_append = "ar1",
			}
		end
		return _card
	end,
}, true)

SMODS.Booster:take_ownership_by_kind("Spectral", {
	create_card = function()
		local item = JROK.generate_spectral()
		if item then
			return {
				area = G.pack_cards,
				skip_materialize = true,
				soulable = true,
				key_append = "ar2",
				key = item,
			}
		end
		return {
			set = "Spectral",
			area = G.pack_cards,
			skip_materialize = true,
			soulable = true,
			key_append = "spe",
		}
	end,
}, true)

function JROK.generate_joker(shop)
	local pool = {}
	if JROK.bananas() then
		pool[#pool + 1] = "j_gros_michel"
		pool[#pool + 1] = "j_cavendish"
	end
	if JROK.cloud_9() then
		pool[#pool + 1] = "cloud_9"
	end
	if JROK.yuri() then
		if shop then
			pool[#pool + 1] = "j_brainstorm"
			pool[#pool + 1] = "j_blueprint"
		else
			pool[#pool + 1] = "j_credit_card"
		end
	end
	if JROK.photochad() then
		pool[#pool + 1] = "j_photograph"
		pool[#pool + 1] = "j_hanging_chad"
	end
	if JROK.naneinf() then
		pool[#pool + 1] = "j_mime"
		pool[#pool + 1] = "j_baron"
	end
	if JROK.wheel() then
		pool[#pool + 1] = "j_bloodstone"
		pool[#pool + 1] = "j_space"
		pool[#pool + 1] = "j_hallucination"
		pool[#pool + 1] = "j_business"
		pool[#pool + 1] = "j_8_ball"
	end
	if next(pool) then
		return pseudorandom_element(pool, "jrok_prompt")
	end
end

function JROK.generate_tarot()
	local pool = {}
	if JROK.legendary() then
		pool[#pool + 1] = "c_soul"
	end
	if JROK.wheel() then
		pool[#pool + 1] = "c_wheel_of_fortune"
	end
	if next(pool) then
		return pseudorandom_element(pool, "jrok_prompt")
	end
end

function JROK.generate_planet()
	local pool = {}
	-- TODO
	if next(pool) then
		return pseudorandom_element(pool, "jrok_prompt")
	end
end

function JROK.generate_spectral()
	local pool = {}
	if JROK.legendary() then
		pool[#pool + 1] = "c_soul"
	end
	if next(pool) then
		return pseudorandom_element(pool, "jrok_prompt")
	end
end

function JROK.generate_blind()
	local pool = {}
	if JROK.photochad() then
		pool[#pool + 1] = "bl_plant"
	end
	if JROK.naneinf() and (G.GAME.round_resets.ante % G.GAME.win_ante == 0 and G.GAME.round_resets.ante >= 2) then
		pool[#pool + 1] = "bl_final_vessel"
	end
	if JROK.wheel() then
		pool[#pool + 1] = "bl_wheel"
	end
	if next(pool) then
		return pseudorandom_element(pool, "jrok_prompt")
	end
end

local get_new_boss_hook = get_new_boss
function get_new_boss()
	local ret = get_new_boss_hook()
	local generated = JROK.generate_blind()
	if generated then
		ret = generated
	end
	return ret
end

function JROK.bananas()
	return G.GAME.jrok_prompt:find("banana")
		or G.GAME.jrok_prompt:find("gros")
		or G.GAME.jrok_prompt:find("cavendish")
		or G.GAME.jrok_prompt:find("potassium")
end

function JROK.cloud_9()
	return G.GAME.jrok_prompt:find("cloud") or G.GAME.jrok_prompt:find("9")
end

function JROK.legendary()
	return G.GAME.jrok_prompt:find("legendary") or G.GAME.jrok_prompt:find("soul")
end

function JROK.yuri()
	return G.GAME.jrok_prompt:find("blueprint")
		or G.GAME.jrok_prompt:find("brainstorm")
		or G.GAME.jrok_prompt:find("yuri")
end

function JROK.photochad()
	return G.GAME.jrok_prompt:find("photo")
		or G.GAME.jrok_prompt:find("chad")
		or G.GAME.jrok_prompt:find("yaoi")
		or G.GAME.jrok_prompt:find("chud")
end

function JROK.naneinf()
	return G.GAME.jrok_prompt:find("baron") or G.GAME.jrok_prompt:find("mime") or G.GAME.jrok_prompt:find("inf")
end

function JROK.wheel()
	for _, str in ipairs({
		"space",
		"glass",
		"wheel",
		"fortune",
		"luck",
		"oops",
		"blood",
		"park",
		"hallucin",
		"business",
		"ball",
		"chance",
	}) do
		if G.GAME.jrok_prompt:find(str) then
			return true
		end
	end
	return false
end

SMODS.Joker:take_ownership("gros_michel", {
	calculate = function(self, card, context)
		if context.end_of_round and context.game_over == false and context.main_eval and not context.blueprint then
			if
				JROK.bananas()
				or G.GAME.jrok_prompt:find("banana")
				or SMODS.pseudorandom_probability(card, "gros_michel", 1, card.ability.extra.odds)
			then
				SMODS.destroy_cards(card, nil, nil, true)
				G.GAME.pool_flags.gros_michel_extinct = true
				return {
					message = localize("k_extinct_ex"),
				}
			else
				return {
					message = localize("k_safe_ex"),
				}
			end
		end
		if context.joker_main then
			return {
				mult = card.ability.extra.mult,
			}
		end
	end,
}, true)

SMODS.Joker:take_ownership("cavendish", {
	calculate = function(self, card, context)
		if context.end_of_round and context.game_over == false and context.main_eval and not context.blueprint then
			if JROK.bananas() or SMODS.pseudorandom_probability(card, "cavendish", 1, card.ability.extra.odds) then
				SMODS.destroy_cards(card, nil, nil, true)
				return {
					message = localize("k_extinct_ex"),
				}
			else
				return {
					message = localize("k_safe_ex"),
				}
			end
		end
		if context.joker_main then
			return {
				xmult = card.ability.extra.Xmult,
			}
		end
	end,
}, true)

SMODS.Consumable:take_ownership("soul", {
	use = function(self, card, area, copier)
		if JROK.legendary() then
			G.E_MANAGER:add_event(Event({
				trigger = "after",
				delay = 0.4,
				func = function()
					play_sound("timpani")
					SMODS.add_card({ set = "Joker" })
					card:juice_up(0.3, 0.5)
					return true
				end,
			}))
			delay(0.6)
		else
			G.E_MANAGER:add_event(Event({
				trigger = "after",
				delay = 0.4,
				func = function()
					play_sound("timpani")
					SMODS.add_card({ set = "Joker", legendary = true })
					check_for_unlock({ type = "spawn_legendary" })
					card:juice_up(0.3, 0.5)
					return true
				end,
			}))
			delay(0.6)
		end
	end,
}, true)

SMODS.Atlas({
	key = "stolen",
	path = "stolen_spritesheet.png",
	px = 71,
	py = 95,
})

--#region TBOJ
SMODS.Joker({
	key = "monstro_lung",
	pos = { x = 0, y = 0 },
	config = { extra = { min = 1, max = 2 } },
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.min, card.ability.extra.max } }
	end,
	rarity = 1,
	cost = 5,
	atlas = "stolen",
	perishable_compat = true,
	eternal_compat = true,
	blueprint_compat = true,
	calculate = function(self, card, context)
		if context.determine_hand then
			local cards_added = {}
			local to_add = pseudorandom("jrok_montro_lung", card.ability.extra.min, card.ability.extra.max)
			for _ = 1, to_add do
				local _card = SMODS.create_card({
					set = "Base",
					seal = SMODS.poll_seal({ mod = 10 }),
					edition = SMODS.poll_edition({ key = "jrok_montro_lung", mod = 2, no_negative = true }),
					area = G.play,
				})
				_card.monstro_target = true
				_card.states.visible = false
				_card:add_to_deck()
				G.deck.config.card_limit = G.deck.config.card_limit + 1
				G.play:emplace(_card)
				G.E_MANAGER:add_event(Event({
					func = function()
						_card:start_materialize()
						if context.blueprint_card then
							context.blueprint_card:juice_up()
						else
							card:juice_up()
						end
						return true
					end,
				}))
				table.insert(cards_added, _card)
			end
			SMODS.calculate_context({ playing_card_added = true, cards = cards_added })
		end
		if context.destroy_card and not context.blueprint then
			if context.destroy_card.monstro_target then
				return { remove = true }
			end
		end
	end,
	in_pool = function(self, args)
		return false
	end,
})

SMODS.Joker({
	key = "dream_catcher",
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
	return boss
end
--#endregion

