extends Node2D

@onready var timer = $TimerFantasmasAzules

func _ready():
	GlobalValues.fantasmas_azules = true
	timer.start(3.5)

func _on_timer_fantasmas_azules_timeout():
	GlobalValues.fantasmas_azules = false
