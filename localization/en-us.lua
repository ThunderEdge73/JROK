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
		},
	},
}
