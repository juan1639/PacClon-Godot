extends Node

# DICCIONARIO DIRECCIONES: [x, y, flip_h, rotate]
var dic_direcciones = {
	"null": [0, 0, false, 0],
	"up": [0, -1, false, -90.0],
	"do": [0, 1, false, 90.0],
	"iz": [-1, 0, true, 0.0],
	"de": [1, 0, false, 0.0]
}

var intento_cambio_direccion = "de"
var confirmado_cambio_direccion = "de"
var avanzar = true

# MOVIMIENTO PACMAN (# 1= IZ | 2= DE | 3= UP | 4= DO):
func cambio_direccion():
	var axis_ver = Input.get_axis("ui_up", "ui_down")
	var axis_hor = Input.get_axis("ui_left", "ui_right")
	
	if axis_ver != 0.0:
		#print(axis_hor, axis_ver)
		
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

func movimiento_pacman(context):
	cambio_direccion()
	
	const SIZE = GlobalValues.TILE_SIZE
	var tileActual = FuncionesGenerales.get_coords_divide_64_topleft(context.global_position)
	
	if int(context.global_position.x - int(SIZE[0] / 2)) % SIZE[0] == 0 and int(context.global_position.y - int(SIZE[1] / 2)) % SIZE[1] == 0:
		var colision_intento = check_colision_laberinto_tiles(intento_cambio_direccion, tileActual)
		var colision_confirmado = check_colision_laberinto_tiles(confirmado_cambio_direccion, tileActual)
		
		if not colision_intento:
			avanzar = true
			confirmado_cambio_direccion = intento_cambio_direccion
		elif not colision_confirmado:
			avanzar = true
		else:
			avanzar = false
	
	var confirmado = dic_direcciones[confirmado_cambio_direccion]
	
	if avanzar:
		context.global_position += Vector2(confirmado[0] * context.SPEED, confirmado[1] * context.SPEED)
	
	#context.velocity = Vector2(direccion[0] * context.SPEED, direccion[1] * context.SPEED)
	context.animatedSprite.flip_h = confirmado[2]
	context.animatedSprite.rotation = deg_to_rad(confirmado[3])

func check_colision_laberinto_tiles(intento_confirmado, tileActual):
	var vel_x = dic_direcciones[intento_confirmado][0]
	var vel_y = dic_direcciones[intento_confirmado][1]
	
	if tileActual.y + vel_y < 0 or tileActual.y + vel_y >= GlobalValues.FILAS:
		return false
	
	if tileActual.x + vel_x < 0 or tileActual.x + vel_x >= GlobalValues.COLUMNAS:
		return false
	
	return GlobalValues.laberinto[tileActual.y + vel_y][tileActual.x + vel_x] == GlobalValues.TILE_SOLIDO

# RESETEAR DIRECCION TRAS PERDER VIDA:
func reset_direccion_tras_vida_menos():
	intento_cambio_direccion = "de"
