extends Area2D

@onready var timer = $Timer
@onready var sonido_waka = $SonidoWaka

func _ready():
	pass

func _on_body_entered(body):
	sonido_waka.play()
	timer.start(0.7)

func _on_timer_timeout():
	queue_free()
