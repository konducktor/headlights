extends Node2D


@export var animated_sprite: AnimatedSprite2D
@export var animation_player: AnimationPlayer

@export var health_component: HealthComponent


func _on_health_component_died() -> void:
	animation_player.play("enemy/dissolve")


func _on_enemy_state_listening_entered() -> void:
	animated_sprite.play("idle")


func _on_enemy_state_run_entered() -> void:
	animated_sprite.play("walking")


func _on_enemy_state_attack_entered() -> void:
	animated_sprite.play("shooting")


func _on_health_component_took_damage(_amount: int) -> void:
	if health_component.current_health > 0:
		animation_player.play("enemy/damage")
