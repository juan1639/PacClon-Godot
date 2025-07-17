extends CharacterBody2D

# SE OBTIENE EN get_respawn_position():
const RESPAWN_POSITION = Vector2(9, 11)

const SPEED = 2
var direccion = "de"

const lista_bonus_frutas = [200, 200, 400, 800, 1600, 2000]
var lista_puntos_intersecciones = []

# FUNCION INICIALIZADORA:
func _ready():
	lista_puntos_intersecciones = get_puntos_intersecciones()
	print(lista_puntos_intersecciones)
	get_respawn_position()

# FUNCION UPDATE:
func _physics_process(delta):
	movimiento()

# GET RESPAWN POSITION:
func get_respawn_position():
	var SIZE = GlobalValues.TILE_SIZE
	var x = RESPAWN_POSITION.x * SIZE[0] + int(SIZE[0] / 2)
	var y = RESPAWN_POSITION.y * SIZE[1] + int(SIZE[1] / 2)
	global_position = Vector2(x, y)

# MOVIMIENTO FRUTA:
func movimiento():
	const SIZE = GlobalValues.TILE_SIZE
	var tileActual = FuncionesGenerales.get_coords_divide_64_topleft(global_position)
	var tileActual2 = [tileActual.x, tileActual.y]
	
	var confirmado = GlobalValues.dic_direcciones[direccion]
	
	if int(global_position.x - int(SIZE[0] / 2)) % SIZE[0] == 0 and int(global_position.y - int(SIZE[1] / 2)) % SIZE[1] == 0:
		var colision_confirmado = FuncionesGenerales.check_colision_laberinto_tiles(direccion, tileActual)
		
		if tileActual2 in lista_puntos_intersecciones:
			if FuncionesGenerales.get_rnd_int_number(0, 100) < 25:
				elegir_otra_direccion(direccion)
				colision_confirmado = FuncionesGenerales.check_colision_laberinto_tiles(direccion, tileActual)
		
		if not colision_confirmado:
			confirmado = GlobalValues.dic_direcciones[direccion]
		else:
			elegir_otra_direccion(direccion)
			return
	
	global_position += Vector2(confirmado[0] * SPEED, confirmado[1] * SPEED)

# CAMBIAR DE DIRECCION AL COLISIONAR:
func elegir_otra_direccion(copia_direccion):
	var opcionesString = GlobalValues.dic_direcciones[copia_direccion][2]
	var aleatorio = FuncionesGenerales.get_rnd_int_number(0, 2)
	aleatorio *= 2
	var nueva_direccion = opcionesString.substr(aleatorio, 2)
	direccion = nueva_direccion

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

# COLISION VS PACMAN:
func _on_area_2d_body_entered(body):
	#print("Bonus: ", body)
	var nivel = GlobalValues.marcadores["scene"]
	var bonus = lista_bonus_frutas[nivel] if nivel < len(lista_bonus_frutas) else 5000
	FuncionesAuxiliaresPacman.agregar_puntos(bonus, body.global_position)
	GlobalValues.pacmanRG.sonido_eating_cherry.play()
	queue_free()
