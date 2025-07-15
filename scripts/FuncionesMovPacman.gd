extends Node

var intento_cambio_direccion = "null"

var dic_direcciones = {
	"null": [0, 0],
	"up": [0, -1],
	"do": [0, 1],
	"iz": [-1, 0],
	"de": [1, 0]
}

# MOVIMIENTO PACMAN (# 1= IZ | 2= DE | 3= UP | 4= DO):
func cambio_direccion():
	var axis_ver = Input.get_axis("ui_up", "ui_down")
	var axis_hor = Input.get_axis("ui_left", "ui_right")
	
	if axis_ver != 0.0:
		print(axis_hor, axis_ver)
		
		if axis_ver < 0.0:
			intento_cambio_direccion = "up"
			return
		else:
			intento_cambio_direccion = "do"
			return
	
	if axis_hor != 0.0:
		print(axis_hor, axis_ver)
		
		if axis_hor < 0.0:
			intento_cambio_direccion = "iz"
			return
		else:
			intento_cambio_direccion = "de"
			return

func movimiento_pacman(delta, context):
	cambio_direccion()
	print(intento_cambio_direccion)
	#print(str(Engine.get_frames_per_second()))
	
	var direccion = dic_direcciones[intento_cambio_direccion]
	
	context.velocity = Vector2(direccion[0] * context.SPEED, direccion[1] * context.SPEED)
	
	#if input_direccion != 0:
		#context.velocity.x = move_toward(context.velocity.x, input_direccion * context.VEL_MAX, context.ACELERACION * delta)
		#context.sprite.flip_h = input_direccion < 0
	#else:
		#context.velocity.x = move_toward(context.velocity.x, 0, context.DECELERACION * delta)
