SMODS.Atlas({
	key = "al_jokers",
	path = "al_jokers.png",
	px = 71,
	py = 95,
})

SMODS.Atlas({
	key = "new_al",
	path = "new_al.png",
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
		SMODS.Joker:take_ownership(string.sub(k, 3), { atlas = "new_al" }, true)
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

JROK_MOD = SMODS.current_mod
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
									func = "jrok_can_exit",
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
			no_esc = G.STATE == G.STATES.GAME_OVER,
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
										config = { align = "cm", minh = 4, id = "error_entry" },
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
		config = {},
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

function G.FUNCS.jrok_can_exit(e)
	if G.STATE == G.STATES.GAME_OVER then
		e.config.button = nil
		e.config.colour = G.C.UI.BACKGROUND_INACTIVE
	else
		e.config.button = "exit_overlay_menu"
		e.config.colour = G.C.ORANGE
	end
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
	elseif JROK.menu_prompt:find("deck") or JROK.menu_prompt:find("card") or JROK.menu_prompt:find("view") then
		G.FUNCS.deck_info(e)
	elseif JROK.menu_prompt:find("restart") or JROK.menu_prompt:find("reset") then
		G.FUNCS.setup_run(e)
	elseif JROK.menu_prompt:find("seed") and G.GAME.seeded then
		G.FUNCS.copy_seed(e)
	elseif JROK.menu_prompt:find("run") or JROK.menu_prompt:find("planet") or JROK.menu_prompt:find("level") or JROK.menu_prompt:find("hand") then
		G.FUNCS.run_info(e)
	elseif JROK.menu_prompt:find("score") or JROK.menu_prompt:find("high") then
		G.FUNCS.high_scores(e)
	elseif JROK.menu_prompt:find("mod") then
		G.FUNCS.mods_button(e)
	elseif
		JROK.menu_prompt:find("main")
		or JROK.menu_prompt:find("title")
		or JROK.menu_prompt:find("quit")
		or JROK.menu_prompt:find("exit")
		or JROK.menu_prompt:find("menu")
	then
		G.FUNCS.go_to_menu(e)
	elseif JROK.menu_prompt:find("collection") then
		G.FUNCS.your_collection(e)
	elseif JROK.menu_prompt:find("setting") or JROK.menu_prompt:find("option") then
		G.FUNCS.settings(e)
	elseif not G.OVERLAY_MENU:get_UIE_by_ID("errored") then
		local element = G.OVERLAY_MENU:get_UIE_by_ID("error_entry")
		G.OVERLAY_MENU:add_child({
			n = G.UIT.R,
			config = { align = "cm", padding = 0.2, id = "errored" },
			nodes = {
				{
					n = G.UIT.T,
					config = {
						text = localize("k_jrok_error"),
						scale = 0.4,
						colour = G.C.UI.TEXT_LIGHT,
					},
				},
			},
		}, element)
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

SMODS.current_mod.optional_features = {
	post_trigger = true,
}

SMODS.current_mod.calculate = function(self, context)
	if context.create_shop_card then
		if JROK.glitched() then
			return {
				shop_create_flags = {
					set = pseudorandom("glitch", 1, 2) == 1 and "Planet" or "Spectral",
				},
			}
		end
		if context.set == "Joker" then
			local item = JROK.generate_joker(true)
			local edition = nil
			if JROK.plagiarized() and pseudorandom("hallucination", 1, 4) == 1 then
				edition = "e_jrok_hallucinated"
			end
			if item then
				return {
					shop_create_flags = {
						key = item,
						edition = edition,
					},
				}
			end
		elseif context.set == "Tarot" then
			local item = JROK.generate_tarot(true)
			if item then
				return {
					shop_create_flags = {
						key = item,
					},
				}
			end
		elseif context.set == "Spectral" then
			local item = JROK.generate_spectral(true)
			if item then
				return {
					shop_create_flags = {
						key = item,
					},
				}
			end
		elseif context.set == "Planet" then
			local item = JROK.generate_planet(true)
			if item then
				return {
					shop_create_flags = {
						key = item,
					},
				}
			end
		end
	end
	if context.setting_blind and JROK.naneinf() and context.blind.key == "bl_final_vessel" then
		if G.GAME.selected_back.effect.center.key ~= "b_jrok_ai" then
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
	if context.money_altered and context.amount < 0 then
		G.GAME.round_scores.jrok_gallons.amt = G.GAME.round_scores.jrok_gallons.amt
			+ math.random(-context.amount, -context.amount * 3)
	end
	if context.end_of_round and context.main_eval and not context.game_over then
		for _, j in ipairs(G.jokers.cards) do
			if JROK.nope() and pseudorandom("nope", 1, 8) == 1 then
				local card = j
				SMODS.calculate_effect({
					message = localize("k_nope_ex"),
					colour = G.C.SECONDARY_SET.Tarot,
					func = function()
						G.E_MANAGER:add_event(Event({
							func = function()
								if not card.debuff then
									SMODS.debuff_card(card, "jrok_noped", "nope")
									card:juice_up(0.1, 0.1)
								end
								return true
							end,
						}))
					end,
				}, card)
			end
		end
	end
	if context.after then
		if JROK.nope() then
			local noped = false
			for _, card in ipairs(context.scoring_hand) do
				if pseudorandom("nope", 1, 8) == 1 then
					noped = true
					SMODS.calculate_effect({
						message = localize("k_nope_ex"),
						colour = G.C.SECONDARY_SET.Tarot,
						func = function()
							G.E_MANAGER:add_event(Event({
								func = function()
									if not card.debuff then
										SMODS.debuff_card(card, "jrok_noped", "nope")
										card:juice_up(0.1, 0.1)
									end
									return true
								end,
							}))
						end,
					}, card)
				end
			end
			if noped then
				delay(2.5)
			end
		end
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
		pool[#pool + 1] = "j_cloud_9"
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
	if JROK.lucky() then
		pool[#pool + 1] = "j_bloodstone"
		pool[#pool + 1] = "j_hallucination"
		pool[#pool + 1] = "j_business"
		pool[#pool + 1] = "j_8_ball"
	end
	if JROK.plagiarized() then
		for key, center in pairs(G.P_CENTERS) do
			if center.set == "Joker" and center.original_mod == JROK_MOD then
				pool[#pool + 1] = key
			end
		end
	end
	if JROK.stolen() then
		pool[#pool + 1] = "j_burglar"
	end
	if JROK.cryptid() then
		pool[#pool + 1] = "j_chicot"
		pool[#pool + 1] = "j_obelisk"
		pool[#pool + 1] = "j_jolly"
	end
	if JROK.summarize() then
		pool[#pool + 1] = "j_diet_cola"
		pool[#pool + 1] = "j_throwback"
	end
	if JROK.green() then
		pool[#pool + 1] = "j_green_joker"
	end
	if JROK.space() then
		pool[#pool + 1] = "j_space"
	end
	if next(pool) then
		return pseudorandom_element(pool, "jrok_prompt")
	end
end

local skip_hook = G.FUNCS.skip_blind
function G.FUNCS.skip_blind(e)
	if JROK.summarize() and pseudorandom("summarize", 1, 2) == 1 then
		stop_use()
		G.CONTROLLER.locks.skip_blind = true
		G.E_MANAGER:add_event(Event({
			no_delete = true,
			trigger = "after",
			blocking = false,
			blockable = false,
			delay = 2.5,
			timer = "TOTAL",
			func = function()
				G.CONTROLLER.locks.skip_blind = nil
				return true
			end,
		}))
		G.E_MANAGER:add_event(Event({
			trigger = "after",
			delay = 0.4,
			func = function()
				attention_text({
					text = localize("k_nope_ex"),
					scale = 1.3,
					hold = 1.4,
					major = G.play,
					backdrop_colour = G.C.SECONDARY_SET.Tarot,
					align = (
						G.STATE == G.STATES.TAROT_PACK
						or G.STATE == G.STATES.SPECTRAL_PACK
						or G.STATE == G.STATES.SMODS_BOOSTER_OPENED
					)
							and "tm"
						or "cm",
					offset = {
						x = 0,
						y = (
							G.STATE == G.STATES.TAROT_PACK
							or G.STATE == G.STATES.SPECTRAL_PACK
							or G.STATE == G.STATES.SMODS_BOOSTER_OPENED
						)
								and -0.2
							or 0,
					},
					silent = true,
				})
				G.E_MANAGER:add_event(Event({
					trigger = "after",
					delay = 0.06 * G.SETTINGS.GAMESPEED,
					blockable = false,
					blocking = false,
					func = function()
						play_sound("tarot2", 0.76, 0.4)
						return true
					end,
				}))
				play_sound("tarot2", 1, 0.4)
				return true
			end,
		}))
		local skipped, skip_to =
			G.GAME.blind_on_deck or "Small",
			G.GAME.blind_on_deck == "Small" and "Big" or G.GAME.blind_on_deck == "Big" and "Boss" or "Boss"
		G.GAME.round_resets.blind_states[skipped] = "Skipped"
		G.GAME.round_resets.blind_states[skip_to] = "Select"
		G.GAME.blind_on_deck = skip_to
		play_sound("generic1")
	else
		return skip_hook(e)
	end
end

function JROK.generate_tarot(shop)
	local pool = {}
	if JROK.legendary() and not shop then
		pool[#pool + 1] = "c_soul"
	end
	if JROK.lucky() then
		pool[#pool + 1] = "c_wheel_of_fortune"
	end
	if next(pool) then
		return pseudorandom_element(pool, "jrok_prompt")
	end
end

function JROK.generate_planet(shop)
	local pool = {}
	if JROK.space() then
		pool[#pool + 1] = "c_earth"
	end
	if next(pool) then
		return pseudorandom_element(pool, "jrok_prompt")
	end
end

function JROK.generate_spectral(shop)
	local pool = {}
	if JROK.legendary() and not shop then
		pool[#pool + 1] = "c_soul"
	end
	if JROK.space() and not shop then
		pool[#pool + 1] = "c_black_hole"
	end
	if next(pool) then
		return pseudorandom_element(pool, "jrok_prompt")
	end
end

function JROK.generate_blind(seed)
	local pool = {}
	if JROK.photochad() then
		pool[#pool + 1] = "bl_plant"
	end
	if JROK.naneinf() and (G.GAME.round_resets.ante % G.GAME.win_ante == 0 and G.GAME.round_resets.ante >= 2) then
		pool[#pool + 1] = "bl_final_vessel"
	end
	if JROK.lucky() then
		pool[#pool + 1] = "bl_wheel"
	end
	if JROK.stolen() then
		pool[#pool + 1] = "bl_mouth"
	end
	if JROK.green() then
		if G.GAME.round_resets.ante % G.GAME.win_ante == 0 and G.GAME.round_resets.ante >= 2 then
			pool[#pool + 1] = "bl_final_leaf"
		else
			pool[#pool + 1] = "bl_water"
		end
	end
	if next(pool) then
		return pseudorandom_element(pool, seed or "jrok_prompt")
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

SMODS.Atlas({
	key = "ai_deck",
	path = "ai_deck.png",
	px = 71,
	py = 95,
})

SMODS.Back({
	key = "ai",
	atlas = "ai_deck",
	pos = { x = 0, y = 0 },
})

function JROK.bananas()
	if G.GAME.selected_back.effect.center.key == "b_jrok_ai" then
		return true
	end
	return G.GAME.jrok_prompt:find("banana")
		or G.GAME.jrok_prompt:find("gros")
		or G.GAME.jrok_prompt:find("cavendish")
		or G.GAME.jrok_prompt:find("potassium")
end

function JROK.cloud_9()
	if G.GAME.selected_back.effect.center.key == "b_jrok_ai" then
		return true
	end
	return G.GAME.jrok_prompt:find("cloud") or G.GAME.jrok_prompt:find("9")
end

function JROK.legendary()
	if G.GAME.selected_back.effect.center.key == "b_jrok_ai" then
		return true
	end
	return G.GAME.jrok_prompt:find("legendary") or G.GAME.jrok_prompt:find("soul")
end

function JROK.yuri()
	if G.GAME.selected_back.effect.center.key == "b_jrok_ai" then
		return true
	end
	return G.GAME.jrok_prompt:find("blueprint")
		or G.GAME.jrok_prompt:find("brainstorm")
		or G.GAME.jrok_prompt:find("yuri")
end

function JROK.photochad()
	if G.GAME.selected_back.effect.center.key == "b_jrok_ai" then
		return true
	end
	return G.GAME.jrok_prompt:find("photo")
		or G.GAME.jrok_prompt:find("chad")
		or G.GAME.jrok_prompt:find("yaoi")
		or G.GAME.jrok_prompt:find("chud")
end

function JROK.naneinf()
	if G.GAME.selected_back.effect.center.key == "b_jrok_ai" then
		return true
	end
	return G.GAME.jrok_prompt:find("baron")
		or G.GAME.jrok_prompt:find("mime")
		or G.GAME.jrok_prompt:find("infinite")
		or G.GAME.jrok_prompt:find("infinity")
end

function JROK.lucky()
	if G.GAME.selected_back.effect.center.key == "b_jrok_ai" then
		return true
	end
	for _, str in ipairs({
		"fortune",
		"luck",
		"oops",
		"chance",
	}) do
		if G.GAME.jrok_prompt:find(str) then
			return true
		end
	end
	return false
end

function JROK.plagiarized()
	if G.GAME.selected_back.effect.center.key == "b_jrok_ai" then
		return true
	end
	return G.GAME.jrok_prompt:find("vanilla") or G.GAME.jrok_prompt:find("mod") or G.GAME.jrok_prompt:find("content")
end

function JROK.drunk()
	if G.GAME.selected_back.effect.center.key == "b_jrok_ai" then
		return true
	end
	return G.GAME.jrok_prompt:find("perkeo") or G.GAME.jrok_prompt:find("drunk") or G.GAME.jrok_prompt:find("alcohol")
end

function JROK.stolen()
	if G.GAME.selected_back.effect.center.key == "b_jrok_ai" then
		return true
	end
	return G.GAME.jrok_prompt:find("steal")
		or G.GAME.jrok_prompt:find("stole")
		or G.GAME.jrok_prompt:find("copy")
		or G.GAME.jrok_prompt:find("plagiarize")
end

function JROK.cryptid()
	if G.GAME.selected_back.effect.center.key == "b_jrok_ai" then
		return true
	end
	return G.GAME.jrok_prompt:find("cryptid") or G.GAME.jrok_prompt:find("unbalanced")
end

function JROK.summarize()
	if G.GAME.selected_back.effect.center.key == "b_jrok_ai" then
		return true
	end
	return G.GAME.jrok_prompt:find("summarize")
		or G.GAME.jrok_prompt:find("summary")
		or G.GAME.jrok_prompt:find("quick")
		or G.GAME.jrok_prompt:find("speed")
		or G.GAME.jrok_prompt:find("brief")
end

function JROK.nope()
	if G.GAME.selected_back.effect.center.key == "b_jrok_ai" then
		return true
	end
	return G.GAME.jrok_prompt:find("nope")
end

function JROK.glitched()
	if G.GAME.selected_back.effect.center.key == "b_jrok_ai" then
		return true
	end
	return G.GAME.jrok_prompt:find("bug") or G.GAME.jrok_prompt:find("glitch") or G.GAME.jrok_prompt:find("exploit")
end

function JROK.green()
	if G.GAME.selected_back.effect.center.key == "b_jrok_ai" then
		return true
	end
	return G.GAME.jrok_prompt:find("green") or G.GAME.jrok_prompt:find("environment")
end

function JROK.needle()
	if G.GAME.selected_back.effect.center.key == "b_jrok_ai" then
		return true
	end
	return G.GAME.jrok_prompt:find("needle")
end

function JROK.space()
	if G.GAME.selected_back.effect.center.key == "b_jrok_ai" then
		return true
	end
	return G.GAME.jrok_prompt:find("space")
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

SMODS.Consumable:take_ownership("black_hole", {
	use = function(self, card, area, copier)
		if JROK.space() then
			G.E_MANAGER:add_event(Event({
				trigger = "after",
				delay = 0.4,
				func = function()
					local t = {}
					for _, c in ipairs(G.jokers.cards) do
						t[#t + 1] = c
					end
					for _, c in ipairs(G.playing_cards) do
						t[#t + 1] = c
					end
					SMODS.destroy_cards(t, true)
					card:juice_up(0.3, 0.5)
					return true
				end,
			}))
			delay(0.6)
		else
			update_hand_text(
				{ sound = "button", volume = 0.7, pitch = 0.8, delay = 0.3 },
				{ handname = localize("k_all_hands"), chips = "...", mult = "...", level = "" }
			)
			G.E_MANAGER:add_event(Event({
				trigger = "after",
				delay = 0.2,
				func = function()
					play_sound("tarot1")
					card:juice_up(0.8, 0.5)
					G.TAROT_INTERRUPT_PULSE = true
					return true
				end,
			}))
			update_hand_text({ delay = 0 }, { mult = "+", StatusText = true })
			G.E_MANAGER:add_event(Event({
				trigger = "after",
				delay = 0.9,
				func = function()
					play_sound("tarot1")
					card:juice_up(0.8, 0.5)
					return true
				end,
			}))
			update_hand_text({ delay = 0 }, { chips = "+", StatusText = true })
			G.E_MANAGER:add_event(Event({
				trigger = "after",
				delay = 0.9,
				func = function()
					play_sound("tarot1")
					card:juice_up(0.8, 0.5)
					G.TAROT_INTERRUPT_PULSE = nil
					return true
				end,
			}))
			update_hand_text({ sound = "button", volume = 0.7, pitch = 0.9, delay = 0 }, { level = "+1" })
			delay(1.3)
			SMODS.upgrade_poker_hands({ instant = true })
			update_hand_text(
				{ sound = "button", volume = 0.7, pitch = 1.1, delay = 0 },
				{ mult = 0, chips = 0, handname = "", level = "" }
			)
		end
	end,
}, true)

SMODS.Atlas({
	key = "stolen",
	path = "stolen.png",
	px = 71,
	py = 95,
})

SMODS.Atlas({
	key = "stolen_4d",
	path = "4d.png",
	px = 71,
	py = 95,
	atlas_table = "ANIMATION_ATLAS",
	frames = 71,
	fps = 20,
})

SMODS.Atlas({
	key = "stolen_4d_soul",
	path = "4d.png",
	px = 71,
	py = 95,
})

function JROK.recursive_load(path)
	local files = SMODS.NFS.getDirectoryItems(SMODS.current_mod.path .. path)
	for _, item in ipairs(files) do
		if string.sub(item, -4) == ".lua" then
			print("JROK: Loading " .. item:gsub("%d+_", ""))
			assert(SMODS.load_file(path .. "/" .. item), string.format("File %s failed to load", path))()
		elseif path:find("%.") == nil then
			JROK.recursive_load(path .. "/" .. item)
		end
	end
end

SMODS.Shader({
	key = "hallucinated",
	path = "hallucinated.fs",
	send_vars = function(sprite, card)
		return {
			seed = card and card.edition.jrok_hallucination_seed or { 0, 0 },
		}
	end,
})

SMODS.Edition({
	key = "hallucinated",
	shader = "hallucinated",
	config = { extra = { xmult = 0.75 } },
	on_apply = function(card)
		card.edition.jrok_hallucination_seed = {
			math.random(),
			math.random(),
		}
	end,
	loc_vars = function(self, info_queue, card)
		return { vars = { card.edition.extra.xmult } }
	end,
	apply_to_float = true,
})

local smods_badges_hook = SMODS.create_mod_badges
function SMODS.create_mod_badges(obj, badges)
	if obj and obj.original_mod == JROK_MOD and obj.stolen_from then
		if not SMODS.config.no_mod_badges and obj and obj.mod and obj.mod.display_name and not obj.no_mod_badges then
			local mods = {}
			badges.mod_set = badges.mod_set or {}
			if not badges.mod_set[obj.mod.id] and not obj.no_main_mod_badge then
				table.insert(mods, obj.mod)
			end
			badges.mod_set[obj.mod.id] = true
			if obj.dependencies then
				for _, v in ipairs(obj.dependencies) do
					local m = assert(SMODS.find_mod(v)[1], ('Could not find mod "%s".'):format(v))
					if not badges.mod_set[m.id] then
						table.insert(mods, m)
						badges.mod_set[m.id] = true
					end
				end
			end
			for _, mod in ipairs(mods) do
				badges[#badges + 1] = create_jrok_badge(obj.stolen_from, 0.9)
			end
		end
	end
	return smods_badges_hook(obj, badges)
end

function JROK.split_mod_badge_text(str)
	local ret = {}
	local floored = math.floor(string.len(str) / 4)
	local remainder = string.len(str) % 4
	local last_index = 1
	for i = 0, 3 do
		local p, s = string.sub("JROK", 1, i), string.sub("JROK", i + 2, 4)
		local res = ""
		local first = last_index
		if i < remainder then
			last_index = last_index + floored
		else
			last_index = last_index + floored - 1
		end
		res = string.sub(str, first, last_index)
		last_index = last_index + 1
		res = p .. res .. s
		ret[#ret + 1] = res
	end
	return ret
end

function create_jrok_badge(_string, scaling)
	local strings = JROK.split_mod_badge_text(_string)
	for _ = 1, 14 do
		strings[#strings + 1] = "JROK"
	end
	table.insert(strings, 1, "JROK")
	scaling = scaling or 0.9
	return {
		n = G.UIT.R,
		config = { align = "cm" },
		nodes = {
			{
				n = G.UIT.R,
				config = {
					align = "cm",
					colour = G.C.BLACK,
					r = 0.1,
					minw = 2,
					minh = 0.4 * scaling,
					emboss = 0.05,
					padding = 0.03 * scaling,
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
								scale = 0.33 * scaling,
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
end

JROK.recursive_load("items")

SMODS.current_mod.reset_game_globals = function(run_start)
	JROK.reset_ship_card()
	JROK.reset_berry_ranks()
	if run_start then
		G.GAME.round_scores.jrok_gallons = G.GAME.round_scores.jrok_gallons
			or { amt = 0, label = localize("ph_score_jrok_gallons") }
		if JROK.drunk() then
			G.GAME.jrok_drunk = G.GAME.jrok_drunk or 0
			G.E_MANAGER:add_event(Event({
				func = function()
					SMODS.add_card({
						key = "j_perkeo",
						stickers = { "eternal" },
						force_stickers = true,
					})
					return true
				end,
			}))
		end
		if JROK.glitched() then
			G.E_MANAGER:add_event(Event({
				func = function()
					for _, c in ipairs(G.playing_cards) do
						assert(SMODS.change_base(c, "Spades", "10"))
					end
					return true
				end,
			}))
		end
		if JROK.needle() then
			G.GAME.round_resets.hands = 1
			G.GAME.round_resets.discards = 6
			G.GAME.modifiers.discard_cost = 1
			G.GAME.banned_keys = { "j_burglar", "v_nacho_tong", "v_grabber" }
			G.E_MANAGER:add_event(Event({
				func = function()
					SMODS.add_card({
						key = "j_credit_card",
						no_edition = true,
					})
					return true
				end,
			}))
		end
	end
end

JROK.feedback_pool = {
	"https://github.com/Steamodded/smods/issues",
	"https://github.com/nh6574/VanillaRemade/issues",
	"https://github.com/SpectralPack/cryptid/issues",
	"https://github.com/SpectralPack/Spectrallib/issues",
	"https://github.com/SleepyG11/HandyBalatro/issues",
	"https://github.com/ThunderEdge73/JROK/issues",
	"https://github.com/Steamodded/Wiki/issues",
	"https://github.com/Eremel/Malverk/issues",
	"https://github.com/WilsontheWolf/DebugPlus/issues",
	"https://github.com/ethangreen-dev/lovely-injector/issues",
	"https://github.com/WilsontheWolf/balatro-save-loader/issues",
	"https://github.com/jamesthejellyfish/JellyMod/issues",
	"https://github.com/SpectralPack/Talisman/issues",
	"https://github.com/nh6574/JokerDisplay/issues",
	"https://github.com/nh6574/JoyousSpring/issues",
	"https://github.com/notmario/Matador/issues",
	"https://github.com/frostice482/amulet/issues",
	"https://github.com/OceanRamen/Saturn/issues",
	"https://github.com/Cdrvo/Cold-Beans/issues",
	"https://github.com/Balatro-Potato-Patch/Stocking-Stuffer/issues",
	"https://github.com/Balatro-Potato-Patch/Hot-Potato/issues",
	"https://github.com/Balatro-Potato-Patch/Potato-Patch-Utils/issues",
	"https://github.com/Eremel/Galdur/issues",
	"https://github.com/EremelMods/Ortalab/issues",
	"https://shorty.systems/util-modders.webp",
	"https://github.com/Aikoyori/Balatro-Aikoyoris-Shenanigans/issues",
	"https://github.com/cg-223/toomanyjokers/issues",
	"https://github.com/DigitalDetective47/next-ante-preview/issues",
	"https://github.com/Joglacraft/DebugPlusPlus/issues",
	"https://github.com/Mysthaps/blindexpander/issues",
	"https://github.com/BakersDozenBagels/Balatest/issues",
	"https://github.com/icyethics/Glue-For-Modpacks/issues",
	"https://github.com/icyethics/Blockbuster-ValueManipulation/issues",
	"https://github.com/icyethics/Kino/issues",
	"https://github.com/SylviBlossom/Banner/issues",
	"https://github.com/real-niacat/CardPronouns/issues",
	"https://github.com/real-niacat/Scholar/issues",
	"https://github.com/lord-ruby/Overflow/issues",
	"https://github.com/lord-ruby/Engulf/issues",
	"https://github.com/lord-ruby/NoMoreEs/issues",
	"https://github.com/Evgast/LOSS-LackOfShopSpace/issues",
	"https://github.com/blazingulag/Unjankify/issues",
	"https://github.com/stupxd/Cartomancer/issues",
	"https://github.com/Somethingcom515/Yorick/issues",
	"https://github.com/ThunderEdge73/Multiverse/issues",
}

SMODS.JimboQuip({
	key = "feedback",
	extra = {
		center = "j_jrok_thunderedge",
		times = 10,
	},
	filter = function(self, quip_type)
		return true, { weight = 1e308 }
	end,
})

function G.FUNCS.jrok_feedback_prompt(e)
	JROK.feedback_prompt = ""
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
														prompt_text = localize("k_jrok_text_prompt3"),
														ref_table = JROK,
														ref_value = "feedback_prompt",
														max_length = 500,
														w = 11,
														extended_corpus = true,
													}),
													{
														n = G.UIT.C,
														config = {
															button = "notify_then_setup_run",
															ref_element = e,
															id = G.STATE == G.STATES.GAME_OVER and "from_game_over"
																or "from_game_won",
															colour = G.C.BLUE,
															minh = 0.6,
															minw = 1.8,
															padding = 0.05,
															r = 0.1,
															hover = true,
															shadow = true,
															align = "cm",
															func = "can_submit_jrok_feedback",
														},
														nodes = {
															{
																n = G.UIT.T,
																config = {
																	text = localize("k_jrok_submit"),
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
									align = "cm",
									minw = 2.5,
									padding = 0.1,
									r = 0.1,
									hover = true,
									colour = G.C.ORANGE,
									button = "go_to_menu",
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
													text = localize("b_main_menu"),
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
			no_esc = true,
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

function G.FUNCS.can_submit_jrok_feedback(e)
	if JROK.feedback_prompt ~= "" then
		e.config.colour = G.C.BLUE
		e.config.button = "notify_then_setup_run"
	else
		e.config.colour = G.C.UI.BACKGROUND_INACTIVE
		e.config.button = nil
	end
end

--#region Drunk stuff

SMODS.Joker:take_ownership("perkeo", {
	calculate = function(self, card, context)
		if context.ending_shop and G.consumeables.cards[1] then
			if JROK.drunk() and pseudorandom("drunk", 1, 2) == 1 then
				G.E_MANAGER:add_event(Event({
					func = function()
						SMODS.add_card({
							key = "c_jrok_alcohol",
							edition = "e_negative",
							stickers = { "eternal" },
							force_stickers = true,
						})
						return true
					end,
				}))
			else
				G.E_MANAGER:add_event(Event({
					func = function()
						local card_to_copy, _ = pseudorandom_element(G.consumeables.cards, "vremade_perkeo")
						local copied_card = copy_card(card_to_copy)
						copied_card:set_edition("e_negative", true)
						copied_card:add_to_deck()
						G.consumeables:emplace(copied_card)
						return true
					end,
				}))
			end
			return { message = localize("k_duplicated_ex") }
		end
	end,
}, true)

SMODS.ScreenShader({
	key = "drunk",
	path = "drunk.fs",
	send_vars = function(self)
		return {
			progress = math.pow((G.GAME.jrok_drunk or 0) / 10, 1.5),
			time = G.TIMERS.REAL,
		}
	end,
	should_apply = function(self)
		return (G.GAME.jrok_drunk or 0) > 0
	end,
})

SMODS.ScreenShader({
	key = "blackout",
	path = "blackout.fs",
	send_vars = function(self)
		return {
			progress = JROK.blackout,
		}
	end,
	should_apply = function(self)
		return JROK.blackout > 0
	end,
})

SMODS.Atlas({
	key = "alcohol",
	path = "alcohol.png",
	px = 71,
	py = 95,
})

JROK.drunk_limit = 10
JROK.blackout = 0

SMODS.Consumable({
	key = "alcohol",
	set = "Tarot",
	atlas = "alcohol",
	pos = { x = 0, y = 0 },
	config = { extra = { xmult = 0.8 } },
	loc_vars = function(self, info_queue, card)
		return {
			vars = {
				card.ability.extra.xmult,
				JROK.drunk_limit - ((G.GAME or {}).jrok_drunk or 0),
			},
		}
	end,
	in_pool = function(self, args)
		return false
	end,
	calculate = function(self, card, context)
		if context.final_scoring_step then
			return {
				xmult = card.ability.extra.xmult,
			}
		end
	end,
	use = function(self, card, area, copier)
		G.GAME.jrok_drunk = G.GAME.jrok_drunk or 0
		local final = G.GAME.jrok_drunk + 1
		G.E_MANAGER:add_event(Event({
			trigger = "after",
			delay = 0.4,
			func = function()
				play_sound("timpani")
				card:juice_up(0.3, 0.5)
				G.E_MANAGER:add_event(Event({
					trigger = "ease",
					ref_table = G.GAME,
					ref_value = "jrok_drunk",
					ease_to = final,
					timer = "REAL",
					delay = 0.6,
					type = "inoutquad",
				}))
				if final >= JROK.drunk_limit then
					G.E_MANAGER:add_event(Event({
						trigger = "ease",
						ref_table = JROK,
						ref_value = "blackout",
						pause_force = true,
						ease_to = 1,
						delay = 0.5,
						timer = "REAL",
						type = "inoutquad",
					}))
					G.E_MANAGER:add_event(Event({
						trigger = "after",
						timer = "REAL",
						pause_force = true,
						delay = 3,
						func = function()
							JROK.lose()
							return true
						end,
					}))
					G.E_MANAGER:add_event(Event({
						trigger = "after",
						timer = "REAL",
						pause_force = true,
						delay = 1.5,
					}))
					G.E_MANAGER:add_event(Event({
						trigger = "ease",
						ref_table = JROK,
						ref_value = "blackout",
						ease_to = 0,
						pause_force = true,
						timer = "REAL",
						delay = 0.5,
						blocking = false,
						type = "inoutquad",
					}))
					G.E_MANAGER:add_event(Event({
						trigger = "ease",
						ref_table = G.GAME,
						ref_value = "jrok_drunk",
						ease_to = 0,
						timer = "REAL",
						pause_force = true,
						delay = 0.5,
						type = "inoutquad",
					}))
				end
				return true
			end,
		}))
		delay(0.3)
	end,
	can_use = function(self, card)
		return true
	end,
	select_card = "consumeables",
})

function JROK.lose()
	G.STATE = G.STATES.GAME_OVER
	if not G.GAME.won and not G.GAME.seeded and not G.GAME.challenge then
		G.PROFILES[G.SETTINGS.profile].high_scores.current_streak.amt = 0
	end
	G:save_settings()
	G.FILE_HANDLER.force = true
	G.STATE_COMPLETE = false
end

--#endregion
