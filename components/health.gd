extends Node
class_name HealthComponent


signal died

signal health_changed(new_value: int)
signal took_damage(amount: int)
signal regenerated(amount: int)

signal max_health_changed(new_value: int)
signal max_health_increased(amount: int)
signal max_health_decreased(amount: int)

signal became_invincible
signal exited_invincible


@export var max_health: int
@export var damage_cooldown_timer: Timer

var current_health: int

var _takes_damage: bool
var _invincible: bool


func _ready() -> void:
	if damage_cooldown_timer:
		damage_cooldown_timer.timeout.connect(_on_damage_cooldown_timer_timeout)
	
	current_health = max_health
	
	_takes_damage = true
	_invincible = false


func take_damage(amount: int) -> void:
	if _invincible or not _takes_damage:
		return
	
	change_health(-amount)
	took_damage.emit(amount)
	
	if damage_cooldown_timer:
		_takes_damage = false
		damage_cooldown_timer.start()


func regenerate(amount: int) -> void:
	change_health(amount)
	regenerated.emit(amount)


func regenerate_to_max_health() -> void:
	var change: int = max_health - current_health
	change_health(change)
	regenerated.emit(change)


func change_health(amount: int) -> void:
	current_health = clamp(current_health + amount, 0, max_health)
	health_changed.emit(current_health)
	
	if current_health == 0:
		died.emit()


func change_max_health(amount: int) -> void:
	max_health = (max_health + amount) if (max_health + amount) > 0 else 0
	current_health = clamp(current_health, 0, max_health)
	
	max_health_changed.emit(max_health)
	if amount > 0:
		max_health_increased.emit(amount)
	else:
		max_health_decreased.emit(amount)
	
	if max_health == 0:
		died.emit()


func set_invincibility(value: bool) -> void:
	_invincible = value
	
	if value:
		became_invincible.emit()
	else:
		exited_invincible.emit()


func is_invincible() -> bool:
	return _invincible


func _on_damage_cooldown_timer_timeout() -> void:
	_takes_damage = true
