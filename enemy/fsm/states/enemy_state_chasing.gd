extends EnemyStatePathfinding
class_name EnemyStateChasing


@export var reach_threshhold: float
@export var los_component: LOSComponent
@export var acceleration_component: AccelerationComponent

@export_group("Exits")
@export var exit_if_reached: EnemyState
@export var exit_if_los_lost: EnemyState



func physics_update(delta: float) -> EnemyState:
	if player == null:
		return null
	
	if not los_component.is_los_between_nodes(enemy, player):
		return exit_if_los_lost
	
	if enemy.position.distance_to(player.position) <= reach_threshhold:
		return exit_if_reached
	
	enemy.velocity = acceleration_component.smooth_vector(
		enemy.velocity, pathfinding_component.calc_direction() * enemy.movement_speed, delta
	)
	return null


func _on_navigation_update() -> void:
	pathfinding_component.set_target(player.global_position)
