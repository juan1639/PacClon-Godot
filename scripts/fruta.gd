extends CharacterBody2D

# SE OBTIENE EN get_respawn_position():
const RESPAWN_POSITION = Vector2(9, 11)

# FUNCION INICIALIZADORA:
func _ready():
	get_respawn_position()

# FUNCION UPDATE:
func _physics_process(delta):
	pass

func get_respawn_position():
	var SIZE = GlobalValues.TILE_SIZE
	var x = RESPAWN_POSITION.x * SIZE[0] + int(SIZE[0] / 2)
	var y = RESPAWN_POSITION.y * SIZE[1] + int(SIZE[1] / 2)
	global_position = Vector2(x, y)
