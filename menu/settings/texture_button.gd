extends TextureButton



func _on_pressed() -> void:
	SceneTransition.load_scene("res://menu/main_menu.tscn")
