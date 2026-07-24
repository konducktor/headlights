extends DirectedWeapon
class_name Punch

const PUNCH_PROJECTILE: PackedScene = preload("res://weapons/punch/punch_projectile.tscn")

func point_in_direction(vector: Vector2) -> void:
	rotation = vector.angle()

func _fire_projectile() -> void:
	var punch: Projectile = create_projectile(PUNCH_PROJECTILE)
	punch.direction_degrees = global_rotation_degrees
	punch.rotation = global_rotation
