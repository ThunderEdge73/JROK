-- Astra

SMODS.Joker({
	key = "normal",
	atlas = "stolen",
	pos = {
		x = 2,
		y = 0,
	},
	config = {
		extra = {
			mult = 2,
			chips = 15,
		},
	},
	discovered = true,
	rarity = 1,
	blueprint_compat = true,
	cost = 3,
	loc_vars = function(self, info_queue, card)
		local stg = card.ability.extra
		return { vars = { stg.mult, stg.chips } }
	end,
	calculate = function(self, card, context)
		local stg = card.ability.extra
		if context.individual and context.cardarea == G.play then
			if
				not context.other_card.edition
				and not context.other_card.seal
				and not next(SMODS.get_enhancements(context.other_card))
			then
				return {
					mult = stg.mult,
					chips = stg.chips,
					card = card,
				}
			end
		end
	end,
	in_pool = function(self, args)
		return false
	end,
})

SMODS.Joker({
	key = "4d",
	atlas = "stolen_4d",
	pos = {
		x = 0,
		y = 0,
	},
	rarity = 2,
	perishable_compat = false,
	eternal_compat = false,
	blueprint_compat = true,
	cost = 6,
	config = {
		extra = {
			Xmult = 4,
			dXmult = 0.01,
			dt_mod = 0,
		},
	},
	loc_vars = function(self, info_queue, card)
		local stg = card.ability.extra
		return {
			vars = { stg.Xmult, stg.dXmult },
		}
	end,
	calculate = function(self, card, context)
		local stg = card.ability.extra
		if context.joker_main and stg.Xmult > 1 then
			return {
				x_mult = stg.Xmult,
			}
		end
		if stg.Xmult <= 1 and not context.blueprint and not stg.depleated then
			stg.depleated = true
			card:start_dissolve({ G.C.BLUE }, nil, 1.6)
		end
	end,
	set_sprites = function(self, card, front)
		card.children.floating_sprite =
			Sprite(card.T.x, card.T.y, card.T.w, card.T.h, G.ASSET_ATLAS["jrok_stolen_4d_soul"], { x = 0, y = 1 })
		card.children.floating_sprite.role.draw_major = card
		card.children.floating_sprite.states.hover.can = false
		card.children.floating_sprite.states.click.can = false
	end,
	update = function(self, card, dt)
		local stg = card.ability.extra
		if not G.SETTINGS.paused and card.area == G.jokers then
			stg.dt_mod = stg.dt_mod + dt
		end
		if stg.dt_mod > 1 * G.SETTINGS.GAMESPEED then
			stg.dt_mod = 0
			if stg.Xmult > 1 and not card.debuff then
				stg.Xmult = math.max(stg.Xmult - stg.dXmult, 1)
				card:juice_up(0.1, 0.2)
				play_sound("generic1")
			end
		end
	end,
})

SMODS.DrawStep({
	key = "jrok_4d_float",
	order = 60,
	func = function(self)
		if
			self.config.center_key == "j_jrok_4d" and (self.config.center.discovered or self.bypass_discovery_center)
		then
			local scale_mod = 0.07
				+ 0.02 * math.sin(1.8 * G.TIMERS.REAL)
				+ 0.00
					* math.sin((G.TIMERS.REAL - math.floor(G.TIMERS.REAL)) * math.pi * 14)
					* (1 - (G.TIMERS.REAL - math.floor(G.TIMERS.REAL))) ^ 3
			local rotate_mod = 0.05 * math.sin(1.219 * G.TIMERS.REAL)
				+ 0.00 * math.sin(G.TIMERS.REAL * math.pi * 5) * (1 - (G.TIMERS.REAL - math.floor(G.TIMERS.REAL))) ^ 2

			self.children.floating_sprite:draw_shader(
				"dissolve",
				0,
				nil,
				nil,
				self.children.center,
				scale_mod,
				rotate_mod,
				nil,
				0.1 + 0.03 * math.sin(1.8 * G.TIMERS.REAL),
				nil,
				0.6
			)
			self.children.floating_sprite:draw_shader(
				"dissolve",
				nil,
				nil,
				nil,
				self.children.center,
				scale_mod,
				rotate_mod
			)
			if self.edition then
				local edition = G.P_CENTERS[self.edition.key]
				if edition.apply_to_float and self.children.floating_sprite then
					self.children.floating_sprite:draw_shader(
						edition.shader,
						nil,
						nil,
						nil,
						self.children.center,
						scale_mod,
						rotate_mod
					)
				end
			end
		end
	end,
	conditions = { vortex = false, facing = "front" },
})
