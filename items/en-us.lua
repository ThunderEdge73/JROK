return {
    misc = {
        dictionary = {
            -- used by kori when turning cards glass
            k_lem_glass = "Frozen!",

            -- petrfification
            k_lem_petrified_ex = "Petrified!",

            -- unused; originally intended for a cryptid crossmod joker
            -- k_lem_abstracted = "+1 Cuil",

            -- used by Temporary sticker when destroying a card
            k_lem_gone_ex = "Gone!",

            -- used by BITE ME MORE PLS when suit changes
            k_lem_switched_ex = "Switched!",

            -- used by Pawnbroker
            k_lem_accepted_ex = "Accepted!",

            -- used by Gay Baby Jail
            k_lem_gbj_ex = "GBJ!",

            -- used by alexi plushie and reverse alexi
            k_lem_shapeshifted_ex = "Shapeshifted!",

            -- used by reverse jackie
            k_lem_eq_6 = "=6",

            -- fabled rarity
            k_lem_fabled = "Fabled",
            k_lem_internal = "Where The Actual Fuck Did You Get This",

            -- gay sex
            k_lem_hpot_gay_sex = "Gay Sex!",

            -- spell card label
            k_lem_spell = "Spell",
            b_lem_spell_cards = "Spell Cards",

            -- spell card creation
            k_lem_plus_spell = "+1 Spell",

            -- used
            k_lem_cast = "Cast",

            -- Added on to textboxes
            k_lem_pranked = "prank'd lol",
            k_lem_inactive = "Inactive...",

            -- the name of the fucking mod (used for badge text)
            k_lem_mod_name = "Lemniscate",

            k_lem_mythical_pack = "Mythical Pack",
            k_lem_sorcery_pack = "Sorcery Pack",

            -- quest ui text
            b_quests = "Quests",

            ph_lem_choose_quest_1 = "Pick a quest",
            ph_lem_choose_quest_2 = "to go on",

            ph_clear_this_quest_1 = "Clear this quest",
            ph_clear_this_quest_2 = "to discover it",

            ph_lem_objective = "Objective",
            ph_lem_difficulty = "Difficulty",
            ph_lem_boss_squared = "[boss blind size]^2",
            ph_lem_boss_x2 = "[boss blind size]X2",
            ph_lem_least_played_hand = "(least played hand)",

            b_lem_quest_failed_ex = "Quest Failed!",

            ph_lem_boss_reenabled_ex = "Boss reenabled!",

            -- Death prevention messages
            ph_lem_dead_ringer_saved = "Feigned Death",
            ph_lem_gay_baby_jail_saved = "Stuck in Gay Baby Jail",
            ph_lem_r_morgan_saved = "Saved by desperation",

            -- warning texts
            lem_retrigger_max_1 = "{C:inactive}(Max {C:attention}",
            -- .. Lemniscate.retriggerMaximum ..
            lem_retrigger_max_2 = "{C:inactive} retriggers)",

            -- vallkarri easter egg
            -- currently removed but it's kinda funny so you get to see this commented out
            -- k_lem_valk_no_censor = "i'm cancelling lily vallkarri for trying to censor me",

            -- config text
            -- sjogo sprite
            lem_sjogo_sprite = "JP Sjogo Sprite Colors",
            lem_sjogo_info   = "When enabled, changes Sjogo's colors to match Japanese traffic lights",
            lem_sjogo_info_2 = "If language is Japanese, switches to international colors instead",

            -- modded reworks
            lem_modded_content_reworks = "Rework content from other mods (Requires restart)",
            lem_modded_content_info = "If enabled, content from various other mods is reworked to fit this mod better.",

            -- blue stake
            lem_blue_stake_rework = "Reworks Blue Stake (requires restart)",
            lem_alt_blue_stake = {
                "Shop can have {C:attention}Preorder{} Jokers",
                "{C:inactive,s:0.8}(Debuffed for 2 rounds)",
                "{s:0.8}Applies all previous Stakes",
            },

            -- Alexi plushie context descriptions
            -- The second string on each line is put in a {C:attention} tag
            -- For example, "at the", "end of the round" will be displayed like "at the {C:attention}end of the round" would
            lem_alexi_plushie_contexts = {
                -- context.joker_main
                "during", "main joker scoring",

                -- context.setting_blind
                "when", "blind is selected",

                -- (context.individual or context.repetition) and context.cardarea == G.play
                "on", "scored playing cards",

                -- (context.individual or context.repetition) and context.cardarea == G.hand
                "on", "cards held in hand",

                -- context.before or context.initial_scoring_step
                "", "before hand is scored",

                -- context.after or context.final_scoring_step
                "", "after scoring",

                -- context.using_consumeable
                "when a", "consumable is used",

                -- context.selling_self or context.selling_card
                "when a", "card is sold",
            },
        },
        labels = {
            k_lem_fabled = "Fabled",
            k_lem_spell = "Spell",
            k_lem_internal = "Where The Actual Fuck Did You Get This",

            lem_preorder = "Preorder",
            lem_played = "Played this Ante",
            lem_temporary = "Temporary",

            lem_frosted = "Frosted",
            lem_raised = "Raised",
        },
        v_dictionary = {
            a_lem_echips = "^#1# Chips",
            a_lem_emult = "^#1# Mult",
            a_lem_eechips = "^^#1# Chips",
            a_lem_eemult = "^^#1# Mult",
            a_lem_xhands = "X#1# Hands",

            lem_art_credit = "Art: #1#",
            lem_code_credit = "Code: #1#",
            lem_character_credit = "Character: #1#",
            lem_idea_credit = "Idea: #1#",
            lem_shader_credit = "Shader: #1#",

            k_lem_crossmod = "#1# x #2#",

            -- reverse jackie shit
            lem_r_jackie_eq6 = {
                -- mostly things the joker actually sets to 6
                "discards",
                "tarot card uses",
                "booster pack choices",
                "face card rank",
                "free rerolls",
                "round",
                "HERMIT // TEMPERANCE",
                "shop costs",
                "os.time()",
                "6",

                "discards",
                "tarot card uses",
                "booster pack choices",
                "face card rank",
                "free rerolls",
                "round",
                "HERMIT // TEMPERANCE",
                "shop costs",
                "os.time()",
                "6",

                "discards",
                "tarot card uses",
                "booster pack choices",
                "face card rank",
                "free rerolls",
                "round",
                "HERMIT // TEMPERANCE",
                "shop costs",
                "os.time()",
                "6",

                -- leetspeak variations of the actual effects
                "d1sc4rds",
                "74r07 c4rd u535",
                "b00573r p4ck ch01c35",
                "f4c3 c4rd r4nk",
                "fr33 r3r0115",
                "r0und",
                "H3RM17 // 73MP3R4NC3",
                "5h0p c0575",

                "d1sc4rds",
                "74r07 c4rd u535",
                "b00573r p4ck ch01c35",
                "f4c3 c4rd r4nk",
                "fr33 r3r0115",
                "r0und",
                "H3RM17 // 73MP3R4NC3",
                "5h0p c0575",

                -- meaningless/easter egg text
                "RULE_OF",
                "[DATA CORRUPTED]",
                "#1#??", -- displays a table key from the leftmost joker's ability table
                "@##F6666",

                "{f:5}異常",
                "{f:5}六",
                "{f:5}異常六番目",
            }
        },
        challenge_names = {
            c_lem_do_it_vanilla = "Now Do It Vanilla",
            c_lem_dont_forget = "When the Light is Running Low",
        },
        v_text={
            ch_c_lem_vanilla = {
                "All {C:attention}modded{} content is {C:red,E:1}banned{} except for Quests",
            },
            ch_c_lem_no_quest_rewards = {
                "Quests give no {C:attention}rewards",
            },
            ch_c_lem_win_ante = {
                "Win ante is {C:attention}16"
            },
        }
    },

    descriptions = {
        Blind = {
            bl_lem_final_wand = {
                name = "Vermillion Wand",
                text = {
                    "All but one suit",
                    "debuffed every hand",
                    "(changes every hand)"
                }
            },

            bl_lem_final_sword = {
                name = "Sapphire Sword",
                text = {
                    "+#1#X blind requirement",
                    "for each hand",
                    "played this ante"
                }
            },

            bl_lem_final_obol = {
                name = "Ochre Obol",
                text = {
                    "Each card costs X#1#",
                    "its Chips bonus to play",
                    "without being debuffed"
                }
            },

            -- never actually implemented these oops
            bl_lem_final_rose = {
                name = "Black Rose",
                text = {
                    "X0.8 score after",
                    "hand is scored",
                }
            },

            bl_lem_endless_chain = {
                name = "Adamantine Chain",
                text = {
                    "Discarded cards",
                    "become Eternal"
                }
            }
        },

        Joker = {
            -- localization note: just make the name incredibly shitposty
            j_lem_funny_jimbo = {
                name = "THE FORGER OF HILARITY",
                text = {
                    "{B:1,C:white,s:0.5}+#3#2{B:1,C:white,s:1.5}#1#{s:1.5} Mult",
                    "Gains {X:attention,C:white}+#2#{C:attention} operator{} in {C:red}every context",
                }
            },

            j_lem_demiurge = {
                name = "Demiurge",
                text = {
                    "When {C:attention}Blind{} is selected,",
                    "destroy {C:attention}Joker{} to the right",
                    "then create a random {C:attention}Joker{}"
                }
            },

            -- localization note: this joker is intended to be a cult leader. keep that flavor in mind
            j_lem_false_prophet = {
                name = "False Prophet",
                text = {
                    "After earning {C:money}#1##2# {C:inactive}(#1##3#){},",
                    "gain {C:mult}+#5#{} Mult and {C:red,E:1}lose{C:money} #1##4#",
                    "{C:inactive}(Currently {C:mult}+#6#{C:inactive} Mult)"
                }
            },

            j_lem_bad_comparison = {
                name = "Bad Comparison",
                text = {
                    "When {X:lem_echips,C:white}^chips{} is triggered,",
                    "{C:green}#1# in #2#{} chance to {C:red}instead{} create",
                    "a random {C:attention}consumable",
                    "{C:inactive}(Must have room)",
                }
            },

            j_lem_nessie = {
                name = "Nessie",
                text = {
                    "{X:lem_echips,C:white}^#1#{} Chips before all",
                    "other scoring effects"
                }
            },

            j_lem_wizard = {
                name = "Wizard",
                text = {
                    "{C:chips}+#1#{} Chips per {C:lem_spell}Spell{}",
                    "card used this run",
                    "{C:inactive}(Currently {C:chips}+#2#{C:inactive} Chips)",
                },
            },

            j_lem_railroad = {
                name = "Railroad",
                text = {
                    "When completing a {C:attention}Quest{}, gain",
                    "{C:mult}+#2#{} Mult for each star in its {C:attention}difficulty",
                    "{C:inactive}(Currently {C:mult}+#1#{C:inactive} Mult)",
                }
            },

            j_lem_amplifier = {
                name = "Amplifier",
                text = {
                    "{C:mult}+#1#{} Mult before",
                    "{X:mult,C:white}Xmult{} is triggered"
                }
            },

            j_flower_pot_lem_alt = {
                name = "Flower Pot",
                text = {
                    "{X:lem_echips,C:white}^#1#{} Chips if poker",
                    "hand contains a",
                    "{C:diamonds}Diamond{} card, {C:clubs}Club{} card,",
                    "{C:hearts}Heart{} card, and {C:spades}Spade{} card",
                }
            },

            -- localization note: the japanese name can be ripped wholesale from deltarune
            -- deltarune doesn't have any official localizations besides english and japanese so other languages may be troublesome
            j_lem_dark_fountain = {
                name = "Dark Fountain",
                text = {
                    "{C:green}#1# in #2#{} chance for Jokers",
                    "to spawn {C:dark_edition}Negative",
                    "{C:dark_edition}Negative{} Jokers give {C:dark_edition}-1{} Joker slot"
                }
            },

            j_lem_thrill_seeker = {
                name = "Thrill Seeker",
                text = {
                    "{X:lem_echips,C:white}^#1#{} Chips for every",
                    "{C:attention}hand size{} below {C:attention}8{}",
                    "{C:inactive}(Currently {X:lem_echips,C:white}^#2#{C:inactive} Chips)"
                }
            },

            j_lem_bite_me_more_pls = {
                name = "BITE ME MORE PLS",
                text = {
                    "Destroy the {C:attention}first",
                    "scored card with {V:1}#1#{} suit",
                    "{s:0.8}Suit changes every hand"
                }
            },

            j_lem_astrologer = {
                name = "Astrologer",
                text = {
                    "Create a {C:lem_spell}Spell{} card",
                    "when a {C:planet}Planet{} card is used",
                    "{C:inactive}(Must have room)"
                }
            },

            j_lem_paladin = {
                name = "Paladin",
                text = {
                    "{X:mult,C:white}X#1#{} Mult per {C:lem_spell}Spell{} card",
                    "used this round",
                    "{C:inactive}(Currently {X:mult,C:white}X#2#{C:inactive} Mult)"
                }
            },

            j_lem_swarm_intelligence = {
                name = "Swarm Intelligence",
                text = {
                    "When a non-{C:attention}Temporary {C:lem_spell}Spell{} card",
                    "is used, create a {C:attention}Temporary{} copy",
                }
            },

            j_lem_tesla_coil = {
                name = "Tesla Coil",
                text = {
                    "{C:purple}Balances{} Chips and Mult",
                    "before all other scoring effects",
                }
            },

            j_lem_alexi_plushie = {
                name = "Alexi Plushie",
                text = {
                    "Copies all {C:attention}Joker{}",
                    "effects that trigger",
                    "#1# {C:attention}#2#",
                    "{s:0.8}Timing changes every round",
                    "{C:inactive,s:0.8}(Does not copy Alexi Plushie)"
                }
            },

            j_lem_cannonball = {
                name = "Cannonball",
                text = {
                    "Retrigger all scored cards {C:attention}#1#{} times",
                    "Only played cards that are {C:red}not{} part of",
                    "the played {C:attention}poker hand{} are scored"
                }
            },

            j_lem_haunted_house = {
                name = "Haunted House",
                text = {
                    -- "This Joker gains",
                    "{X:lem_echips,C:white}^#2#{} Chips for every",
                    "{C:attention}Ace{} scored this hand",
                    "{C:inactive}(Currently {X:lem_echips,C:white}^#1#{C:inactive} Chips)",
                }
            },

            j_lem_all_or_nothing = {
                name = "All or Nothing",
                text = {
                    "Retrigger all {C:attention}Jokers",
                    "{C:green}#1# in #2#{} chance for a {C:attention}Joker{} to",
                    "instead {C:red}fail{} to trigger"
                }
            },

            -- signalis has localized versions that might help
            -- but the name of the artifact ending doesn't always directly reference the artifact in each language
            j_lem_artifact = {
                name = "The Artifact",
                text = {
                    "{X:lem_echips,C:white}^#1#{} Chips for every",
                    "visible {C:attention}secret hand{}",
                    "{C:inactive}(Currently {X:lem_echips,C:white}^#2#{C:inactive} Chips)",
                }
            },

            j_lem_pawnbroker = {
                name = "Pawnbroker",
                text = {
                    "Create a {C:lem_spell}#1#{} card",
                    "when a {V:2}#2#{} card is {C:attention}sold",
                    "{s:0.8}Selects new consumable types",
                    "{s:0.8}when leaving the {s:0.8,C:attention}shop",
                    "{C:inactive}(Must have room)"
                }
            },

            j_lem_dead_ringer = {
                name = "Dead Ringer",
                text = {
                    "Prevents death against {C:attention}Small Blinds",
                    "{X:mult,C:white}X#1#{} Mult if this Joker prevented",
                    "death this {C:attention}ante",
                    "{C:inactive}(#2#)"
                }
            },

            j_lem_gay_baby_jail = {
                name = "Gay Baby Jail",
                text = {
                    "Fixed {C:green}#1# in #2#{} chance for {C:attention}-#3#{} ante",
                    "when failing a {C:attention}Quest",
                    "{s:0.8}In Endless Mode, will also prevent death",
                    "{s:0.8}if this probability {C:attention,s:0.8}succeeds"
                },
            },

            j_lem_petrification = {
                name = "Petrification",
                text = {
                    "When using a {C:lem_spell}Spell{} Card",
                    "a random card held in hand",
                    "becomes a {C:attention}Stone{} Card"
                }
            },

            j_lem_aromaticity = {
                name = "Aromaticity",
                text = {
                    "{C:attention}Straight{}, {C:attention}Flush{}, and",
                    "{C:attention}Straight Flush{} share hand",
                    "level-ups"
                }
            },

            j_lem_maxx_c = {
                name = 'Maxx "C"',
                text = {
                    "This Joker gains {C:attention}+#2#{} hand size",
                    "when a {C:attention}consumable{} is used, resets",
                    "at end of round",
                    "{C:inactive}(Currently {C:attention}+#1#{C:inactive} hand size)"
                }
            },

            j_lem_wallsocket = {
                name = "Wallsocket",
                text = {
                    "Guarantees all {C:attention}listed {C:green,E:1}probabilities{},",
                    "{X:gold,C:white}#1#X#2#{} at end of round",
                    "{C:inactive,s:0.8}Good luck!~"
                }
            },

            j_lem_alexi = {
                name = "{E:lem_alexi_text}Alexi!",
                text = {
                    "Copies ability of {C:attention}Jokers{}",
                    "to the left and right"
                },
                unlock = {
                    "{E:1,s:1.3}?????",
                },
            },

            j_lem_r_alexi = {
                -- the capricious would fit very well but unfortunately i am not tainted eden
                -- or perhaps fortunately
                name = "The Variable",
                text = {
                    "Copies ability of {C:attention}3{} random {C:attention}Jokers{}",
                    "Picks new Jokers when entering the {C:attention}shop"
                }
            },

            -- localization note: this is a splatoon au of alexi
            -- for a localized name, look into how jelletons in splatoon 3: side order are named in the language you're localizing for
            -- marina agitando is especially good to look at as she's a normal character with a name modified to fit the convention in english
            -- tbh might remove this
            --[[j_lem_asc_alexi = {
                name = "Alexi Allegro",
                text = {
                    "Copies ability of {C:attention}Joker{}",
                    "to the left and right",
                    "Copied {C:attention}scoring{} jokers are calculated",
                    "with the next highest {C:attention}operator{}",
                    "and the scoring values {C:attention}square rooted{}",
                    "{C:inactive,s:0.8}(Is not copied by Blueprint-like effects)"
                }
            },]]

            j_lem_kori = {
                name = "Korihas",
                text = {
                    "{C:green}#3# in #4#{} chance for played cards",
                    "to {C:red,E:lem_shaking}shatter{} and add {X:lem_echips,C:white}^#2#{} Chips",
                    "to this Joker",
                    "{C:inactive}(Currently {X:lem_echips,C:white}^#1#{C:inactive} Chips)",
                },
                unlock = {
                    "{E:1,s:1.3}?????",
                },
            },

            j_lem_r_kori = {
                name = "The Defiant",
                text = {
                    {
                        "Scored cards become",
                        "{C:attention}Glass{} cards after scoring"
                    },
                    {
                        "When a {C:attention}Glass{} card {C:red}shatters{},",
                        "create a {C:attention}copy{} with an",
                        "additional {X:mult,C:white}X#1#{} Mult"
                    }
                },
                unlock = {
                    "{E:1,s:1.3}?????",
                },
            },

            j_lem_sjogo = {
                name = "Sjogo",
                text = {
                    "Retrigger scored cards",
                    "{C:attention}#1#{} times per non-scoring card",
                },
                unlock = {
                    "{E:1,s:1.3}?????",
                },
            },

            j_lem_r_sjogo = {
                name = "The Device", -- not entirely satisfied with this but gah
                text = {
                    "This Joker changes effects",
                    "every {C:attention}#1#{} seconds",
                },
            },

            j_lem_r_sjogo1 = {
                name = "The Device",
                text = {
                    {
                        "This Joker changes effects",
                        "every {C:attention}#1#{} seconds",
                    },
                    {
                        "{C:green}#2# in #3#{} chance for",
                        "played cards to create a",
                        "{C:dark_edition}Negative {C:red}Inverted{} card",
                        "when scored"
                    }
                },
            },

            j_lem_r_sjogo2 = {
                name = "The Device",
                text = {
                    {
                        "This Joker changes effects",
                        "every {C:attention}#1#{} seconds",
                        --"{C:inactive,s:0.8}(Effect cannot change",
                        --"{C:inactive,s:0.8}while hand is being scored)"
                    },
                    {
                        "Played {C:attention}unscored{} cards",
                        "permanently gain",
                        "{C:gold}+#4#{} Ascension Power"
                    }
                },
            },

            j_lem_r_sjogo3 = {
                name = "The Device",
                text = {
                    {
                        "This Joker changes effects",
                        "every {C:attention}#1#{} seconds",
                        --"{C:inactive,s:0.8}(Effect cannot change",
                        --"{C:inactive,s:0.8}while hand is being scored)"
                    },
                    {
                        "Held in hand {C:attention}Enhanced",
                        "cards level up {C:attention}#5#{} random",
                        "poker hands"
                    }
                },
            },

            j_lem_morgan = {
                name = "Morgan",
                text = {
                    {
                        "{X:lem_echips,C:white}^#3#{} Chips"
                    },
                    {
                        "{C:attention}Once{} per ante, selling this Joker",
                        "will create {C:attention}#2#{} copies of it",
                        "{C:inactive}(#1#)",
                    }
                },
                unlock = {
                    "{E:1,s:1.3}?????",
                },
            },

            -- might need a rework soon
            j_lem_r_morgan = {
                name = "The Bereaved",
                text = {
                    {
                        "{C:attention}Once{} per ante, prevent death if",
                        "at least {C:attention}1{} Joker is not {C:attention}Eternal{},",
                        "then immediately use {C:red}Pact of Eternity",
                        "{C:inactive}(#1#)"
                    },
                    {
                        "Retrigger {C:red}Pact of Eternity{} once",
                        "for every active {C:red}Pact of Eternity",
                        "{C:inactive}(Currently {C:attention}#2#{C:inactive} retriggers)"
                    }
                },
                unlock = {
                    "{E:1,s:1.3}?????",
                },
            },

            j_lem_zekki = {
                name = "Zekki",
                text = {
                    "When a {C:attention}consumable{} is used,",
                    "this Joker gains {C:chips}+#2#{} Chips for each",
                    "{C:attention}consumable{} used this run",
                    "{C:inactive}(Currently {C:chips}+#1#{C:inactive} Chips)",
                    "{C:inactive}(Will gain {C:chips}+#3#{C:inactive} Chips)"
                },
                unlock = {
                    "{E:1,s:1.3}?????",
                },
            },

            -- reverse zekki: "The Isolated"

            j_lem_jackie = {
                name = "Jackie",
                text = {
                    "{X:blue,C:white}X#1#{} hands when {C:attention}Blind{}",
                    "is selected",
                },
                unlock = {
                    "{E:1,s:1.3}?????",
                },
            },

            -- see v_dictionary
            j_lem_r_jackie = {
                name = "The Anomaly",
                -- no text field; the text is generated in a manner similar to misprint
            },

            j_lem_tsen = {
                name = "Tsen",
                text = {
                    "{C:attention}+#1#{} hand size",
                    "{C:attention}+#2#{} consumable slots",
                    "{C:attention}+#3#{} card selection limit",
                },
                unlock = {
                    "{E:1,s:1.3}?????",
                },
            },

            -- reverse tsen: "The Cheated"
            -- +X1 Ascension Power for every card in played hand under card selection limit

            j_lem_riqa = {
                name = "Riqa",
                text = {
                    "All enhanced cards count",
                    "as {C:attention}Steel{} cards"
                }
            },

            -- crossmod misc
            --[[j_lem_eldritch_invocation = {
                name = "Eldritch Invocation",
                text = {
                    "Spell Cards gain +1 use",
                    "per Pact used this run"
                }
            },]]

            -- fabled jokers
            j_lem_ouroboros = {
                name = "Ouroboros",
                text = {
                    {
                        "{C:red,E:lem_shaking}Destroy{} all {C:attention}played{} cards",
                    },
                    {
                        "Create copies of the {C:attention}first",
                        "card in each {C:attention}discard{} until",
                        "there are {C:attention}52{} cards in the deck"
                    }
                },
            },

            j_lem_wild_hunt = {
                name = "Wild Hunt",
                text = {
                    "{C:attention}Wild{} cards retrigger",
                    "adjacent cards {C:attention}10{} times"
                }
            },

            j_lem_charon = {
                name = "Charon",
                text = {
                    "When {X:mult,C:white}Xmult{} is triggered, {C:red}destroy{}",
                    "its {C:attention}source{} and gain {X:lem_emult,C:white}^#2#{} Mult",
                    "{C:inactive}(Currently {X:lem_emult,C:white}^#1#{C:inactive} Mult)",
                },
            },

            j_lem_big_bang = {
                name = "Big Bang",
                text = {
                    "After levelling up a hand,",
                    "{C:attention,E:1}double{} that hand's level"
                }
            },

            j_lem_prophecy = {
                name = "PROPHECY",
                text = {
                    {
                        "{C:legendary,E:1}Hidden consumables{} appear",
                        "much more frequently"
                    },
                    {
                        "Gains {X:lem_echips,C:white}^#2#{} Chips when",
                        "any {C:attention}Booster Pack{} containing a",
                        "{C:legendary,E:1}hidden consumable{} is skipped",
                        "{C:inactive}(Currently {X:lem_echips,C:white}^#1#{C:inactive} Chips)"
                    }
                }
            },

            j_lem_entire_fucking_polycule = {
                name = "The Entire Fucking Polycule", -- except melons
                text = {
                    {
                        "Copies ability of {C:attention}Alexi"
                    },
                    {
                        "Copies abilities of {C:attention}TwyLight{},",
                        "{C:attention}ellestuff.{}, and {C:attention}Jess{} {C:attention}twice{}",
                    },
                    -- extra awesome bonus effect
                    {
                        "{X:lem_echips,C:white}^#1#{} Chips"
                    }
                }
            },

            -- entropy - void jokers
            j_lem_thorn_ring = {
                name = "Thorn Ring",
                text = {
                    {
                        "All {C:lem_spell}Spell{} cards are",
                        "replaced with {C:attention}Frostbite{}",
                    },
                    {
                        "Gains {X:chips,C:white}X#2#{} Chips when",
                        "using {C:attention}Frostbite",
                        "{C:inactive}(Currently {X:chips,C:white}X#1#{C:inactive} Chips)",
                    },
                    {
						"{s:0} "
					}
                }
            },

            -- lemniscate title screen clone
            j_lem_lemniscate_title_card_clone = {
                name = "ERROR!",
                text = {
                    "This Joker is a copy of {C:attention}Lemniscate",
                    "used for the card on the {C:attention}main menu{},",
                    "and should not be obtainable legitimately.",
                    "If you see this message, please {C:red}report{} where",
                    "you saw it, and {C:red}precisely{} what you did",
                    "to find it."
                }
            }
        },

        Back = {
            b_lem_stairway = {
                name = "Stairway Deck",
                text = {
                    "{C:legendary,E:1}Harder{} Quests",
                    "appear more {C:attention}often"
                }
            },

            -- with vallkarri this effectively does what stairway deck does normally
            --[[b_lem_stairway_valk = {
                name = "Stairway Deck",
                text = {
                    "Start with a {C:lem_fabled}#2#{} joker",
                    "and {C:attention}#1# {C:tarot,T:tag_buffoon}#3#s",
                    "Rarer Jokers appear more often",
                    "{X:attention,C:white}X#4#{} effective ante",
                    "{C:attention}Endless Mode{} is active immediately"
                }
            }]]
        },

        Quest = {
            -- the descriptions with the "_short" suffix are used for the quest progress UI
            -- 1 star
            qst_lem_supply_run = {
                name = "Supply Run",
                text = { "Purchase #1# cards" },
                ui_text = { "#1#/#2# cards" }
            },
            qst_lem_supply_run_short = {
                name = "Supply Run",
                text = { "#1#/#2# cards" }
            },
            qst_lem_just_browsing = {
                name = "Just Browsing!",
                text = {
                    "Reroll the shop",
                    "#1# times"
                }
            },
            qst_lem_just_browsing_short = {
                name = "Just Browsing!",
                text = { "#1#/#2# rerolls" }
            },
            qst_lem_janitor_duty = {
                name = "Janitor Duty",
                text = { "Use #1# discards" },
                ui_text = { "#1#/#2# discards" }
            },
            qst_lem_janitor_duty_short = {
                name = "Janitor Duty",
                text = { "#1#/#2# discards" }
            },

            -- 2 stars
            qst_lem_speedy_delivery = {
                name = "Speedy Delivery",
                text = { "Play #1# or less hands" },
                ui_text = { "#1#/#2# hands" }
            },
            qst_lem_speedy_delivery_short = {
                name = "Speedy Delivery",
                text = { "#1#/#2# hands" }
            },
            qst_lem_espionage_mission = {
                name = "Espionage Mission",
                text = { "Play at least #1# hands" },
                ui_text = { "#1#/#2# hands" }
            },
            qst_lem_espionage_mission_short = {
                name = "Espionage Mission",
                text = { "#1#/#2# hands" }
            },
            qst_lem_survey_stars = {
                name = "Survey the Stars",
                text = {
                    "Use at least #1#",
                    "Planet cards"
                },
                ui_text = { "#1#/#2# Planets" }
            },
            qst_lem_survey_stars_short = {
                name = "Survey the Stars",
                text = { "#1#/#2# Planets" }
            },

            -- 3 stars
            qst_lem_avoid = {
                name = "Keep a Secret",
                text = { "Don't play a #1#" },
                ui_text = { "Don't play", "a #1#" }
            },
            qst_lem_avoid_short = {
                name = "Keep a Secret",
                text = { "Don't play", "a #1#" }
            },
            qst_lem_demolition = {
                name = "Controlled Demolition",
                text = {
                    "Don't score",
                    "more than #1#"
                },
                ui_text = { "#1#/#2#" }
            },
            qst_lem_demolition_short = {
                name = "Controlled Demolition",
                text = { "#1#/#2#" }
            },
            qst_lem_gain_recruits = {
                name = "Recruit New Members",
                text = {
                    "Add #1# new",
                    "playing cards to",
                    "your deck"
                },
                ui_text = { "#1#/#2# cards" }
            },
            qst_lem_gain_recruits_short = {
                name = "Recruit New Members",
                text = { "#1#/#2# cards" }
            },
            qst_lem_assassination = {
                name = "Assassination",
                text = {
                    "Defeat the Boss Blind",
                    "in a single hand"
                },
            },
            qst_lem_assassination_short = {
                name = "Assassination",
                text = { "#1#/#2# hands" },
            },
            qst_lem_throw_for_content = {
                name = "Throw for Content",
                text = {
                    "Skip #1#",
                    "booster packs"
                },
            },
            qst_lem_throw_for_content_short = {
                name = "Throw for Content",
                text = { "#1#/#2# skipped" }
            },

            -- 4 stars
            qst_lem_find_mole = {
                name = "Find the Mole",
                text = {
                    "Earn $#1# from",
                    "selling Jokers"
                },
                ui_text = { "$#1#/#2#" }
            },
            qst_lem_find_mole_short = {
                name = "Find the Mole",
                text = { "$#1#/#2#" }
            },
            qst_lem_ford_the_river = {
                name = "Ford the River",
                text = {
                    "Do not use",
                    "any discards"
                },
                ui_text = { "#1#/#2#" }
            },
            qst_lem_ford_the_river_short = {
                name = "Ford the River",
                text = {
                    "Do not use",
                    "any discards"
                },
            },
            -- not added yet
            --[[qst_lem_double_duty = {
                name = "Double Duty",
                text = {
                    "Complete 2 random quests"
                }
            },
            qst_lem_double_duty_short = {
                name = "Double Duty",
                text = {
                    "#1#",
                    "#2#"
                }
            },]]

            -- 5 stars
            qst_lem_put_on_a_show = {
                name = "Put on a Show",
                text = {
                    "Play #1#",
                    "unique cards"
                },
                ui_text = { "#1#/#2# cards" }
            },
            qst_lem_put_on_a_show_short = {
                name = "Put on a Show",
                text = {
                    "#1#/#2# cards"
                }
            },
            qst_lem_it_hungers = {
                name = "It Hungers",
                text = {
                    "Only play",
                    "#1#"
                },
                ui_text = {
                    "Only play",
                    "#1#"
                }
            },
            qst_lem_it_hungers_short = {
                name = "It Hungers",
                text = {
                    "Only play",
                    "#1#"
                }
            },
            qst_lem_see_everything = {
                name = "See Everything",
                text = {
                    "Play at least",
                    "#1# poker hand types",
                    "without repeats"
                },
                ui_text = { "#1#/#2# hands" }
            },
            qst_lem_see_everything_short = {
                name = "See Everything",
                text = {
                    "#1#/#2# hands"
                }
            },
            qst_lem_repent = {
                name = "Repent",
                text = {
                    "Sell #1#",
                    "before entering any Blind"
                }
            },
            qst_lem_repent_short = {
                name = "Repent",
                text = { "Sell #1#" }
            },

            -- Endless Entropy (Entropy crossmod)
            qst_lem_endless_entropy = {
                name = "?????",
                text = {
                    "Survive."
                },
                ui_text = { "#1#/#2# hands" }
            },
            qst_lem_endless_entropy_short = {
                name = "?????",
                text = {
                    "Survive."
                }
            },
            qst_lem_endless_entropy_short_in_ee = {
                name = "Endless Entropy",
                text = {
                    "Survive."
                }
            },
        },

        lem_spell = {
            c_lem_fireball = {
                name = "Fireball",
                text = { "{X:mult,C:white}X#1#{} Mult next hand" }
            },
            c_lem_fireball_infinity = {
                name = "Fireball",
                text = { "{X:legendary,C:white,E:1}X#1#{} Mult" }
            },
            c_lem_frostbite = {
                name = "Frostbite",
                text = { "{C:chips}+#1#{} Chips next hand" }
            },
            c_lem_frostbite_infinity = {
                name = "Frostbite",
                text = { "{C:legendary,E:1}+#1#{} Chips" }
            },
            c_lem_confusion = {
                name = "Confusion",
                text = {
                    "Gain {C:blue}+#1#{} hand",
                    "Next hand will {C:red}not{} be counted",
                    "towards your {C:attention}score"
                }
            },
            c_lem_confusion_infinity = {
                name = "Confusion",
                text = {
                    "{C:legendary,E:1}Permanently{} gain {C:legendary,E:1}+#1#{} hand",
                    "This hand will {C:red}not{} be counted",
                    "towards your {C:legendary,E:1}score"
                }
            },
            c_lem_divination = {
                name = "Divination",
                text = {
                    "Draw {C:attention}#1#{} cards to hand"
                }
            },
            c_lem_divination_infinity = {
                name = "Divination",
                text = {
                    "{C:legendary,E:1}Permanently{} gain",
                    "{C:legendary,E:1}+#1#{} hand size"
                }
            },
            c_lem_fortune = {
                name = "Fortune",
                text = {
                    "Quadruples all {C:attention}listed",
                    "{C:green,E:1,S:1.1}probabilities{} next hand",
                }
            },
            c_lem_fortune_infinity = {
                name = "Fortune",
                text = {
                    "Quadruples all {C:attention}listed",
                    "{C:legendary,E:1,S:1.1}probabilities{}"
                }
            },
            c_lem_haste = {
                name = "Haste",
                text = {
                    "{C:attention}Retrigger{} all played",
                    "cards next hand"
                }
            },
            c_lem_haste_infinity = {
                name = "Haste",
                text = {
                    "{C:legendary,E:1}Retrigger{} all played cards"
                }
            },
            c_lem_mirror_image = {
                name = "Mirror Image",
                text = {
                    "Create a {C:attention}Temporary {C:dark_edition}Negative{} copy",
                    "of {C:attention}#1#{} selected Joker",
                }
            },
            c_lem_mirror_image_infinity = {
                name = "Mirror Image",
                text = {
                    "Create a {C:legendary,E:1}Negative{} copy",
                    "of {C:legendary,E:1}#1#{} selected Joker",
                }
            },
            c_lem_starstorm = {
                name = "Starstorm",
                text = {
                    "{C:attention}+#1#{} hand levels to",
                    "next played {C:attention}poker hand",
                    "Levels from this effect are",
                    "{C:red,E:1}lost{} after hand is scored"
                }
            },
            c_lem_starstorm_infinity = {
                name = "Starstorm",
                text = {
                    "{C:legendary,E:1}+#1#{} hand levels to",
                    "next played {C:legendary,E:1}poker hand",
                }
            },
            c_lem_moonbeam = {
                name = "Moonbeam",
                text = {
                    "Upgrade the level of the",
                    "next played {C:attention}poker hand"
                }
            },
            c_lem_moonbeam_infinity = {
                name = "Moonbeam",
                text = {
                    "Upgrade the level of the",
                    "first played {C:legendary,E:1}poker hand",
                    "each round"
                }
            },
            c_lem_mage_hand = {
                name = "Mage Hand",
                text = {
                    "{C:attention}+#1#{} card selection limit",
                    "until hand is played"
                }
            },
            c_lem_mage_hand_infinity = {
                name = "Mage Hand",
                text = {
                    "{C:legendary,E:1}Permanently{} gain",
                    "{C:legendary,E:1}+#1#{} card selection limit"
                }
            },
            c_lem_enervate = {
                name = "Enervate",
                text = {
                    "Disables the {C:attention}Boss Blind{}",
                    "until after hand is scored",
                }
            },
            c_lem_enervate_infinity = {
                name = "Enervate",
                text = {
                    "Disables the {C:attention}Boss Blind{}",
                    "until after {C:legendary,E:1}first hand",
                    "each round is scored",
                }
            },
            c_lem_avarice = {
                name = "Avarice",
                text = {
                    "Playing cards earn {C:money}#1##2#{}",
                    "when scored next hand"
                }
            },
            c_lem_avarice_infinity = {
                name = "Avarice",
                text = {
                    "Playing cards earn {C:legendary,E:1}#1##2#{}",
                    "when scored"
                }
            },
            c_lem_polymorph = {
                name = "Polymorph",
                text = {
                    "Next hand, convert a random {C:attention}scored{} card",
                    "into a random {C:attention}unscored{} card"
                }
            },
            c_lem_chaos = {
                name = "Chaos",
                text = {
                    "Use {C:attention}#1#{} random",
                    "{C:lem_spell}Spell{} cards"
                }
            },
            c_lem_chaos_infinity = {
                name = "Chaos",
                text = {
                    "Use {C:legendary,E:1}#1#{} random",
                    "{C:legendary,E:1}Spell{} cards"
                }
            },
        },

        Spectral = {
            c_lem_lemniscate = {
                name = "Lemniscate",
                text = {
                    "All {C:lem_spell}Spell{} cards used this hand",
                    "become {C:legendary,E:1}permanent{}",
                    "{C:inactive, s:0.8}(Spells may have altered effects)",
                }
            }
        },

        Tag = {
            tag_lem_frosted = {
                name = "Frosted Tag",
                text = {
                    "Next base edition shop",
                    "Joker is free and",
                    "becomes {C:dark_edition}Frosted",
                },
            },

            tag_lem_acidic = {
                name = "Acidic Tag",
                text = {
                    "Next base edition shop",
                    "Joker is free and",
                    "becomes {C:dark_edition}Acidic",
                },
            },

            tag_lem_magick = {
                name = "Magick Tag",
                text = {
                    "Gives a free",
                    "{C:lem_spell}Mega Sorcery Pack",
                },
            },

            tag_lem_legendary = {
                name = "Soul Tag",
                text = {
                    "Shop has a",
                    "{C:legendary,E:1}Legendary Joker",
                },
            },

            tag_lem_singularity = {
                name = "Singularity Tag",
                text = {
                    "Upgrade every",
                    "{C:legendary,E:1}poker hand",
                    "by {C:attention}#1#{} levels",
                },
            },

            tag_lem_infinity = {
                name = "Infinity Tag",
                text = {
                    "The next used {C:lem_spell}Spell{} card",
                    "becomes {C:legendary,E:1}permanent",
                    "{C:inactive, s:0.8}(Spells may have altered effects)",
                },
            },

            tag_lem_xmult_tag = {
                name = "EPIC TEST TAG OF DOOM",
                text = {
                    "{X:mult,C:white}X#1#{} Mult next hand"
                }
            },

            tag_lem_myths = {
                name = "Tag of Myths",
                text = {
                    "Gives a free",
                    "{C:lem_fabled,E:1}Mythical Pack",
                },
            },

            tag_lem_transcendence = {
                name = "Transcendence",
                text = {
                    "{C:entr_entropic,E:1}The ultimate reward.",
                    "{C:inactive}(Must have room)",
                }
            }
        },

        Edition = {
            e_lem_frosted = {
                name = "Frosted",
                text = {
                    "Gives more {X:lem_echips,C:white}^chips{} the more",
                    "{V:1}balanced {C:chips}chips{} and {C:mult}mult{} are",
                    "{C:inactive}(Max {X:lem_echips,C:white}^#1#{C:inactive} Chips)"
                },
            },

            e_lem_raised = {
                name = "Raised",
                text = {
                    "{X:attention,C:white}X#1#{} quest requirements",
                },
            },
        },

        Enhanced = {
            m_lem_highway = {
                name = "Highway Card",
                text = {
                    "This card gains {X:mult,C:white}X#2#{} Mult",
                    "when {C:attention}discarded{}",
                    "{C:inactive}(Currently {X:mult,C:white}X#1#{C:inactive} Mult)"
                }
            }
        },

        Other = {
            -- localization note: forger of hilarity text. be a little shit with this one
			o_lem_pranked = {
				name = "Extremely important information",
				text = {
					"Read the joker text again :3c"
				},
			},

            -- directly taken from vanilla
            undiscovered_lem_spell = {
                name = "Not Discovered",
                text = {
                    "Purchase or use",
                    "this card in an",
                    "unseeded run to",
                    "learn what it does",
                },
            },

            o_lem_negative_dark_fountain = {
                name = "Negative Dark Fountain",
                text = {
                    "Does not require room",
                    "to be purchased"
                }
            },

            -- this is a crossmod info text
            o_lem_ortalab_dead_ringer = {
                name = "Ortalab Blinds",
                text = {
                    "{C:attention}Fold{}, {C:attention}Check{}, and {C:attention}Bet{} also",
                    "count as Small Blinds",
                    "for this Joker's purposes"
                }
            },

            lem_preorder = {
                name = "Preorder",
                text = {
                    "Debuffed for",
                    "{C:attention}#1#{} rounds",
                    "{C:inactive}({C:attention}#2#{C:inactive} remaining)",
                }
            },

            lem_played = {
                name = "Played",
                text = {
                    "Card was already",
                    "played this {C:attention}ante"
                }
            },

            lem_temporary = {
                name = "Temporary",
                text = {
                    "{C:red}Destroyed{} at the",
                    "end of the round"
                }
            },

            -- used generically by all sorcery packs
            p_lem_sorcery_normal = {
                name = "Sorcery Pack",
                text = {
                    "Choose {C:attention}#1#{} of up to",
                    "{C:attention}#2#{C:lem_spell} Spell{} cards",
                },
            },

            p_lem_sorcery_jumbo = {
                name = "Jumbo Sorcery Pack",
                text = {
                    "Choose {C:attention}#1#{} of up to",
                    "{C:attention}#2#{C:lem_spell} Spell{} cards",
                },
            },

            p_lem_sorcery_mega = {
                name = "Mega Sorcery Pack",
                text = {
                    "Choose {C:attention}#1#{} of up to",
                    "{C:attention}#2#{C:lem_spell} Spell{} cards",
                },
            },

            p_lem_fabled_pack = {
                name = "Mythical Pack",
                text = {
                    "Choose {C:attention}#1#{} of up to",
                    "{C:attention}#2#{C:lem_fabled,E:1} Fabled Jokers{}",
                },
            },

            slime_upgr_j_lem_alexi = {
				name = "Upgrade",
				text = {
					"Have {C:attention}TwyLight{},",
					"{C:attention}ellestuff.{}, and {C:attention}Jess"
				}
			},
        }
    }
}