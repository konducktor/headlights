@abstract
extends Node2D
class_name Weapon


@export var entity: CharacterBody2D

var can_fire: bool


func create_projectile(projectile_scene: PackedScene) -> Projectile:
	var projectile := projectile_scene.instantiate() as Projectile
	
	get_tree().root.add_child(projectile)
	projectile.global_position = global_position
	projectile.weapon = self
	
	return projectile

@abstract
func fire() -> void
