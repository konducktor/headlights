extends Node2D


@export var animated_sprite: AnimatedSprite2D
@export var animated_player: AnimationPlayer


func _on_enemy_state_listening_entered() -> void:
	
	animated_sprite.play("idle")


func _on_enemy_state_chasing_entered() -> void:
	animated_sprite.play("chase")


func _on_enemy_state_grab_entered() -> void:
	animated_sprite.play("catch")


func _on_health_component_died() -> void:
	animated_player.play("dissolve")
