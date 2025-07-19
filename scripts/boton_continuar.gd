extends CanvasLayer


func _on_button_pressed():
	GlobalValues.marcadores["scene"] += 1
	get_tree().change_scene_to_file("res://scenes/game_manager.tscn")
