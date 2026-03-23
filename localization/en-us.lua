return {
	descriptions = {
		Joker = {
			j_jrok_spoon_bender = {
				name = "Spoon Bender",
				text = {
					"{C:attention}Unscored cards{}",
					"give {C:white,X:mult}X#1#{} Mult",
				},
			},
			j_jrok_charm_of_the_vampire = {
				name = "Charm of the Vampire",
				text = {
					"This Joker gains {C:mult}+#1#{} Mult",
					"when {C:attention}Blind{} is defeated",
					"{C:inactive}(Currently {C:mult}+#2#{C:inactive} Mult)",
				},
			},
			j_jrok_normal = {
				name = "Normal Joker",
				text = {
					"Played cards without an",
					"{C:attention}Enhancement{}, {C:attention}Edition{}, or {C:attention}Seal",
					"give {C:mult}+#1#{} Mult and {C:chips}+#2#{} Chips",
				},
			},
			j_jrok_4d = {
				name = "4D Joker",
				text = {
					"{X:mult,C:white}X#1#{} Mult",
					"Decreases by {X:mult,C:white}X#2#{}",
					"{C:attention}every second",
				},
			},
			j_jrok_jetfish = {
				name = "Jetfish",
				text = {
					"{C:mult}+#1#{} Mult for each",
					"consecutive hand",
					"played without",
					"unscoring cards",
					"{C:inactive}(Currently {C:mult}+#2#{C:inactive} Mult)",
				},
			},
			j_jrok_cobbler = {
				name = "Cobbler",
				text = {
					"Gains {C:mult}+#1#{} Mult at",
					"end of round",
					"This Joker {C:red}self-destructs",
					"after reaching {C:mult}+#3#{} Mult",
					"{C:inactive}(Currently {C:red}+#2#{C:inactive} Mult)",
				},
			},
			j_jrok_shiny_rock = {
				name = "Shiny Rock",
				text = {
					"{C:green}#1# in #2#{} chance to give",
					"a playing card an {C:dark_edition}Edition",
					"when scored",
				},
			},
			j_jrok_cultist = {
				name = "Cultist",
				text = {
					"{C:attention}Arcana Packs{} contain a",
					"bonus {C:attention}Spectral{} Card",
				},
			},
			j_jrok_forgery = {
				name = "Forgery",
				text = {
					"When {C:attention}Blind{} is selected,",
					"{C:attention}destroy{} a random card in {C:attention}deck{},",
					"and add a {C:attention}quarter{} of its",
					"{C:chips}Chips{} to this Joker as {C:mult}Mult",
					"{C:inactive}(Currently {C:mult}+#1#{C:inactive} Mult)",
				},
			},
			j_jrok_leeroooooy = {
				name = "LEEROOOOOY!!",
				text = {
					"{C:attention}Retrigger{} all played cards",
					"per {C:attention}Blind skipped{} this {C:attention}Ante",
					"{C:inactive}(Currently {C:attention}#1#{} {C:inactive}retriggers)",
				},
			},
			j_jrok_hatchet = {
				name = "Hatchet",
				text = {
					"{X:red,C:white}X#1#{} Mult on {C:attention}first",
					"{C:attention}hand of round",
					"{C:red}Destroy{} scored cards",
				},
			},
			j_jrok_dakimakura = {
				name = "Dakimakura",
				text = {
					"If played hand contains a",
					"{C:attention}Flush{}, convert each played",
					"card into a {C:attention}random suit",
				},
			},
			j_jrok_philosophical = {
				name = "Philosophical Joker",
				text = {
					"{C:dark_edition}+#1#{} Joker Slot",
				},
			},
			j_jrok_basepaul = {
				name = "Basepaul Card",
				text = {
					"{X:mult,C:white} X#1# {} Mult. {X:mult,C:white} X#2# {} Mult",
					"instead for {C:red}Paul{}",
					"{C:inactive}(Who's Paul?)",
				},
			},
			j_jrok_dazzles = {
				name = "The Dazzles",
				text = {
					"{C:mult}+#1#{} Mult after {C:attention}#2#{} card#3#",
					"scored, then change to a random",
					"requirement between {C:attention}1{}, {C:attention}2{}, {C:attention}3{} and {C:attention}6{}",
				},
			},
			j_jrok_croque_madame = {
				name = "Croque Madame",
				text = {
					"If a Joker is on the right of",
					"this at end of round, consume",
					"this and gain {C:money}${} equal to {C:attention}double",
					"the {C:attention}sell value{} of both",
				},
			},
		},
	},
	misc = {
		poker_hands = {
			Straight = "StrAIght",
			Pair = "PAIr",
			["Straight Flush"] = "StrAIght Flush",
			["Two Pair"] = "Two PAIr",
		},
		dictionary = {
			k_jrok_prompt = "Generate your own Balatro content",
			k_jrok_prompt2 = "How may I help you?",
			k_jrok_text_prompt = "What's your idea?",
			k_jrok_text_prompt2 = "Ask anything",
			k_jrok_start = "Start Run",
			k_jrok_arrow = ">",
			k_jrok = "JROK",
			k_jrok_powered = "(Powered",
			k_by_jrok = "by JROK)",
			k_felled_ex = "Felled!",
		},
	},
}
