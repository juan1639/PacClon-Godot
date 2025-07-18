extends Node2D

@onready var sonido_escapatoria = $SonidoEscapatoria

func _on_escapatoria_iz_body_entered(body):
	if not GlobalValues.estado_juego["en_juego"]:
		return
	
	print(body)
	var size = GlobalValues.TILE_SIZE[0]
	body.global_position.x = 19 * size + int(size / 2)
	sonido_escapatoria.play()
	
func _on_escapatoria_de_body_entered(body):
	if not GlobalValues.estado_juego["en_juego"]:
		return
	
	print(body)
	var size = GlobalValues.TILE_SIZE[0]
	body.global_position.x = 0
	sonido_escapatoria.play()
