extends CanvasLayer

func _on_button_pressed():
	get_tree().change_scene_to_file("res://scenes/menu_principal.tscn")

func _on_option_button_item_selected(index: int):
	print(index)
	GlobalValues.SPEED_ELEGIDA = index
