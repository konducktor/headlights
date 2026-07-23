extends EnemyStatePathfinding
class_name EnemyStateSearching


@export var search_timer: Timer
@export var los_component: LOSComponent

@export_group("Exits")
@export var exit_if_found: EnemyState
@export var exit_if_not_found: EnemyState

var searching: bool


func enter() -> void:
	searching = true
	super()


func physics_update(_delta: float) -> EnemyState:
	if player == null:
		return null
	
	if los_component.is_los_between_nodes(enemy, player):
		return exit_if_found
	
	if not searching:
		return exit_if_not_found
	
	enemy.velocity = pathfinding_component.calc_direction() * enemy.movement_speed
	return null


func _on_navigation_update() -> void:
	pathfinding_component.set_target(player.global_position)


func _on_search_timer_timeout() -> void:
	searching = false
