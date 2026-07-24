## During this state the enemy tries to run from player to desired distance. Exits if player is far enough or too close
extends EnemyStatePathfinding
class_name EnemyStateRun


@export_range(-1, 1000) var desired_distance: float
@export_range(0, 1000) var min_distance: float

@export_group("Exits")
@export var exit_if_far_enough: EnemyState
@export var exit_if_too_close: EnemyState


func physics_update(_delta: float) -> EnemyState:
	var distance: float = enemy.position.distance_to(player.body_pos())
	if distance >= desired_distance:
		return exit_if_far_enough
	elif distance <= min_distance:
		return exit_if_too_close
	
	return null


func _on_navigation_update() -> void:
	var target_vector: Vector2 = Vector2.ZERO
	var target_direction: Vector2 = player.body_pos().direction_to(enemy.position)
	if desired_distance == -1:
		target_vector = target_direction * 99999
	else:
		target_vector = target_direction * desired_distance
	
	pathfinding_component.set_target(player.global_position + target_vector)
