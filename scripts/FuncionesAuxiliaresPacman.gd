extends Node

signal marcador_actualizado
signal scene_actualizada

# =================================================================
# 	T R A N S I C I O N E S
# -----------------------------------------------------------------
#func transicion_level_up(delta, context):
	#if not GlobalValues.estado_juego["transicion_goal_zone"]:
		#return
	#
	#if context.velocity.x <= 0.0:
		#context.velocity = Vector2(abs(context.VEL_MAX / 8), 0)
		#context.sprite.flip_h = false
	#
	#FuncionesGenerales.aplicar_gravedad(delta, context)
	#context.move_and_slide()
	#AnimacionesMario.update_animation(context)
	#FuncionesMovSaltoMario.aplicar_clamps(context)

#func transicion_vida_menos(delta, context):
	#if not GlobalValues.estado_juego["transicion_vida_menos"]:
		#return
	#
	#FuncionesGenerales.aplicar_gravedad(delta, context)
	#context.move_and_slide()
	#AnimacionesMario.update_animation(context)
	#FuncionesMovSaltoMario.aplicar_clamps(context)
	#
	#if GlobalValues.marcadores["lives"] <= 0:
		#print("señal gameover")
		#FuncionesGenerales.reset_estados_cambio_estado_a("game_over")
		#FuncionesGenerales.emitir_signal_gameover()
		#return
	#
	#if context.timerTransicionVidaMenos.time_left == 0.0 and GlobalValues.estado_juego["transicion_vida_menos"]:
		#context.timerTransicionVidaMenos.start(2.1)
		#context.panelTimeup.visible = false
		#FuncionesGenerales.reset_estados_cambio_estado_a("transicion_next_vida")
		#context.bandera_underground = true
		#FuncionesMovSaltoMario.reset_position(context, true)
		#context.panelShowVidas.visible = true if not GlobalValues.estado_juego["game_over"] else false
		#return

#func transicion_next_vida(delta, context):
	#if not GlobalValues.estado_juego["transicion_next_vida"]:
		#return
	#
	#FuncionesGenerales.aplicar_gravedad(delta, context)
	#context.move_and_slide()
	#AnimacionesMario.update_animation(context)
	#
	#if context.timerTransicionVidaMenos.time_left == 0.0:
		#FuncionesGenerales.reset_estados_cambio_estado_a("en_juego")
		#context.panelShowVidas.visible = false
		#context.musica.play()

func transicion_preparado():
	if not GlobalValues.estado_juego["transicion_preparado"]:
		return

func en_juego(delta, context):
	if not GlobalValues.estado_juego["en_juego"]:
		return
	
	FuncionesMovPacman.movimiento_pacman(delta, context)
	context.move_and_slide()
	AnimacionesPacman.update_animation(context)
	#FuncionesTilesPacman.identificar_tile(context.global_position, context.salto, context.timer, context.sonido_coin)
	#FuncionesGenerales.efecto_intermitente_invulnerable(delta, context)
	#print(str(Engine.get_frames_per_second()))

#func otros_estados(delta, context):
	#for estado in context.lista_estados_transiciones:
		#if GlobalValues.estado_juego[estado]:
			#return
	#
	#FuncionesGenerales.aplicar_gravedad(delta, context)
	#context.move_and_slide()

# ================================================================
# 	FUNCIONES AUXILIARES PACMAN
#-----------------------------------------------------------------
# SCORES:
func agregar_puntos(cantidad, global_position):
	GlobalValues.marcadores["score"] += cantidad
	emit_signal("marcador_actualizado")
	#var showBonus = show_bonus_scene.instantiate()
	#showBonus.global_position = global_position
	#showBonus.frame_ssheet = showBonus.choose_bonus[str(cantidad)]
	#add_child(showBonus)

# SOLO SUMAR PUNTOS (BONUS-FINAL-NIVEL):
func agregar_puntos_sin_texto(cantidad):
	GlobalValues.marcadores["score"] += cantidad
	
	if cantidad < 0:
		GlobalValues.marcadores["score"] = 0
	
	emit_signal("marcador_actualizado")

# ACTUALIZAR SCENE:
func actualizar_scene(scene):
	GlobalValues.marcadores["scene"] += scene
	emit_signal("scene_actualizada")
