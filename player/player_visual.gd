extends Node2D

@export var animated_sprite: AnimatedSprite2D
@export var animation_player: AnimationPlayer

@export_group("Invincibility Visuals")
@export var invincible_in_time: float
@export var invincible_out_time: float

var died: bool


func _ready() -> void:
	died = false


func _on_player_started_walking() -> void:
	animated_sprite.play("walking")


func _on_player_stopped_walking() -> void:
	animated_sprite.play("idle")


func _on_attack_component_attacked() -> void:
	var last_animation: StringName = animated_sprite.animation
	
	if last_animation == "idle":
		animated_sprite.play("idle_attack")
	else:
		animated_sprite.play("walk_attack")
	
	await animated_sprite.animation_finished
	animated_sprite.play(last_animation)


func _on_health_component_took_damage(_amount: int) -> void:
	if died:
		return
	
	animation_player.play("took_damage")


func _on_health_component_died() -> void:
	if died:
		return
	
	animation_player.play("death")
	died = true


func _on_damage_cooldown_timer_timeout() -> void:
	if animation_player.current_animation == "took_damage":
		animation_player.stop()


func _on_health_component_became_invincible() -> void:
	var tween := create_tween()
	tween.tween_property(animated_sprite, "modulate", Color("ffcd18"), invincible_in_time)


func _on_health_component_exited_invincible() -> void:
	var tween := create_tween()
	tween.tween_property(animated_sprite, "modulate", Color.WHITE, invincible_out_time)
