extends Node2D

func _on_escapatoria_iz_body_entered(body):
	if not GlobalValues.estado_juego["en_juego"]:
		return
	
	print(body)
	var size = GlobalValues.TILE_SIZE[0]
	body.global_position.x = 19 * size + int(size / 2)
	
func _on_escapatoria_de_body_entered(body):
	if not GlobalValues.estado_juego["en_juego"]:
		return
	
	print(body)
	var size = GlobalValues.TILE_SIZE[0]
	body.global_position.x = 0
