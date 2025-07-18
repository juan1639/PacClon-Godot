extends CharacterBody2D

# SPEED:
const SPEED = 4

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
@onready var timerTransicionVidaMenos = $TimerTransicionVidaMenos
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
	get_respawn_position()
	get_child(0).frame = 4
	
	FuncionesGenerales.reset_estados_cambio_estado_a("transicion_preparado")
	texto_preparado = txt_preparado_scene.instantiate()
	call_deferred("instanciar_preparado")
	timerPreparado.start(4.2)
	AnimacionesPacman.update_animation(self)
	
	musica_preparado.play()

# FUNCION UPDATE:
func _physics_process(delta):
	FuncionesAuxiliaresPacman.transicion_preparado()
	FuncionesAuxiliaresPacman.transicion_vida_menos(self)
	FuncionesAuxiliaresPacman.transicion_next_vida(self)
	#FuncionesAuxiliaresPacman.transicion_level_up(delta, self)
	FuncionesAuxiliaresPacman.en_juego(self)
	#FuncionesAuxiliaresPacman.otros_estados(self)

# TIMEOUT PREPARADO:
func _on_timer_preparado_timeout():
	FuncionesGenerales.reset_estados_cambio_estado_a("en_juego")
	texto_preparado.queue_free()

# OBTENER RESPAWN-POSITION:
func get_respawn_position():
	global_position = FuncionesGenerales.get_coords_multiply_64(RESPAWN_POSITION)
	global_scale = Vector2(1, 1)
	animatedSprite.flip_h = false
	animatedSprite.rotation = deg_to_rad(0)
	FuncionesMovPacman.reset_direccion_tras_vida_menos()
	visible = true

# INSTANCIAR PREPARADO:
func instanciar_preparado():
	nodoPadre.add_child(texto_preparado)

# Pulsar ESC (salir):
func _input(event):
	if event is InputEventKey and event.pressed and event.keycode == KEY_ESCAPE:
		get_tree().quit()
	
	if event is InputEventKey and event.pressed and event.keycode == KEY_1:
		print("Instancias-fantasmas: " + str(len(GlobalValues.fantasmas_instancias)))
