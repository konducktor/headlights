@abstract
extends Node2D
class_name Weapon


var can_fire: bool


func create_projectile(projectile_scene: PackedScene) -> Projectile:
	var projectile := projectile_scene.instantiate() as Projectile
	add_child(projectile)
	projectile.position = Vector2.ZERO
	
	return projectile

@abstract
func fire() -> void
