return {
	descriptions = {
		Edition = {
			e_jrok_hallucinated = {
				name = "Hallucinated",
				text = {
					"{X:mult,C:white}X#1#{} Mult",
				},
			},
		},
		Joker = {
			j_jrok_spoon_bender = {
				name = "Spoon Bender",
				text = {
					"{C:attention}Unscored cards{}",
					"give {C:white,X:mult}X#1#{} Mult",
				},
			},
			j_jrok_dream_catcher = {
				name = "Dream Catcher",
				text = {
					"The next {C:attention}Boss Blind{}",
					"is {C:attention}#1#",
					"{s:0.8}Prediction might change",
					"{s:0.8}based on your actions",
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
					"{C:attention}consecutive{} hand",
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
					"{C:red}Destroy{} played",
					"cards in {C:attention}first{}",
					"hand of round",
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
			j_jrok_tony = {
				name = "Tony",
				text = {
					"Create a {C:dark_edition}Negative {C:spectral}Spectral{}",
					"card if played hand",
					"contains a card with",
					"{C:attention}Foil{} and an {C:attention}Ace{}",
				},
			},
			j_jrok_nyala = {
				name = "Nyala",
				text = {
					"Played hands turn their respective",
					"held {C:planet}Planets{} into {C:enhanced}Black Holes{}",
					"{X:mult,C:white}X#2#{} Mult for every {C:enhanced}Black Hole{} used",
					"{C:inactive}(Currently {X:mult,C:white}X#1#{C:inactive} Mult)",
				},
			},
			j_jrok_punch_card = {
				name = "Punch Card",
				text = {
					"Duplicates next used",
					"consumable every {C:attention}#1#",
					"consumables used",
					"{C:inactive}(#2#){}",
				},
			},
			j_jrok_copycat = {
				name = "Copy Cat",
				text = {
					"Copies the effect of a {C:attention}random{} other Joker",
					"{C:inactive}(Changes target at end of shop){}",
					"{C:inactive}(Currently {C:attention}#1#{C:inactive}){}",
				},
			},
			j_jrok_obsession = {
				name = "Obsession",
				text = {
					"Retriggers all cards",
					"of rank {C:attention}#1#{}, {C:blue}#2#{} time#3#",
					"{C:inactive}(Rank selected randomly on spawn)",
				},
			},
			j_jrok_toiletrock = {
				name = "Toilet Rock",
				text = {
					"{C:attention}#1#es{} can be made",
					"out of {C:attention}Stone Cards{}",
				},
			},
			j_jrok_wishingstones = {
				name = "Wishing Stones",
				text = {
					"{C:attention}#1#s{} can be made",
					"out of {C:attention}Stone Cards{}",
				},
			},
			j_jrok_kitsune_mask = {
				name = "Kitsune Mask",
				text = {
					"{C:green}#1# in #2#{} chance for each",
					"played {C:attention}#3#{} to create a",
					"{C:spectral}#4#{} card when scored",
					"Chance {C:green}doubled{} on {C:attention}#5#s{}",
					"{C:inactive}(Must have room)",
				},
			},
			j_jrok_thrift_shop = {
				name = "Thrift Shop",
				text = {
					"{C:green}#1# in #2#{} chance for each",
					"shop {C:green}reroll{} to",
					"create a random {C:attention}Tag{}",
				},
			},
			j_jrok_posh = {
				name = "Posh Joker",
				text = {
					"{C:chips}+#1#{} Chips for each",
					"enhanced card {C:attention}held-in-hand{}",
				},
			},
			j_jrok_stellar_yogurt = {
				name = "Stellar Yogurt",
				text = {
					"Creates {C:attention}The Fool{}",
					"and a {C:planet}Meteor Tag{}",
					"when sold",
				},
			},
			j_jrok_slop_vulpix = {
				name = "Vulpix Plush :)",
				text = {
					{
						"When a {C:planet}Planet{} card is",
						"sold, {C:green}#1# in #2#{} chance to",
						"gain {C:blue}+1{} hand for this",
						"round temporarily",
						"If a {C:planet}Planet{} card was",
						"sold this round,",
						"{C:green}#3# in #4#{} chance",
						"to lose {C:red}1{} discard",
						"when hand is played",
					},
				},
			},
			j_jrok_slop_moist = {
				name = "Moisturiser",
				text = {
					{
						"When sold, removes {C:attention}Perishable{}",
						"or a {C:attention}debuff{} from a",
						"random owned Joker",
						"If there are no existing",
						"{C:attention}Perishable{} or {C:red}debuffed{} Jokers,",
						"a random Joker instead",
						"becomes {C:dark_edition}Foil{}, {C:dark_edition}Polychrome{},",
						"or {C:dark_edition}Negative{}",
						"{C:inactive,s:0.8}(Can override existing editions)",
					},
				},
			},
			j_jrok_sora = {
				name = "Sora",
				text = {
					"This Joker gains {X:mult,C:white}X#2#{} Mult",
					"for each scored card",
					"with a {C:hearts}Heart{} suit, resets",
					"when {C:attention}Boss Blind{} is defeated.{}",
					"{C:inactive}(Currently {X:mult,C:white}X#1# {C:inactive} Mult)",
				},
			},
			j_jrok_paopufruit = {
				name = "Paopu Fruit",
				text = {
					"Add a random {C:dark_edition}Edition{},",
					"{C:dark_edition}Enhancement{}, and {C:attention}Seal{} to",
					"first scored card for",
					"the next {C:attention}#1#{} hands",
				},
			},
			j_jrok_orchid = {
				name = "Orchid",
				text = {
					"This Joker gains {C:mult}+#1#{} Mult",
					"per hand played with",
					"a scoring {C:attention}Jack{}",
					"{C:inactive}(Currently {C:mult}+#2#{}{C:inactive} Mult){}",
				},
			},
			j_jrok_sunflower = {
				name = "Sunflower",
				text = {
					"After skipping a blind",
					"{C:attention}disable{} the {C:attention}Boss Blind{}",
					"{C:inactive}(#1#){}",
				},
			},
			j_jrok_goldship = {
				name = "Gold Ship",
				text = {
					"Earn {C:money}money{} for each {C:attention}#1#",
					"drawn to hand, rank",
					"changes every round",
					"{C:inactive,S:0.8}Golshi decides how much",
				},
			},
			j_jrok_tmoperao = {
				name = "TM Opera O",
				text = {
					"This Joker gains {C:white,X:red}X#2#{} Mult",
					"per {C:attention}consecutive{} hand played",
					"with a scoring {C:attention}face{} card",
					"{C:inactive}(Currently {C:white,X:red}X#1#{C:inactive} Mult)",
				},
			},
			j_jrok_atmospheric = {
				name = "Atmospheric Joker",
				text = {
					"Retriggers the {C:attention}first three{}",
					"scored {C:attention}5s{} twice",
				},
			},
			j_jrok_precious = {
				name = "Precious Joker",
				text = {
					"This Joker gains {X:mult,C:white}X#1#{} Mult",
					"each time a {C:attention}5{} is scored",
					"Resets at end of round",
					"{C:inactive} (Currently {X:mult,C:white} X#2# {C:inactive} Mult)",
				},
			},
			j_jrok_grosdish = {
				name = "Grosdish",
				text = {
					"{C:chips}+#1#{} Chips",
					"{C:green}#2# in #3#{} chance",
					"to go extinct",
				},
			},
			j_jrok_spin = {
				name = "Do a Barrel Roll",
				text = {
					"Scored cards will do a spin",
					"{C:dark_edition}+1{C:attention} Joker Slot",
				},
			},
			j_jrok_detour = {
				name = "Detour",
				text = {
					"Allows {C:attention}Straights{}",
					"to wrap around",
					"{C:inactive}(ex: {C:attention}Q K A 2 3{C:inactive}){}",
				},
			},
			j_jrok_twins = {
				name = "The Twins",
				text = {
					"When {C:attention}Blind{} is skipped,",
					"create a {C:attention}Double Tag{}",
					"before {C:attention}Tag{} reward",
				},
			},
			j_jrok_berry_golden = {
				name = "Goldenberry",
				text = {
					{
						"Each scored",
						"{C:attention}#1#{} or {C:attention}#2#",
						"earns {C:money}$#3#{}-{C:money}$#4#",
						"{s:0.1} ",
						"{C:inactive}Ranks change",
						"{C:inactive}every round",
					},
					{
						"{C:red,s:0.9,E:2}Eaten{s:0.9} when",
						"{s:0.9}no {C:attention,s:0.9}#1#{s:0.9} or {C:attention,s:0.9}#2#",
						"{s:0.9}scored this round",
					},
				},
			},
			j_jrok_berry_shimmer = {
				name = "Shimmerberry",
				text = {
					{
						"Each scored",
						"{C:attention}#1#{} or {C:attention}#2#",
						"{C:green}reduces {C:attention}Blind",
						"{C:attention}Size{} by {C:SEMBY_percent}#3#%",
						"{s:0.1} ",
						"{C:inactive}Ranks change",
						"{C:inactive}every round",
					},
					{
						"{C:red,s:0.9,E:2}Eaten{s:0.9} when",
						"{s:0.9}no {C:attention,s:0.9}#1#{s:0.9} or {C:attention,s:0.9}#2#",
						"{s:0.9}scored this round",
					},
				},
			},
			j_jrok_baguette = {
				name = "Baguette",
				text = {
					"Played {C:attention}face cards{}",
					"give {C:money}$#1#{} when scored",
					"{C:red}Self-destructs",
					"in {C:attention}#2#{} rounds",
				},
			},
			j_jrok_thunderedge = {
				name = "ThunderEdge",
				text = {
					{
						"This Joker gains {X:mult,C:white}X#1#{} Mult",
						"for every {C:money}$#2#{} {C:inactive}($#3#){} earned",
						"{C:inactive}(Currently {X:mult,C:white}X#4#{C:inactive} Mult)",
					},
					{
						"{C:inactive,s:0.8}How the hell did I get here?",
					},
				},
			},
			j_jrok_fireball = {
				name = "Fireball",
				text = { "{X:mult,C:white}X#1#{} Mult next hand" },
			},
			j_jrok_fireball_infinity = {
				name = "Fireball",
				text = { "{X:legendary,C:white,E:1}X#1#{} Mult" },
			},
			j_jrok_dead_ringer = {
				name = "Dead Ringer",
				text = {
					"Prevents death against {C:attention}Small Blinds",
					"{X:mult,C:white}X#1#{} Mult if this Joker prevented",
					"death this {C:attention}ante",
					"{C:inactive}(#2#)",
				},
			},
			j_jrok_pero = {
				name = "PERO",
				text = {
					"{X:mult,C:white}X#1#{} Mult if all",
					"Joker slots are full",
				},
			},
			j_jrok_butterfly = {
				name = "Butterfly Memory",
				text = {
					"Creates a random {C:dark_edition}Negative{}",
					"{C:spectral}Spectral{} card when {C:attention}Boss Blind{}",
					"is selected",
				},
			},
			j_jrok_ghost_joker = {
				name = "Poltergeist",
				text = {
					"Create a {C:spectral}Spectral{} card",
					"when {C:attention}Blind{} is selected",
					"{C:inactive}(Must have room)",
				},
			},
			j_jrok_uniku = {
				name = "Uniku",
				text = {
					"{C:attention}Retrigger{} all scored",
					"{C:attention}7{}s {C:attention}#1#{} times",
				},
			},
			j_jrok_ghostinabucket = {
				name = "Ghost in a Bucket",
				text = {
					"{C:attention}Aces{} held in hand each",
					"have a {C:green}#1# in #2#{} chance to",
					"create a {C:tarot}Tarot{} card",
					"{C:inactive}(Must have room){}",
				},
			},
			j_jrok_ghost = {
				name = "Ghost",
				text = {
					"Gives {X:mult,C:white}X#1#{} Mult for",
					"each {C:tarot}Tarot{} card in",
					"your {C:attention}consumable{} area",
					"{C:inactive}(Currently {X:mult,C:white}X#2#{C:inactive} Mult){}",
				},
			},
			j_jrok_d0 = {
				name = "D0",
				text = {
					"Multiplies all {C:attention}listed{}",
					"{C:green,E:1}probabilities{} by {C:attention}0",
					"{C:inactive}(ex. {C:green}1 in 3{C:inactive} -> {C:green}0 in 3{C:inactive})",
				},
			},
			j_jrok_lambda_calculus = {
				name = "Lambda Calculus",
				text = {
					"Whenever another Joker {C:attention}triggers{}",
					"add its {C:attention}values{} to this Jokers {C:blue}Chips{}",
					"{C:red}Resets{} when this Joker triggers",
					"{C:inactive}(Currently {C:blue}+#1#{C:inactive} Chips)",
				},
			},
			j_jrok_subterfuge = {
				name = "Subterfuge",
				text = {
					"Destroys the {C:attention}first played",
					"{C:attention}hand{} every round",
				},
			},
			j_jrok_deadringer = {
				name = "Deadringer",
				text = {
					"Retrigger scored {C:attention}#1#s{} and {C:attention}#2#s",
					"once, and scored {C:attention}#3#s{} twice",
				},
			},
			j_jrok_starPlatinum = {
				name = "Star Platinum",
				text = {
					"This Joker gains {C:mult}+#1#{} Mult",
					"per {C:attention}consecutive hand{} played that",
					"is your most played {C:attention}poker hand",
					"{C:inactive}(Currently {C:mult}+#2#{} {C:inactive}Mult{C:inactive})",
				},
			},
			j_jrok_crazyDiamond = {
				name = "Crazy Diamond",
				text = {
					"Create a {C:attention}copy{} of any",
					"{C:attention}destroyed cards{} and",
					"add them to hand",
				},
			},
			j_jrok_fountain = {
				name = "Fountain",
				text = {
					"Played cards have a",
					"{C:green}#1# in (rank){} chance to",
					"earn {C:money}$#2#{} when {C:attention}scored{}",
				},
			},
			j_jrok_jokerton = {
				name = "Jokerton",
				text = {
					"Every {C:attention}#1# {C:inactive}[#2#] {C:hearts}Hearts{} cards discarded,",
					"enhance {C:attention}first card{} of next",
					"hand played to a {C:attention}Steel Card{}",
				},
			},
			j_jrok_stormshooter = {
				name = "Storm Shooter",
				text = {
					"Creates as many {C:planet}Planet{} cards for the scoring hand as possible",
					"if an unscored card is played in this card's {C:attention}column{}",
					"This card has to be in {C:attention}column #1#{} to use this ability",
					"{C:inactive}(Changes each round){}",
					"{C:inactive}(Currently in {C:attention}column #2#{}{C:inactive})",
				},
			},
			j_jrok_trash_bin = {
				name = "Trash Bin",
				text = {
					"{C:mult}+#1#{} Mult for each",
					"card discarded or previously",
					"played this round",
					"{C:inactive}(Currently{} {C:mult}+#2#{} {C:inactive}Mult){}",
				},
			},
			j_jrok_futuristic = {
				name = "Futuristic Joker",
				text = {
					"Each {C:attention}played card{} gives {X:red,C:white}X#1#{} Mult",
					"if {C:attention}played hand{} contains a {C:attention}rank{}",
					"one {C:attention}higher{} or {C:attention}lower{}",
				},
			},
			j_jrok_gratification = {
				name = "Instant Gratification",
				text = {
					"Earn {C:money}$#1#{} when you",
					"use a {C:red}discard{}",
				},
			},
			j_jrok_solar = {
				name = "Solar Flare",
				text = {
					"If first hand of round",
					"is {C:attention}not{} your most played",
					"hand, {C:attention}upgrade{} it and {C:red}destroy",
					"random {C:attention}#1#{} played cards",
				},
			},
			j_jrok_7_ball = {
				name = "7 Ball",
				text = {
					"{C:green}#1# in #2#{} chance for each",
					"played {C:attention}7{} to create a",
					"{C:spectral}Spectral{} card when scored",
					"{C:inactive}(Must have room)",
				},
			},
			j_jrok_eviloops = {
				name = "{C:red}Evil{} Oops All Sixes",
				text = {
					"Halves all {C:attention}listed{}",
					"{C:green,E:1}probabilities",
					"{C:inactive}(ex: {C:green}1 in 3{C:inactive} -> {C:green}1 in 6{C:inactive}){}",
				},
			},
			j_jrok_polychromeToTheRight = {
				name = "Polychrome to the Right",
				text = {
					"Always {C:dark_edition}Polychrome",
					"{X:mult,C:white}X#1#{} Mult if this",
					"Joker is the",
					"rightmost {C:attention}Joker",
				},
			},
			j_jrok_pissandshittium = {
				name = "Pissandshittium",
				text = {
					"Tells the URL where to download",
					"{B:1,C:white}Pissandshittium{}",
					"{V:1}+#1#{} Mult",
				},
			},
			j_jrok_ash_joker = {
				name = "Ash Joker",
				text = {
					"{C:chips}+#1#{} Chips",
					"{C:green}#2# in #3#{} chance",
					"of disintegrating",
					"at the end of the round",
					"but gains {C:chips}+#4#{} Chips",
					"if it survives",
				},
			},
			j_jrok_hitomania = {
				name = "HITO Mania",
				text = {
					"Played {C:attention}face{} cards",
					"give {C:mult}#1#{} to {C:mult}#2#{} Mult",
					"or {C:chips}#3#{} to {C:chips}#4#{} Chips",
					"when scored",
				},
			},
			j_jrok_pingas = {
				name = "Snoo{C:attention}ping as{} usual?",
				text = {
					"{C:red}+#1#{} Mult for each {C:attention}Played{} cards",
					"{C:attention}He{} might see {C:red}you{} snooping around.",
				},
			},
			j_jrok_kendih = {
				name = ". . .{X:attention,C:white,s:2,E:2}M-{}",
				text = {
					"{C:green}#1#{} in {C:green}#2#{} chance for {C:attention}Kendih{}{f:jrok_emoji}🥀{}",
					"to scream {X:attention,C:white,s:2,E:2}MUSTARD{}",
				},
			},
		},
		Other = {
			o_jrok_ortalab_dead_ringer = {
				name = "Ortalab Blinds",
				text = {
					"{C:attention}Fold{}, {C:attention}Check{}, and {C:attention}Bet{} also",
					"count as Small Blinds",
					"for this Joker's purposes",
				},
			},
		},
		Tarot = {
			c_jrok_alcohol = {
				name = "Alcohol",
				text = {
					"{X:mult,C:white}X#1#{} Mult while held in",
					"consumable slots",
					"After using {C:attention}Alcohol",
					"{C:attention}10 {C:inactive}(#2#){} times,",
					"{C:red,E:1}lose the run{}",
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
			k_jrok_text_prompt3 = "Let me know what's on your mind",
			k_jrok_start = "Start Run",
			k_jrok_submit = "Submit",
			k_jrok_arrow = ">",
			k_jrok = "JROK",
			k_jrok_error = "Sorry, I didn't quite get that.",
			k_jrok_powered = "(Powered",
			k_by_jrok = "by JROK)",
			k_felled_ex = "Felled!",
			k_berry_ex = "Berry!",
			jrok_unknown = "[Unknown]",
			jrok_acquire_to_reveal = "[Acquire to reveal]",
			k_jrok_punch_duplicate = "Consumable printed",
			jrok_active = "Active",
			jrok_inactive = "Inactive",
			jrok_disabled = "Disabled!",
			jrok_nom = "Nom!",
			k_jrok_spell = "Spell",
			k_jrok_inactive = "Inactive...",
			ph_jrok_dead_ringer_saved = "Feigned Death",
			k_jrok_destroyed_ex = "Destroyed!",
			ph_score_jrok_gallons = "Gallons Of Water Used",
			k_jrok_steel = "Steel!",
			jrok_rank = "certain rank",
			k_jrok_pissandshittium = "https://pissandshittium.org/",
		},
		v_dictionary = {
			jrok_punch_card_more = "#1# more required...",
			jrok_punch_card_will = "Next consumable will be duplicated!",
			jrok_percentage_minus = "-#1#%",
		},
		labels = {
			jrok_hallucinated = "Hallucinated",
		},
		quips = {
			jrok_feedback = {
				"Do you have any feedback",
				"for {C:attention}JROK AI{}? Feel free",
				"to click me and send me",
				"your feedback, any",
				"feedback is valuable!",
			},
		},
	},
}
