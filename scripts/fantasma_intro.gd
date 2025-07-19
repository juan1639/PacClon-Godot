extends AnimatedSprite2D

var SPEED = 3.0

func _ready():
	global_scale = Vector2(1.3, 1.3)
	global_position = Vector2(-300, 150)
	play("Derecha")
	flip_h = false

func _process(delta):
	global_position += Vector2(SPEED, 0)
	
	if global_position.x > 1991.0 and SPEED > 0.0:
		SPEED *= -1
		flip_h = true
	elif global_position.x < -199.0 and SPEED < 0.0:
		SPEED *= -1
		flip_h = false
