extends Node

# GESTIONAR-ANIMACIONES-PACMAN:
func update_animation(context):
	if GlobalValues.estado_juego["transicion_vida_menos"]:
		context.animatedSprite.play("PacmanDies")
		return
	
	if GlobalValues.estado_juego["transicion_preparado"] or GlobalValues.estado_juego["transicion_next_vida"]:
		context.animatedSprite.play("Idle")
		return
	
	if GlobalValues.estado_juego["en_juego"]:
		context.animatedSprite.play("Derecha")
		return
	
	context.animatedSprite.play("Derecha")
