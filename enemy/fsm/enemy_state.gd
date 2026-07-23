extends Node2D
class_name EnemyState


var enemy: Enemy
var player: Player

var is_active: bool


func _ready() -> void:
	is_active = false


func enter() -> void:
	is_active = true


func physics_update(_delta: float) -> EnemyState:
	return null


func exit() -> void:
	is_active = false
