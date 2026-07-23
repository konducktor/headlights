extends Control

func _on_play_button_pressed() -> void:
	SceneTransition.load_scene("res://menu/placeholder.tscn")


func _on_settings_button_pressed() -> void:
	SceneTransition.load_scene("res://menu/settings/settings.tscn")
