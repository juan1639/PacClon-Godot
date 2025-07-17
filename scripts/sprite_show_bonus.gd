extends Sprite2D

var choose_bonus = { "200": 0, "400": 1, "800": 2, "1600": 3, "2000": 4 }

var frame_ssheet = 0
var vel_y = 50
const direccion = -1

@onready var timer = $Timer

# FUNCION INIT:
func _ready():
	frame = frame_ssheet
	global_position += Vector2(64, -64)
	timer.start(1.8)

# FUNCION A 60 FPS:
func _process(delta):
	global_position.y += direccion * vel_y * delta
	
	if timer.time_left <= 0.0:
		queue_free()
