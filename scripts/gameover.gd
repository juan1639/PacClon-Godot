extends CanvasLayer

func _on_button_pressed():
	GlobalValues.marcadores["scene"] = 1
	GlobalValues.fantasmas_instancias = []
	get_tree().change_scene_to_file("res://scenes/menu_principal.tscn")
