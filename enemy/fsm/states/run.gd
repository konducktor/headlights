@tool
## During this state the enemy tries to run from player to desired distance. Exits if player is far enough or too close. Debug visuals are purple.
extends EnemyStatePathfinding
class_name EnemyStateRun


@export_range(-1, 1000) var desired_distance: float
@export_range(0, 1000) var min_distance: float
@export var acceleration_component: AccelerationComponent

@export_group("Exits")
@export var exit_if_far_enough: EnemyState
@export var exit_if_too_close: EnemyState

func enter() -> void:
	_on_navigation_update()
	super()

func physics_update(delta: float) -> EnemyState:
	var distance: float = enemy.position.distance_to(Global.player.body_pos())
	if distance >= desired_distance:
		return exit_if_far_enough
	elif distance <= min_distance:
		return exit_if_too_close
	
	enemy.velocity = acceleration_component.smooth_vector(
		enemy.velocity, pathfinding_component.calc_direction() * enemy.movement_speed, delta
	)
	return null


func _on_navigation_update() -> void:
	var target_vector: Vector2 = Vector2.ZERO
	var target_direction: Vector2 = Global.player.body_pos().direction_to(enemy.position)
	if desired_distance == -1:
		target_vector = target_direction * 99999
	else:
		target_vector = target_direction * desired_distance
	
	pathfinding_component.set_target(Global.player.body_pos() + target_vector)


func _draw() -> void:
	if Engine.is_editor_hint():
		draw_circle(Vector2.ZERO, min_distance, Color.PURPLE, false, 1.0)
		draw_circle(Vector2.ZERO, desired_distance, Color.PURPLE, false, 1.0)
