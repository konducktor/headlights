extends Node2D
class_name FlipOnVelocityComponent


const EPSILON: float = 0.5

@export var target: CharacterBody2D
@export var reverse: bool = false


func _process(_delta: float) -> void:
	if absf(target.velocity.x) < EPSILON:
		return
	
	scale.x = 1.0 if (target.velocity.x > EPSILON) != reverse else -1.0
