extends Node2D


@export var outro_scene: String


func _ready() -> void:
	SceneTransition.load_scene(outro_scene)
