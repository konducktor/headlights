extends EnemyStatePathfinding
class_name EnemyStateChasing


@export var reach_threshhold: float
@export var los_component: LOSComponent

@export_group("Exits")
@export var exit_if_reached: EnemyState
@export var exit_if_los_lost: EnemyState


func physics_update(_delta: float) -> EnemyState:
	if player == null:
		return null
	
	if not los_component.is_los_between_nodes(enemy, player):
		return exit_if_los_lost
	
	if enemy.position.distance_to(player.position) <= reach_threshhold:
		return exit_if_reached
	
	enemy.velocity = pathfinding_component.calc_direction() * enemy.movement_speed
	return null


func _on_navigation_update() -> void:
	pathfinding_component.set_target(player.global_position)
