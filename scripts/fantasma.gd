extends CharacterBody2D

# SE OBTIENE EN get_respawn_position():
const RESPAWN_POSITION = Vector2(9, 11)

var SPEED = GlobalValues.SPEED_LIST[GlobalValues.SPEED_ELEGIDA]
var direccion = "de"
var idAnimacion: String
var ini_x: int
var ini_y: int

var comido = false

# REFERENCIAS:
@onready var animatedSprite = $AnimatedSprite2D

# FUNCION INICIALIZADORA:
func _ready():
	#print(lista_puntos_intersecciones)
	get_respawn_position()
	update_animation()
	
# FUNCION UPDATE:
func _physics_process(delta):
	if GlobalValues.mini_pausa:
		return
	
	if GlobalValues.estado_juego["en_juego"]:
		movimiento()
		FuncionesGenerales.efecto_intermitente_azules(delta, self)
		update_animation()
	elif GlobalValues.estado_juego["transicion_next_vida"]:
		get_respawn_position()

# GET RESPAWN POSITION:
func get_respawn_position():
	var SIZE = GlobalValues.TILE_SIZE
	var x = ini_x * SIZE[0] + int(SIZE[0] / 2)
	var y = ini_y * SIZE[1] + int(SIZE[1] / 2)
	global_position = Vector2(x, y)
	SPEED = GlobalValues.SPEED_LIST[GlobalValues.SPEED_ELEGIDA]

# MOVIMIENTO FANTASMA:
func movimiento():
	const SIZE = GlobalValues.TILE_SIZE
	var tileActual = FuncionesGenerales.get_coords_divide_64_topleft(global_position)
	var tileActual2 = [tileActual.x, tileActual.y]
	
	var confirmado = GlobalValues.dic_direcciones[direccion]
	
	if int(global_position.x - int(SIZE[0] / 2)) % SIZE[0] == 0 and int(global_position.y - int(SIZE[1] / 2)) % SIZE[1] == 0:
		var colision_confirmado = FuncionesGenerales.check_colision_laberinto_tiles(direccion, tileActual)
		
		if tileActual2 in GlobalValues.puntos_intersecciones:
			seguir_a_pacman()
			colision_confirmado = FuncionesGenerales.check_colision_laberinto_tiles(direccion, tileActual)
		
		if not colision_confirmado:
			confirmado = GlobalValues.dic_direcciones[direccion]
		else:
			elegir_otra_direccion(direccion)
			return
	
	global_position += Vector2(confirmado[0] * SPEED, confirmado[1] * SPEED)

# CAMBIAR DE DIRECCION AL COLISIONAR:
func elegir_otra_direccion(copia_direccion):
	var opcionesString = GlobalValues.dic_direcciones[copia_direccion][2]
	var aleatorio = FuncionesGenerales.get_rnd_int_number(0, 2)
	aleatorio *= 2
	var nueva_direccion = opcionesString.substr(aleatorio, 2)
	direccion = nueva_direccion

# SEGUIR A PACMAN:
func seguir_a_pacman():
	if FuncionesGenerales.get_rnd_int_number(0, 100) > GlobalValues.porcentaje_seguir_a_pacman:
		return
	
	if FuncionesGenerales.get_rnd_int_number(0, 10) < 5:  # Decisión horizontal/vertical
		direccion = "up" if GlobalValues.pacmanRG.global_position.y < global_position.y else "do"
		print("Seguir: ", name)
	else:
		direccion = "iz" if GlobalValues.pacmanRG.global_position.x < global_position.x else "de"
		print("Seguir: ", name)

# ANIMACIONES:
func update_animation():
	if comido:
		update_animation_ojos()
		return
	
	var animacion = GlobalValues.dic_direcciones[direccion][3]
	animacion += idAnimacion
	animatedSprite.play(animacion)

func update_animation_ojos():
	var animacion = GlobalValues.dic_direcciones[direccion][4]
	animatedSprite.play(animacion)

# COLISION VS FANTASMA:
func _on_area_2d_body_entered(body):
	if not GlobalValues.estado_juego["en_juego"]:
		return
	
	if not GlobalValues.fantasmas_azules:
		print("Colision-fantasma")
		FuncionesGenerales.reset_estados_cambio_estado_a("transicion_vida_menos")
		body.timerTransicionVidaMenos.start(2.1)
		body.global_scale = Vector2(4, 4)
		body.sonido_lose_life.play()
	else:
		if not comido:
			print("come-fantasma")
			comido = true
			GlobalValues.contador_bonus_come_fantasmas *= 2
			FuncionesAuxiliaresPacman.agregar_puntos(GlobalValues.contador_bonus_come_fantasmas, global_position)
			body.sonido_eating_ghost.play()
			call_deferred("comenzar_mini_pausa")

func comenzar_mini_pausa():
	GlobalValues.mini_pausa = true
	GlobalValues.game_manager_node.timerMiniPausa.start(0.6)
