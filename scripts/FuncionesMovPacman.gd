extends Node

# DICCIONARIO DIRECCIONES: [x, y, flip_h, rotate]
var dic_direcciones = {
	"null": [0, 0, false, 0],
	"up": [0, -1, false, -90.0],
	"do": [0, 1, false, 90.0],
	"iz": [-1, 0, true, 0.0],
	"de": [1, 0, false, 0.0]
}

var intento_cambio_direccion = "null"

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
	
	var direccion = dic_direcciones[intento_cambio_direccion]
	context.velocity = Vector2(direccion[0] * context.SPEED, direccion[1] * context.SPEED)
	context.animatedSprite.flip_h = direccion[2]
	context.animatedSprite.rotation = deg_to_rad(direccion[3])
