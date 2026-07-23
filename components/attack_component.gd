extends Node2D
class_name AttackComponent


@export var weapon: Weapon


func point_in_direction(vector: Vector2) -> void:
	if weapon is DirectedWeapon:
		weapon.point_in_direction(vector)


func fire() -> void:
	if weapon.can_fire:
		weapon.fire()
