extends Area2D

func _ready():
	pass

func _on_body_entered(body):
	FuncionesAuxiliaresPacman.agregar_puntos_sin_texto(10)
	GlobalValues.pacmanRG.sonido_waka.play()
	queue_free()
