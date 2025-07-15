extends Node

signal gameover_instance
signal next_level_instance

# VARIABLES:
var tiempo_actual = 0.0

# EFECTO INTERMITENTE (INVULNERABLE - ESTRELLA):
#func efecto_intermitente_invulnerable(delta, context):
	#if context.invulnerability:
		#tiempo_actual += delta
#
		## Cambia el color cada frame o según el tiempo
		#var intensidad = sin(tiempo_actual * 20.0) * 0.5 + 0.5
		#context.modulate = Color(1, intensidad, intensidad)
	#else:
		#tiempo_actual = 0.0

# OBTENER UNA (POR EJEMPLO: POS (64, 64) A PARTIR DE UNA POS (1, 1):
func get_coords_multiply_64(vector):
	var size = GlobalValues.TILE_SIZE
	return vector * Vector2i(size[0], size[1]) + Vector2i(int(size[0] / 2), int(size[1] / 2))

# OBTENER UNA (POR EJEMPLO: POS (1, 1) A PARTIR DE UNA POS (64, 64):
func get_coords_divide_64(vector):
	var size = GlobalValues.TILE_SIZE
	var newVector = Vector2i(vector.x, vector.y)
	return newVector / Vector2i(size[0], size[1])

# RESETEAR-ESTADOS Y CAMBIAR UN ESTADO:
func reset_estados_cambio_estado_a(estado):
	for keyName in GlobalValues.estado_juego.keys():
		GlobalValues.estado_juego[keyName] = false
	
	GlobalValues.estado_juego[estado] = true

# RESETEAR MARCADORES:
func reset_scores():
	GlobalValues.marcadores["score"] = 0
	GlobalValues.marcadores["lives"] = 3
	GlobalValues.marcadores["scene"] = 1

# EMITIR SEÑAL GAMEOVER:
func emitir_signal_gameover():
	emit_signal("gameover_instance")

# EMITIR SEÑAL NEXT-LEVEL:
func emitir_signal_next_level():
	emit_signal("next_level_instance")
