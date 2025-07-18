extends Node2D

@onready var timer = $Timer

func _ready():
	timer.start(2.9)

func _on_timer_timeout():
	queue_free()
