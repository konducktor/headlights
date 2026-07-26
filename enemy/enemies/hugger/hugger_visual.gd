extends Node2D


@export var animated_sprite: AnimatedSprite2D
@export var animation_player: AnimationPlayer

@export var health_component: HealthComponent


func _on_enemy_state_listening_entered() -> void:
	animated_sprite.play("idle")


func _on_enemy_state_chasing_entered() -> void:
	animated_sprite.play("chase")


func _on_enemy_state_grab_entered() -> void:
	animated_sprite.play("catch")


func _on_health_component_died() -> void:
	animation_player.play("dissolve")


func _on_health_component_took_damage(_amount: int) -> void:
	if health_component.current_health > 0:
		animation_player.play("damage")
