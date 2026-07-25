extends DirectedWeapon
class_name Knife


const CLOSE_ATTACK_SCENE: PackedScene = preload("res://weapons/knife/knife_close_attack.tscn")

var _close_attack: Projectile


func point_in_direction(vector: Vector2) -> void:
	rotation = vector.angle()


func _fire_projectile() -> Projectile:
	_close_attack = create_projectile(CLOSE_ATTACK_SCENE)
	_close_attack.direction_degrees = global_rotation_degrees
	
	get_tree().root.remove_child(_close_attack)
	add_child(_close_attack)
	_close_attack.position = Vector2.ZERO
	
	return _close_attack
