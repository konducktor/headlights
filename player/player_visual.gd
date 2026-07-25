extends Node2D

@export var animated_sprite: AnimatedSprite2D

func _on_player_started_walking() -> void:
	animated_sprite.play("walking")


func _on_player_stopped_walking() -> void:
	animated_sprite.play("idle")
