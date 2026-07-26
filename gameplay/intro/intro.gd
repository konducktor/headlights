extends Node


@export var on_finish_scene_path: String

var _animation_player: AnimationPlayer


func _ready() -> void:
	_animation_player = $AnimationPlayer
	_animation_player.play("intro")


func end() -> void:
	SceneTransition.load_scene(on_finish_scene_path)
