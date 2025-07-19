extends Node

signal marcador_actualizado
signal scene_actualizada
signal vidas_actualizadas

var show_bonus_scene = preload("res://scenes/sprite_show_bonus.tscn")
var boton_continuar_scene = preload("res://scenes/boton_continuar.tscn")

# =================================================================
# 	T R A N S I C I O N E S
# -----------------------------------------------------------------
func transicion_vida_menos(context):
	if not GlobalValues.estado_juego["transicion_vida_menos"]:
		return
	
	if context.timerTransicionVidaMenos.time_left == 0.0:
		context.timerTransicionVidaMenos.start(3.1)
		FuncionesGenerales.reset_estados_cambio_estado_a("transicion_next_vida")
		FuncionesAuxiliaresPacman.actualizar_vidas(-1)
		context.get_respawn_position()
		AnimacionesPacman.update_animation(context)
		return
	
	AnimacionesPacman.update_animation(context)

func transicion_next_vida(context):
	if not GlobalValues.estado_juego["transicion_next_vida"]:
		return
	
	if GlobalValues.marcadores["lives"] < 0:
		print("señal gameover")
		FuncionesAuxiliaresPacman.actualizar_vidas(1)
		FuncionesGenerales.reset_estados_cambio_estado_a("game_over")
		context.visible = false
		#context.get_respawn_position()
		FuncionesGenerales.emitir_signal_gameover()
		return
	
	if context.timerTransicionVidaMenos.time_left == 0.0:
		FuncionesGenerales.reset_estados_cambio_estado_a("en_juego")

func transicion_level_up(context):
	if not GlobalValues.estado_juego["transicion_level_up"]:
		return
	
	print("Level up")

func transicion_preparado():
	if not GlobalValues.estado_juego["transicion_preparado"]:
		return

func en_juego(context):
	if not GlobalValues.estado_juego["en_juego"] or GlobalValues.mini_pausa:
		return
	
	FuncionesMovPacman.movimiento_pacman(context)
	AnimacionesPacman.update_animation(context)
	check_puntitos_to_level_up(context)

#func otros_estados(context):
	#for estado in context.lista_estados_transiciones:
		#if GlobalValues.estado_juego[estado]:
			#return
	#
	#AnimacionesPacman.update_animation(context)

# ================================================================
# 	FUNCIONES AUXILIARES PACMAN
#-----------------------------------------------------------------
# CHECKEAR SI HEMOS COMIDO TODOS LOS PUNTITOS:
func check_puntitos_to_level_up(context):
	if GlobalValues.puntitos["contador"] >= GlobalValues.puntitos["totales"]:
		FuncionesGenerales.reset_estados_cambio_estado_a("transicion_level_up")
		context.sonido_level_up.play()
		var botonContinuar = boton_continuar_scene.instantiate()
		GlobalValues.game_manager_node.add_child(botonContinuar)

# SCORES:
func agregar_puntos(cantidad, global_position):
	GlobalValues.marcadores["score"] += cantidad
	emit_signal("marcador_actualizado")
	var showBonus = show_bonus_scene.instantiate()
	showBonus.global_position = global_position
	showBonus.frame_ssheet = showBonus.choose_bonus[str(cantidad)]
	GlobalValues.game_manager_node.add_child(showBonus)

# SOLO SUMAR PUNTOS (BONUS-FINAL-NIVEL):
func agregar_puntos_sin_texto(cantidad):
	GlobalValues.marcadores["score"] += cantidad
	
	if cantidad < 0:
		GlobalValues.marcadores["score"] = 0
	
	emit_signal("marcador_actualizado")

# ACTUALIZAR SCENE:
func actualizar_scene(scene):
	GlobalValues.marcadores["scene"] += scene
	
	if scene < 0:
		GlobalValues.marcadores["scene"] = 1
	
	emit_signal("scene_actualizada")

# ACTUALIZAR VIDAS:
func actualizar_vidas(vidas):
	GlobalValues.marcadores["lives"] += vidas
	
	if vidas < -1:
		GlobalValues.marcadores["lives"] = 2
	
	emit_signal("vidas_actualizadas")
