extends CharacterBody2D

@onready var particulas_scene = preload("res://scenes/particulas.tscn")
@onready var timer_fantasmas_azules_scene = preload("res://scenes/timer_fantasmas_azules.tscn")

var particulasPacman: Node2D

func _on_area_2d_body_entered(body):
	if GlobalValues.fantasmas_azules or not GlobalValues.estado_juego["en_juego"]:
		return
	
	print(body)
	print(global_position)
	GlobalValues.timer_fantasmas_azules = timer_fantasmas_azules_scene.instantiate()
	call_deferred("instanciar_timer_fantasmas_azules")
	GlobalValues.pacmanRG.sonido_eating_ghost.play()
	GlobalValues.pacmanRG.global_position = global_position
	GlobalValues.pacmanRG.SPEED *= 2
	particulasPacman = particulas_scene.instantiate()
	GlobalValues.pacmanRG.add_child(particulasPacman)
	queue_free()

func instanciar_timer_fantasmas_azules():
	GlobalValues.game_manager_node.add_child(GlobalValues.timer_fantasmas_azules)
