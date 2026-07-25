extends DirectedWeapon
class_name Paper


const PAPER_PROJECTILE: PackedScene = preload("res://weapons/paper/paper_projectile.tscn")


func point_in_direction(vector: Vector2) -> void:
	global_rotation = vector.angle()


func _fire_projectile() -> Projectile:
	var projectile: Projectile = create_projectile(PAPER_PROJECTILE)
	projectile.direction_degrees = rotation_degrees
	
	return projectile
