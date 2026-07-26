extends Node2D


@export var animation_player: AnimationPlayer


func _on_health_component_died() -> void:
	animation_player.play("enemy/dissolve")
