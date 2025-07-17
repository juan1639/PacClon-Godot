extends CharacterBody2D

# SE OBTIENE EN get_respawn_position():
const RESPAWN_POSITION = Vector2(9, 11)

const SPEED = 2
var direccion = "de"

const lista_bonus_frutas = [200, 200, 400, 800, 1600, 2000]

# FUNCION INICIALIZADORA:
func _ready():
	get_respawn_position()

# FUNCION UPDATE:
func _physics_process(delta):
	movimiento()

func get_respawn_position():
	var SIZE = GlobalValues.TILE_SIZE
	var x = RESPAWN_POSITION.x * SIZE[0] + int(SIZE[0] / 2)
	var y = RESPAWN_POSITION.y * SIZE[1] + int(SIZE[1] / 2)
	global_position = Vector2(x, y)

func movimiento():
	const SIZE = GlobalValues.TILE_SIZE
	var tileActual = FuncionesGenerales.get_coords_divide_64_topleft(global_position)

	var confirmado = GlobalValues.dic_direcciones[direccion]
	
	if int(global_position.x - int(SIZE[0] / 2)) % SIZE[0] == 0 and int(global_position.y - int(SIZE[1] / 2)) % SIZE[1] == 0:
		var colision_confirmado = FuncionesGenerales.check_colision_laberinto_tiles(direccion, tileActual)
		
		if not colision_confirmado:
			confirmado = GlobalValues.dic_direcciones[direccion]
		else:
			elegir_otra_direccion(direccion)
			return
	
	global_position += Vector2(confirmado[0] * SPEED, confirmado[1] * SPEED)

func elegir_otra_direccion(copia_direccion):
	var opcionesString = GlobalValues.dic_direcciones[copia_direccion][2]
	var aleatorio = FuncionesGenerales.get_rnd_int_number(0, 2)
	aleatorio *= 2
	var nueva_direccion = opcionesString.substr(aleatorio, 2)
	direccion = nueva_direccion

func _on_area_2d_body_entered(body):
	#print("Bonus: ", body)
	var nivel = GlobalValues.marcadores["scene"]
	var bonus = lista_bonus_frutas[nivel] if nivel < len(lista_bonus_frutas) else 5000
	FuncionesAuxiliaresPacman.agregar_puntos(bonus, body.global_position)
	GlobalValues.pacmanRG.sonido_eating_cherry.play()
	queue_free()
