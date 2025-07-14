extends PanelContainer

func _on_button_pressed():
	get_tree().change_scene_to_file("res://scenes/game_manager.tscn")

func _on_button_3_pressed():
	get_tree().quit()
