extends EnemyState
class_name EnemyStateChasing


@export var reach_threshhold: float

@export_group("Exits")
@export var exit_if_reached: EnemyState
@export var exit_if_los_lost: EnemyState

@export_group("References")
@export var pathfinding_component: PathfindingComponent
@export var navigation_update_timer: Timer
@export var los_component: LOSComponent


func enter() -> void:
	navigation_update_timer.timeout.connect(_on_navigation_update_timer_timeout)
	super()


func exit() -> void:
	navigation_update_timer.timeout.disconnect(_on_navigation_update_timer_timeout)
	super()


func physics_update(_delta: float) -> EnemyState:
	if player == null:
		return null
	
	enemy.velocity = pathfinding_component.calc_direction() * enemy.movement_speed
	
	if not los_component.is_los_between_nodes(enemy, player):
		return exit_if_los_lost
	
	if enemy.position.distance_to(player.position) <= reach_threshhold:
		return exit_if_reached
	
	return null


func _on_navigation_update_timer_timeout() -> void:
	pathfinding_component.set_target(player.global_position)
