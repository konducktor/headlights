extends Node2D
class_name PathfindingComponent


signal targer_reached


@export var _navigation_agent: NavigationAgent2D

var _current_target: Vector2


func get_curr_target() -> Vector2:
	return _current_target


func set_target(new_target: Vector2) -> void:
	if _current_target != new_target:
		_navigation_agent.target_position = new_target
		_current_target = new_target


func calc_direction() -> Vector2:
	if !_navigation_agent.is_target_reached():
		return to_local(_navigation_agent.get_next_path_position()).normalized()
	else:
		return Vector2.ZERO


func is_target_reached() -> bool:
	return _navigation_agent.is_target_reached()
