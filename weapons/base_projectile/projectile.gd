extends Node2D
class_name Projectile


@export_range(-180.0, 180.0) var direction_degrees: float
@export var speed: float


func stop() -> void:
	queue_free()


func _physics_process(_delta: float) -> void:
	global_rotation_degrees = direction_degrees
