extends Node2D

# REFERENCIAS A LAS SCENES:
@onready var scene_1 = preload("res://scenes/escena_1.tscn")
#@onready var world1_2_scene = preload("res://scenes/world_1_2.tscn")

@onready var puntitos_scene = preload("res://scenes/puntitos.tscn")
@onready var puntos_gordos_scene = preload("res://scenes/puntos_gordos.tscn")
@onready var fruta_scene = preload("res://scenes/fruta.tscn")

# SCENE-CONTAINER (CURRENT SCENE):
@onready var scene_container = $SceneContainer

# PUNTITOS-CONTAINER:
@onready var puntitos_container = $PuntitosContainer
@onready var puntos_gordos_container = $PuntosGordosContainer

# REFERENCIAS A SPRITES:
#@onready var goomba_scene = preload("res://scenes/goomba.tscn")
#@onready var gameover_scene = preload("res://scenes/gameover.tscn")
#@onready var button_next_level_scene = preload("res://scenes/next_level_button.tscn")

# REFERENCIA A PACMAN(JUGADOR):
@onready var pacman = $Pacman

# REFERENCIAS A LOS TIMERS:
@onready var timerFruta = $TimerFruta

# FUNCION INICIALIZADORA:
func _ready():
	print("Start new game")
	timerFruta.start(12.1)
	
	# INSTANCIAR CURRENT-WORLD:
	var current_scene = scene_1.instantiate()
	scene_container.add_child(current_scene)
	GlobalValues.laberinto = Escenarios.get_laberinto()
	
	#var escapatoriaZone_iz = current_world.get_node("EscapatoriaZoneIz")
	#var escapatoriaZone_de = current_world.get_node("EscapatoriaZoneDe")
	
	# RESETEAR MARCADORES:
	if GlobalValues.marcadores["scene"] == 1:
		FuncionesGenerales.reset_scores()
		FuncionesAuxiliaresPacman.agregar_puntos_sin_texto(-99)
		FuncionesAuxiliaresPacman.actualizar_scene(0)
	else:
		FuncionesAuxiliaresPacman.agregar_puntos_sin_texto(0)
		FuncionesAuxiliaresPacman.actualizar_scene(0)
	
	# RESETEAR LISTA-DESACTIVADOS:
	GlobalValues.lista_desactivados = []
	
	# CONEXION A SEÑALES GAMEOVER y BUTTON-NEXT-LEVEL:
	#FuncionesGenerales.connect("gameover_instance", Callable(self, "_on_gameover_instance"))
	#FuncionesGenerales.connect("next_level_instance", Callable(self, "_on_next_level_instance"))
	
	# REFERENCIA ESTE NODO PRINCIPAL (MAIN):
	GlobalValues.game_manager_node = self

	# REFERENCIAR A MARIO EN GLOBAL-VALUES:
	GlobalValues.pacmanRG = pacman
	
	# REFERENCIA AL TILEMAP:
	GlobalValues.ref_tilemap = current_scene.get_node("TileMapLayer")
	
	# CREAR LOS PUNTITOS EN EL ESCENARIO:
	crear_puntitos()
	crear_puntos_gordos()
	
	# INSTANCIAR GOOMBAS:
	#for spawn_point in goomba_spawns.get_children():
		#print("Instanciando Goomba en ", spawn_point.global_position)
		#var goomba = goomba_scene.instantiate()
		#goomba.global_position = spawn_point.global_position
		#goomba.get_child(2).connect("body_entered", Callable(mario, "_on_goomba_body_entered").bind(goomba))
		#goomba.get_child(3).connect("body_entered", Callable(mario, "_on_aplastar_goomba_body_entered").bind(goomba))
		#add_child(goomba)
		#GlobalValues.goombas_instancias.append(goomba)
	
	# MOSTRAR NUMERO DE CHILDRENS DE ESTA ESCENA (PRINCIPAL):
	print("Nro childrens: ", get_child_count())
	
	for child in get_children():
		print("Children: ", child)
	
	# CONECTAR SEÑAL de fallZone:
	#escapatoriaZone_iz.connect("body_entered", Callable(pacman, "_on_escapatoria_zone_iz_body_entered"))
	#escapatoriaZone_de.connect("body_entered", Callable(pacman, "_on_escapatoria_zone_de_body_entered"))

# FUNCIONES:
# INSTANCIAR PUNTITOS:
func crear_puntitos():
	for filas in range(GlobalValues.FILAS):
		for col in range(GlobalValues.COLUMNAS):
			#print(filas * 64, ": ", col * 64)
			
			var size = GlobalValues.TILE_SIZE
			var posicion_global_iteracion = Vector2(col * size[0] + int(size[0] / 2), filas * size[1] + int(size[0] / 2))
			
			var tile_pos = GlobalValues.ref_tilemap.local_to_map(posicion_global_iteracion)
			var tile_id = GlobalValues.ref_tilemap.get_cell_atlas_coords(tile_pos)
			
			if FuncionesGenerales.get_coords_divide_64(posicion_global_iteracion) not in GlobalValues.lista_excepciones:
				if tile_id == Vector2i(1, 0):
					var puntito = puntitos_scene.instantiate()
					puntito.global_position = posicion_global_iteracion
					puntitos_container.add_child(puntito)

# INSTANCIAR PUNTOS GORDOS:
func crear_puntos_gordos():
	var size = GlobalValues.TILE_SIZE
	
	for coords in GlobalValues.lista_excepciones:
		if coords != GlobalValues.PACMAN_INIT_POSITION:
			var punto_gordo = puntos_gordos_scene.instantiate()
			var x = coords.x * size[0] + int(size[0] / 2)
			var y = coords.y * size[1] + int(size[1] / 2)
			punto_gordo.global_position = Vector2(x, y)
			puntos_gordos_container.add_child(punto_gordo)

# INSTANCIAR FRUTA (SE INVOCA MEDIANTE TIMER-TIEMOUT-FRUTA):
func instanciar_fruta():
	var fruta = fruta_scene.instantiate()
	#fruta.global_position = Vector2(64+32, 256+32)
	add_child(fruta)

# CALL-DEFERRED:
func ejemplo_call_deferred():
	pass
	
	#var goomba = goomba_scene.instantiate()
	#goomba.global_position = Vector2(mario.global_position.x + 124, -20)
	#goomba.reset_tipo_goomba_cambio_a("paracaidas")
	#goomba.get_child(2).connect("body_entered", Callable(mario, "_on_goomba_body_entered").bind(goomba))
	#goomba.get_child(3).connect("body_entered", Callable(mario, "_on_aplastar_goomba_body_entered").bind(goomba))
	#add_child(goomba)

# INSTANCIAR GAME OVER:
func _on_gameover_instance():
	pass
	
	#var gameover = gameover_scene.instantiate()
	#add_child(gameover)

# INSTANCIAR BUTTON-NEXT-LEVVEL:
func _on_next_level_instance():
	pass
	
	#var buttonNextLevel = button_next_level_scene.instantiate()
	#add_child(buttonNextLevel)

func _on_timer_fruta_timeout():
	instanciar_fruta()
