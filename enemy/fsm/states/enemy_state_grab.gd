## When entering this state the enemy grabs the player (he cant move and needs to dash 5 times). Exit after a timer (optional, otherwise exits instantly).
extends EnemyState
class_name EnemyStateGrab

@export var timeout_timer: Timer

@export_group("Exits")
@export var exit_into: EnemyState

var can_exit: bool


func enter() -> void:
	can_exit = false
	player.make_stuck()
	
	if timeout_timer != null:
		timeout_timer.start()
		timeout_timer.timeout.connect(_on_timeout_timer_timeout)
	
	super()


func physics_update(_delta: float) -> EnemyState:
	if can_exit or (timeout_timer == null):
		return exit_into
	return null


func _on_timeout_timer_timeout() -> void:
	can_exit = true
