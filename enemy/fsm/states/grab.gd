## When entering this state the enemy grabs the player (he cant move and needs to dash 5 times). Exit after a timer (optional, otherwise exits instantly).
extends EnemyState
class_name EnemyStateGrab


@export var position_marker: Marker2D

@export_group("Exits")
@export var exit_into: EnemyState


func enter() -> void:
	enemy.position = Global.player.position + (position_marker.global_position - global_position)
	Global.player.make_stuck()
	super()


func physics_update(_delta: float) -> EnemyState:
	return exit_into
