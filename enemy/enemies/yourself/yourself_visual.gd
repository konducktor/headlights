extends Node2D


@export var animated_sprite: AnimatedSprite2D
@export var animation_player: AnimationPlayer


func _on_health_component_died() -> void:
	animation_player.play("enemy/dissolve")


func _on_enemy_state_chasing_entered() -> void:
	animated_sprite.play("walking")


func _on_enemy_state_run_entered() -> void:
	animated_sprite.play("walking")


func _on_knife_attack_fired() -> void:
	animated_sprite.play("idle_attack")



func _on_paper_attack_fired() -> void:
	animated_sprite.play("idle_throw")


func _on_yourself_activated() -> void:
	animation_player.play("enemy/appear")


func _on_knife_wait_entered() -> void:
	animated_sprite.play("idle")
