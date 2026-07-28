@abstract
## Base enemy state class. Cannot be used on its own.
extends Node2D
class_name EnemyState


signal entered
signal exited


var enemy: Enemy

var is_active: bool


func _ready() -> void:
	is_active = false


func enter() -> void:
	entered.emit()
	enemy.velocity = Vector2.ZERO
	is_active = true


func physics_update(_delta: float) -> EnemyState:
	return null


func exit() -> void:
	exited.emit()
	is_active = false
