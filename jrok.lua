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

local start_run_hook = Game.start_run
function Game:start_run(args)
	start_run_hook(self, args)
	G.GAME.jrok_prompt = G.GAME.jrok_prompt or JROK.prompt_text
end

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
	elseif JROK.menu_prompt:find("deck") then
		G.FUNCS.deck_info(e)
	elseif JROK.menu_prompt:find("restart") or JROK.menu_prompt:find("reset") then
		G.FUNCS.setup_run(e)
	elseif JROK.menu_prompt:find("seed") and G.GAME.seeded then
		G.FUNCS.copy_seed(e)
	elseif JROK.menu_prompt:find("run") then
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
