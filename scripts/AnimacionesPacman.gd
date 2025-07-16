extends Node

# GESTIONAR-ANIMACIONES-PACMAN:
func update_animation(context):
	if GlobalValues.estado_juego["transicion_vida_menos"]:
		context.animatedSprite.play("LoseLife")
		return
	
	context.animatedSprite.play("Derecha")
