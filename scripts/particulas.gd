extends Node2D

@onready var timer = $Timer

func _ready():
	#print("Parent:", get_parent().name)
	
	if get_parent().name == "Pacman":
		timer.start(FuncionesGenerales.get_duracion_fantasmas_azules())
		global_scale = Vector2(4, 4)
	else:
		timer.start(2.9)

func _on_timer_timeout():
	queue_free()
