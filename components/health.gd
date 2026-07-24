extends Node
class_name HealthComponent


signal died

signal health_changed(new_value: int)
signal took_damage(amount: int)
signal regenerated(amount: int)

signal max_health_changed(new_value: int)
signal max_health_increased(amount: int)
signal max_health_decreased(amount: int)


@export var max_health: int

var current_health: int


func _ready() -> void:
	current_health = max_health


func take_damage(amount: int) -> void:
	change_health(-amount)
	took_damage.emit(amount)


func regenerate(amount: int) -> void:
	change_health(amount)
	regenerated.emit(amount)


func change_health(amount: int) -> void:
	current_health = clamp(current_health + amount, 0, max_health)
	health_changed.emit(current_health)
	
	if current_health == 0:
		died.emit()


func change_max_health(amount: int) -> void:
	max_health = (max_health + amount) if (max_health + amount) > 0 else 0
	
	max_health_changed.emit(max_health)
	if amount > 0:
		max_health_increased.emit(amount)
	else:
		max_health_decreased.emit(amount)
	
	if max_health == 0:
		died.emit()
