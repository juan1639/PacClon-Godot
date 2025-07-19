extends Node2D

var duracion_azules: float

@onready var timer = $TimerFantasmasAzules
@onready var sonido_durante_azules = $SonidoDuranteAzules

func _ready():
	GlobalValues.fantasmas_azules = true
	duracion_azules = FuncionesGenerales.get_duracion_fantasmas_azules()
	print(duracion_azules)
	timer.start(duracion_azules)
	sonido_durante_azules.play()

func _on_timer_fantasmas_azules_timeout():
	GlobalValues.fantasmas_azules = false
	GlobalValues.contador_bonus_come_fantasmas = 100
	GlobalValues.pacmanRG.SPEED /= 2
	
	for fantasma in GlobalValues.fantasmas_instancias:
		fantasma.comido = false
	
	queue_free()
