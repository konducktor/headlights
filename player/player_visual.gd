extends Node2D

@export var animated_sprite: AnimatedSprite2D
@export var animation_player: AnimationPlayer

var died: bool


func _ready() -> void:
	died = false


func _on_player_started_walking() -> void:
	animated_sprite.play("walking")


func _on_player_stopped_walking() -> void:
	animated_sprite.play("idle")


func _on_health_component_took_damage(_amount: int) -> void:
	if died:
		return
	
	animation_player.play("took_damage")


func _on_health_component_died() -> void:
	if died:
		return
	
	animation_player.play("death")
	died = true
