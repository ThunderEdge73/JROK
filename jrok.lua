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
	if JROK.lucky() then
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
	if JROK.lucky() then
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

function JROK.lucky()
	for _, str in ipairs({
		"space",
		"glass",
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

function JROK.theft()
	return G.GAME.jrok_prompt:find("vanilla") or G.GAME.jrok_prompt:find("mod") or G.GAME.jrok_prompt:find("content")
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
end
