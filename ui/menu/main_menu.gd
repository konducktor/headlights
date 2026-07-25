extends Control

@export var gameplay_scene_path: String = "res://menu/placeholder.tscn"
@export var settings_scene_path: String = "res://menu/settings/settings.tscn"


func _on_play_button_pressed() -> void:
	SceneTransition.load_scene(gameplay_scene_path)


func _on_settings_button_pressed() -> void:
	SceneTransition.load_scene(settings_scene_path)
