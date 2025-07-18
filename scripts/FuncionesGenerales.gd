extends Node

signal gameover_instance
signal next_level_instance

# VARIABLES:
var tiempo_actual = 0.0

# CHECK-COLISIONS (LABERINTO-TILE):
func check_colision_laberinto_tiles(intento_confirmado, tileActual):
	var vel_x = GlobalValues.dic_direcciones[intento_confirmado][0]
	var vel_y = GlobalValues.dic_direcciones[intento_confirmado][1]
	
	if tileActual.y + vel_y < 0 or tileActual.y + vel_y >= GlobalValues.FILAS:
		return false
	
	if tileActual.x + vel_x < 0 or tileActual.x + vel_x >= GlobalValues.COLUMNAS:
		return false
	
	return GlobalValues.laberinto[tileActual.y + vel_y][tileActual.x + vel_x] == GlobalValues.TILE_SOLIDO

# EFECTO INTERMITENTE:
func efecto_intermitente_azules(delta, context):
	if context.comido:
		context.modulate = Color(1, 1, 1, 1)
		return
	
	if GlobalValues.fantasmas_azules:
		tiempo_actual += delta

		# Cambia el color cada frame o según el tiempo
		var intensidad = sin(tiempo_actual * 20.0) * 0.5 + 0.5
		context.modulate = Color(intensidad, intensidad, 1)
	else:
		tiempo_actual = 0.0
		context.modulate = Color(1, 1, 1, 1)

# OBTENER LOS PUNTOS INTERSECCIONES:
func get_puntos_intersecciones():
	var lista = []
	
	for punto in GlobalValues.lista_puntos_intersecciones:
		#print(punto)
		punto[0] -= 25
		punto[0] /= 50
		punto[1] -= 25
		punto[1] /= 50
		lista.append([int(punto[0]), int(punto[1])])
	
	return lista

# OBTENER UN NUMERO ALEATORIO:
func get_rnd_int_number(min, max):
	var rng = RandomNumberGenerator.new()
	rng.randomize() # Inicializa la semilla con el tiempo actual
	return rng.randi_range(min, max)

# OBTENER UNA (POR EJEMPLO: POS (64, 64) A PARTIR DE UNA POS (1, 1):
func get_coords_multiply_64(vector):
	var size = GlobalValues.TILE_SIZE
	return vector * Vector2i(size[0], size[1]) + Vector2i(int(size[0] / 2), int(size[1] / 2))

# OBTENER UNA (POR EJEMPLO: POS (1, 1) A PARTIR DE UNA POS (64, 64):
func get_coords_divide_64(vector):
	var size = GlobalValues.TILE_SIZE
	var newVector = Vector2i(vector.x, vector.y)
	return newVector / Vector2i(size[0], size[1])

func get_coords_divide_64_topleft(vector):
	var size = GlobalValues.TILE_SIZE
	var newVector = Vector2i(vector.x - int(size[0] / 2), vector.y - int(size[1] / 2))
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
