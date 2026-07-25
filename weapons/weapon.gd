@abstract
extends Node2D
class_name Weapon


signal fired(projectile: Projectile)
signal hit(entity: CharacterBody2D)


@export var damage: int
@export var entity: CharacterBody2D
var can_fire: bool

var _cooldown_timer: Timer


func _ready() -> void:
	_cooldown_timer = $CooldownTimer
	_cooldown_timer.timeout.connect(_on_cooldown_timer_timeout)
	can_fire = true


func fire() -> void:
	if not can_fire:
		return
	
	fired.emit(_fire_projectile())
	
	_cooldown_timer.start()
	can_fire = false


@abstract
func _fire_projectile() -> Projectile


func create_projectile(projectile_scene: PackedScene) -> Projectile:
	var projectile := projectile_scene.instantiate() as Projectile
	
	get_tree().root.add_child(projectile)
	projectile.global_position = global_position
	projectile.weapon = self
	
	return projectile

func _on_cooldown_timer_timeout() -> void:
	can_fire = true
