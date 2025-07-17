extends CharacterBody2D

# SE OBTIENE EN get_respawn_position():
const RESPAWN_POSITION = Vector2(9, 11)

const SPEED = 2
var direccion = "de"

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
		#var colision_confirmado = false
		
		if not colision_confirmado:
			confirmado = GlobalValues.dic_direcciones[direccion]
		else:
			elegir_otra_direccion()
			return
	
	global_position += Vector2(confirmado[0] * SPEED, confirmado[1] * SPEED)

func elegir_otra_direccion():
	pass
