extends CharacterBody2D

# SPEED:
const SPEED = 150

# INVULNERABLE:
var invulnerability = false

# RESPAWN-POSITION:
#const RESPAWN_POSITION = Vector2(608, 544)
const RESPAWN_POSITION = GlobalValues.PACMAN_INIT_POSITION

# REFERENCIAS:
@onready var animatedSprite = $AnimatedSprite2D
@onready var camera = $Camera2D
#@onready var cpuParticles = $CPUParticles2D
#@onready var cpuParticlesFireworks = preload("res://scenes/fireworks.tscn")
@onready var timerPreparado = $TimerPreparado
#@onready var timerColision = $TimerColision
#@onready var timerTransicionVidaMenos = $TimerTransicionVidaMenos
#@onready var timerAzules = $TimerAzules
@onready var sonido_waka = $SonidoWaka
@onready var sonido_lose_life = $SonidoLoseLife
@onready var sonido_level_up = $SonidoLevelUp
@onready var sonido_eating_ghost = $SonidoEatingGhost
@onready var sonido_mientras_azules = $SonidoMientrasAzules
@onready var sonido_eating_cherry = $SonidoEatingCherry
@onready var musica_intermision = $MusicaIntermision
@onready var musica_preparado = $MusicaPreparado

# REFERENCIAS OTRAS ESCENAS:
@onready var nodoPadre = get_parent()
var texto_preparado: CanvasLayer
var txt_preparado_scene = preload("res://scenes/texto_preparado.tscn")

var fireworks: Node2D = null

# FUNCION INICIALIZADORA:
func _ready():
	print("Instancia Pacman")
	global_position = FuncionesGenerales.get_coords_multiply_64(RESPAWN_POSITION)
	get_child(0).frame = 4
	
	FuncionesGenerales.reset_estados_cambio_estado_a("transicion_preparado")
	texto_preparado = txt_preparado_scene.instantiate()
	call_deferred("instanciar_preparado")
	timerPreparado.start(4.2)
	
	musica_preparado.play()

# FUNCION EJECUTANDOSE A 60 FPS:
func _physics_process(delta):
	FuncionesAuxiliaresPacman.transicion_preparado()
	#FuncionesAuxiliaresPacman.transicion_vida_menos(delta, self)
	#FuncionesAuxiliaresPacman.transicion_next_vida(delta, self)
	#FuncionesAuxiliaresPacman.transicion_level_up(delta, self)
	FuncionesAuxiliaresPacman.en_juego(self)
	#FuncionesAuxiliaresPacman.otros_estados(delta, self)

# ----------------------------------------------------------------
#	S E Ñ A L E S
# ----------------------------------------------------------------
func _on_timer_preparado_timeout():
	FuncionesGenerales.reset_estados_cambio_estado_a("en_juego")
	texto_preparado.queue_free()

# MARIO FALL-ZONES:
#func _on_fall_zone_body_entered(body):
	#if body == self and GlobalValues.estado_juego["en_juego"]:
		#actions_lose_life()

# COLISION VS ESTRELLA (INVULNERAB):
#func _on_estrella_body_entered(body):
	#if body == self:
		#print("Invulnerable!")
		#invulnerability = true
		#timerEstrella.start(GlobalValues.DURACION_ESTRELLA)
		#musica.stop()
		#musica_estrella.play()
		## LA DESPLAZAMOS MUY ABAJO PARA QUE SE DETECTE BOTTOM-LIMIT Y DESACTIVARLA:
		#GlobalValues.estrellaSprite.global_position += Vector2(0, 9990)

# COLISION VS GOOMBA (LOSE LIFE):
#func _on_goomba_body_entered(body, goomba):
	#if timerColision.time_left > 0:
		#return
	#
	#if body == self and GlobalValues.estado_juego["en_juego"] and not goomba.aplastado:
		#if invulnerability and not goomba.is_dying_not_aplastado:
			#goomba.is_dying_not_aplastado = true
			#goomba.timerGoombaAplastado.start(0.4)
			#goomba.velocity.y = -200
			#FuncionesTilesMario.agregar_puntos(200, global_position)
			#sonido_impacto.play()
			#return
		#elif not invulnerability:
			#velocity = Vector2(0, POTENCIA_SALTO * 2)
			#actions_lose_life()

# COLISION VS GOOMBA (APLASTAR-GOOMBA):
#func _on_aplastar_goomba_body_entered(body, goomba):
	#if invulnerability:
		#return
	#
	#if body == self and GlobalValues.estado_juego["en_juego"] and not goomba.aplastado:
		#timerColision.start(0.1)
		#goomba.aplastado = true
		#goomba.velocity.x = 0
		#goomba.timerGoombaAplastado.start(0.8)
		#velocity = Vector2(velocity.x, POTENCIA_SALTO * 2.8)
		#FuncionesTilesMario.agregar_puntos(100, global_position)
		#sonido_aplastar.play()

# CHECK TIMEOUT ESTRELLA (y FIREWORKS):
#func _on_timer_timeout_estrella():
	#if GlobalValues.estado_juego["fireworks"]:
		#fireworks = cpuParticlesFireworks.instantiate()
		#add_child(fireworks)
		#fireworks.get_child(0).emitting = true
		#fireworks.get_child(1).emitting = true
		#var rnd_position = Vector2(randf_range(3120 , 3350), randf_range(75, 150))
		#fireworks.get_child(0).global_position = rnd_position
		#fireworks.get_child(1).global_position = rnd_position
		#fireworks.get_child(0).z_index = -1
		#fireworks.get_child(1).z_index = -1
		#fireworks.get_child(1).modulate = Color(1, 1, 1, 0.6)
		#timerEstrella.start(2.1)
	#else:
		#print("Timeup invulnerabilidad")
		#invulnerability = false
		#modulate = Color(1, 1, 1, 1)
		#musica_estrella.stop()
		#musica.play()

## ACCIONES AL PERDER VIDA:
#func actions_lose_life():
	#FuncionesGenerales.reset_estados_cambio_estado_a("transicion_vida_menos")
	#GlobalValues.marcadores["lives"] -= 1
	#invulnerability = false
	#GlobalValues.marcadores["time"] = GlobalValues.TIEMPO_INICIAL
	#
	#var newText = "x " + str(GlobalValues.marcadores["lives"])
	#panelShowVidas.get_child(0).get_child(0).get_child(1).text = newText
	##panelShowVidasMiddle.get_child(0).get_child(0).get_child(1).text = newText
	#
	#timerTransicionVidaMenos.start(3.1)
	#
	#musica.stop()
	#
	#if GlobalValues.marcadores["lives"] <= 0:
		#musica_gameover.play()
	#else:
		#sonido_lose_life.play()

# INSTANCIAR PREPARADO:
func instanciar_preparado():
	nodoPadre.add_child(texto_preparado)

# VELOCITY ZERO:
func velocity_zero():
	velocity = Vector2(0, 0)

# Pulsar ESC (salir):
func _input(event):
	if event is InputEventKey and event.pressed and event.keycode == KEY_ESCAPE:
		get_tree().quit()
	
	if event is InputEventKey and event.pressed and event.keycode == KEY_1:
		print(global_position)
