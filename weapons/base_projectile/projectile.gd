extends CharacterBody2D
class_name Projectile


@export var damage: int
@export_range(-180.0, 180.0) var direction_degrees: float
@export var speed: float


func stop() -> void:
	queue_free()


func _physics_process(_delta: float) -> void:
	global_rotation_degrees = direction_degrees
	
	velocity = Vector2.RIGHT.rotated(rotation) * speed
	move_and_slide()
