extends CharacterBody2D
class_name Enemy


signal died
signal activated


@export var active: bool = false
@export var movement_speed: float


func _process(_delta: float) -> void:
	move_and_slide()


func _on_health_component_died() -> void:
	died.emit()
	Global.enemy_died.emit()


func activate() -> void:
	activated.emit()
	active = true
