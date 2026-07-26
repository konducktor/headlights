extends CharacterBody2D
class_name Enemy


signal died
signal activated


@export var active: bool = false
@export var movement_speed: float

var player: Player


func _ready() -> void:
	player = Global.player


func _process(_delta: float) -> void:
	move_and_slide()


func _on_health_component_died() -> void:
	died.emit()
	Global.enemy_died.emit()


func activate() -> void:
	activated.emit()
	active = true
