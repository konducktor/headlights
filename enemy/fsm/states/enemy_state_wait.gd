## Makes the enemy wait for amount of seconds on the timer
extends EnemyState
class_name EnemyStateWait

@export var exit_timer: Timer

@export_category("Exits")
@export var exit_to: EnemyState


var _can_exit: bool


func enter() -> void:
	_can_exit = false
	
	exit_timer.start()
	exit_timer.timeout.connect(_on_exit_timer_timeout)


func _on_exit_timer_timeout() -> void:
	_can_exit = true


func physics_update(_delta: float) -> EnemyState:
	if _can_exit:
		return exit_to
	
	return null
