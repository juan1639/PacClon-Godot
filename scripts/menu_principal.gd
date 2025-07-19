extends PanelContainer

@onready var musica_intro = $MusicaIntro

func _ready():
	musica_intro.play()

func _on_button_pressed():
	get_tree().change_scene_to_file("res://scenes/game_manager.tscn")

func _on_button_3_pressed():
	get_tree().quit()

func _on_button_2_pressed():
	get_tree().change_scene_to_file("res://scenes/menu_opciones.tscn")
